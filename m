Message-ID: <379F7AB9.E8D230CE@videotron.ca>
Date: Wed, 28 Jul 1999 16:48:42 -0500
From: Alain Birtz <abz@videotron.ca>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Realloc() problem with Efence
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


What is wrong with this code ?
Code is executed correctly without Electric Fence
But linked with Efence library, dbg complaint:

   Electric Fence 2.0.5 Copyright (C) 1987-1998 Bruce Perens.
   ...
   ...
   Program received signal SIGSEGV, Segmentation fault.

when trying to write the first B, just after the first memory allocation
buffer
(at the instruction (*c_ptr++ = 'B'))


void tst ()
{
 int i;
 char *c_buf, *c_ptr, *temp_c_buf;

 c_buf = (char *)malloc(5000);
 if (c_buf != NULL)
  {
  c_ptr = c_buf;
  for (i = 0; i < 5000; i++)
   *c_ptr++ = 'A';
  temp_c_buf = c_buf;
  realloc(temp_c_buf, 5000 + 5000);
  if (temp_c_buf != NULL)
   {
   for (i = 0; i < 5000; i++)
    *c_ptr++ = 'B';
   }
  }
}




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
