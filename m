Message-Id: <200007240717.JAA26318@denx.local.net>
To: mark@sps.la.asu.edu
cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Porting linux ppc to new platform 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 23 Jul 2000 20:12:13 PDT."
             <E13GYf7-0000Lz-00@sps.la.asu.edu>
Date: Mon, 24 Jul 2000 09:17:39 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Mark,

in message <E13GYf7-0000Lz-00@sps.la.asu.edu> you wrote:
>
>   Recently I have begun working with ppc and have ported vxWorks to our
> platform and am now interested in porting linux.  I have gotten the RPX
> lite board to boot, but then I really did not have to do anywork.

Check the Embedded PowerPC HOWTO at
http://members.xoom.com/greyhams/linux/PowerPC-Embedded-HOWTO.html

>   What I'm intrested in is others who have ported linux to embedded platforms
> so that I might ask them the amount of work invovled and where is a good
> place to begin.  This will be on a board with no available firmware or drivers,
> although I can perform enough low level configuration to bring up vxWorks.

There are several Open Source firmware projects:

* PPCBOOT - Embedded PowerPC Linux Boot Project - MPC8xx, MPC82xx
  Homepage: http://ppcboot.sourceforge.net/
  Download: ftp://ftp.denx.de/pub/ppcboot or CVS on Sourceforge

* LiMon - Linux Monitor - SBC8260
  Homepage: http://www.thinsys.com/limon.html
  Download: http://www.thinsys.com/limon-1.4.2.tar.gz

* PBOOT - PMON/2000 BootROM Monitor - 603e, 604, 604r, 740, 750
  Homepage: http://pmon.groupbsd.org/
  Download: ftp://pmon.groupbsd.org/pub/PMON/src/

>   Is there specific memory layout required, what types of cpnfiguration is

Yes. Life will be easier for you when RAM starts at 0 and IMMR is  at
0xFFF00000  (assuming  you  stay  on MPC8xx as the use of an RPX lite
indicates).

> neccessary at the hardware layer (immr, sypcr, icdct, mamr level stuff, etc.).

These things are usually done by the firmware.

> What do I need to do vs. what is done in the ppc kernel after it is capable
> enough to load a C program.  Is there a powerpc equivalent to lilo,
> or is this even needed.  Can I just jump to main.c?

Using PPCBOOT,  you  can  "jump"  to  the  entry  point  "_start"  in
arch/ppc/kernel/head.S  using the "bootm" command - but this includes
_some_ initialization (like  loading  and  uncompressing  the  kernel
image)  and  parameter  passing.  With more traditional firmware, you
will have to modify the code in the arch/ppc/mbxboot diretory to  fit
to the interfaces provided by your firmware.

>   I have many more questions, but if these aqre answered by a FAQ I'll hold off until I can investigate more.

I guess the HOWTO mentioned above will answer some, but not all.

Wolfgang

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There's no sense in being precise  when  you  don't  even  know  what
you're talking about.                             -- John von Neumann

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
