Date: Thu, 6 Jan 2000 10:10:41 -0700
From: Matt Porter <mmporter@home.com>
To: Eric Valette <valette@crf.canon.fr>
Cc: Matt Porter <mmporter@home.com>, Cort Dougan <cort@fsmlabs.com>,
        Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
Message-ID: <20000106101041.A27148@cx258813-a.chnd1.az.home.com>
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com> <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr>; from valette@crf.canon.fr on Thu, Jan 06, 2000 at 01:15:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 06, 2000 at 01:15:48PM +0100, Eric Valette wrote:
> 
> >>>>> "Matt" == Matt Porter <mmporter@home.com> writes:
> 
> Matt> On Tue, Jan 04, 2000 at 10:24:21PM -0700, Cort Dougan wrote:
> >> 
> >> } Attached is a patch which allows to work Motorola PREP hardware (like
> >> } Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
> >> } selectively introduce the changes for the Motorola hardware only.
> >> } IBM's can stay with their irq 13 for IDE and with their preferred
> >> } method of non swapped data stream. I have no chance to test on IBM.
> >> 
> >> How would this work if both irqs arrive at the same time?
> >> 
> >> Johnnie, Matt - can you test this out on your systems?
> 
> Matt> Alois' IDE patch is a subset of the functionality that has made it into
> Matt> 2.2.14 from our IDE patch.  This patch doesn't account for the secondary
> Matt> IDE controller on irq 15 among other things.  I'm attaching our full
> Matt> patch as submitted versus 2.2.14pre4 so everybody can see the code I'm
> Matt> talking about.  Note that changes to ide-pci.c, ide-probe.c, and sl82c105.c
> Matt> in the patch got dropped and Alan said "maybe for 2.2.15".  The full patch
> Matt> was tested on every board MCG has made with IDE. 
> 
> Matt> As for the 8259 patch, I think it may help the problem but will 
> Matt> probably cause some bad situations disabling interrupts like that.  I
> Matt> will test it out and see if it can be used or made better so we can
> Matt> get these PReP 8259 problems behind us.
> 
> Just to tell you that : 
> 
>         1) I applied the 2.2.14pre4 prepide-patch on a clean
>         linux 2.2.14 tree. Effectively the ppc part is in and
>         not the ide-pci.c, ide-probe.c, and sl82c105.c
>         2) BUT : after applying the missing part of the patches
>         the behavior is absolutely identical!!!
> 
> hdc : lost interrupt...
> 
> any other hints?

Since you have the old defective MCP750, you can either return it or apply
the 99% workaround of reprogramming the level/edge triggering on the VIA as
you've done before.  The patch does work on all MCG IDE capable hardware
except the revs of the MCP750 that should no longer be used by customers.

I'll reiterate that since the policy is to replace these old boards which
have the interrupt triggering set incorrectly, a workaround that doesn't
work 100% of the time shouldn't go in the kernel.

Now, actually getting the board replaced when going through a distributor
is another problem that we can continue further offline.

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
