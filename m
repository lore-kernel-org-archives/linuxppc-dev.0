Message-ID: <387CF1D1.FC1F0603@talknet.de>
Date: Wed, 12 Jan 2000 22:27:45 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: Matt Porter <mmporter@home.com>
CC: Cort Dougan <cort@fsmlabs.com>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Looking over the patch I'd like to make a few remarks.

prep_setup.c:
The irq stuff is only for the ISA IDE interface of the Intel 82378
on Blackhawk systems. There is only one channel using irq 14.

The split between swapping and non-swapping is because I assumed that the
given code works as is on IBM hardware.

ide-pci.c:
I did not expect the Winbond chip (PCI) requiring a hardcoded irq assignment.
On the PowerStackII this chip works well with the PCI setting connecting
both channels to one PCI INT. I hope there isn't any reason to use the device
in legacy mode.

sl82c105.c:
The proposed patch breaks the IDE CD-Rom which is on my system connected to
the second Winbond IDE channel. I think it is the setting of bit 5 which
configures to use the preset speed settings for port.

Matt Porter wrote:
> 
> On Tue, Jan 04, 2000 at 10:24:21PM -0700, Cort Dougan wrote:
> >
> > } Attached is a patch which allows to work Motorola PREP hardware (like
> > } Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
> > } selectively introduce the changes for the Motorola hardware only.
> > } IBM's can stay with their irq 13 for IDE and with their preferred
> > } method of non swapped data stream. I have no chance to test on IBM.
> >
> > How would this work if both irqs arrive at the same time?
> >
> > Johnnie, Matt - can you test this out on your systems?
> 
> Alois' IDE patch is a subset of the functionality that has made it into
> 2.2.14 from our IDE patch.  This patch doesn't account for the secondary
> IDE controller on irq 15 among other things.  I'm attaching our full
> patch as submitted versus 2.2.14pre4 so everybody can see the code I'm
> talking about.  Note that changes to ide-pci.c, ide-probe.c, and sl82c105.c
> in the patch got dropped and Alan said "maybe for 2.2.15".  The full patch
> was tested on every board MCG has made with IDE.
> 
> As for the 8259 patch, I think it may help the problem but will
> probably cause some bad situations disabling interrupts like that.  I
> will test it out and see if it can be used or made better so we can
> get these PReP 8259 problems behind us.
> 
> --
> Matt Porter
> mmporter@home.com
> This is Linux Country. On a quiet night, you can hear Windows reboot.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
