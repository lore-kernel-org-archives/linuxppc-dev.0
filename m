Return-Path: <bhelgaas@google.com>
Received: from mail-ob0-x22d.google.com (mail-ob0-x22d.google.com
 [IPv6:2607:f8b0:4003:c01::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B5DC61A0FA7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Feb 2015 10:19:23 +1100 (AEDT)
Received: by mail-ob0-f173.google.com with SMTP id uy5so27438758obc.4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Feb 2015 15:19:21 -0800 (PST)
Date: Fri, 20 Feb 2015 17:19:17 -0600
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V11 08/17] powrepc/pci: Refactor pci_dn
Message-ID: <20150220231917.GC21131@google.com>
References: <20150113180502.GC2776@google.com>
 <1421288887-7765-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1421288887-7765-9-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421288887-7765-9-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2015 at 10:27:58AM +0800, Wei Yang wrote:
> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
> pci_dn is the extension of PCI device node and it's created from
> device node. Unfortunately, VFs that are enabled dynamically by
> PF's driver and they don't have corresponding device nodes, and
> pci_dn. The patch refactors pci_dn to support VFs:
> 
>    * pci_dn is organized as a hierarchy tree. VF's pci_dn is put
>      to the child list of pci_dn of PF's bridge. pci_dn of other
>      device put to the child list of pci_dn of its upstream bridge.
> 
>    * VF's pci_dn is expected to be created dynamically when PF
>      enabling VFs. VF's pci_dn will be destroyed when PF disabling
>      VFs. pci_dn of other device is still created from device node
>      as before.
> 
>    * For one particular PCI device (VF or not), its pci_dn can be
>      found from pdev->dev.archdata.firmware_data, PCI_DN(devnode),
>      or parent's list. The fast path (fetching pci_dn through PCI
>      device instance) is populated during early fixup time.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/device.h         |    3 +
>  arch/powerpc/include/asm/pci-bridge.h     |   14 +-
>  arch/powerpc/kernel/pci_dn.c              |  242 ++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/pci-ioda.c |   16 ++
>  4 files changed, 270 insertions(+), 5 deletions(-)
> ...

> +#ifdef CONFIG_PCI_IOV
> +static struct pci_dn *add_one_dev_pci_info(struct pci_dn *parent,
> +					   struct pci_dev *pdev,
> +					   int busno, int devfn)
> +{
> +	struct pci_dn *pdn;
> +
> +	/* Except PHB, we always have parent firmware data */
> +	if (!parent)
> +		return NULL;
> +
> +	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> +	if (!pdn) {
> +		pr_warn("%s: Out of memory !\n", __func__);
> +		return NULL;
> +	}
> +
> +	pdn->phb = parent->phb;
> +	pdn->parent = parent;
> +	pdn->busno = busno;
> +	pdn->devfn = devfn;
> +#ifdef CONFIG_PPC_POWERNV
> +	pdn->pe_number = IODA_INVALID_PE;
> +#endif
> +	INIT_LIST_HEAD(&pdn->child_list);
> +	INIT_LIST_HEAD(&pdn->list);
> +	list_add_tail(&pdn->list, &parent->child_list);
> +
> +	/*
> +	 * If we already have PCI device instance, lets
> +	 * bind them.
> +	 */
> +	if (pdev)
> +		pdev->dev.archdata.firmware_data = pdn;
> +
> +	return pdn;

I'd like to see this done in pcibios_add_device(), as I mentioned in
response to "[PATCH V11 01/17] PCI/IOV: Export interface for retrieve VF's
BDF".  Maybe that's not feasible for some reason, but it would be a nicer
design if it's possible.

The remove_dev_pci_info() work would be done in pcibios_release_device()
then, of course.

> +}
> +#endif // CONFIG_PCI_IOV
> +
> +struct pci_dn *add_dev_pci_info(struct pci_dev *pdev, u16 vf_num)
> +{
> +#ifdef CONFIG_PCI_IOV
> +	struct pci_dn *parent, *pdn;
> +	int i;
> +
> +	/* Only support IOV for now */
> +	if (!pdev->is_physfn)
> +		return pci_get_pdn(pdev);
> +
> +	/* Check if VFs have been populated */
> +	pdn = pci_get_pdn(pdev);
> +	if (!pdn || (pdn->flags & PCI_DN_FLAG_IOV_VF))
> +		return NULL;
> +
> +	pdn->flags |= PCI_DN_FLAG_IOV_VF;
> +	parent = pci_bus_to_pdn(pdev->bus);
> +	if (!parent)
>  		return NULL;
> -	return PCI_DN(dn);
> +
> +	for (i = 0; i < vf_num; i++) {
> +		pdn = add_one_dev_pci_info(parent, NULL,
> +					   pci_iov_virtfn_bus(pdev, i),
> +					   pci_iov_virtfn_devfn(pdev, i));
> +		if (!pdn) {
> +			pr_warn("%s: Cannot create firmware data "
> +				"for VF#%d of %s\n",
> +				__func__, i, pci_name(pdev));
> +			return NULL;
> +		}
> +	}
> +#endif
> +
> +	return pci_get_pdn(pdev);
> +}
> +
> +void remove_dev_pci_info(struct pci_dev *pdev, u16 vf_num)
> +{
> +#ifdef CONFIG_PCI_IOV
> +	struct pci_dn *parent;
> +	struct pci_dn *pdn, *tmp;
> +	int i;
> +
> +	/* Only support IOV PF for now */
> +	if (!pdev->is_physfn)
> +		return;
> +
> +	/* Check if VFs have been populated */
> +	pdn = pci_get_pdn(pdev);
> +	if (!pdn || !(pdn->flags & PCI_DN_FLAG_IOV_VF))
> +		return;
> +
> +	pdn->flags &= ~PCI_DN_FLAG_IOV_VF;
> +	parent = pci_bus_to_pdn(pdev->bus);
> +	if (!parent)
> +		return;
> +
> +	/*
> +	 * We might introduce flag to pci_dn in future
> +	 * so that we can release VF's firmware data in
> +	 * a batch mode.
> +	 */
> +	for (i = 0; i < vf_num; i++) {
> +		list_for_each_entry_safe(pdn, tmp,
> +			&parent->child_list, list) {
> +			if (pdn->busno != pci_iov_virtfn_bus(pdev, i) ||
> +			    pdn->devfn != pci_iov_virtfn_devfn(pdev, i))
> +				continue;
> +
> +			if (!list_empty(&pdn->list))
> +				list_del(&pdn->list);
> +			kfree(pdn);
> +		}
> +	}
> +#endif
>  }
