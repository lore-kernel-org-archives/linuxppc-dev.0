To: Wolfgang Denk <wd@denx.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: My (per)version of 8xxrom 
In-Reply-To: Message from Wolfgang Denk <wd@denx.de>
   of "Wed, 07 Jun 2000 21:54:32 +0200." <200006071954.VAA09159@denx.local.net>
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 08 Jun 2000 11:18:59 +1000
Message-ID: <25582.960427139@msa.cmst.csiro.au>
From: Murray Jensen <Murray.Jensen@cmst.csiro.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 07 Jun 2000 21:54:32 +0200, Wolfgang Denk <wd@denx.de> writes:
>I will try to coordinate changes a bit, and maybe start a re-write of
>some parts of the code. I might have an engineer working on  this  by
>mid-July to pick up what we have by then. My current intentions are:
>
>* Make 8xxrom run on the TQM8xxL modules (99% of that are done)
>* Add network boot using TFTP / BOOTP (Duncan Palmer is working on
>  that, too)
>* Add booting from PCMCIA / directly attached ATA disks (not working
>  yet on the TQM8xxL)
>* Add FLASH driver so that you can use the monitor to load an image
>  over the network and write it to FLASH;
>* Add some features needed for safe field upgradability (automatic
>  selection between two or more boot images)
>
>The list represents more or less the priorities as I see them at  the
>moment.
>
>Comments welcome, volunteers even more :-)
>
>Wolfgang Denk

Hi Wolfgang, I have taken the GDB stubs configuration of eCos (embedded
Cygnus operating system(?)) and built a ROM monitor on top which supports
flash, serial and lcd drivers for my board (a Cogent CMA286-60 (MPC860) with a
CMA102 motherboard - supported already by eCos), and has commands to download
via serial port using GDB protocol, program flash from an image in memory,
and boot an image that resides in flash. I don't have an ethernet driver,
because my cpu board doesn't have the appropriate hardware support (I would
need an external physical interface), but the effort might be small to add
this, esp. if code were re-used from elsewhere and grafted in (I will be
doing it at some stage, unless I can find something better - I'm not sure
8xxrom fits the bill, but I will watch it from now on - having only just
discovered it).

So if your board is supported by eCos (not many boards are - I bought this
board specifically because eCos supported it, as I was going to use eCos,
but it was too primitive for my liking so I am now using RT-Linux/PPC),
it might be a good point to start. I don't like re-inventing the wheel,
which is why I used eCos as a base for my EPROM boot code.

I call it ELILO :-) (eCos linux loader). You are welcome to it, but first
check out: http://sourceware.cygnus.com/ecos/. Hope this helps. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing Sci & Tech,         Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@cmst.csiro.au  (old address was mjj@mlb.dmt.csiro.au)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
