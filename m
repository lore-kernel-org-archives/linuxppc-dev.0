Date: Tue, 27 Feb 2001 08:10:59 -0700
From: Matt Porter <mporter@mvista.com>
To: xav <grave@ipno.in2p3.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>, paubert@iram.es
Subject: Re: Problem requesting IRQ with 2.4.2 kernel
Message-ID: <20010227081059.B32137@cx258813-a.chnd1.az.home.com>
References: <3A9BDC55.FCD90F9A@ipno.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A9BDC55.FCD90F9A@ipno.in2p3.fr>; from grave@ipno.in2p3.fr on Tue, Feb 27, 2001 at 05:56:53PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Feb 27, 2001 at 05:56:53PM +0100, xav wrote:
>
> Hi !
>
> I'm using a clone of the bk tree to compile a 2.4.2 kernel.
> I have also downloaded the code from Gabriel Paubert for the
> pci2vme chip from TUNDRA.

Which bk tree? linuxppc_2_4 or linuxppc_2_5?

> Before with a 2.4.0 kernel I succesfully inmod the code.
> But know I have the following error :
> Unable to grab interrupt 16 for VME !
> Trying to free free IRQ16

Look at Genesis2_pci_IRQ_map in prep_pci.c.  Unassigned interrupts
have zero which looks like IRQ 16 after the openpic offset is added.
This is actually the MPIC input for the 8259 cascade so anything
trying to use it will generate unhappy messages.

> And if I have a look at /proc/pci I have the following :
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Motorola Raven (rev 5).
>       IRQ 16.
>       I/O at 0x0 [0xffffffff].
>       Non-prefetchable 32 bit memory at 0xfc000000 [0xfc03ffff].
>   Bus  0, device  11, function  0:
>     ISA bridge: Symphony Labs W83C553 (rev 16).
>       IRQ 16.
>   Bus  0, device  11, function  1:
>     IDE interface: Symphony Labs SL82c105 (rev 5).
>       IRQ 16.
>       Master Capable.  No bursts.  Min Gnt=2.Max Lat=40.
>       I/O at 0xffffff0 [0xffffff7].
>       I/O at 0xfffffec [0xfffffef].
>       I/O at 0xfffffe0 [0xfffffe7].
>       I/O at 0xfffffdc [0xfffffdf].
>       I/O at 0xfffffc0 [0xfffffcf].
>       I/O at 0xfffffb0 [0xfffffbf].
>   Bus  0, device  13, function  0:
>     Bridge: Tundra Semiconductor Corp. CA91C042 [Universe]
> (rev1).
>       IRQ 16.
>       Master Capable.  No bursts.  Min Gnt=3.
>       Non-prefetchable 32 bit memory at 0xeffef000 [0xeffeffff].
>       I/O at 0xfffe000 [0xfffefff].
>
>
> How can avoid all this pci board to have the same IRQ ?
> Is this an openPic related problem ?

Interrupt routing problem.  IIRC, put a 5 for the interrupt line in
the entry for Slot 13, Universe II LINT#0.  That should get you
going.  Check the 2300 programmer's reference if that interrupt
 doesn't work for you.  If the driver is using more LINT inputs than
that then you'll have to fix the routing as appropriate.  It can all
be rerouted via the Universe II but that's another game.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
