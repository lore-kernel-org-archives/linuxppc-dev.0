Message-Id: <v04003a00b31ae22dc5ae@[10.0.0.2]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 21 Mar 1999 13:08:51 -0500
To: linuxppc-dev@lists.linuxppc.org
From: Paul Barrette <barretp@mcmail.cis.mcmaster.ca>
Subject: VRAM not recognized! platinumfb, kernel 2.2.2
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've gone through the faq on this and there are several questions and few
 answers.  Firstly, I added a1mb vram card (1 built in + 1 =2MB) to my
 7200/120 r4 kernel 2.2.2, Xpmac_mga machine.  It should be able to run in
 24/32 bit colour at 800x600.  I checked the apple spec database and it says
 I can go up to 832x624 at 24 bit colour.  Furthermore 800x600x 4 B < 2MB,
 so it should work; now to get it to work.  btw I boot with OF.

 I checked /var/log/dmesg and it says "Total VRAM=1 MB 0001"  !!!! I guess
 it doesn't recognize my vram?    Any ideas on getting linux to
 recognize my vram?

It was suggested that I hack the video driver to force it to use 2mb for
vram (platinumfb.c file?).  Here is where I would guess to set it:
bank0 = 1; /* builtin 1MB vram, always there */
bank1 = info->base_frame_buffer[0x100000] == 0x34;

****can I just set "bank1=1;" and get away with it?  Or does the kernel
have to find it?

bank2 = info->base_frame_buffer[0x200000] == 0x56;
bank3 = info->base_frame_buffer[0x300000] == 0x78;
info->total_vram = (bank0 + bank1 + bank2 + bank3) * 0x100000;
printk(KERN_INFO "Total VRAM = %dMB %d%d%d%d\n", (int) (info->total_vram /
1024 / 1024), bank3, bank2, bank1, bank0);

There are severals calls to "info->total_vram == 0x100000"  but I would
guess that the values are already set at this point (??).  Any help would
be appreciated.

--
Paul Barrette
Ph.D. candidate, dept. of Classics
System Administrator
McMaster University

umbra loco deerat; qua postquam parte resedit
Dis genitus vates et fila sonantia movit,
umbra loco venit.                  (Ov. Met. 10. 88 ff.)
http://www.humanities.mcmaster.ca/~barrette/



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
