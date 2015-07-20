Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A947D1A094B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:46:56 +1000 (AEST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 20 Jul 2015 20:46:56 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id BECEE2CE804E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:46:52 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6KAkhcB2032072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:46:52 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6KAkJJx029245
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 20:46:19 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel] powerpc/powernv/ioda2: Fix calculation for memory
 allocated for TCE table
Date: Mon, 20 Jul 2015 20:45:51 +1000
Message-Id: <1437389151-4042-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing code stores the amount of memory allocated for a TCE table.
At the moment it uses @offset which is a virtual offset in the TCE table
which is only correct for a one level tables and it does not include
memory allocated for intermediate levels. When multilevel TCE table is
requested, WARN_ON in tce_iommu_create_table() prints a warning.

This adds an additional counter to pnv_pci_ioda2_table_do_alloc_pages()
to count actually allocated memory.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

I was sure I sent it already but could not find it anywhere so reposting.
Sorry if it is a duplicate.


---
 arch/powerpc/platforms/powernv/pci-ioda.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5738d31..85cbc96 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2220,7 +2220,7 @@ static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb)
 
 static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
 		unsigned levels, unsigned long limit,
-		unsigned long *current_offset)
+		unsigned long *current_offset, unsigned long *total_allocated)
 {
 	struct page *tce_mem = NULL;
 	__be64 *addr, *tmp;
@@ -2236,6 +2236,7 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
 	}
 	addr = page_address(tce_mem);
 	memset(addr, 0, allocated);
+	*total_allocated += allocated;
 
 	--levels;
 	if (!levels) {
@@ -2245,7 +2246,7 @@ static __be64 *pnv_pci_ioda2_table_do_alloc_pages(int nid, unsigned shift,
 
 	for (i = 0; i < entries; ++i) {
 		tmp = pnv_pci_ioda2_table_do_alloc_pages(nid, shift,
-				levels, limit, current_offset);
+				levels, limit, current_offset, total_allocated);
 		if (!tmp)
 			break;
 
@@ -2267,7 +2268,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 		struct iommu_table *tbl)
 {
 	void *addr;
-	unsigned long offset = 0, level_shift;
+	unsigned long offset = 0, level_shift, total_allocated = 0;
 	const unsigned window_shift = ilog2(window_size);
 	unsigned entries_shift = window_shift - page_shift;
 	unsigned table_shift = max_t(unsigned, entries_shift + 3, PAGE_SHIFT);
@@ -2286,7 +2287,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 
 	/* Allocate TCE table */
 	addr = pnv_pci_ioda2_table_do_alloc_pages(nid, level_shift,
-			levels, tce_table_size, &offset);
+			levels, tce_table_size, &offset, &total_allocated);
 
 	/* addr==NULL means that the first level allocation failed */
 	if (!addr)
@@ -2308,7 +2309,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid, __u64 bus_offset,
 			page_shift);
 	tbl->it_level_size = 1ULL << (level_shift - 3);
 	tbl->it_indirect_levels = levels - 1;
-	tbl->it_allocated_size = offset;
+	tbl->it_allocated_size = total_allocated;
 
 	pr_devel("Created TCE table: ws=%08llx ts=%lx @%08llx\n",
 			window_size, tce_table_size, bus_offset);
-- 
2.4.0.rc3.8.gfb3e7d5
