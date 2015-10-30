Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 03F761A0C23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Oct 2015 15:56:19 +1100 (AEDT)
Received: by pasz6 with SMTP id z6so62111026pas.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Oct 2015 21:56:17 -0700 (PDT)
Subject: Re: [PATCH V10 09/12] powerpc/powernv: Support PCI config restore for
 VFs
To: Wei Yang <weiyang@linux.vnet.ibm.com>, gwshan@linux.vnet.ibm.com,
 bhelgaas@google.com, mpe@ellerman.id.au
References: <1445829362-2738-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1445829362-2738-10-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <5632F86C.9060602@ozlabs.ru>
Date: Fri, 30 Oct 2015 15:56:12 +1100
MIME-Version: 1.0
In-Reply-To: <1445829362-2738-10-git-send-email-weiyang@linux.vnet.ibm.com>
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
> After PE reset, OPAL API opal_pci_reinit() is called on all devices
> contained in the PE to reinitialize them. However, VFs can't be seen
> from skiboot firmware. We have to implement the functions, similar
> those in skiboot firmware, to reinitialize VFs after reset on PE
> for VFs.
>
> [gwshan: changelog and code refactoring]
> Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
> Acked-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/pci-bridge.h        |  1 +
>   arch/powerpc/platforms/powernv/eeh-powernv.c | 70 +++++++++++++++++++++++++++-
>   arch/powerpc/platforms/powernv/pci.c         | 18 +++++++
>   3 files changed, 88 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
> index 3d7e537..e499d93 100644
> --- a/arch/powerpc/include/asm/pci-bridge.h
> +++ b/arch/powerpc/include/asm/pci-bridge.h
> @@ -219,6 +219,7 @@ struct pci_dn {
>   #define IODA_INVALID_M64        (-1)
>   	int     (*m64_map)[PCI_SRIOV_NUM_BARS];
>   #endif /* CONFIG_PCI_IOV */
> +	int     mps;

int     mps; /* maximum payload size */
?


>   #endif
>   	struct list_head child_list;
>   	struct list_head list;
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 017cd72..3cc3e76 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1616,6 +1616,67 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>   	return ret;
>   }
>
> +static int pnv_eeh_restore_vf_config(struct pci_dn *pdn)

It does not exactly restore it, it just tweaks few bytes.


> +{
> +	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> +	u32 devctl, cmd, cap2, aer_capctl;
> +	int old_mps;
> +
> +	/* Restore MPS */
> +	if (edev->pcie_cap) {
> +		old_mps = (ffs(pdn->mps) - 8) << 5;
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				     2, &devctl);
> +		devctl &= ~PCI_EXP_DEVCTL_PAYLOAD;
> +		devctl |= old_mps;
> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				      2, devctl);
> +	}
> +
> +	/* Disable Completion Timeout */
> +	if (edev->pcie_cap) {
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCAP2,
> +				     4, &cap2);
> +		if (cap2 & 0x10) {
> +			eeh_ops->read_config(pdn,
> +					edev->pcie_cap + PCI_EXP_DEVCTL2,
> +					4, &cap2);
> +			cap2 |= 0x10;
> +			eeh_ops->write_config(pdn,
> +					edev->pcie_cap + PCI_EXP_DEVCTL2,
> +					4, cap2);
> +		}
> +	}
> +
> +	/* Enable SERR and parity checking */
> +	eeh_ops->read_config(pdn, PCI_COMMAND, 2, &cmd);


No complains from gcc about uninitialized @cmd and others? Cooool...


> +	cmd |= (PCI_COMMAND_PARITY | PCI_COMMAND_SERR);
> +	eeh_ops->write_config(pdn, PCI_COMMAND, 2, cmd);
> +
> +	/* Enable report various errors */
> +	if (edev->pcie_cap) {
> +		eeh_ops->read_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				2, &devctl);
> +		devctl &= ~PCI_EXP_DEVCTL_CERE;
> +		devctl |= (PCI_EXP_DEVCTL_NFERE |
> +			   PCI_EXP_DEVCTL_FERE |
> +			   PCI_EXP_DEVCTL_URRE);
> +		eeh_ops->write_config(pdn, edev->pcie_cap + PCI_EXP_DEVCTL,
> +				2, devctl);
> +	}
> +
> +	/* Enable ECRC generation and check */
> +	if (edev->pcie_cap && edev->aer_cap) {
> +		eeh_ops->read_config(pdn, edev->aer_cap + PCI_ERR_CAP,
> +				4, &aer_capctl);
> +		aer_capctl |= (PCI_ERR_CAP_ECRC_GENE | PCI_ERR_CAP_ECRC_CHKE);
> +		eeh_ops->write_config(pdn, edev->aer_cap + PCI_ERR_CAP,
> +				4, aer_capctl);
> +	}
> +
> +	return 0;
> +}
> +
>   static int pnv_eeh_restore_config(struct pci_dn *pdn)
>   {
>   	struct eeh_dev *edev = pdn_to_eeh_dev(pdn);
> @@ -1626,7 +1687,14 @@ static int pnv_eeh_restore_config(struct pci_dn *pdn)
>   		return -EEXIST;
>
>   	phb = edev->phb->private_data;
> -	ret = opal_pci_reinit(phb->opal_id,
> +	/*
> +	 * We have to restore the PCI config space after reset since the
> +	 * firmware can't see SRIOV VFs.


When I see "restore config space", pci_restore_state() comes to my mind... 
What you do is rather "fixup" but for some reason you do not call this from 
pnv_pci_fixup_vf_mps (which could be more generic and call 
pnv_eeh_restore_config()). Or that pnv_pci_fixup_vf_mps() could be merged 
into pnv_eeh_restore_config(). Having "restore" code in 2 places with 
unclear execution order does not feel right.



> +	 */
> +	if (edev->physfn)
> +		ret = pnv_eeh_restore_vf_config(pdn);
> +	else
> +		ret = opal_pci_reinit(phb->opal_id,
>   			      OPAL_REINIT_PCI_DEV, edev->config_addr);
>   	if (ret) {
>   		pr_warn("%s: Can't reinit PCI dev 0x%x (%lld)\n",
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 765d8ed..0e4f42e 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -788,6 +788,24 @@ static void pnv_p7ioc_rc_quirk(struct pci_dev *dev)
>   }
>   DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_IBM, 0x3b9, pnv_p7ioc_rc_quirk);
>
> +#ifdef CONFIG_PCI_IOV
> +static void pnv_pci_fixup_vf_mps(struct pci_dev *pdev)
> +{
> +	struct pci_dn *pdn = pci_get_pdn(pdev);
> +	int parent_mps;
> +
> +	if (!pdev->is_virtfn)
> +		return;
> +
> +	/* Synchronize MPS for VF and PF */
> +	parent_mps = pcie_get_mps(pdev->physfn);
> +	if ((128 << pdev->pcie_mpss) >= parent_mps)
> +		pcie_set_mps(pdev, parent_mps);


There is no mentioning of MPS in the commit log. What and why is happening 
here? Is this cut-n-paste? Is not there already some code somewhere which 
does the same thing already for initial init()? Can this be reused? Or 
extracted to a helper and reused?



> +	pdn->mps = pcie_get_mps(pdev);
> +}
> +DECLARE_PCI_FIXUP_HEADER(PCI_ANY_ID, PCI_ANY_ID, pnv_pci_fixup_vf_mps);
> +#endif /* CONFIG_PCI_IOV */
> +
>   void __init pnv_pci_init(void)
>   {
>   	struct device_node *np;
>


-- 
Alexey
