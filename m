From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14239.28171.5732.716574@gargle.gargle.HOWL>
Date: Wed, 28 Jul 1999 16:54:35 -0400 (EDT)
To: Alain Birtz <abz@videotron.ca>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Realloc() problem with Efence
In-Reply-To: <379F7AB9.E8D230CE@videotron.ca>
References: <379F7AB9.E8D230CE@videotron.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Alain Birtz <abz@videotron.ca> writes:
Alain> What is wrong with this code ?
Alain> Code is executed correctly without Electric Fence
Alain> But linked with Efence library, dbg complaint:
Alain> 
Alain> 	  Electric Fence 2.0.5 Copyright (C) 1987-1998 Bruce Perens.
Alain> 	  ...
Alain> 	  ...
Alain> 	  Program received signal SIGSEGV, Segmentation fault.
Alain> 
Alain> when trying to write the first B, just after the first memory allocation
Alain> buffer
Alain> (at the instruction (*c_ptr++ = 'B'))
Alain> 
Alain> 
Alain> void tst ()
Alain> {
Alain> 	int i;
Alain> 	char *c_buf, *c_ptr, *temp_c_buf;
Alain> 
Alain> 	c_buf = (char *)malloc(5000);
Alain> 	if (c_buf != NULL)
Alain> 	 {
Alain> 	 c_ptr = c_buf;
Alain> 	 for (i = 0; i < 5000; i++)
Alain> 	  *c_ptr++ = 'A';
Alain> 	 temp_c_buf = c_buf;
Alain> 	 realloc(temp_c_buf, 5000 + 5000);
Alain> 	 if (temp_c_buf != NULL)
Alain> 	  {
Alain> 	  for (i = 0; i < 5000; i++)
Alain> 	   *c_ptr++ = 'B';
Alain> 	  }
Alain> 	 }
Alain> }
Alain> 

realloc can (and did) move the block.  Therefore, when you start writing 'B's, 
they are going into invalid memory.  The fact that it works without Electric
Fence is luck.

To do this, you need to set the pointer to the whole block to the output of
realloc and then you can start writing B's at the new location + 5000.

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
