class BloggersController < ApplicationController
  # GET /bloggers
  # GET /bloggers.json
  def index
    @bloggers = Blogger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bloggers }
    end
  end

  def admin
    @bloggers = Blogger.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bloggers }
    end
  end
      
  def showimg
    imgbi = Blogger.find(params[:id])[:img]
    send_data imgbi, :type=>"image/jpeg", :disposition=>'inline'
  end
  # GET /bloggers/1
  # GET /bloggers/1.json
  def show
    @blogger = Blogger.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @blogger }
    end
  end
  def getJsonWTImg
    @bloggers = Blogger.all
    stringArray = Array.new
    @bloggers.each do |item|
      item2 = JSON.parse(item.to_json)
      item2.delete("img");
      stringArray.push(item2)
    end
    respond_to do |format|
      format.json { render json: stringArray}
    end
  end
  # GET /bloggers/new
  # GET /bloggers/new.json
  def new
    @blogger = Blogger.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @blogger }
    end
  end      

  # GET /bloggers/1/edit
  def edit
    @blogger = Blogger.find(params[:id])
  end

  # POST /bloggers
  # POST /bloggers.json
  def create
    imgbi = params[:blogger][:img].read
    params[:blogger][:img] = imgbi
    @blogger = Blogger.new(params[:blogger])

    respond_to do |format|
      if @blogger.save
        format.html { redirect_to @blogger, notice: 'Blogger was successfully created.' }
        format.json { render json: @blogger, status: :created, location: @blogger }
      else
        format.html { render action: "new" }
        format.json { render json: @blogger.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /bloggers/1
  # PUT /bloggers/1.json
  def update
    @blogger = Blogger.find(params[:id])

    respond_to do |format|
      if @blogger.update_attributes(params[:blogger])
        format.html { redirect_to @blogger, notice: 'Blogger was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @blogger.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bloggers/1
  # DELETE /bloggers/1.json
  def destroy
    @blogger = Blogger.find(params[:id])
    @blogger.destroy

    respond_to do |format|
      format.html { redirect_to bloggers_url }
      format.json { head :no_content }
    end
  end
end
