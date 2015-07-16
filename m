Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x233.google.com (mail-ig0-x233.google.com
 [IPv6:2607:f8b0:4001:c05::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CA9801A0784
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jul 2015 02:00:26 +1000 (AEST)
Received: by igbpg9 with SMTP id pg9so16985685igb.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 09:00:23 -0700 (PDT)
Date: Thu, 16 Jul 2015 11:00:19 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V8 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150716160019.GE25591@google.com>
References: <1434614805-19002-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1434614805-19002-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1434614805-19002-7-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 18, 2015 at 04:06:41PM +0800, Wei Yang wrote:
> Current EEH recovery code works with the assumption: the PE has primary
> bus. Unfortunately, that's not true for VF PEs, which generally contains
> one or multiple VFs (for VF group case).
> 
> The patch introduces a weak function pcibios_bus_add_device() which is
> called by pci_bus_add_device(). In this function, we creates PEs for VFs.
> Those PEs for VFs are identified with newly introduced flag EEH_PE_VF so
> that we handle them differently during EEH recovery.
> 
> [gwshan: changelog and code refactoring]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |    1 +
>  arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   16 ++++++++++++++++
>  drivers/pci/bus.c                            |    2 ++
>  4 files changed, 27 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 1b3614d..c1fde48 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -70,6 +70,7 @@ struct pci_dn;
>  #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>  #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>  #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
> +#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>  
>  #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>  #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 35f0b62..260a701 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>  	 * EEH device already having associated PE, but
>  	 * the direct parent EEH device doesn't have yet.
>  	 */
> -	pdn = pdn ? pdn->parent : NULL;
> +	if (edev->physfn)
> +		pdn = pci_get_pdn(edev->physfn);
> +	else
> +		pdn = pdn ? pdn->parent : NULL;
>  	while (pdn) {
>  		/* We're poking out of PCI territory */
>  		parent = pdn_to_eeh_dev(pdn);
> @@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>  	}
>  
>  	/* Create a new EEH PE */
> -	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
> +	if (edev->physfn)
> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
> +	else
> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>  	if (!pe) {
>  		pr_err("%s: out of memory!\n", __func__);
>  		return -ENOMEM;
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index ce738ab..4ec1d2e 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1520,6 +1520,22 @@ static struct eeh_ops pnv_eeh_ops = {
>  	.restore_config		= pnv_eeh_restore_config
>  };
>  
> +void pcibios_bus_add_device(struct pci_dev *pdev)
> +{
> +	struct pci_dn *pdn = pci_get_pdn(pdev);
> +
> +	if (!pdev->is_virtfn)
> +		return;
> +
> +	/*
> +	 * The following operations will fail if VF's sysfs files
> +	 * aren't created or its resources aren't finalized.
> +	 */
> +	eeh_add_device_early(pdn);
> +	eeh_add_device_late(pdev);
> +	eeh_sysfs_add_device(pdev);
> +}
> +
>  /**
>   * eeh_powernv_init - Register platform dependent EEH operations
>   *
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 90fa3a7..960577f 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -267,6 +267,7 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx)
>  
>  void __weak pcibios_resource_survey_bus(struct pci_bus *bus) { }
>  
> +void __weak pcibios_bus_add_device(struct pci_dev *dev) { }
>  /**
>   * pci_bus_add_device - start driver for a single device
>   * @dev: device to add
> @@ -277,6 +278,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  {
>  	int retval;
>  
> +	pcibios_bus_add_device(dev);

Add a blank line here.

>  	/*
>  	 * Can not put in pci_device_add yet because resources
>  	 * are not assigned yet for some devices.

Please put the drivers/pci/bus.c change in a separate patch so it's clear
that we're changing the PCI core here, not just the powerpc code.  That
will also make it possible to revert the powerpc change if necessary
without breaking any other pcibios_bus_add_device() users that may be
added.

You can add my Acked-by: to the new drivers/pci/bus.c patch.

Bjorn
