Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f174.google.com (mail-pd0-f174.google.com
 [209.85.192.174])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71E551A0E1D
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2015 22:46:02 +1000 (AEST)
Received: by pdbqd1 with SMTP id qd1so109559288pdb.2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 May 2015 05:46:00 -0700 (PDT)
Message-ID: <554E0181.1030500@ozlabs.ru>
Date: Sat, 09 May 2015 22:45:53 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 08/21] powerpc/powernv: Drop pnv_ioda_setup_dev_PE()
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-9-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1430460188-31343-9-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/01/2015 04:02 PM, Gavin Shan wrote:
> Nobody is using the this function. The patch drops it.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Yay! :)

I would move this patchset along with other mechanical changes to the 
beginning of the patchset.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>   arch/powerpc/platforms/powernv/pci-ioda.c | 71 -------------------------------
>   1 file changed, 71 deletions(-)
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index ef8c216..5cd8298 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -1302,77 +1302,6 @@ static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>   }
>   #endif /* CONFIG_PCI_IOV */
>
> -#if 0
> -static struct pnv_ioda_pe *pnv_ioda_setup_dev_PE(struct pci_dev *dev)
> -{
> -	struct pci_controller *hose = pci_bus_to_host(dev->bus);
> -	struct pnv_phb *phb = hose->private_data;
> -	struct pci_dn *pdn = pci_get_pdn(dev);
> -	struct pnv_ioda_pe *pe;
> -	int pe_num;
> -
> -	if (!pdn) {
> -		pr_err("%s: Device tree node not associated properly\n",
> -			   pci_name(dev));
> -		return NULL;
> -	}
> -	if (pdn->pe_number != IODA_INVALID_PE)
> -		return NULL;
> -
> -	/* PE#0 has been pre-set */
> -	if (dev->bus->number == 0)
> -		pe_num = 0;
> -	else
> -		pe_num = pnv_ioda_alloc_pe(phb);
> -	if (pe_num == IODA_INVALID_PE) {
> -		pr_warning("%s: Not enough PE# available, disabling device\n",
> -			   pci_name(dev));
> -		return NULL;
> -	}
> -
> -	/* NOTE: We get only one ref to the pci_dev for the pdn, not for the
> -	 * pointer in the PE data structure, both should be destroyed at the
> -	 * same time. However, this needs to be looked at more closely again
> -	 * once we actually start removing things (Hotplug, SR-IOV, ...)
> -	 *
> -	 * At some point we want to remove the PDN completely anyways
> -	 */
> -	pe = &phb->ioda.pe_array[pe_num];
> -	pci_dev_get(dev);
> -	pdn->pcidev = dev;
> -	pdn->pe_number = pe_num;
> -	pe->pdev = dev;
> -	pe->pbus = NULL;
> -	pe->tce32_seg = -1;
> -	pe->mve_number = -1;
> -	pe->rid = dev->bus->number << 8 | pdn->devfn;
> -
> -	pe_info(pe, "Associated device to PE\n");
> -
> -	if (pnv_ioda_configure_pe(phb, pe)) {
> -		/* XXX What do we do here ? */
> -		if (pe_num)
> -			pnv_ioda_free_pe(phb, pe_num);
> -		pdn->pe_number = IODA_INVALID_PE;
> -		pe->pdev = NULL;
> -		pci_dev_put(dev);
> -		return NULL;
> -	}
> -
> -	/* Assign a DMA weight to the device */
> -	pe->dma_weight = pnv_ioda_dma_weight(dev);
> -	if (pe->dma_weight != 0) {
> -		phb->ioda.dma_weight += pe->dma_weight;
> -		phb->ioda.dma_pe_count++;
> -	}
> -
> -	/* Link the PE */
> -	pnv_ioda_link_pe_by_weight(phb, pe);
> -
> -	return pe;
> -}
> -#endif /* Useful for SRIOV case */
> -
>   static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>   {
>   	struct pci_dev *dev;
>


-- 
Alexey
