Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x229.google.com (mail-pa0-x229.google.com
 [IPv6:2607:f8b0:400e:c03::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6193D1A0521
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 14:46:43 +1100 (AEDT)
Received: by padhk11 with SMTP id hk11so60443048pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 20:46:40 -0700 (PDT)
Subject: Re: [PATCH V10 07/12] powerpc/eeh: Create PE for VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-8-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632E81B.6060003@ozlabs.ru>
Date: Fri, 30 Oct 2015 14:46:35 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-8-git-send-email-weiyang@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/26/2015 02:15 PM, Wei Yang wrote:
> Current EEH recovery code works with the assumption: the PE has primary
> bus. Unfortunately, that's not true for VF PEs, which generally contains
> one or multiple VFs (for VF group case).

What is that "VF group case"? Is not it a "compound PE" thingy which you 
were removing in "SRIOV redesign patchset"?

The patch might be ok but the commit log above does not explain why the 
existing way of PEs allocation would not work - somehow it works for a 
primary bus now, why would not it work on other buses?


> The patch creates PEs for VFs in the weak function
> pcibios_bus_add_device().Those PEs for VFs are identified with newly
> introduced flag EEH_PE_VF so that we handle them differently during EEH
> recovery.
 >
> [gwshan: changelog and code refactoring]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/eeh.h               |  1 +
>   arch/powerpc/kernel/eeh_pe.c                 | 10 ++++++++--
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 16 ++++++++++++++++
>   3 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/eeh.h b/arch/powerpc/include/asm/eeh.h
> index 6c383ad..ec21f8f 100644
> --- a/arch/powerpc/include/asm/eeh.h
> +++ b/arch/powerpc/include/asm/eeh.h
> @@ -72,6 +72,7 @@ struct pci_dn;
>   #define EEH_PE_PHB	(1 << 1)	/* PHB PE    */
>   #define EEH_PE_DEVICE 	(1 << 2)	/* Device PE */
>   #define EEH_PE_BUS	(1 << 3)	/* Bus PE    */
> +#define EEH_PE_VF	(1 << 4)	/* VF PE     */
>
>   #define EEH_PE_ISOLATED		(1 << 0)	/* Isolated PE		*/
>   #define EEH_PE_RECOVERING	(1 << 1)	/* Recovering PE	*/
> diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
> index 35f0b62..260a701 100644
> --- a/arch/powerpc/kernel/eeh_pe.c
> +++ b/arch/powerpc/kernel/eeh_pe.c
> @@ -299,7 +299,10 @@ static struct eeh_pe *eeh_pe_get_parent(struct eeh_dev *edev)
>   	 * EEH device already having associated PE, but
>   	 * the direct parent EEH device doesn't have yet.
>   	 */
> -	pdn = pdn ? pdn->parent : NULL;
> +	if (edev->physfn)
> +		pdn = pci_get_pdn(edev->physfn);
> +	else
> +		pdn = pdn ? pdn->parent : NULL;
>   	while (pdn) {
>   		/* We're poking out of PCI territory */
>   		parent = pdn_to_eeh_dev(pdn);
> @@ -382,7 +385,10 @@ int eeh_add_to_parent_pe(struct eeh_dev *edev)
>   	}
>
>   	/* Create a new EEH PE */
> -	pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
> +	if (edev->physfn)
> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_VF);
> +	else
> +		pe = eeh_pe_alloc(edev->phb, EEH_PE_DEVICE);
>   	if (!pe) {
>   		pr_err("%s: out of memory!\n", __func__);
>   		return -ENOMEM;
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 7cf0df8..cfd55dd 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1524,6 +1524,22 @@ static struct eeh_ops pnv_eeh_ops = {
>   	.restore_config		= pnv_eeh_restore_config
>   };
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
>   /**
>    * eeh_powernv_init - Register platform dependent EEH operations
>    *
>


-- 
Alexey
