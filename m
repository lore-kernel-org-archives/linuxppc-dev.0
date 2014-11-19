Return-Path: <bhelgaas@google.com>
Received: from mail-ig0-x232.google.com (mail-ig0-x232.google.com
 [IPv6:2607:f8b0:4001:c05::232])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F6851A0916
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 10:30:30 +1100 (AEDT)
Received: by mail-ig0-f178.google.com with SMTP id hl2so1886057igb.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Nov 2014 15:30:27 -0800 (PST)
Date: Wed, 19 Nov 2014 16:30:24 -0700
From: Bjorn Helgaas <bhelgaas@google.com>
To: Wei Yang <weiyang@linux.vnet.ibm.com>
Subject: Re: [PATCH V9 08/18] powrepc/pci: Refactor pci_dn
Message-ID: <20141119233024.GF23467@google.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-9-git-send-email-weiyang@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1414942894-17034-9-git-send-email-weiyang@linux.vnet.ibm.com>
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

On Sun, Nov 02, 2014 at 11:41:24PM +0800, Wei Yang wrote:
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
>    * VF's pci_dn is expected to be created dynamically when applying
>      final fixup to PF. VF's pci_dn will be destroyed when releasing
>      PF's pci_dev instance. pci_dn of other device is still created
>      from device node as before.
> 
>    * For one particular PCI device (VF or not), its pci_dn can be
>      found from pdev->dev.archdata.firmware_data, PCI_DN(devnode),
>      or parent's list. The fast path (fetching pci_dn through PCI
>      device instance) is populated during early fixup time.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
> ...

> +struct pci_dn *add_dev_pci_info(struct pci_dev *pdev)
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
> +		return NULL;
> +
> +	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
> +		pdn = add_one_dev_pci_info(parent, NULL,
> +					   pci_iov_virtfn_bus(pdev, i),
> +					   pci_iov_virtfn_devfn(pdev, i));

I'm not sure this makes sense, but I certainly don't know this code, so
maybe I'm missing something.

pci_iov_virtfn_bus() and pci_iov_virtfn_devfn() depend on
pdev->sriov->stride and pdev->sriov->offset.  These are read from VF Stride
and First VF Offset in the SR-IOV capability by sriov_init(), which is
called before add_dev_pci_info():

  pci_scan_child_bus
    pci_scan_slot
      pci_scan_single_device
	pci_device_add
	  pci_init_capabilities
	    pci_iov_init(PF)
	      sriov_init(PF, pos)
		pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0)
		pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset)
		pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride)
		iov->offset = offset
		iov->stride = stride

  pci_bus_add_devices
    pci_bus_add_device
      pci_fixup_device(pci_fixup_final)
	add_dev_pci_info
	  pci_iov_virtfn_bus
	    return ... + sriov->offset + (sriov->stride * id) ...

But both First VF Offset and VF Stride change when ARI Capable Hierarchy or
NumVFs changes (SR-IOV spec sec 3.3.9, 3.3.10).  We set NumVFs to zero in
sriov_init() above.  We will change NumVFs to something different when a
driver calls pci_enable_sriov():

  pci_enable_sriov
    sriov_enable
      pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn)

Now First VF Offset and VF Stride have changed from what they were when we
called pci_iov_virtfn_bus() above.

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
> ...

> +static void pci_dev_pdn_create(struct pci_dev *pdev)
> +{
> +	add_dev_pci_info(pdev);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_create);

There are no other callers of add_dev_pci_info(), so it seems pointless to
declare it in arch/powerpc/include/asm/pci-bridge.h and add this wrapper
around it.

> +
> +static void pci_dev_pdn_setup(struct pci_dev *pdev)
> +{
> +	struct pci_dn *pdn;
> +
> +	if (pdev->dev.archdata.firmware_data)
> +		return;
> +
> +	/* Setup the fast path */
> +	pdn = pci_get_pdn(pdev);
> +	pdev->dev.archdata.firmware_data = pdn;
> +}
> +DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
> -- 
> 1.7.9.5
> 
