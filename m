Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 557A71A001D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:04:12 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 12 May 2015 10:04:10 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id A238A2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:04:07 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4C03ws039977198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:04:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4C03XQ4026729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 10:03:34 +1000
Date: Tue, 12 May 2015 10:03:08 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH v4 07/21] powerpc/powernv: Release PEs dynamically
Message-ID: <20150512000308.GC4646@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1430460188-31343-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1430460188-31343-8-git-send-email-gwshan@linux.vnet.ibm.com>
 <554E00EB.5070802@ozlabs.ru> <20150511062553.GB28073@gwshan>
 <555053F0.1000409@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <555053F0.1000409@ozlabs.ru>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 11, 2015 at 05:02:08PM +1000, Alexey Kardashevskiy wrote:
>On 05/11/2015 04:25 PM, Gavin Shan wrote:
>>On Sat, May 09, 2015 at 10:43:23PM +1000, Alexey Kardashevskiy wrote:
>>>On 05/01/2015 04:02 PM, Gavin Shan wrote:
>>>>The original code doesn't support releasing PEs dynamically, meaning
>>>>that PE and the associated resources (IO, M32, M64 and DMA) can't
>>>>be released when unplugging a PCI adapter from one hotpluggable slot.
>>>>
>>>>The patch takes object oriented methodology, introducs reference
>>>>count to PE, which is initialized to 1 and increased with 1 when a
>>>>new PCI device joins the PE. Once the last PCI device leaves the
>>>>PE, the PE is going to be release together with its associated
>>>>(IO, M32, M64, DMA) resources.
>>>
>>>
>>>Too little commit log for non-trivial non-cut-n-paste 30KB patch...
>>>
>>
>>Ok. I'll add more details in next revision.
>>
>>>>
>>>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>>>---
>>>>  arch/powerpc/include/asm/pci-bridge.h     |   3 +
>>>>  arch/powerpc/kernel/pci-hotplug.c         |   5 +
>>>>  arch/powerpc/platforms/powernv/pci-ioda.c | 658 +++++++++++++++++++-----------
>>>>  arch/powerpc/platforms/powernv/pci.h      |   4 +-
>>>>  4 files changed, 432 insertions(+), 238 deletions(-)
>>>>
>>>>diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
>>>>index 5367eb3..a6ad4b1 100644
>>>>--- a/arch/powerpc/include/asm/pci-bridge.h
>>>>+++ b/arch/powerpc/include/asm/pci-bridge.h
>>>>@@ -31,6 +31,9 @@ struct pci_controller_ops {
>>>>  	resource_size_t (*window_alignment)(struct pci_bus *, unsigned long type);
>>>>  	void		(*setup_bridge)(struct pci_bus *, unsigned long);
>>>>  	void		(*reset_secondary_bus)(struct pci_dev *dev);
>>>>+
>>>>+	/* Called when PCI device is released */
>>>>+	void		(*release_device)(struct pci_dev *);
>>>>  };
>>>>
>>>>  /*
>>>>diff --git a/arch/powerpc/kernel/pci-hotplug.c b/arch/powerpc/kernel/pci-hotplug.c
>>>>index 7ed85a6..0040343 100644
>>>>--- a/arch/powerpc/kernel/pci-hotplug.c
>>>>+++ b/arch/powerpc/kernel/pci-hotplug.c
>>>>@@ -29,6 +29,11 @@
>>>>   */
>>>>  void pcibios_release_device(struct pci_dev *dev)
>>>>  {
>>>>+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>>>>+
>>>>+	if (hose->controller_ops.release_device)
>>>>+		hose->controller_ops.release_device(dev);
>>>>+
>>>>  	eeh_remove_device(dev);
>>>>  }
>>>>
>>>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>index 910fb67..ef8c216 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>>>@@ -12,6 +12,8 @@
>>>>  #undef DEBUG
>>>>
>>>>  #include <linux/kernel.h>
>>>>+#include <linux/atomic.h>
>>>>+#include <linux/kref.h>
>>>>  #include <linux/pci.h>
>>>>  #include <linux/crash_dump.h>
>>>>  #include <linux/debugfs.h>
>>>>@@ -47,6 +49,8 @@
>>>>  /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
>>>>  #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
>>>>
>>>>+static void pnv_ioda_release_pe(struct kref *kref);
>>>>+
>>>>  static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
>>>>  			    const char *fmt, ...)
>>>>  {
>>>>@@ -123,25 +127,400 @@ static inline bool pnv_pci_is_mem_pref_64(unsigned long flags)
>>>>  		(IORESOURCE_MEM_64 | IORESOURCE_PREFETCH));
>>>>  }
>>>>
>>>>-static void pnv_ioda_reserve_pe(struct pnv_phb *phb, int pe_no)
>>>>+static inline void pnv_ioda_pe_get(struct pnv_ioda_pe *pe)
>>>>  {
>>>>-	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
>>>>-		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>>>>-			__func__, pe_no, phb->hose->global_number);
>>>>+	if (!pe)
>>>>+		return;
>>>>+
>>>>+	kref_get(&pe->kref);
>>>>+}
>>>>+
>>>>+static inline void pnv_ioda_pe_put(struct pnv_ioda_pe *pe)
>>>>+{
>>>>+	unsigned int count;
>>>>+
>>>>+	if (!pe)
>>>>  		return;
>>>>+
>>>>+	/*
>>>>+	 * The count is initialized to 1 and increased with 1 when
>>>>+	 * a new PCI device is bound with the PE. Once the last PCI
>>>>+	 * device is leaving from the PE, the PE is going to be
>>>>+	 * released.
>>>>+	 */
>>>>+	count = atomic_read(&pe->kref.refcount);
>>>>+	if (count == 2)
>>>>+		kref_sub(&pe->kref, 2, pnv_ioda_release_pe);
>>>>+	else
>>>>+		kref_put(&pe->kref, pnv_ioda_release_pe);
>>>
>>>
>>>What if pnv_ioda_pe_get() gets called between atomic_read() and kref_sub()?
>>>
>>
>>Yeah, that would have problem. But it shouldn't happen because the
>>PCI devices are joining the parent PE# in strictly serialized mode.
>>Same thing happens when detaching PCI devices from its parent PE.
>
>
>oookay. Another thing then - why is this kref counter initialized to 1?
>It would make sense if you did something special when the counter becomes 1
>after decrement but you do not.
>
>Also, this kref thing makes sense if you do kref_put() in multiple places and
>do not know which one will be the last one so you pass the callback to all of
>them. Here you do kref_put/sub in one place and you read the counter - so you
>can call pnv_ioda_release_pe() directly. And it feels like a simple atomic_t
>would do the job just fine. If you still feel that the counter should start
>from 1, there are atomic_dec_if_positive() and atomic_inc_not_zero() and
>others.
>

It's good question actually. The counter is initialized to 1 when the PE
is reserved because of M64 requirement or allocated for non-M64 case. If
we reserve or allocate PE#, there is one thing for sure: the PCI bus has
one PCI device (including PCI bridge) at least. After the PE# is reserved
or allocated, the PCI device joins the PE with the result of increasing
the counter with 1. It means the counter is 2 when PE contains one PCI
device, and 3 when there're 2 devices. One reason for this design is that
we just need decrease the counter if we have to release this PE in the
window between PE reservation/allocation and first PCI device joins. I
think you're correct that we can call pnv_ioda_release_pe() in this window.
In this way, the counter is always reflecting the number of PCI devices
the PE contains.

>>>>+}
>>>>+
>>>>+static void pnv_pci_release_device(struct pci_dev *pdev)
>>>>+{
>>>>+	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
>>>>+	struct pnv_phb *phb = hose->private_data;
>>>>+	struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>+	struct pnv_ioda_pe *pe;
>>>>+
>>>>+	if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>>>+		pe = &phb->ioda.pe_array[pdn->pe_number];
>>>>+		pnv_ioda_pe_put(pe);
>>>>+		pdn->pe_number = IODA_INVALID_PE;
>>>>  	}
>>>>+}
>>>>
>>>>-	if (test_and_set_bit(pe_no, phb->ioda.pe_alloc)) {
>>>>-		pr_warn("%s: PE %d was assigned on PHB#%x\n",
>>>>-			__func__, pe_no, phb->hose->global_number);
>>>>+static void pnv_ioda_release_pe_dma(struct pnv_ioda_pe *pe)
>>>>+{
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>+	int index, count;
>>>>+	unsigned long tbl_addr, tbl_size;
>>>>+
>>>>+	/* No DMA capability for slave PEs */
>>>>+	if (pe->flags & PNV_IODA_PE_SLAVE)
>>>>+		return;
>>>>+
>>>>+	/* Bypass DMA window */
>>>>+	if (phb->type == PNV_PHB_IODA2 &&
>>>>+	    pe->tce_bypass_enabled &&
>>>>+	    pe->tce32_table &&
>>>>+	    pe->tce32_table->set_bypass)
>>>>+		pe->tce32_table->set_bypass(pe->tce32_table, false);
>>>>+
>>>>+	/* 32-bits DMA window */
>>>>+	count = pe->tce32_seg_end - pe->tce32_seg_start;
>>>>+	tbl_addr = pe->tce32_table->it_base;
>>>>+	if (!count)
>>>>  		return;
>>>>+
>>>>+	/* Free IOMMU table */
>>>>+	iommu_free_table(pe->tce32_table,
>>>>+			 of_node_full_name(phb->hose->dn));
>>>>+
>>>>+	/* Deconfigure TCE table */
>>>>+	switch (phb->type) {
>>>>+	case PNV_PHB_IODA1:
>>>>+		for (index = 0; index < count; index++)
>>>>+			opal_pci_map_pe_dma_window(phb->opal_id,
>>>>+						   pe->pe_number,
>>>>+						   pe->tce32_seg_start + index,
>>>>+						   1,
>>>>+						   __pa(tbl_addr) +
>>>>+						   index * TCE32_TABLE_SIZE,
>>>>+						   0,
>>>>+						   0x1000);
>>>>+		bitmap_clear(phb->ioda.tce32_segmap,
>>>>+			     pe->tce32_seg_start,
>>>>+			     count);
>>>>+		tbl_size = TCE32_TABLE_SIZE * count;
>>>>+		break;
>>>>+	case PNV_PHB_IODA2:
>>>>+		opal_pci_map_pe_dma_window(phb->opal_id,
>>>>+					   pe->pe_number,
>>>>+					   pe->pe_number << 1,
>>>>+					   1,
>>>>+					   __pa(tbl_addr),
>>>>+					   0,
>>>>+					   0x1000);
>>>>+		tbl_size = (1ul << ilog2(phb->ioda.m32_pci_base));
>>>>+		tbl_size = (tbl_size >> IOMMU_PAGE_SHIFT_4K) * 8;
>>>>+		break;
>>>>+	default:
>>>>+		pe_warn(pe, "Unsupported PHB type %d\n", phb->type);
>>>>+		return;
>>>>+	}
>>>>+
>>>>+	/* Free memory of IOMMU table */
>>>>+	free_pages(tbl_addr, get_order(tbl_size));
>>>
>>>
>>>You just programmed the table address to TVT and then you are releasing the
>>>pages. It does not seem right, it will leave garbage in TVT. Also, I am
>>>adding helpers to alloc/free TCE pages in DDW patchset, you could reuse bits
>>>from there (I'll post v10 soon, you'll be in copy and you'll have to review
>>>that ;) ).
>>>
>>
>>I assume you're talking about TVE. I don't understand how garbage will be left
>>in TVE. opal_pci_map_pe_dma_window(), which is handled by skiboot, clear TVE
>>with zero'ed "tce_table_size". The pages previously allocated for TCE table is
>>released to buddy system, which can be allocated by somebody else (from buddy
>>or slab).
>
>opal_pci_map_pe_dma_window() takes __pa(tbl_addr) which points to some memory
>which is still allocated. This value goes to a table (which has 2 entries per
>PE, one for 32bit DMA window and one for bypass/hugewindow) which PHB uses to
>get the actual TCE table address. What is the name of this table? :) Anyway,
>you write an address there and then you call free_pages() so after
>free_pages(), the value in that TVE/TVT/whatever table is a garbage.
>

I don't look into your DDW code yet. Before we have DDW patchset, the bypass
TVE (window) isn't supposed to have corresponding TCE table. I guess you might
change the behaviour in your DDW patchset and I'll take a close look on that.
For DMA32 window, which is the name of the table, the TVE is cleared by skiboot
when having zero "tce_table_size" argument.

	opal_pci_map_pe_dma_window(phb->opal_id,
				   pe->pe_number,
				   pe->pe_number << 1,
				   1,
				   __pa(tbl_addr),
				   0,			<<<< "tce_table_size".
				   0x1000);

>
>>
>>Ok. Please put me into the cc list. I guess the whole series of patches is
>>better to rebased on your DDW patchset, which is to be merged first, I believe.
>>
>>>
>>>>+	pe->tce32_table = NULL;
>>>>+	pe->tce32_seg_start = 0;
>>>>+	pe->tce32_seg_end = 0;
>>>>+}
>>>>+
>>>>+static void pnv_ioda_release_pe_seg(struct pnv_ioda_pe *pe)
>>>>+{
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>+	unsigned long *segmap = NULL, *pe_segmap = NULL;
>>>>+	int i;
>>>>+	uint16_t win, win_type[] = { OPAL_IO_WINDOW_TYPE,
>>>>+				     OPAL_M32_WINDOW_TYPE,
>>>>+				     OPAL_M64_WINDOW_TYPE };
>>>>+
>>>>+	for (win = 0; win < ARRAY_SIZE(win_type); win++) {
>>>>+		switch (win_type[win]) {
>>>>+		case OPAL_IO_WINDOW_TYPE:
>>>>+			segmap = phb->ioda.io_segmap;
>>>>+			pe_segmap = pe->io_segmap;
>>>>+			break;
>>>>+		case OPAL_M32_WINDOW_TYPE:
>>>>+			segmap = phb->ioda.m32_segmap;
>>>>+			pe_segmap = pe->m32_segmap;
>>>>+			break;
>>>>+		case OPAL_M64_WINDOW_TYPE:
>>>>+			segmap = phb->ioda.m64_segmap;
>>>>+			pe_segmap = pe->m64_segmap;
>>>>+			break;
>>>>+		}
>>>>+		i = -1;
>>>>+		while ((i = find_next_bit(pe_segmap,
>>>>+			phb->ioda.total_pe, i + 1)) < phb->ioda.total_pe) {
>>>>+			if (win_type[win] == OPAL_IO_WINDOW_TYPE ||
>>>>+			    win_type[win] == OPAL_M32_WINDOW_TYPE)
>>>>+				opal_pci_map_pe_mmio_window(phb->opal_id,
>>>>+						phb->ioda.reserved_pe,
>>>>+						win_type[win], 0, i);
>>>>+			else if (phb->type == PNV_PHB_IODA1)
>>>>+				opal_pci_map_pe_mmio_window(phb->opal_id,
>>>>+						phb->ioda.reserved_pe,
>>>>+						win_type[win],
>>>>+						i / 8, i % 8);
>>>
>>>The function is called ""release" but it programs something what looks like
>>>reasonable values, is it correct?
>>>
>>
>>It's out of problem, When the segment is deallocated, it's mapped to the
>>reserved PE#.
>>
>>>
>>>
>>>>+
>>>>+			clear_bit(i, pe_segmap);
>>>>+			clear_bit(i, segmap);
>>>>+		}
>>>>+	}
>>>>+}
>>>>+
>>>>+static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
>>>>+				  struct pnv_ioda_pe *parent,
>>>>+				  struct pnv_ioda_pe *child,
>>>>+				  bool is_add)
>>>>+{
>>>>+	const char *desc = is_add ? "adding" : "removing";
>>>>+	uint8_t op = is_add ? OPAL_ADD_PE_TO_DOMAIN :
>>>>+			      OPAL_REMOVE_PE_FROM_DOMAIN;
>>>>+	struct pnv_ioda_pe *slave;
>>>>+	long rc;
>>>>+
>>>>+	/* Parent PE affects child PE */
>>>>+	rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
>>>>+				child->pe_number, op);
>>>>+	if (rc != OPAL_SUCCESS) {
>>>>+		pe_warn(child, "OPAL error %ld %s to parent PELTV\n",
>>>>+			rc, desc);
>>>>+		return -ENXIO;
>>>>+	}
>>>>+
>>>>+	if (!(child->flags & PNV_IODA_PE_MASTER))
>>>>+		return 0;
>>>>+
>>>>+	/* Compound case: parent PE affects slave PEs */
>>>>+	list_for_each_entry(slave, &child->slaves, list) {
>>>>+		rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
>>>>+					slave->pe_number, op);
>>>>+		if (rc != OPAL_SUCCESS) {
>>>>+			pe_warn(slave, "OPAL error %ld %s to parent PELTV\n",
>>>>+				rc, desc);
>>>>+			return -ENXIO;
>>>>+		}
>>>>+	}
>>>>+
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+static int pnv_ioda_set_peltv(struct pnv_ioda_pe *pe, bool is_add)
>>>>+{
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>+	struct pnv_ioda_pe *slave;
>>>>+	struct pci_dev *pdev = NULL;
>>>>+	int ret;
>>>>+
>>>>+	/*
>>>>+	 * Clear PE frozen state. If it's master PE, we need
>>>>+	 * clear slave PE frozen state as well.
>>>>+	 */
>>>>+	opal_pci_eeh_freeze_clear(phb->opal_id,
>>>>+				  pe->pe_number,
>>>>+				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>>>+	if (pe->flags & PNV_IODA_PE_MASTER) {
>>>>+		list_for_each_entry(slave, &pe->slaves, list) {
>>>>+			opal_pci_eeh_freeze_clear(phb->opal_id,
>>>>+						  slave->pe_number,
>>>>+						  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>>>+		}
>>>>+	}
>>>>+
>>>>+	/*
>>>>+	 * Associate PE in PELT. We need add the PE into the
>>>>+	 * corresponding PELT-V as well. Otherwise, the error
>>>>+	 * originated from the PE might contribute to other
>>>>+	 * PEs.
>>>>+	 */
>>>>+	ret = pnv_ioda_set_one_peltv(phb, pe, pe, is_add);
>>>>+	if (ret)
>>>>+		return ret;
>>>>+
>>>>+	/* For compound PEs, any one affects all of them */
>>>>+	if (pe->flags & PNV_IODA_PE_MASTER) {
>>>>+		list_for_each_entry(slave, &pe->slaves, list) {
>>>>+			ret = pnv_ioda_set_one_peltv(phb, slave, pe, is_add);
>>>>+			if (ret)
>>>>+				return ret;
>>>>+		}
>>>>+	}
>>>>+
>>>>+	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
>>>>+		pdev = pe->pbus->self;
>>>>+	else if (pe->flags & PNV_IODA_PE_DEV)
>>>>+		pdev = pe->pdev->bus->self;
>>>>+#ifdef CONFIG_PCI_IOV
>>>>+	else if (pe->flags & PNV_IODA_PE_VF)
>>>>+		pdev = pe->parent_dev->bus->self;
>>>>+#endif /* CONFIG_PCI_IOV */
>>>>+
>>>>+	while (pdev) {
>>>>+		struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>+		struct pnv_ioda_pe *parent;
>>>>+
>>>>+		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>>>+			parent = &phb->ioda.pe_array[pdn->pe_number];
>>>>+			ret = pnv_ioda_set_one_peltv(phb, parent, pe, is_add);
>>>>+			if (ret)
>>>>+				return ret;
>>>>+		}
>>>>+
>>>>+		pdev = pdev->bus->self;
>>>>+	}
>>>>+
>>>>+	return 0;
>>>>+}
>>>>+
>>>>+static void pnv_ioda_deconfigure_pe(struct pnv_ioda_pe *pe)
>>>
>>>
>>>It used to be under #ifdef CONFIG_PCI_IOV, now it is not. Looks like just
>>>moving of this function to a different place deserves a separate patch with a
>>>comment why ("it is going to be used now for non-SRIOV case too" may be?).
>>>
>>
>>Yeah, it makes sense to me. Will fix it up.
>>
>>>
>>>>+{
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>+	struct pci_dev *parent;
>>>>+	uint8_t bcomp, dcomp, fcomp;
>>>>+	long rid_end, rid;
>>>>+	int64_t rc;
>>>>+
>>>>+	/* Tear down MVE */
>>>>+	if (phb->type == PNV_PHB_IODA1 &&
>>>>+	    pe->mve_number != -1) {
>>>>+		rc = opal_pci_set_mve(phb->opal_id,
>>>>+				      pe->mve_number,
>>>>+				      phb->ioda.reserved_pe);
>>>>+		if (rc != OPAL_SUCCESS)
>>>>+			pe_warn(pe, "Error %lld unmapping MVE#%d\n",
>>>>+				rc, pe->mve_number);
>>>>+		rc = opal_pci_set_mve_enable(phb->opal_id,
>>>>+					     pe->mve_number,
>>>>+					     OPAL_DISABLE_MVE);
>>>>+		if (rc != OPAL_SUCCESS)
>>>>+			pe_warn(pe, "Error %lld disabling MVE#%d\n",
>>>>+				rc, pe->mve_number);
>>>>+		pe->mve_number = -1;
>>>>+	}
>>>>+
>>>>+	/* Unmapping PELTV */
>>>>+	pnv_ioda_set_peltv(pe, false);
>>>>+
>>>>+	/* To unmap PELTM */
>>>>+	if (pe->pbus) {
>>>>+		int count;
>>>>+
>>>>+		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
>>>>+		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
>>>>+		parent = pe->pbus->self;
>>>>+		if (pe->flags & PNV_IODA_PE_BUS_ALL)
>>>>+			count = pe->pbus->busn_res.end -
>>>>+				pe->pbus->busn_res.start + 1;
>>>>+		else
>>>>+			count = 1;
>>>>+
>>>>+		switch(count) {
>>>>+		case  1: bcomp = OpalPciBusAll;   break;
>>>>+		case  2: bcomp = OpalPciBus7Bits; break;
>>>>+		case  4: bcomp = OpalPciBus6Bits; break;
>>>>+		case  8: bcomp = OpalPciBus5Bits; break;
>>>>+		case 16: bcomp = OpalPciBus4Bits; break;
>>>>+		case 32: bcomp = OpalPciBus3Bits; break;
>>>>+		default:
>>>>+			/* Fail back to case of one bus */
>>>>+			pe_warn(pe, "Cannot support %d buses\n", count);
>>>>+			bcomp = OpalPciBusAll;
>>>>+		}
>>>>+		rid_end = pe->rid + (count << 8);
>>>>+	} else {
>>>>+#ifdef CONFIG_PCI_IOV
>>>>+		if (pe->flags & PNV_IODA_PE_VF)
>>>>+			parent = pe->parent_dev;
>>>>+		else
>>>>+#endif
>>>>+			parent = pe->pdev->bus->self;
>>>>+		bcomp = OpalPciBusAll;
>>>>+		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
>>>>+		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
>>>>+		rid_end = pe->rid + 1;
>>>>+	}
>>>>+
>>>>+	/* Clear RID mapping */
>>>>+	for (rid = pe->rid; rid < rid_end; rid++)
>>>>+		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>>>+
>>>>+	/* Unmapping PELTM */
>>>>+	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
>>>>+			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
>>>>+	if (rc)
>>>>+		pe_warn(pe, "Error %ld unmapping PELTM\n", rc);
>>>>+}
>>>>+
>>>>+static void pnv_ioda_release_pe(struct kref *kref)
>>>>+{
>>>>+	struct pnv_ioda_pe *pe = container_of(kref, struct pnv_ioda_pe, kref);
>>>>+	struct pnv_ioda_pe *tmp, *slave;
>>>>+	struct pnv_phb *phb = pe->phb;
>>>>+
>>>>+	pnv_ioda_release_pe_dma(pe);
>>>>+	pnv_ioda_release_pe_seg(pe);
>>>>+	pnv_ioda_deconfigure_pe(pe);
>>>>+
>>>>+	/* Release slave PEs for compound PE */
>>>>+	if (pe->flags & PNV_IODA_PE_MASTER) {
>>>>+		list_for_each_entry_safe(slave, tmp, &pe->slaves, list)
>>>>+			pnv_ioda_pe_put(slave);
>>>>+	}
>>>>+
>>>>+	/* Remove the PE from various list. We need remove slave
>>>>+	 * PE from master's list.
>>>>+	 */
>>>>+	list_del(&pe->dma_link);
>>>>+	list_del(&pe->list);
>>>>+
>>>>+	/* Free PE number */
>>>>+	clear_bit(pe->pe_number, phb->ioda.pe_alloc);
>>>>+}
>>>>+
>>>>+static struct pnv_ioda_pe *pnv_ioda_init_pe(struct pnv_phb *phb,
>>>>+					    int pe_no)
>>>>+{
>>>>+	struct pnv_ioda_pe *pe = &phb->ioda.pe_array[pe_no];
>>>>+
>>>>+	kref_init(&pe->kref);
>>>>+	pe->phb = phb;
>>>>+	pe->pe_number = pe_no;
>>>>+	INIT_LIST_HEAD(&pe->dma_link);
>>>>+	INIT_LIST_HEAD(&pe->list);
>>>>+
>>>>+	return pe;
>>>>+}
>>>>+
>>>>+static struct pnv_ioda_pe *pnv_ioda_reserve_pe(struct pnv_phb *phb,
>>>>+					       int pe_no)
>>>>+{
>>>>+	if (!(pe_no >= 0 && pe_no < phb->ioda.total_pe)) {
>>>>+		pr_warn("%s: Invalid PE %d on PHB#%x\n",
>>>>+			__func__, pe_no, phb->hose->global_number);
>>>>+		return NULL;
>>>>  	}
>>>>
>>>>-	phb->ioda.pe_array[pe_no].phb = phb;
>>>>-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
>>>>+	/*
>>>>+	 * Same PE might be reserved for multiple times, which
>>>>+	 * is out of problem actually.
>>>>+	 */
>>>>+	set_bit(pe_no, phb->ioda.pe_alloc);
>>>>+	return pnv_ioda_init_pe(phb, pe_no);
>>>>  }
>>>>
>>>>-static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>>>+static struct pnv_ioda_pe *pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>>>  {
>>>>  	unsigned long pe_no;
>>>>  	unsigned long limit = phb->ioda.total_pe - 1;
>>>>@@ -154,20 +533,10 @@ static int pnv_ioda_alloc_pe(struct pnv_phb *phb)
>>>>  			break;
>>>>
>>>>  		if (--limit >= phb->ioda.total_pe)
>>>>-			return IODA_INVALID_PE;
>>>>+			return NULL;
>>>>  	} while(1);
>>>>
>>>>-	phb->ioda.pe_array[pe_no].phb = phb;
>>>>-	phb->ioda.pe_array[pe_no].pe_number = pe_no;
>>>>-	return pe_no;
>>>>-}
>>>>-
>>>>-static void pnv_ioda_free_pe(struct pnv_phb *phb, int pe)
>>>>-{
>>>>-	WARN_ON(phb->ioda.pe_array[pe].pdev);
>>>>-
>>>>-	memset(&phb->ioda.pe_array[pe], 0, sizeof(struct pnv_ioda_pe));
>>>>-	clear_bit(pe, phb->ioda.pe_alloc);
>>>>+	return pnv_ioda_init_pe(phb, pe_no);
>>>>  }
>>>>
>>>>  static int pnv_ioda1_init_m64(struct pnv_phb *phb)
>>>>@@ -382,8 +751,9 @@ static void pnv_ioda_reserve_m64_pe(struct pnv_phb *phb,
>>>>  	}
>>>>  }
>>>>
>>>>-static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>>>-				struct pci_bus *bus, int all)
>>>>+static struct pnv_ioda_pe *pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>>>+						struct pci_bus *bus,
>>>>+						int all)
>>>
>>>
>>>Mechanic changes like this could easily go to a separate patch.
>>>
>>
>>Indeed. I'll see how I can split the patches up in next revision.
>>Thanks for the suggestion.
>>
>>>>  {
>>>>  	resource_size_t segsz = phb->ioda.m64_segsize;
>>>>  	struct pci_dev *pdev;
>>>>@@ -394,14 +764,14 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>>>  	int i;
>>>>
>>>>  	if (!pnv_ioda_need_m64_pe(phb, bus))
>>>>-		return IODA_INVALID_PE;
>>>>+		return NULL;
>>>>
>>>>          /* Allocate bitmap */
>>>>  	size = _ALIGN_UP(phb->ioda.total_pe / 8, sizeof(unsigned long));
>>>>  	pe_bitsmap = kzalloc(size, GFP_KERNEL);
>>>>  	if (!pe_bitsmap) {
>>>>  		pr_warn("%s: Out of memory !\n", __func__);
>>>>-		return IODA_INVALID_PE;
>>>>+		return NULL;
>>>>  	}
>>>>
>>>>  	/* The bridge's M64 window might be extended to PHB's M64
>>>>@@ -438,7 +808,7 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>>>  	/* No M64 window found ? */
>>>>  	if (bitmap_empty(pe_bitsmap, phb->ioda.total_pe)) {
>>>>  		kfree(pe_bitsmap);
>>>>-		return IODA_INVALID_PE;
>>>>+		return NULL;
>>>>  	}
>>>>
>>>>  	/* Figure out the master PE and put all slave PEs
>>>>@@ -491,7 +861,7 @@ static int pnv_ioda_pick_m64_pe(struct pnv_phb *phb,
>>>>  	}
>>>>
>>>>  	kfree(pe_bitsmap);
>>>>-	return master_pe->pe_number;
>>>>+	return master_pe;
>>>>  }
>>>>
>>>>  static void __init pnv_ioda_parse_m64_window(struct pnv_phb *phb)
>>>>@@ -695,7 +1065,7 @@ static int pnv_ioda_get_pe_state(struct pnv_phb *phb, int pe_no)
>>>>   * but in the meantime, we need to protect them to avoid warnings
>>>>   */
>>>>  #ifdef CONFIG_PCI_MSI
>>>>-static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
>>>>+static struct pnv_ioda_pe *pnv_ioda_pci_dev_to_pe(struct pci_dev *dev)
>>>>  {
>>>>  	struct pci_controller *hose = pci_bus_to_host(dev->bus);
>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>@@ -709,191 +1079,6 @@ static struct pnv_ioda_pe *pnv_ioda_get_pe(struct pci_dev *dev)
>>>>  }
>>>>  #endif /* CONFIG_PCI_MSI */
>>>>
>>>>-static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
>>>>-				  struct pnv_ioda_pe *parent,
>>>>-				  struct pnv_ioda_pe *child,
>>>>-				  bool is_add)
>>>>-{
>>>>-	const char *desc = is_add ? "adding" : "removing";
>>>>-	uint8_t op = is_add ? OPAL_ADD_PE_TO_DOMAIN :
>>>>-			      OPAL_REMOVE_PE_FROM_DOMAIN;
>>>>-	struct pnv_ioda_pe *slave;
>>>>-	long rc;
>>>>-
>>>>-	/* Parent PE affects child PE */
>>>>-	rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
>>>>-				child->pe_number, op);
>>>>-	if (rc != OPAL_SUCCESS) {
>>>>-		pe_warn(child, "OPAL error %ld %s to parent PELTV\n",
>>>>-			rc, desc);
>>>>-		return -ENXIO;
>>>>-	}
>>>>-
>>>>-	if (!(child->flags & PNV_IODA_PE_MASTER))
>>>>-		return 0;
>>>>-
>>>>-	/* Compound case: parent PE affects slave PEs */
>>>>-	list_for_each_entry(slave, &child->slaves, list) {
>>>>-		rc = opal_pci_set_peltv(phb->opal_id, parent->pe_number,
>>>>-					slave->pe_number, op);
>>>>-		if (rc != OPAL_SUCCESS) {
>>>>-			pe_warn(slave, "OPAL error %ld %s to parent PELTV\n",
>>>>-				rc, desc);
>>>>-			return -ENXIO;
>>>>-		}
>>>>-	}
>>>>-
>>>>-	return 0;
>>>>-}
>>>>-
>>>>-static int pnv_ioda_set_peltv(struct pnv_phb *phb,
>>>>-			      struct pnv_ioda_pe *pe,
>>>>-			      bool is_add)
>>>>-{
>>>>-	struct pnv_ioda_pe *slave;
>>>>-	struct pci_dev *pdev = NULL;
>>>>-	int ret;
>>>>-
>>>>-	/*
>>>>-	 * Clear PE frozen state. If it's master PE, we need
>>>>-	 * clear slave PE frozen state as well.
>>>>-	 */
>>>>-	if (is_add) {
>>>>-		opal_pci_eeh_freeze_clear(phb->opal_id, pe->pe_number,
>>>>-					  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>>>-		if (pe->flags & PNV_IODA_PE_MASTER) {
>>>>-			list_for_each_entry(slave, &pe->slaves, list)
>>>>-				opal_pci_eeh_freeze_clear(phb->opal_id,
>>>>-							  slave->pe_number,
>>>>-							  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>>>-		}
>>>>-	}
>>>>-
>>>>-	/*
>>>>-	 * Associate PE in PELT. We need add the PE into the
>>>>-	 * corresponding PELT-V as well. Otherwise, the error
>>>>-	 * originated from the PE might contribute to other
>>>>-	 * PEs.
>>>>-	 */
>>>>-	ret = pnv_ioda_set_one_peltv(phb, pe, pe, is_add);
>>>>-	if (ret)
>>>>-		return ret;
>>>>-
>>>>-	/* For compound PEs, any one affects all of them */
>>>>-	if (pe->flags & PNV_IODA_PE_MASTER) {
>>>>-		list_for_each_entry(slave, &pe->slaves, list) {
>>>>-			ret = pnv_ioda_set_one_peltv(phb, slave, pe, is_add);
>>>>-			if (ret)
>>>>-				return ret;
>>>>-		}
>>>>-	}
>>>>-
>>>>-	if (pe->flags & (PNV_IODA_PE_BUS_ALL | PNV_IODA_PE_BUS))
>>>>-		pdev = pe->pbus->self;
>>>>-	else if (pe->flags & PNV_IODA_PE_DEV)
>>>>-		pdev = pe->pdev->bus->self;
>>>>-#ifdef CONFIG_PCI_IOV
>>>>-	else if (pe->flags & PNV_IODA_PE_VF)
>>>>-		pdev = pe->parent_dev->bus->self;
>>>>-#endif /* CONFIG_PCI_IOV */
>>>>-	while (pdev) {
>>>>-		struct pci_dn *pdn = pci_get_pdn(pdev);
>>>>-		struct pnv_ioda_pe *parent;
>>>>-
>>>>-		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>>>-			parent = &phb->ioda.pe_array[pdn->pe_number];
>>>>-			ret = pnv_ioda_set_one_peltv(phb, parent, pe, is_add);
>>>>-			if (ret)
>>>>-				return ret;
>>>>-		}
>>>>-
>>>>-		pdev = pdev->bus->self;
>>>>-	}
>>>>-
>>>>-	return 0;
>>>>-}
>>>>-
>>>>-#ifdef CONFIG_PCI_IOV
>>>>-static int pnv_ioda_deconfigure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>>>-{
>>>>-	struct pci_dev *parent;
>>>>-	uint8_t bcomp, dcomp, fcomp;
>>>>-	int64_t rc;
>>>>-	long rid_end, rid;
>>>>-
>>>>-	/* Currently, we just deconfigure VF PE. Bus PE will always there.*/
>>>>-	if (pe->pbus) {
>>>>-		int count;
>>>>-
>>>>-		dcomp = OPAL_IGNORE_RID_DEVICE_NUMBER;
>>>>-		fcomp = OPAL_IGNORE_RID_FUNCTION_NUMBER;
>>>>-		parent = pe->pbus->self;
>>>>-		if (pe->flags & PNV_IODA_PE_BUS_ALL)
>>>>-			count = pe->pbus->busn_res.end - pe->pbus->busn_res.start + 1;
>>>>-		else
>>>>-			count = 1;
>>>>-
>>>>-		switch(count) {
>>>>-		case  1: bcomp = OpalPciBusAll;         break;
>>>>-		case  2: bcomp = OpalPciBus7Bits;       break;
>>>>-		case  4: bcomp = OpalPciBus6Bits;       break;
>>>>-		case  8: bcomp = OpalPciBus5Bits;       break;
>>>>-		case 16: bcomp = OpalPciBus4Bits;       break;
>>>>-		case 32: bcomp = OpalPciBus3Bits;       break;
>>>>-		default:
>>>>-			dev_err(&pe->pbus->dev, "Number of subordinate buses %d unsupported\n",
>>>>-			        count);
>>>>-			/* Do an exact match only */
>>>>-			bcomp = OpalPciBusAll;
>>>>-		}
>>>>-		rid_end = pe->rid + (count << 8);
>>>>-	} else {
>>>>-		if (pe->flags & PNV_IODA_PE_VF)
>>>>-			parent = pe->parent_dev;
>>>>-		else
>>>>-			parent = pe->pdev->bus->self;
>>>>-		bcomp = OpalPciBusAll;
>>>>-		dcomp = OPAL_COMPARE_RID_DEVICE_NUMBER;
>>>>-		fcomp = OPAL_COMPARE_RID_FUNCTION_NUMBER;
>>>>-		rid_end = pe->rid + 1;
>>>>-	}
>>>>-
>>>>-	/* Clear the reverse map */
>>>>-	for (rid = pe->rid; rid < rid_end; rid++)
>>>>-		phb->ioda.pe_rmap[rid] = IODA_INVALID_PE;
>>>>-
>>>>-	/* Release from all parents PELT-V */
>>>>-	while (parent) {
>>>>-		struct pci_dn *pdn = pci_get_pdn(parent);
>>>>-		if (pdn && pdn->pe_number != IODA_INVALID_PE) {
>>>>-			rc = opal_pci_set_peltv(phb->opal_id, pdn->pe_number,
>>>>-						pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
>>>>-			/* XXX What to do in case of error ? */
>>>
>>>
>>>Not much :) Free associated memory and mark it "dead" so it won't be used
>>>again till reboot. In what circumstance can this opal_pci_set_peltv() fail at
>>>all?
>>>
>>
>>Yeah, maybe. Until now, I didn't see this failure since the code is there
>>from the day. Note the code has been there for almost 4 years since the
>>day Ben wrote it.
>
>
>Sure. But if it starts failing, we won't even notice it - there is no even
>pr_err() or WARN_ON.
>

Agree. I'll see what I can do. At least I can have error message to alert.

>>
>>>
>>>>-		}
>>>>-		parent = parent->bus->self;
>>>>-	}
>>>>-
>>>>-	opal_pci_eeh_freeze_set(phb->opal_id, pe->pe_number,
>>>>-				  OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
>>>>-
>>>>-	/* Disassociate PE in PELT */
>>>>-	rc = opal_pci_set_peltv(phb->opal_id, pe->pe_number,
>>>>-				pe->pe_number, OPAL_REMOVE_PE_FROM_DOMAIN);
>>>>-	if (rc)
>>>>-		pe_warn(pe, "OPAL error %ld remove self from PELTV\n", rc);
>>>>-	rc = opal_pci_set_pe(phb->opal_id, pe->pe_number, pe->rid,
>>>>-			     bcomp, dcomp, fcomp, OPAL_UNMAP_PE);
>>>>-	if (rc)
>>>>-		pe_err(pe, "OPAL error %ld trying to setup PELT table\n", rc);
>>>>-
>>>>-	pe->pbus = NULL;
>>>>-	pe->pdev = NULL;
>>>>-	pe->parent_dev = NULL;
>>>>-
>>>>-	return 0;
>>>>-}
>>>>-#endif /* CONFIG_PCI_IOV */
>>>>-
>>>>  static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>>>  {
>>>>  	struct pci_dev *parent;
>>>>@@ -953,7 +1138,7 @@ static int pnv_ioda_configure_pe(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
>>>>  	}
>>>>
>>>>  	/* Configure PELTV */
>>>>-	pnv_ioda_set_peltv(phb, pe, true);
>>>>+	pnv_ioda_set_peltv(pe, true);
>>>>
>>>>  	/* Setup reverse map */
>>>>  	for (rid = pe->rid; rid < rid_end; rid++)
>>>>@@ -1207,6 +1392,8 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>>>  		if (pdn->pe_number != IODA_INVALID_PE)
>>>>  			continue;
>>>>
>>>>+		/* Increase reference count of the parent PE */
>>>
>>>When you comment like this, I read it as the comment belongs to the whole
>>>next chunk till the first empty line, i.e. to all 5 lines below, which is not
>>>the case. I'd remove the comment as 1) "pe_get" in pnv_ioda_pe_get() name
>>>suggests incrementing the reference counter 2) "pe" is always parent in this
>>>function. I do not insist though.
>>>
>>
>>Agree on your explaining. I'll remove this unuseful comments.
>>
>>>
>>>>+		pnv_ioda_pe_get(pe);
>>>>  		pdn->pe_number = pe->pe_number;
>>>>  		pe->dma_weight += pnv_ioda_dev_dma_weight(dev);
>>>>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>>>>@@ -1224,7 +1411,7 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>>>>  {
>>>>  	struct pci_controller *hose = pci_bus_to_host(bus);
>>>>  	struct pnv_phb *phb = hose->private_data;
>>>>-	struct pnv_ioda_pe *pe;
>>>>+	struct pnv_ioda_pe *pe = NULL;
>>>>  	int pe_num = IODA_INVALID_PE;
>>>>
>>>>  	/* For partial hotplug case, the PE instance hasn't been destroyed
>>>>@@ -1240,24 +1427,24 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>>>>  	}
>>>>
>>>>  	/* PE number for root bus should have been reserved */
>>>>-	if (pci_is_root_bus(bus))
>>>>-		pe_num = phb->ioda.root_pe_no;
>>>>+	if (pci_is_root_bus(bus) &&
>>>>+	    phb->ioda.root_pe_no != IODA_INVALID_PE)
>>>>+		pe = &phb->ioda.pe_array[phb->ioda.root_pe_no];
>>>>
>>>>  	/* Check if PE is determined by M64 */
>>>>-	if (pe_num == IODA_INVALID_PE && phb->pick_m64_pe)
>>>>-		pe_num = phb->pick_m64_pe(phb, bus, all);
>>>>+	if (!pe && phb->pick_m64_pe)
>>>>+		pe = phb->pick_m64_pe(phb, bus, all);
>>>>
>>>>  	/* The PE number isn't pinned by M64 */
>>>>-	if (pe_num == IODA_INVALID_PE)
>>>>-		pe_num = pnv_ioda_alloc_pe(phb);
>>>>+	if (!pe)
>>>>+		pe = pnv_ioda_alloc_pe(phb);
>>>>
>>>>-	if (pe_num == IODA_INVALID_PE) {
>>>>-		pr_warning("%s: Not enough PE# available for PCI bus %04x:%02x\n",
>>>>+	if (!pe) {
>>>>+		pr_warn("%s: No enough PE# available for PCI bus %04x:%02x\n",
>>>>  			__func__, pci_domain_nr(bus), bus->number);
>>>>  		return NULL;
>>>>  	}
>>>>
>>>>-	pe = &phb->ioda.pe_array[pe_num];
>>>>  	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>>>>  	pe->pbus = bus;
>>>>  	pe->pdev = NULL;
>>>>@@ -1274,14 +1461,12 @@ static struct pnv_ioda_pe *pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>>>>
>>>>  	if (pnv_ioda_configure_pe(phb, pe)) {
>>>>  		/* XXX What do we do here ? */
>>>>-		if (pe_num)
>>>>-			pnv_ioda_free_pe(phb, pe_num);
>>>>-		pe->pbus = NULL;
>>>>+		pnv_ioda_pe_put(pe);
>>>>  		return NULL;
>>>>  	}
>>>>
>>>>  	pe->tce32_table = kzalloc_node(sizeof(struct iommu_table),
>>>>-			GFP_KERNEL, hose->node);
>>>>+				       GFP_KERNEL, hose->node);
>>>
>>>Seems like spaces change only - if you really want this change (which I hate
>>>- makes code look inaccurate to my taste but it seems I am in minority here
>>>:) ), please put it to the separate patch.
>>>
>>
>>Ok. Confirm with you: You prefer the original format? I don't know
>>why I prefer the later one. Maybe my eyes are quite broken :-)
>
>
>I prefer not to change existing whitespaces unless it is done once and for
>the entire file :) Just remove this change from the patch.
>

Sure.

>>>
>>>>  	pe->tce32_table->data = pe;
>>>>
>>>>  	/* Associate it with all child devices */
>>>>@@ -1521,9 +1706,9 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>>>  		list_del(&pe->list);
>>>>  		mutex_unlock(&phb->ioda.pe_list_mutex);
>>>>
>>>>-		pnv_ioda_deconfigure_pe(phb, pe);
>>>>+		pnv_ioda_deconfigure_pe(pe);
>>>
>>>
>>>Is this change necessary to get "Release PEs dynamically" working? Move it to
>>>mechanical changes patch may be?
>>>
>>
>>Ok. I'll try to do that.
>>
>>>
>>>>
>>>>-		pnv_ioda_free_pe(phb, pe->pe_number);
>>>>+		pnv_ioda_pe_put(pe);
>>>>  	}
>>>>  }
>>>>
>>>>@@ -1601,9 +1786,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>>>
>>>>  		if (pnv_ioda_configure_pe(phb, pe)) {
>>>>  			/* XXX What do we do here ? */
>>>>-			if (pe_num)
>>>>-				pnv_ioda_free_pe(phb, pe_num);
>>>>-			pe->pdev = NULL;
>>>>+			pnv_ioda_pe_put(pe);
>>>>  			continue;
>>>>  		}
>>>>
>>>>@@ -2263,7 +2446,7 @@ int pnv_phb_to_cxl_mode(struct pci_dev *dev, uint64_t mode)
>>>>  	struct pnv_ioda_pe *pe;
>>>>  	int rc;
>>>>
>>>>-	pe = pnv_ioda_get_pe(dev);
>>>>+	pe = pnv_ioda_pci_dev_to_pe(dev);
>>>
>>>
>>>And this change could to separately. Not clear how this helps to "Release PEs
>>>dynamically".
>>>
>>>
>>
>>It's not related to "Release PEs dynamically". The change is introduced by
>>the function rename: Original pnv_ioda_get_pe() is renamed to pnv_ioda_pci_dev_to_pe().
>
>
>But the rename happened in this patch and the patch's subj is "Release PEs
>dynamically" so it should be related somehow or move it to a simple separate
>patch "let's give the lalala function a better name to reflect what it
>actually does" (but in this case the new name does not make any more sense
>than the old one).
>

Yeah, I'll try to split the patches to separate blala and walala :-)

>>>>  	if (!pe)
>>>>  		return -ENODEV;
>>>>
>>>>@@ -2379,7 +2562,7 @@ int pnv_cxl_ioda_msi_setup(struct pci_dev *dev, unsigned int hwirq,
>>>>  	struct pnv_ioda_pe *pe;
>>>>  	int rc;
>>>>
>>>>-	if (!(pe = pnv_ioda_get_pe(dev)))
>>>>+	if (!(pe = pnv_ioda_pci_dev_to_pe(dev)))
>>>>  		return -ENODEV;
>>>>
>>>>  	/* Assign XIVE to PE */
>>>>@@ -2401,7 +2584,7 @@ static int pnv_pci_ioda_msi_setup(struct pnv_phb *phb, struct pci_dev *dev,
>>>>  				  unsigned int hwirq, unsigned int virq,
>>>>  				  unsigned int is_64, struct msi_msg *msg)
>>>>  {
>>>>-	struct pnv_ioda_pe *pe = pnv_ioda_get_pe(dev);
>>>>+	struct pnv_ioda_pe *pe = pnv_ioda_pci_dev_to_pe(dev);
>>>>  	unsigned int xive_num = hwirq - phb->msi_base;
>>>>  	__be32 data;
>>>>  	int rc;
>>>>@@ -3065,6 +3248,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>>  	pnv_pci_controller_ops.setup_bridge = pnv_pci_setup_bridge;
>>>>  	pnv_pci_controller_ops.window_alignment = pnv_pci_window_alignment;
>>>>  	pnv_pci_controller_ops.reset_secondary_bus = pnv_pci_reset_secondary_bus;
>>>>+	pnv_pci_controller_ops.release_device = pnv_pci_release_device;
>>>>  	hose->controller_ops = pnv_pci_controller_ops;
>>>>
>>>>  #ifdef CONFIG_PCI_IOV
>>>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>>>index 1bea3a8..8b10f01 100644
>>>>--- a/arch/powerpc/platforms/powernv/pci.h
>>>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>>>@@ -28,6 +28,7 @@ enum pnv_phb_model {
>>>>  /* Data associated with a PE, including IOMMU tracking etc.. */
>>>>  struct pnv_phb;
>>>>  struct pnv_ioda_pe {
>>>>+	struct kref		kref;
>>>>  	unsigned long		flags;
>>>>  	struct pnv_phb		*phb;
>>>>
>>>>@@ -120,7 +121,8 @@ struct pnv_phb {
>>>>  	void (*shutdown)(struct pnv_phb *phb);
>>>>  	int (*init_m64)(struct pnv_phb *phb);
>>>>  	void (*reserve_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus);
>>>>-	int (*pick_m64_pe)(struct pnv_phb *phb, struct pci_bus *bus, int all);
>>>>+	struct pnv_ioda_pe *(*pick_m64_pe)(struct pnv_phb *phb,
>>>>+					   struct pci_bus *bus, int all);
>>>>  	int (*get_pe_state)(struct pnv_phb *phb, int pe_no);
>>>>  	void (*freeze_pe)(struct pnv_phb *phb, int pe_no);
>>>>  	int (*unfreeze_pe)(struct pnv_phb *phb, int pe_no, int opt);
>>>>

Thanks,
Gavin
