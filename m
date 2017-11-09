Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yXxHz2r6NzDrK8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Nov 2017 08:34:06 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vA9LTTaq117267
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 9 Nov 2017 16:34:02 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2e4wks3sqe-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Nov 2017 16:34:02 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Thu, 9 Nov 2017 14:34:01 -0700
Subject: Re: [PATCH v2] powerpc/powernv: Add pci_reset_phbs parameter to issue
 a PHB reset
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org
References: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Thu, 9 Nov 2017 19:33:56 -0200
MIME-Version: 1.0
In-Reply-To: <20171025152754.25166-1-gpiccoli@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <f534cf16-d7f8-cfbb-5f81-df7b297683b9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/25/2017 01:27 PM, Guilherme G. Piccoli wrote:
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


Hi Michael/Ben...any thoughts about this one?
Thanks in advance!


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
> +
>  static inline bool pnv_pci_is_m64(struct pnv_phb *phb, struct resource *r)
>  {
>  	/*
> @@ -4014,9 +4023,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>  	 * If we're running in kdump kernel, the previous kernel never
>  	 * shutdown PCI devices correctly. We already got IODA table
>  	 * cleaned out. So we have to issue PHB reset to stop all PCI
> -	 * transactions from previous kernel.
> +	 * transactions from previous kernel. The pci_reset_phbs
> +	 * kernel parameter will force this reset too.
>  	 */
> -	if (is_kdump_kernel()) {
> +	if (is_kdump_kernel() || pci_reset_phbs) {
>  		pr_info("  Issue PHB reset ...\n");
>  		pnv_eeh_phb_reset(hose, EEH_RESET_FUNDAMENTAL);
>  		pnv_eeh_phb_reset(hose, EEH_RESET_DEACTIVATE);
> 
