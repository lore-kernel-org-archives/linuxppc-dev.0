Date: Wed, 12 Jan 2000 04:02:27 -0700
From: Matt Porter <mmporter@home.com>
To: Eric Valette <valette@crf.canon.fr>
Cc: Matt Porter <mmporter@home.com>, Cort Dougan <cort@fsmlabs.com>,
        Alois Fertl <alois_fertl@talknet.de>,
        LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
Message-ID: <20000112040227.B20677@cx258813-a.chnd1.az.home.com>
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com> <20000105164119.C20193@cx258813-a.chnd1.az.home.com> <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <u8d7rfl7kb.fsf@tri-yann.crf.canon.fr>; from valette@crf.canon.fr on Thu, Jan 06, 2000 at 01:15:48PM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 06, 2000 at 01:15:48PM +0100, Eric Valette wrote:
> Matt> On Tue, Jan 04, 2000 at 10:24:21PM -0700, Cort Dougan wrote:
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

kernel 2.2.14 breaks all Motorola PowerPlus systems.  That is, all systems
which have an OpenPIC.  The patch was against 2.2.14pre4 which was before
all the changes.  Unfortunately, I didn't have time to test every prepatch
with PowerPC merges to check for breakage.  I see this problem on all
interrupts since everything (inluding the 8259 irqs) is routed through the
OpenPIC.

The OpenPIC is completely rewritten which is more than likely the cause.
I thought there was going to be just some minor changes that affected
SMP boxes (fixed IPI support) but a lot appears to be touched.

PowerPlus IDE and PCI interrupt routing fixes will have to be backburnered
until I can repair OpenPIC handling.

FWIW, 2.2.12 is the last stock stable release that is know to be good with
Moto. PowerPlus systems (and was the basis of the IDE support).  There
was a patch posted here for testing a long while back versus 2.2.12.

Oh, and I noticed in released 2.2.14 that the gemini support just inserts
itself into a PReP image build with no conditionals.  New architectures
shouldn't be bloating existing ones this way, especially when there is a
CONFIG_GEMINI.  One other thing is that the SYSRQ support is broken as
the machdep sysrq_xlate function somehow got "ppc_" prepended to it's name
in a couple places and the SYSRQ defines never get defined anywhere. 

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
