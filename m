Date: Tue, 26 Oct 1999 02:30:48 -0400 (EDT)
From: Morningstar <elfboy@antioch-college.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: recv programming problem...
In-Reply-To: <19991025222905.A32256@gondolin.asf>
Message-ID: <Pine.GSO.3.96.991026015532.12729A-100000@college.antioch-college.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	Okay I might be a moron and have been going about this all
 wrong, but I can't for the life of me figure out why this code acts
 the way it does. It's a simple client/server program using 
 send/recv.
	What happens is this. When files are larger than the send/recieve
 buffers. They are split up, sent, recieved, and closed just fine. When
 the file is less than the buffer size, the server sends everything just
 fine but the client hangs. I thought that the recv command reported
 everything up to the max its told to read. It seems to act like this
 when recieving the segmented files, just not the single buffer ones. 
 Here's the code snippets and output...

     do               	/*Server Code...ret_buffer =[4096]*/
	{nread = fread(ret_buffer, 1, sizeof(ret_buffer), local_file);
	send(fd, ret_buffer, nread,0); 
	cout<<nread<<endl;}    /*Outputs char sent for debug*/
      while(!feof(local_file));
      send(fd, 0,1,0);         /*Send signal to client it's done*/
      cout<<"File Done..."<<end;

     do    		/*Client Code...in_buffer is again 4096 */
	{  nread=recv(socketfd, in_buffer, sizeof(in_buffer), 0);
	   test=fwrite(in_buffer, 1, nread, local_file);	
	   cout<<nread<<":"<<endl;}   /*Outputs char in for debug */
      while(in_buffer[nread-1] != '\0');

	This Produces the following output...

		   Server                  Client
        /neotrin.jpg			/neotrin.jpg
	4096				4096
	4096				4096
	1345				1344
	File Done			File Done

	/client.cpp			/client.cpp
	2494				2494
	File Done...			(hangs...)

  The closest I've figured out to what's wrong is that the
 client is not recieving the second send signal(the termination one)
 because if I remove it, the larger files exhibit the same behavior.
 Yet why would it work on a segment of a file that is less than the
 buffer size and not a single file that is less than the buffer size.

  The tech specs of the machine are. Biege G3 333, LinuxR5 2.2.6-15 
 gcc version egcs-2.91.66  

  Sorry for the long post but this has me beating my head against a wall.
 I do apreaciate any input people can give. Cheers.	

						-Morningstar

		* We dance where angels fear to tread *

  	  * I seek a lover whose kiss is like an open wound *

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
