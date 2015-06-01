Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x229.google.com (mail-ig0-x229.google.com
 [IPv6:2607:f8b0:4001:c05::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8919C1A0054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Jun 2015 09:46:50 +1000 (AEST)
Received: by igbjd9 with SMTP id jd9so74509469igb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Jun 2015 16:46:48 -0700 (PDT)
Date: Mon, 1 Jun 2015 18:46:45 -0500
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Cc: gwshan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH V7 06/10] powerpc/eeh: Create PE for VFs
Message-ID: <20150601234645.GF3631@google.com>
References: <1431999312-10517-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1432032612-21701-7-git-send-email-weiyang@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 19, 2015 at 06:50:08PM +0800, Wei Yang wrote:
> Current EEH recovery code works with the assumption: the PE has primary
> bus. Unfortunately, that's not true to VF PEs, which generally contains
> one or multiple VFs (for VF group case). The patch creates PEs for VFs
> at PCI final fixup time. Those PEs for VFs are indentified with newly
> introduced flag EEH_PE_VF so that we handle them differently during
> EEH recovery.
> 
> [gwshan: changelog and code refactoring]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/eeh.h               |    1 +
>  arch/powerpc/kernel/eeh_pe.c                 |   10 ++++++++--
>  arch/powerpc/platforms/powernv/eeh-powernv.c |   17 +++++++++++++++++
>  3 files changed, 26 insertions(+), 2 deletions(-)
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
> index ce738ab..c505036 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1520,6 +1520,23 @@ static struct eeh_ops pnv_eeh_ops = {
>  	.restore_config		= pnv_eeh_restore_config
>  };
>  
> +static void pnv_eeh_vf_final_fixup(struct pci_dev *pdev)
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

I don't understand this comment.  "The following operations" seems to refer
to eeh_add_device_early() and eeh_add_device_late(), and
"VF's sysfs files being created" seems to refer to eeh_sysfs_add_device().

So the comment suggests that eeh_add_device_early() and
eeh_add_device_late() will fail because they're called before
eeh_sysfs_add_device().  So I think you must be talking about some other
"following operations," not eeh_add_device_early() and
eeh_add_device_late().

> +	eeh_add_device_early(pdn);
> +	eeh_add_device_late(pdev);
> +	eeh_sysfs_add_device(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pnv_eeh_vf_final_fixup);

Ugh.  This is powerpc code, but I don't like using fixups as a hook like
this.  There is a pcibios_add_device() -- could this be done there?

If not, what happens after pcibios_add_device() that is required for this
code?  Maybe we need a pcibios_bus_add_device() hook?

> +
>  /**
>   * eeh_powernv_init - Register platform dependent EEH operations
>   *
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
