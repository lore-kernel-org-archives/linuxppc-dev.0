Message-ID: <3856C0D7.4E1404C9@ctam.com.au>
Date: Wed, 15 Dec 1999 09:12:40 +1100
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: linuxppc embedded boot problems.
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



Just when I thought I had things sussed out, something changes and I'm
back to square one.  Sigh.......

I have HAD linuxppc (embedded-2.2.5) working on a custom MPC860 board.
By working I mean booting to the bash prompt and being able to view the
initrd filesystem with ls.  I have compiled some simple apps that print
things to the console but they only work if I compile with -static
option.

I now want to get the network going and really want to get root nfs
stuff going so development is easy.  I decided to put a whole lot of
printk statements in the enet.c code to see what was happening.  I
loaded this code and all the printk statements are output to the console
when I try "root=/dev/nfs ......" and the boot prompt and I even saw
that statement that the root file system was mounted.  Cool, but the
console hung and there is no bash shell.  I put some more printks in
init/main.c to see how far the code was getting.
NOW HERE IS WHERE THE WIERDNESS STARTS.  The kernel no longer boots.
WHAT !!!  The boot code seems to uncompress the kernel image into RAM
but then nothing else happens.  Here is the output:

loaded at:     FF801000 FF812BAC
relocated to:  00100000 00111BAC
board data at: 001001C4 001001E0
relocated to:  00200100 0020011C
zimage at:     FF807000 FF868100
avail ram:     00201000 01000000

Linux/PPC load:
Uncompressing Linux...done.
Now booting the kernel

That is all I get.  What the hell could be causing this.  OK, time to
take all the printk statements out so I can get back to where I left
off.  I can't believe it; the same thing happens.  I have appended the
output sections of my image.  It looks OK and I have had this thing
booting before so there must be something I'm missing.  I'm a bit
concerned about the possible overlap of the .bss and image sections.
Could some bss data be overwriting the image data at runtime ???

Sections:
Idx Name          Size      VMA       LMA       File off  Algn
  0 .text         00004870  ff801000  ff801000  00001000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
  1 .rodata       00000470  ff805870  ff805870  00005870  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .data         00000300  ff806000  ff806000  00006000  2**2
                  CONTENTS, ALLOC, LOAD, DATA
  3 .bss          0000bbac  ff807000  ff807000  00007000  2**2
                  ALLOC
  4 image         00061104  ff807000  ff807000  00007000  2**0
                  CONTENTS, ALLOC, LOAD, DATA


Thanks,
Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
