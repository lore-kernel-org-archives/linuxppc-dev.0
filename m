Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 2E286DE0A0
	for <linuxppc-dev@ozlabs.org>; Sat, 18 Apr 2009 04:23:34 +1000 (EST)
Date: Fri, 17 Apr 2009 22:23:32 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: RFC Patch: Use x86 init_hwif in the alim15x3 for x86-like
	PowerPC systems
Message-ID: <20090417182332.GA18756@oksana.dev.rtsoft.ru>
References: <c8485d470904150202s1f5c8cd7p34f0eaf4872f3e17@mail.gmail.com>
	<20090417124014.GA8944@oksana.dev.rtsoft.ru>
	<1239986984.7210.9.camel@pasglop>
	<200904172017.18486.bzolnier@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <200904172017.18486.bzolnier@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Roderick Colenbrander <thunderbird2k@gmail.com>,
	linux-ide@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 17, 2009 at 08:17:18PM +0200, Bartlomiej Zolnierkiewicz wrote:
> On Friday 17 April 2009 18:49:44 Benjamin Herrenschmidt wrote:
> > > But they don't. On MPC8610HPCD we have IDE interrupt directly
> > > connected to the MPIC line (through PCI sideband interrupt), and
> > > i8259 is _completely_ disabled in the bridge.
> > 
> > Hrm why did you do that ? :-)
> > 
> > Just kidding... if what you want is the PCI interrupt, then it should
> > be in native mode, not legacy mode... Maybe the driver can figure out
> > how the chip is configured by reading said configuration and use
> > either the legacy interrupts or the PCI one...
> > 
> > > See this commit:
> > > 
> > >   commit 6d1cee44361b8d06ccd1812e80448d86ae60dfe3
> > >   Author: Anton Vorontsov <avorontsov@ru.mvista.com>
> > >   Date:   Tue Apr 29 22:57:38 2008 +0200
> > >   
> > >       alim15x3: disable init_hwif_ali15x3 for PowerPC
> > > 
> > > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > 
> > > If the patch applied, MPC8610HPCD will be broken.
> > > 
> > > We need at least some machine_is() check.
> > 
> > That sucks. That's an endless problems with IDE and those on-board
> > chipsets though. The interrupts should pretty much -always- be provided
> > by the arch code, but for some reason, that got removed in favor of
> > various hacks in the drivers themselves...
> 
> Previous PPC IRQ hacks combined with IDE IRQ hacks were a real nightmare
> from maintenance perspective -- one could just never tell what is going
> on and whether it is correct.
> 
> IDE host driver specific hacks were just a necessary temporary step into
> solving this problem and most of them got removed in this merge window
> during more general rework of IRQ setup code.
> 
> Nowadays IDE PCI layer just consistently uses arch specific (+ non-IDE
> specific so libata gets benefits too) pci_get_legacy_ide_irq() helper
> for legacy IRQs, please see ide_pci_init_one():
> 
> ...
>         /* fixup IRQ */
>         if (ide_pci_is_in_compatibility_mode(dev)) {
>                 hw[0].irq = pci_get_legacy_ide_irq(dev, 0);
>                 hw[1].irq = pci_get_legacy_ide_irq(dev, 1);
>         } else
>                 hw[1].irq = hw[0].irq = ret;
> ...
> 
> That's all!  No PPC-specific IRQ overrides, IDE-specific IRQ overrides
> and IDE host driver ones needed! :)
> 
> There is still some legacy code (like the one in alim15x3 host driver)
> needing fixing but the infrastructure allowing it should be all there.
> 
> Hmm, it looks like this historical IRQ override in init_hwif_ali15x3():
> 
>         if (dev->device == PCI_DEVICE_ID_AL_M5229)
>                 hwif->irq = hwif->channel ? 15 : 14;
> 
> should be just removed nowadays.
> 
> Seems like this should allow MPC8610HPCD to work with Roderick's patch
> if the IDE controller is set to native mode and ALI south-bridge SIRQ
> tables are correctly set (or if this is not ALI's south-bridge).  Anton?

OK, I'll test this approach.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
