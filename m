Date: Tue, 30 Dec 2003 20:02:28 -0600
From: Chris Zimman <chris@cryptoapps.com>
To: ?????? <jazz0719@dreamwiz.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: DMA problem in Sil0680A - detail setting in my system
Message-ID: <20031231020228.GA5679@dingdong.cryptoapps.com>
Reply-To: Chris Zimman <chris@cryptoapps.com>
References: <200312300128.hBU1Sh3g057052@mail0.dreamwiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200312300128.hBU1Sh3g057052@mail0.dreamwiz.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Dec 30, 2003 at 10:28:43AM +0900, ?????? wrote:

> - modified irq setting of PCI device. as you see, Sil0680 got a irq 25...
>  (sorry for the misprint in the mail before. QLogic ISP1020 SCSI got a irq 27)
>                 /* modified by hwjang : see PPC405GP User's manual Table 10-1. UIC Interrupt Assignments */
>                 {-1, -1, -1, -1},       /* PCI slot 1 : PCI device 10ea:5252 (INTERG VGA) */
>                 {25, 25, 25, 25},       /* PCI slot 2 : PCI device 1095:0680 (CMD SII680) */
>                 {-1, -1, -1, -1},       /* PCI slot 3 : PCI device 104c:a106 (TI 6205 Decoder)*/
>                 {27, 27, 27, 27},       /* PCI slot 4 : PCI device 1077:1020 (QLogic ISP1020 SCSI) */

Without seeing the schematics, I can't be sure -- but did you
double check that you have the right INT# pin going to the right IRQ?

> - modified Timing setting for PIO, DMA, UDMA as my system works now...
>   and set IDE clock freq to 100Mhz
> drivers/ide/pci/siimage.c

I'm not intimately familar with the Silicon Image IDE controllers, so
I'll just take it for granted that you everything that you've done to
the driver is OK.  I'd always suggest starting with the reference driver
though and modifying after you know it's working.  For all I know, the
reason that you may not be getting the DMA interrupt back is because
something you've done to the driver is hosing the transfers.  I'm not
saying that for certain, but since it's not really possible for me to
know one way or the other, it has to be left to possibility.

Unfortunately, since I don't have any of the SI documentation, the dumps
are not really too useful.  Since PIO seems to be working, things must
be at least somewhat OK.  There can be a lot of reasons that the DMA
transfers aren't working right though.  Could be driver problems, could
be a setup problem, could be a routing problem on the board, etc.
First, I would just confirm that the interrupt is working as expected.
You can quickly write hack a driver to report when an interrupt comes
in on IRQ 25 and then put a change wire to the pin and bounce it low to
see what happens.  If the interrupt is working, then you should probably
try lowering the transfer speed and see if that improves things any.  If
that does, then you know you have some signal integrity problems that
you need to look at.  If not, it's probably something busted in the
driver.

> please, give me any advice or suggestion.
> I will try to recognize SCSI device from now.... thanks.

Did you have any luck with the SCSI controller?

--Chris

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
