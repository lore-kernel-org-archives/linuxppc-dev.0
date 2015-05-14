Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A30861A03DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:32:44 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 14 May 2015 14:32:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id AD5E82CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:32:40 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4E4WWJu39911632
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:32:40 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4E4W7w8012141
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 14:32:08 +1000
Date: Thu, 14 May 2015 14:31:42 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH kernel v10 25/34] powerpc/powernv/ioda2: Introduce
 helpers to allocate TCE pages
Message-ID: <20150514043142.GA20566@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-26-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431358763-24371-26-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 12, 2015 at 01:39:14AM +1000, Alexey Kardashevskiy wrote:
>This is a part of moving TCE table allocation into an iommu_ops
>callback to support multiple IOMMU groups per one VFIO container.
>
>This moves the code which allocates the actual TCE tables to helpers:
>pnv_pci_ioda2_table_alloc_pages() and pnv_pci_ioda2_table_free_pages().
>These do not allocate/free the iommu_table struct.
>
>This enforces window size to be a power of two.
>
>This should cause no behavioural change.
>
>Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

>---
>Changes:
>v10:
>* removed @table_group parameter from pnv_pci_create_table as it was not used
>* removed *tce_table_allocated from pnv_alloc_tce_table_pages()
>* pnv_pci_create_table/pnv_pci_free_table renamed to
>pnv_pci_ioda2_table_alloc_pages/pnv_pci_ioda2_table_free_pages and moved
>back to pci-ioda.c as these only allocate pages for IODA2 and there is
>no chance they will be reused for IODA1/P5IOC2
>* shortened subject line
>
>v9:
>* moved helpers to the common powernv pci.c file from pci-ioda.c
>* moved bits from pnv_pci_create_table() to pnv_alloc_tce_table_pages()
>---
> arch/powerpc/platforms/powernv/pci-ioda.c | 82 +++++++++++++++++++++++--------
> 1 file changed, 62 insertions(+), 20 deletions(-)
>
>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>index 9b80b74..7d98d83 100644
>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>@@ -49,6 +49,8 @@
> /* 256M DMA window, 4K TCE pages, 8 bytes TCE */
> #define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
>
>+static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl);
>+
> static void pe_level_printk(const struct pnv_ioda_pe *pe, const char *level,
> 			    const char *fmt, ...)
> {
>@@ -1313,8 +1315,8 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev, struct pnv_ioda_pe
> 		iommu_group_put(pe->table_group.group);
> 		BUG_ON(pe->table_group.group);
> 	}
>+	pnv_pci_ioda2_table_free_pages(tbl);
> 	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
>-	free_pages(addr, get_order(TCE32_TABLE_SIZE));
> }
>
> static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>@@ -2034,13 +2036,62 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
> };
> #endif
>
>-static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>-				       struct pnv_ioda_pe *pe)
>+static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift)
> {
> 	struct page *tce_mem = NULL;
>+	__be64 *addr;
>+	unsigned order = max_t(unsigned, shift, PAGE_SHIFT) - PAGE_SHIFT;
>+
>+	tce_mem = alloc_pages_node(nid, GFP_KERNEL, order);
>+	if (!tce_mem) {
>+		pr_err("Failed to allocate a TCE memory, order=%d\n", order);
>+		return NULL;
>+	}
>+	addr = page_address(tce_mem);
>+	memset(addr, 0, 1UL << (order + PAGE_SHIFT));
>+
>+	return addr;
>+}
>+
>+static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
>+		__u32 page_shift, __u64 window_size, struct iommu_table *tbl)
>+{

It seems that pci-ioda.c has the convention to have u32/u64, instead of
__u32/__u64.

Thanks,
Gavin

> 	void *addr;
>+	const unsigned window_shift = ilog2(window_size);
>+	unsigned entries_shift = window_shift - page_shift;
>+	unsigned table_shift = max_t(unsigned, entries_shift + 3, PAGE_SHIFT);
>+	const unsigned long tce_table_size = 1UL << table_shift;
>+
>+	if ((window_size > memory_hotplug_max()) || !is_power_of_2(window_size))
>+		return -EINVAL;
>+
>+	/* Allocate TCE table */
>+	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, table_shift);
>+	if (!addr)
>+		return -ENOMEM;
>+
>+	/* Setup linux iommu table */
>+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, bus_offset,
>+			page_shift);
>+
>+	pr_devel("Created TCE table: ws=%08llx ts=%lx @%08llx\n",
>+			window_size, tce_table_size, bus_offset);
>+
>+	return 0;
>+}
>+
>+static void pnv_pci_ioda2_table_free_pages(struct iommu_table *tbl)
>+{
>+	if (!tbl->it_size)
>+		return;
>+
>+	free_pages(tbl->it_base, get_order(tbl->it_size << 3));
>+}
>+
>+static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>+				       struct pnv_ioda_pe *pe)
>+{
> 	struct iommu_table *tbl;
>-	unsigned int tce_table_size, end;
> 	int64_t rc;
>
> 	/* We shouldn't already have a 32-bit DMA associated */
>@@ -2059,24 +2110,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>
> 	/* The PE will reserve all possible 32-bits space */
> 	pe->tce32_seg = 0;
>-	end = (1 << ilog2(phb->ioda.m32_pci_base));
>-	tce_table_size = (end / 0x1000) * 8;
> 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>-		end);
>+		phb->ioda.m32_pci_base);
>
>-	/* Allocate TCE table */
>-	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
>-				   get_order(tce_table_size));
>-	if (!tce_mem) {
>-		pe_err(pe, "Failed to allocate a 32-bit TCE memory\n");
>+	/* Setup linux iommu table */
>+	rc = pnv_pci_ioda2_table_alloc_pages(pe->phb->hose->node,
>+			0, IOMMU_PAGE_SHIFT_4K, phb->ioda.m32_pci_base, tbl);
>+	if (rc) {
>+		pe_err(pe, "Failed to create 32-bit TCE table, err %ld", rc);
> 		goto fail;
> 	}
>-	addr = page_address(tce_mem);
>-	memset(addr, 0, tce_table_size);
>-
>-	/* Setup linux iommu table */
>-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
>-			IOMMU_PAGE_SHIFT_4K);
>
> 	tbl->it_ops = &pnv_ioda2_iommu_ops;
> 	iommu_init_table(tbl, phb->hose->node);
>@@ -2122,9 +2165,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
> fail:
> 	if (pe->tce32_seg >= 0)
> 		pe->tce32_seg = -1;
>-	if (tce_mem)
>-		__free_pages(tce_mem, get_order(tce_table_size));
> 	if (tbl) {
>+		pnv_pci_ioda2_table_free_pages(tbl);
> 		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
> 		iommu_free_table(tbl, "pnv");
> 	}
>-- 
>2.4.0.rc3.8.gfb3e7d5
>
