Date: Thu, 6 Nov 2003 08:18:16 -0500
Subject: Re: IRQS on 6 Slot Macs
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v552)
Cc: linuxppc-dev@lists.linuxppc.org
To: Brad Boyer <flar@allandria.com>
From: "Michael R. Zucca" <mrz5149@acm.org>
In-Reply-To: <20031106070716.GB17235@pants.nu>
Message-Id: <AED94E45-105B-11D8-A7D0-003065D401D8@acm.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thursday, November 6, 2003, at 02:07  AM, Brad Boyer wrote:

Sorry to butt-in but I've done a little work on the AV's for NetBSD.

> And as a noteworthy fact,
> the AV models were the only 68k models to have a number of features,
> including using the MACE ethernet and having DMA on the serial ports.

Most of the I/O on the AV's had DMA. Unfortunately, the DMA engine is a
bit brain dead. It's not descriptor based. Each I/O item has a channel
and two sets of registers that indicate physical start address and
transfer length. I think each channel has a "done" interrupt so I
suppose it's possible to fake descriptor DMA in software.

> All the other 68k Macs with onboard Ethernet use the sonic driver.
> Supposedly the AV models also had an AMD chip controlling the floppy
> drive, but this is the only AMD labelled chip.

The floppy on the AV's is controlled by the NEC uPD72070. The only
surviving documentation I could find was in Japanese! After a little
translation it seems the chip is pretty much the same as a typical PC
floppy controller but some of the commands to the chip take an extra
byte or two. I think this is because the chip can handle both GCR and
MFM.

>  Perhaps it has more
> features than SCSI, Ethernet, and serial? There are several very
> large Apple ASICs, tho...

The video on those machines is very complex. In fact, I think it's the
same video subsystem (Civic) that is on the HPV card of the x100
PowerMacs. There's also DMA sound, a NuBus bridge, and, of course,
there's the DSP.

All in all it's an interesting little machine. If I had more time I'd
be writing drivers for it :-)

--
----------------------------------------------
  Michael Zucca - mrz5149@acm.org
----------------------------------------------
  "I'm too old to use Emacs." -- Rod MacDonald
----------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
