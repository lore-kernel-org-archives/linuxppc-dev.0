Message-ID: <384532AA.E0EB8B8E@switchboard.ericsson.se>
Date: Wed, 01 Dec 1999 15:37:30 +0100
From: Magnus Damm <damm@kieraypc01.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
To: wung_y@263.net
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: ask for help
References: <38451447.BFB42D44@263.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 > the main difference between the environments of yours and mine is that
> you
> put image on disk while i put it on flash. something must do some
> transferring

Hm. 
Nowadays I use NFS/compact flash for storage.
But before stuff like that worked I used initrd.
And I am very sure I did the initrd on my x86 server.
I copied the linux image and the initrd to flash on my 8xx board.
It worked. Did not gzip it though.

And I did some code to 8xxrom that reads blocks from a romdisk.
 
This is how it must be:

1. The program you use to write the diskimage to flash does not convert 
   anything. If it did it would convert your linux image too, right?
   And that would not work.

2. Your block device driver reads the data from the flash, right?

   Lets say that the x86 computer has stored the 32bit
   number 0xdeadbeef in memory and written it to disk:

   byte no. 00 01 02 03

   content  ef be ad de

   You burn your file to your flash:

   flash addr 00 01 02 03

   content    ef be ad de
 
   You read it out to register r3.

   r3 = 0xefbeadde - not the same 32bit value as on the x86!

   But the contents of the memory is the same on both platforms.
   It is the way it is written/read that matters.
   That is why it must be some standard how the fs is treated.
   The blockdriver should copy 512/4 bytes. No translation at all. 

3. File systems are either big endian or little endian.
   If your platform is say big endian and the fs is little,
   you need to byteswap. This is usually handled by the fs
   with macros.

   If you have a look at minix source code it looks like
   the code does not support endian changing.
   That means that you have to create the fs on the
   machine you intend to use it on.
   
   Both fat and ext2 supports both endians -> no problems!

Good luck /

Magnus Damm

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
