Date: Thu, 1 Jun 2000 08:53:49 -0400
From: Josh Huber <huberj@wpi.edu>
To: Michel Lanners <mlan@cpu.lu>
Cc: jgarzik@mandrakesoft.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: Lite-On ethernet controller
Message-ID: <20000601085349.A307@mclinux.com>
References: <20000531094520.B652@mclinux.com> <200005311840.UAA00709@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200005311840.UAA00709@piglet.grunz.lu>; from mlan@cpu.lu on Wed, May 31, 2000 at 08:40:57PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, May 31, 2000 at 08:40:57PM +0200, Michel Lanners wrote:
> 00:05.0 Ethernet controller: Lite-On Communications Inc: Unknown device c115 (rev 25)
>         Subsystem: Asante Technologies, Inc.: Unknown device f001
>         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping+ SERR- FastB2B-
>         Status: Cap+ 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort- <TAbort- <MAbort- >SERR- <PERR-
>         Latency: 8 min, 56 max, 32 set, cache line size 08
>         Interrupt: pin A routed to IRQ 30
>         Region 0: I/O ports at 1c00 [size=256]
>                   ^^^^^^^^^    ^^^^
>         Region 1: Memory at c3002000 (32-bit, non-prefetchable) [size=256]
>         Expansion ROM at c1240000 [disabled] [size=256K]
>
> The IO port region above might be your problem. What machine type is
> this? Do you have any ISA slots in your machine? Form the i8259
> interrupt controller I deduce it's not a PowerMac...

It's not a powermac...it's a CHRP Longtrail board.  Geert's board has an ISA
slot, and I believe mine has all the hardware for an ISA slot, except the
actual slot was removed.

Geert, how did you get the tulip-diag program to compile on your chrp
machine?  I'd like to give it a try and see what it tells me.

> Have you looked at the driver whether it runs on IO ports or
> memory-mapped? Since the two regions above probably represent different
> views on the same register file, I'd go memory-mapped (i.e. using region
> 1 above), if possible.

How would I check this?  Perhaps Jeff knows this? :)

What's the next step for debugging this?

Now, as for possible buggy motherboards, wouldn't other PCI devices have
trouble?  Perhaps network cards just show the problem becuase of the high
interrupt delivery rate?

I've got other PCI cards in this machine, and haven't had any trouble with
them:
00:00.0 Host bridge: VLSI Technology Inc VAS96011 [Golden Gate II] (rev 14)
00:01.0 ISA bridge: Symphony Labs W83C553 (rev 05)
00:01.1 IDE interface: Symphony Labs SL82c105 (rev 05)
00:02.0 Class ff00: Apple Computer Inc. Hydra Mac I/O (rev 03)
00:03.0 VGA compatible controller: ATI Technologies Inc 3D Rage I/II 215GT [Mach64 GT] (rev 9a)
00:04.0 Ethernet controller: Digital Equipment Corporation DECchip 21142/43 (rev 30)
00:05.0 Ethernet controller: Lite-On Communications Inc: Unknown device c115 (rev 25)
00:06.0 SCSI storage controller: Adaptec AIC-7881U

Josh

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
