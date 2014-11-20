Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2864A1A017A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 12:02:21 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 20 Nov 2014 06:32:18 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 6F49B3940045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 06:32:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAK12VMU16384204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 06:32:31 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAK12Fpt028159
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 06:32:16 +0530
Date: Thu, 20 Nov 2014 12:02:13 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V9 08/18] powrepc/pci: Refactor pci_dn
Message-ID: <20141120010213.GA11893@shangw>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1414942894-17034-1-git-send-email-weiyang@linux.vnet.ibm.com>
 <1414942894-17034-9-git-send-email-weiyang@linux.vnet.ibm.com>
 <20141119233024.GF23467@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141119233024.GF23467@google.com>
Cc: linux-pci@vger.kernel.org, Wei Yang <weiyang@linux.vnet.ibm.com>,
 benh@au1.ibm.com, linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 19, 2014 at 04:30:24PM -0700, Bjorn Helgaas wrote:
>On Sun, Nov 02, 2014 at 11:41:24PM +0800, Wei Yang wrote:
>> From: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> 
>> pci_dn is the extension of PCI device node and it's created from
>> device node. Unfortunately, VFs that are enabled dynamically by
>> PF's driver and they don't have corresponding device nodes, and
>> pci_dn. The patch refactors pci_dn to support VFs:
>> 
>>    * pci_dn is organized as a hierarchy tree. VF's pci_dn is put
>>      to the child list of pci_dn of PF's bridge. pci_dn of other
>>      device put to the child list of pci_dn of its upstream bridge.
>> 
>>    * VF's pci_dn is expected to be created dynamically when applying
>>      final fixup to PF. VF's pci_dn will be destroyed when releasing
>>      PF's pci_dev instance. pci_dn of other device is still created
>>      from device node as before.
>> 
>>    * For one particular PCI device (VF or not), its pci_dn can be
>>      found from pdev->dev.archdata.firmware_data, PCI_DN(devnode),
>>      or parent's list. The fast path (fetching pci_dn through PCI
>>      device instance) is populated during early fixup time.
>> 
>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>> ...
>
>> +struct pci_dn *add_dev_pci_info(struct pci_dev *pdev)
>> +{
>> +#ifdef CONFIG_PCI_IOV
>> +	struct pci_dn *parent, *pdn;
>> +	int i;
>> +
>> +	/* Only support IOV for now */
>> +	if (!pdev->is_physfn)
>> +		return pci_get_pdn(pdev);
>> +
>> +	/* Check if VFs have been populated */
>> +	pdn = pci_get_pdn(pdev);
>> +	if (!pdn || (pdn->flags & PCI_DN_FLAG_IOV_VF))
>> +		return NULL;
>> +
>> +	pdn->flags |= PCI_DN_FLAG_IOV_VF;
>> +	parent = pci_bus_to_pdn(pdev->bus);
>> +	if (!parent)
>> +		return NULL;
>> +
>> +	for (i = 0; i < pci_sriov_get_totalvfs(pdev); i++) {
>> +		pdn = add_one_dev_pci_info(parent, NULL,
>> +					   pci_iov_virtfn_bus(pdev, i),
>> +					   pci_iov_virtfn_devfn(pdev, i));
>
>I'm not sure this makes sense, but I certainly don't know this code, so
>maybe I'm missing something.
>

For ARI, Richard had some patches to fix the issue from firmware side.

>pci_iov_virtfn_bus() and pci_iov_virtfn_devfn() depend on
>pdev->sriov->stride and pdev->sriov->offset.  These are read from VF Stride
>and First VF Offset in the SR-IOV capability by sriov_init(), which is
>called before add_dev_pci_info():
>
>  pci_scan_child_bus
>    pci_scan_slot
>      pci_scan_single_device
>	pci_device_add
>	  pci_init_capabilities
>	    pci_iov_init(PF)
>	      sriov_init(PF, pos)
>		pci_write_config_word(dev, pos + PCI_SRIOV_NUM_VF, 0)
>		pci_read_config_word(dev, pos + PCI_SRIOV_VF_OFFSET, &offset)
>		pci_read_config_word(dev, pos + PCI_SRIOV_VF_STRIDE, &stride)
>		iov->offset = offset
>		iov->stride = stride
>
>  pci_bus_add_devices
>    pci_bus_add_device
>      pci_fixup_device(pci_fixup_final)
>	add_dev_pci_info
>	  pci_iov_virtfn_bus
>	    return ... + sriov->offset + (sriov->stride * id) ...
>
>But both First VF Offset and VF Stride change when ARI Capable Hierarchy or
>NumVFs changes (SR-IOV spec sec 3.3.9, 3.3.10).  We set NumVFs to zero in
>sriov_init() above.  We will change NumVFs to something different when a
>driver calls pci_enable_sriov():
>
>  pci_enable_sriov
>    sriov_enable
>      pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn)
>
>Now First VF Offset and VF Stride have changed from what they were when we
>called pci_iov_virtfn_bus() above.
>

It's the case we missed: First VF Offset and VF Stride can change when
PF's number of VFs is changed. It means the BDFN (Bus/Device/Function
number) for one VF can't be determined until PF's number of VFs is
populated and updated to HW (before calling to virtfn_add()).

The dynamically created pci_dn is used in PCI config accessors currently.
That means we have to get it ready before first PCI config request to the
VF in pci_setup_device(). In the code of old revision, we had some weak
function called in pci_alloc_dev(), which gave platform chance to create
pci_dn. I think we have to switch back to the old way in order to fix
the problem you catched. However, the old way is implemented with cost
of more weak function, which you're probably unhappy to see.

  sriov_enable()
    virtfn_add()
      virtfn_add_bus()
      pci_alloc_dev()
      pci_setup_device()

>> +		if (!pdn) {
>> +			pr_warn("%s: Cannot create firmware data "
>> +				"for VF#%d of %s\n",
>> +				__func__, i, pci_name(pdev));
>> +			return NULL;
>> +		}
>> +	}
>> +#endif
>> +
>> +	return pci_get_pdn(pdev);
>> +}
>> ...
>
>> +static void pci_dev_pdn_create(struct pci_dev *pdev)
>> +{
>> +	add_dev_pci_info(pdev);
>> +}
>> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_create);
>
>There are no other callers of add_dev_pci_info(), so it seems pointless to
>declare it in arch/powerpc/include/asm/pci-bridge.h and add this wrapper
>around it.
>

Yep and will fix.

Thanks,
Gavin

>> +
>> +static void pci_dev_pdn_setup(struct pci_dev *pdev)
>> +{
>> +	struct pci_dn *pdn;
>> +
>> +	if (pdev->dev.archdata.firmware_data)
>> +		return;
>> +
>> +	/* Setup the fast path */
>> +	pdn = pci_get_pdn(pdev);
>> +	pdev->dev.archdata.firmware_data = pdn;
>> +}
>> +DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_dev_pdn_setup);
>> -- 
>> 1.7.9.5
>> 
>
