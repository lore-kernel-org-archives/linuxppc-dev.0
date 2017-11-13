Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yZyGs6krvzDqH0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2017 15:25:09 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: gpiccoli@linux.vnet.ibm.com, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue
 a PHB reset
In-Reply-To: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
References: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
Date: Mon, 13 Nov 2017 15:25:09 +1100
Message-ID: <87r2t2x0t6.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:

> During a kdump kernel boot in PowerPC, we request a reset of the PHBs
> to the FW. It makes sense, since if we are booting a kdump kernel it
> means we had some trouble before and we cannot rely in the adapters'
> health; they could be in a bad state, hence the reset is needed.
>
> But this reset is useful not only in kdump - there are situations,
> specially when debugging drivers, that we could break an adapter in
> a way it requires such reset. One can tell to just go ahead and
> reboot the machine, but happens that many times doing kexec is much
> faster, and so preferable than a full power cycle.
>
> This patch adds the pci_reset_phbs parameter to perform such reset
> when desired by the user.
>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
> ---
> v2: changed name of the parameter [ben/mpe suggestion].
>
> The patch was implemented against powerpc/next.
>
>  arch/powerpc/platforms/powernv/pci-ioda.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index fb5cd7511189..6070e0d4a7f3 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -89,6 +89,7 @@ void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>  }
>  
>  static bool pnv_iommu_bypass_disabled __read_mostly;
> +static bool pci_reset_phbs __read_mostly;
>  
>  static int __init iommu_setup(char *str)
>  {
> @@ -110,6 +111,14 @@ static int __init iommu_setup(char *str)
>  }
>  early_param("iommu", iommu_setup);
>  
> +static int __init pci_reset_phbs_setup(char *str)
> +{
> +	pci_reset_phbs = true;
> +	return 0;
> +}
> +
> +early_param("pci_reset_phbs", pci_reset_phbs_setup);

Is there a reason you didn't make it a module parameter?

That is preferable IMHO because it is namespaced, which means we don't
need to worry about polluting the top-level parameter namespace.

cheers
