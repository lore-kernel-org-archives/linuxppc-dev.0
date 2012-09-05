Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 161732C0094
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 11:16:51 +1000 (EST)
Message-ID: <1346807803.2257.19.camel@pasglop>
Subject: Re: [PATCH] powerpc-powernv: align BARs to PAGE_SIZE on powernv
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 05 Sep 2012 11:16:43 +1000
In-Reply-To: <5046A2F1.1020004@ozlabs.ru>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
 <1346787940.3025.11.camel@pasglop> <5046A2F1.1020004@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > It's still bad in more ways that I care to explain...
> 
> Well it is right before pci_reassigndev_resource_alignment() which is 
> common and does the same thing.
> 
> > The main one is that you do the "fixup" in a very wrong place anyway and
> > it might cause cases of overlapping BARs.
> 
> As far as I can tell it may only happen if someone tries to align resource 
> via kernel command line.
> 
> But ok. I trust you :)

I have reasons to believe that this realignment crap is wrong too :-)

> > In any case this is wrong. It's a VFIO design bug and needs to be fixed
> > there (CC'ing Alex).
> 
> It can be fixed in VFIO only if VFIO will stop treating functions 
> separately and start mapping group's MMIO space as a whole thing. But this 
> is not going to happen.

It still can be fixed without that...

> The example of the problem is NEC USB PCI which has 3 functions, each has 
> one BAR, these BARs are 4K aligned and I cannot see how it can be fixed 
> with 64K page size and VFIO creating memory regions per BAR (not per PHB).

VFIO can perfectly well realize it's the same MR or even map the same
area 3 times and create 3 MRs, both options work. All it needs is to
know the offset of the BAR inside the page.

> > IE. We need a way to know where the BAR is within a page at which point
> > VFIO can still map the page, but can also properly take into account the
> > offset.
> 
> It is not about VFIO, it is about KVM. I cannot put non-aligned page to 
> kvm_set_phys_mem(). Cannot understand how we would solve this.

No, VFIO still maps the whole page and creates an MR for the whole page,
that's fine. But you still need to know the offset within the page.

Now the main problem here is going to be that the guest itself might
reallocate the BAR and move it around (well, it's version of the BAR
which isn't the real thing), and so we cannot create a direct MMU
mapping between -that- and the real BAR.

IE. We can only allow that direct mapping if the guest BAR mapping has
the same "offset within page" as the host BAR mapping. 

Our guests don't mess with BARs but SLOF does ... it's really tempting
to look into bringing the whole BAR allocation back into qemu and out of
SLOF :-( (We might have to if we ever do hotplug anyway). That way qemu
could set offsets that match appropriately.
 
Cheers,
Ben.

> You better discuss it with David, my vocab is weak.
> 
> 
> 
> > We also need a way to tell VFIO userspace that it's OK to use the fast
> > path for such small BARs. It's not for all host platforms. We know it's
> > ok for PowerNV because we know the devices are grouped by PEs and the PE
> > granularity is larger than a page but that's not necessarily going to be
> > the case on all powerpc platforms that support KVM.
> >
> > Cheers,
> > Ben.
> >
> >> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> >> ---
> >>   arch/powerpc/platforms/powernv/setup.c |   26 ++++++++++++++++++++++++++
> >>   1 file changed, 26 insertions(+)
> >>
> >> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> >> index db1ad1c..331838e 100644
> >> --- a/arch/powerpc/platforms/powernv/setup.c
> >> +++ b/arch/powerpc/platforms/powernv/setup.c
> >> @@ -25,6 +25,7 @@
> >>   #include <linux/of.h>
> >>   #include <linux/interrupt.h>
> >>   #include <linux/bug.h>
> >> +#include <linux/pci.h>
> >>
> >>   #include <asm/machdep.h>
> >>   #include <asm/firmware.h>
> >> @@ -179,6 +180,30 @@ static int __init pnv_probe(void)
> >>   	return 1;
> >>   }
> >>
> >> +static void pnv_pcibios_fixup_resources(struct pci_dev *pdev)
> >> +{
> >> +	struct resource *r;
> >> +	int i;
> >> +
> >> +	/*
> >> +	 * Aligning resources to PAGE_SIZE in order to
> >> +	 * support "fast" path for PCI BAR access under VFIO
> >> +	 * which maps every BAR individually to the guest
> >> +	 * so BARs have to be PAGE aligned.
> >> +	 */
> >> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> >> +		r = &pdev->resource[i];
> >> +		if (!r->flags)
> >> +			continue;
> >> +		pr_debug("powernv: %s, aligning BAR#%d %llx..%llx",
> >> +			pdev->dev.kobj.name, i, r->start, r->end);
> >> +		r->end = PAGE_ALIGN(r->end - r->start + 1) - 1;
> >> +		r->start = 0;
> >> +		r->flags |= IORESOURCE_UNSET;
> >> +		pr_debug(" to  %llx..%llx\n", r->start, r->end);
> >> +	}
> >> +}
> >> +
> >>   define_machine(powernv) {
> >>   	.name			= "PowerNV",
> >>   	.probe			= pnv_probe,
> >> @@ -189,6 +214,7 @@ define_machine(powernv) {
> >>   	.progress		= pnv_progress,
> >>   	.power_save             = power7_idle,
> >>   	.calibrate_decr		= generic_calibrate_decr,
> >> +	.pcibios_fixup_resources= pnv_pcibios_fixup_resources,
> >>   #ifdef CONFIG_KEXEC
> >>   	.kexec_cpu_down		= pnv_kexec_cpu_down,
> >>   #endif
> >
> >
> 
> 
