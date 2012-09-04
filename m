Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 99B0A2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 05:45:48 +1000 (EST)
Message-ID: <1346787940.3025.11.camel@pasglop>
Subject: Re: [PATCH] powerpc-powernv: align BARs to PAGE_SIZE on powernv
 platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Wed, 05 Sep 2012 05:45:40 +1000
In-Reply-To: <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
References: <1346744035-31154-1-git-send-email-aik@ozlabs.ru>
 <1346744201-31262-1-git-send-email-aik@ozlabs.ru>
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

On Tue, 2012-09-04 at 17:36 +1000, Alexey Kardashevskiy wrote:
> VFIO adds a separate memory region for every BAR and tries
> to mmap() it to provide direct BAR mapping to the guest.
> If it succeedes, QEMU registers this address with kvm_set_phys_mem().
> However it is not always possible because such a BAR should
> be host page size aligned. In this case VFIO uses "slow" path
> and emulated BAR access in QEMU.
> 
> In order to avoid "slow" path, BARs have to be PAGE_SIZE aligned
> in the host kernel and this is what the patch does.
> 
> The patch adds powernv platform specific hook which makes all
> BARs sizes 64K aligned. The pci_reassigndev_resource_alignment()
> function from drivers/pci/pci.c has been used as a reference.
> 
> This is purely an optimization patch, the things will work without
> it, just a bit slower.

It's still bad in more ways that I care to explain...

The main one is that you do the "fixup" in a very wrong place anyway and
it might cause cases of overlapping BARs.

In any case this is wrong. It's a VFIO design bug and needs to be fixed
there (CC'ing Alex).

IE. We need a way to know where the BAR is within a page at which point
VFIO can still map the page, but can also properly take into account the
offset.

We also need a way to tell VFIO userspace that it's OK to use the fast
path for such small BARs. It's not for all host platforms. We know it's
ok for PowerNV because we know the devices are grouped by PEs and the PE
granularity is larger than a page but that's not necessarily going to be
the case on all powerpc platforms that support KVM.

Cheers,
Ben.

> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> ---
>  arch/powerpc/platforms/powernv/setup.c |   26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index db1ad1c..331838e 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -25,6 +25,7 @@
>  #include <linux/of.h>
>  #include <linux/interrupt.h>
>  #include <linux/bug.h>
> +#include <linux/pci.h>
>  
>  #include <asm/machdep.h>
>  #include <asm/firmware.h>
> @@ -179,6 +180,30 @@ static int __init pnv_probe(void)
>  	return 1;
>  }
>  
> +static void pnv_pcibios_fixup_resources(struct pci_dev *pdev)
> +{
> +	struct resource *r;
> +	int i;
> +
> +	/*
> +	 * Aligning resources to PAGE_SIZE in order to
> +	 * support "fast" path for PCI BAR access under VFIO
> +	 * which maps every BAR individually to the guest
> +	 * so BARs have to be PAGE aligned.
> +	 */
> +	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
> +		r = &pdev->resource[i];
> +		if (!r->flags)
> +			continue;
> +		pr_debug("powernv: %s, aligning BAR#%d %llx..%llx",
> +			pdev->dev.kobj.name, i, r->start, r->end);
> +		r->end = PAGE_ALIGN(r->end - r->start + 1) - 1;
> +		r->start = 0;
> +		r->flags |= IORESOURCE_UNSET;
> +		pr_debug(" to  %llx..%llx\n", r->start, r->end);
> +	}
> +}
> +
>  define_machine(powernv) {
>  	.name			= "PowerNV",
>  	.probe			= pnv_probe,
> @@ -189,6 +214,7 @@ define_machine(powernv) {
>  	.progress		= pnv_progress,
>  	.power_save             = power7_idle,
>  	.calibrate_decr		= generic_calibrate_decr,
> +	.pcibios_fixup_resources= pnv_pcibios_fixup_resources,
>  #ifdef CONFIG_KEXEC
>  	.kexec_cpu_down		= pnv_kexec_cpu_down,
>  #endif
