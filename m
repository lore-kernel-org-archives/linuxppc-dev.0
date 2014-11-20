Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 708001A09CB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 18:21:06 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Thu, 20 Nov 2014 17:21:04 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C3D383578062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 18:21:00 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAK7MqrT34078828
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 18:22:53 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAK7KxEM024460
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Nov 2014 18:20:59 +1100
Date: Thu, 20 Nov 2014 15:20:57 +0800
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V9 08/18] powrepc/pci: Refactor pci_dn
Message-ID: <20141120072057.GC8562@richard>
Reply-To: Wei Yang <weiyang@linux.vnet.ibm.com>
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

Oops, I see the ARI would affect those value, while missed the NumVFs also
would.

Let's look at the problem one by one.

1. The ARI capability.
===============================================================================
The kernel initialize the capability like this:

pci_init_capabilities()
	pci_configure_ari()
	pci_iov_init()
		iov->offset = offset
		iov->stride = stride

When offset/stride is retrieved at this point, the ARI capability is taken
into consideration.

2. The PF's NumVFs field
===============================================================================
2.1 Potential problem in current code
===============================================================================
First, is current pci code has some potential problem?

sriov_enable()
	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_OFFSET, &offset);
	pci_read_config_word(dev, iov->pos + PCI_SRIOV_VF_STRIDE, &stride);
	iov->offset = offset;
	iov->stride = stride;
	pci_write_config_word(dev, iov->pos + PCI_SRIOV_NUM_VF, nr_virtfn);
	virtfn_add()
		...
		virtfn->devfn = pci_iov_virtfn_devfn(dev, id);

The sriov_enable() retrieve the offset/stride then write the NumVFs. According
to the SPEC, at this moment the offset/stride may change. While I don't see
some code to retrieve and store those value again. And these fields will be
used in virtfn_add().

If my understanding is correct, I suggest to move the retrieve and store
operation after NumVFs is written.

2.2 The IOV bus range may not be correct in pci_scan_child_bus()?
===============================================================================
In current pci core, when enumerating the pci tree, we do like this:

pci_scan_child_bus()
	pci_scan_slot()
		pci_scan_single_device()
			pci_device_add()
				pci_init_capabilities()
					pci_iov_init()
	max += pci_iov_bus_range(bus);
		busnr = pci_iov_virtfn_bus(dev, dev->sriov->total_VFs - 1);
	max = pci_scan_bridge(bus, dev, max, pass);

>From this point, we see pci core reserve some bus range for VFs. This
calculation is based on the offset/stride at this moment. And do the
enumeration with the new bus number.

sriov_enable() could be called several times from driver to enable SRIOV, and
with different nr_virtfn. If each time the NumVFs written, the offset/stride
will change. This means we may try to address an extra bus we didn't reserve?
Or this means it is out of control?

Do I miss something?

2.3 How can I reserve bus range in FW?
===============================================================================
This question comes from the previous one.

Based on my understanding, current pci core will rely on the bus number in HW
if pcibios_assign_all_busses() is not set. If we want to support those VFs
sits on different bus with PF, we need to reserve bus range and write the
correct secondary/subordinate in bridge. Otherwise, those VFs on different bus
may not be addressed.

Currently I am writing the code in FW to reserve the range with the same
mechanism in pci core. While as you mentioned the offset/stride may change
after sriov_enable(), I am confused whether this is the correct way.

2.4 The potential problem for [Patch 08/18]
===============================================================================
According to the SPEC, the offset/stride will change after each
sriov_enable(). This means the bus/devfn will change after each
sriov_enable().

My current thought is to fix it up in virtfn_add(). If the total VF number
will not change, we could create those pci_dn at the beginning and fix the
bus/devfn at each time the VF is truely created.

-- 
Richard Yang
Help you, Help me
