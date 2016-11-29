Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tSzyW1qjyzDvt6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 10:19:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uATNIiQf146215
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 18:19:11 -0500
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0a-001b2d01.pphosted.com with ESMTP id 271ghuydnw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Nov 2016 18:19:10 -0500
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 09:19:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2BAF42BB0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 10:19:06 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uATNJ6vl39452772
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 10:19:06 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uATNJ542016330
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 10:19:06 +1100
Date: Wed, 30 Nov 2016 10:20:28 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Bjorn Helgaas <bhelgaas@google.com>, clsoto@us.ibm.com,
 benh@kernel.crashing.org, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH v4 3/7] PCI: Separate VF BAR updates from standard BAR
 updates
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041506.21453.18478.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129045546.GB20642@gwshan>
 <20161129144826.GB7285@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161129144826.GB7285@bhelgaas-glaptop.roam.corp.google.com>
Message-Id: <20161129232028.GA8143@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 29, 2016 at 08:48:26AM -0600, Bjorn Helgaas wrote:
>On Tue, Nov 29, 2016 at 03:55:46PM +1100, Gavin Shan wrote:
>> On Mon, Nov 28, 2016 at 10:15:06PM -0600, Bjorn Helgaas wrote:
>> >Previously pci_update_resource() used the same code path for updating
>> >standard BARs and VF BARs in SR-IOV capabilities.
>> >
>> >Split the VF BAR update into a new pci_iov_update_resource() internal
>> >interface, which makes it simpler to compute the BAR address (we can get
>> >rid of pci_resource_bar() and pci_iov_resource_bar()).
>> >
>> >This patch:
>> >
>> >  - Renames pci_update_resource() to pci_std_update_resource(),
>> >  - Adds pci_iov_update_resource(),
>> >  - Makes pci_update_resource() a wrapper that calls the appropriate one,
>> >
>> >No functional change intended.
>> >
>> >Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> 
>> With below minor comments fixed:
>> 
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> 
>> >---
>> > drivers/pci/iov.c       |   49 +++++++++++++++++++++++++++++++++++++++++++++++
>> > drivers/pci/pci.h       |    1 +
>> > drivers/pci/setup-res.c |   13 +++++++++++-
>> > 3 files changed, 61 insertions(+), 2 deletions(-)
>> >
>> >diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
>> >index d41ec29..d00ed5c 100644
>> >--- a/drivers/pci/iov.c
>> >+++ b/drivers/pci/iov.c
>> >@@ -571,6 +571,55 @@ int pci_iov_resource_bar(struct pci_dev *dev, int resno)
>> > 		4 * (resno - PCI_IOV_RESOURCES);
>> > }
>> >
>> >+/**
>> >+ * pci_iov_update_resource - update a VF BAR
>> >+ * @dev: the PCI device
>> >+ * @resno: the resource number
>> >+ *
>> >+ * Update a VF BAR in the SR-IOV capability of a PF.
>> >+ */
>> >+void pci_iov_update_resource(struct pci_dev *dev, int resno)
>> >+{
>> >+	struct pci_sriov *iov = dev->is_physfn ? dev->sriov : NULL;
>> >+	struct resource *res = dev->resource + resno;
>> >+	int vf_bar = resno - PCI_IOV_RESOURCES;
>> >+	struct pci_bus_region region;
>> >+	u32 new;
>> >+	int reg;
>> >+
>> >+	/*
>> >+	 * The generic pci_restore_bars() path calls this for all devices,
>> >+	 * including VFs and non-SR-IOV devices.  If this is not a PF, we
>> >+	 * have nothing to do.
>> >+	 */
>> >+	if (!iov)
>> >+		return;
>> >+
>> >+	/*
>> >+	 * Ignore unimplemented BARs, unused resource slots for 64-bit
>> >+	 * BARs, and non-movable resources, e.g., those described via
>> >+	 * Enhanced Allocation.
>> >+	 */
>> >+	if (!res->flags)
>> >+		return;
>> >+
>> >+	if (res->flags & IORESOURCE_UNSET)
>> >+		return;
>> >+
>> >+	if (res->flags & IORESOURCE_PCI_FIXED)
>> >+		return;
>> >+
>> >+	pcibios_resource_to_bus(dev->bus, &region, res);
>> >+	new = region.start;
>> >+
>> 
>> The bits indicating the BAR's property (e.g. memory, IO etc) are missed in @new.
>
>Hmm, yes.  I omitted those because those bits are supposed to be
>read-only, per spec (PCI r3.0, sec 6.2.5.1).  But I guess it would be
>more conservative to keep them, and this shouldn't be needlessly
>different from pci_std_update_resource().
>

Yeah, Agree.

>However, I don't think this code in pci_update_resource() is obviously
>correct:
>
>  new = region.start | (res->flags & PCI_REGION_FLAG_MASK);
>
>PCI_REGION_FLAG_MASK is 0xf.  For memory BARs, bits 0-3 are read-only
>property bits.  For I/O BARs, bits 0-1 are read-only and bits 2-3 are
>part of the address, so on the face of it, the above could corrupt two
>bits of an I/O address.
>
>It's true that decode_bar() initializes flags correctly, using
>PCI_BASE_ADDRESS_IO_MASK for I/O BARs and PCI_BASE_ADDRESS_MEM_MASK
>for memory BARs, but it would take a little more digging to be sure
>that we never set bits 2-3 of flags for an I/O resource elsewhere.
>

The BAR's property bits are probed from device-tree, not hardware
on some platforms (e.g. pSeries). Also, there is only one (property)
bit if it's a ROM BAR. So more check as below might be needed because
the code (without the enhancement) should also work fine.

>How about this in pci_std_update_resource():
>
>        pcibios_resource_to_bus(dev->bus, &region, res);
>        new = region.start;
>
>        if (res->flags & IORESOURCE_IO) {
>                mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
>                new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
>        } else {
>                mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
>                new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
>        }
>

	if (res->flags & IORESOURCE_IO) {
		mask = (u32)PCI_BASE_ADDRESS_IO_MASK;
		new |= res->flags & ~PCI_BASE_ADDRESS_IO_MASK;
	} else if (resno < PCI_ROM_RESOURCE) {
		mask = (u32)PCI_BASE_ADDRESS_MEM_MASK;
		new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
	} else if (resno == PCI_ROM_RESOURCE) {
		mask = ~((u32)IORESOURCE_ROM_ENABLE);
		new |= res->flags & IORESOURCE_ROM_ENABLE);
	} else {
		dev_warn(&dev->dev, "BAR#%d out of range\n", resno);
		return;
	}


>and this in pci_iov_update_resource():
>
>        pcibios_resource_to_bus(dev->bus, &region, res);
>        new = region.start;
>        new |= res->flags & ~PCI_BASE_ADDRESS_MEM_MASK;
>
>It shouldn't fix anything, but I think it is more obvious that we
>can't corrupt bits 2-3 of an I/O BAR.
>

Agree and the this part of changes look good to me.

>> >+	reg = iov->pos + PCI_SRIOV_BAR + 4 * vf_bar;
>> >+	pci_write_config_dword(dev, reg, new);
>> >+	if (res->flags & IORESOURCE_MEM_64) {
>> >+		new = region.start >> 16 >> 16;
>> 
>> I think it was copied from pci_update_resource(). Why we can't just have "new = region.start >> 32"? 
>
>Right; I did copy this from pci_update_resource().  The changelog from
>cf7bee5a0bf2 ("[PATCH] Fix restore of 64-bit PCI BAR's") says "Also
>make sure to write high bits - use "x >> 16 >> 16" (rather than the
>simpler ">> 32") to avoid warnings on 32-bit architectures where we're
>not going to have any high bits."
>
>I didn't take the time to revalidate whether that's still applicable.
>

Ah, I see. I think we still need this on 32-bits systems.

>> >+void pci_update_resource(struct pci_dev *dev, int resno)
>> >+{
>> >+	if (resno <= PCI_ROM_RESOURCE)
>> >+		pci_std_update_resource(dev, resno);
>> >+#ifdef CONFIG_PCI_IOV
>> >+	else if (resno >= PCI_IOV_RESOURCES && resno < PCI_IOV_RESOURCE_END)
>> 
>> The last BAR is missed:
>> 
>> 	else if (resno >= PCI_IOV_RESOURCES && resno <= PCI_IOV_RESOURCE_END)
>
>Ah, right, thanks!
>
>> >+		pci_iov_update_resource(dev, resno);
>--
>To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
