Message-ID: <3CF4F06E.3080800@eccincorp.com>
Date: Wed, 29 May 2002 11:14:54 -0400
From: Jon Baker <jon@eccincorp.com>
Reply-To: jon@eccincorp.com
MIME-Version: 1.0
To: Embedded Linux Forum <linuxppc-embedded@lists.linuxppc.org>
Subject: How do you link resolve kernel references
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am new to embedded Linux and am trying to develop code on Hard Hat 1.2 with an
Embedded Planet RPX Classic MPC860T / CLLF_BW31 with Red Hat 7.2.

We currently build a "kernel" image which we program to flash.  This flash image
is the linux kernel and some of our code.  We then load more application code
either via (1) FTP or (2) NFS.  The application code is compiled separately from
the flash image.  We compile many small utility programs to executeables then
FTP them in (say to /app dir) then run them from the Bash prompt on the target.

My question is this:  If my separately compiled program references (ie extern) a
a function that is in the flashed image, how do I link it to resolve that extern?

I want to do some debugging.  I have added some logging code and structures in
several functions in the flash image.  All structures and functions ("get" and
"set") are in dbg_fns.c.  I make many "set" calls to log data from various
functions in the flash image.  Everything links fine since all objects are
present upon linking (dbg_fns.o is linked with all caller objects to build the
flash image).  I want to add a utility (dbg_pr.c) that I can FTP to /app that I
can call from the Bash prompt to display the logged info.  dbg_pr.c simply calls
the "get" function in dbg_fns.c to dump the logged data.  When I compile the
display function  I get errors on the externs to the "get" functions in the
flash image.

The only example I have to go from is that the only references I see in our
application code to flashed functions is done via a driver.  Is this the only
way/recommended way to access "kernel" functions?  Conceptually a driver does
not make sense to me since I just want to print a structure not access a device.

I know our applications also access shared library functions (ie libc-2.1.3.so).
  These are in std dirs that the compiler and loader search.  How were the
library functions compiled?  Do the library functions reference kernel
functions?  Or do they only use driver calls?

Thanks

Jon Baker

===================================
Jon Baker
Software Engineer
Efficient Channel Coding, Inc.
216-635-1610
www.eccincorp.com
===================================


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
