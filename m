Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 03/18] IB/ehca: Don't use phys_to_abs(), it's a nop
Date: Thu, 26 Jul 2012 17:19:49 +1000
Message-Id: <1343287204-7700-3-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
References: <1343287204-7700-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since commit f5339277 phys_to_abs() is 100% a nop, so just remove it.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/infiniband/hw/ehca/ehca_mrmw.c |   33 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index b781b2c..47baa54 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1870,9 +1870,8 @@ static int ehca_set_pagebuf_user1(struct ehca_mr_pginfo *pginfo,
 		for (i = pginfo->u.usr.next_nmap; i < chunk->nmap; ) {
 			pgaddr = page_to_pfn(sg_page(&chunk->page_list[i]))
 				<< PAGE_SHIFT ;
-			*kpage = phys_to_abs(pgaddr +
-					     (pginfo->next_hwpage *
-					      pginfo->hwpage_size));
+			*kpage = pgaddr + (pginfo->next_hwpage *
+					   pginfo->hwpage_size);
 			if ( !(*kpage) ) {
 				ehca_gen_err("pgaddr=%llx "
 					     "chunk->page_list[i]=%llx "
@@ -1927,7 +1926,7 @@ static int ehca_check_kpages_per_ate(struct scatterlist *page_list,
 		u64 pgaddr = page_to_pfn(sg_page(&page_list[t])) << PAGE_SHIFT;
 		if (ehca_debug_level >= 3)
 			ehca_gen_dbg("chunk_page=%llx value=%016llx", pgaddr,
-				     *(u64 *)abs_to_virt(phys_to_abs(pgaddr)));
+				     *(u64 *)abs_to_virt(pgaddr));
 		if (pgaddr - PAGE_SIZE != *prev_pgaddr) {
 			ehca_gen_err("uncontiguous page found pgaddr=%llx "
 				     "prev_pgaddr=%llx page_list_i=%x",
@@ -1962,7 +1961,7 @@ static int ehca_set_pagebuf_user2(struct ehca_mr_pginfo *pginfo,
 			if (nr_kpages == kpages_per_hwpage) {
 				pgaddr = ( page_to_pfn(sg_page(&chunk->page_list[i]))
 					   << PAGE_SHIFT );
-				*kpage = phys_to_abs(pgaddr);
+				*kpage = pgaddr;
 				if ( !(*kpage) ) {
 					ehca_gen_err("pgaddr=%llx i=%x",
 						     pgaddr, i);
@@ -1990,13 +1989,11 @@ static int ehca_set_pagebuf_user2(struct ehca_mr_pginfo *pginfo,
 						 (pginfo->hwpage_size - 1)) >>
 						PAGE_SHIFT;
 					nr_kpages -= pginfo->kpage_cnt;
-					*kpage = phys_to_abs(
-						pgaddr &
-						~(pginfo->hwpage_size - 1));
+					*kpage = pgaddr &
+						 ~(pginfo->hwpage_size - 1);
 				}
 				if (ehca_debug_level >= 3) {
-					u64 val = *(u64 *)abs_to_virt(
-						phys_to_abs(pgaddr));
+					u64 val = *(u64 *)abs_to_virt(pgaddr);
 					ehca_gen_dbg("kpage=%llx chunk_page=%llx "
 						     "value=%016llx",
 						     *kpage, pgaddr, val);
@@ -2084,9 +2081,8 @@ static int ehca_set_pagebuf_phys(struct ehca_mr_pginfo *pginfo,
 					     pginfo->num_hwpages, i);
 				return -EFAULT;
 			}
-			*kpage = phys_to_abs(
-				(pbuf->addr & ~(pginfo->hwpage_size - 1)) +
-				(pginfo->next_hwpage * pginfo->hwpage_size));
+			*kpage = (pbuf->addr & ~(pginfo->hwpage_size - 1)) +
+				 (pginfo->next_hwpage * pginfo->hwpage_size);
 			if ( !(*kpage) && pbuf->addr ) {
 				ehca_gen_err("pbuf->addr=%llx pbuf->size=%llx "
 					     "next_hwpage=%llx", pbuf->addr,
@@ -2124,8 +2120,8 @@ static int ehca_set_pagebuf_fmr(struct ehca_mr_pginfo *pginfo,
 	/* loop over desired page_list entries */
 	fmrlist = pginfo->u.fmr.page_list + pginfo->u.fmr.next_listelem;
 	for (i = 0; i < number; i++) {
-		*kpage = phys_to_abs((*fmrlist & ~(pginfo->hwpage_size - 1)) +
-				     pginfo->next_hwpage * pginfo->hwpage_size);
+		*kpage = (*fmrlist & ~(pginfo->hwpage_size - 1)) +
+			   pginfo->next_hwpage * pginfo->hwpage_size;
 		if ( !(*kpage) ) {
 			ehca_gen_err("*fmrlist=%llx fmrlist=%p "
 				     "next_listelem=%llx next_hwpage=%llx",
@@ -2152,8 +2148,7 @@ static int ehca_set_pagebuf_fmr(struct ehca_mr_pginfo *pginfo,
 			u64 prev = *kpage;
 			/* check if adrs are contiguous */
 			for (j = 1; j < cnt_per_hwpage; j++) {
-				u64 p = phys_to_abs(fmrlist[j] &
-						    ~(pginfo->hwpage_size - 1));
+				u64 p = fmrlist[j] & ~(pginfo->hwpage_size - 1);
 				if (prev + pginfo->u.fmr.fmr_pgsize != p) {
 					ehca_gen_err("uncontiguous fmr pages "
 						     "found prev=%llx p=%llx "
@@ -2388,8 +2383,8 @@ static int ehca_update_busmap(unsigned long pfn, unsigned long nr_pages)
 		memset(ehca_bmap, 0xFF, EHCA_TOP_MAP_SIZE);
 	}
 
-	start_section = phys_to_abs(pfn * PAGE_SIZE) / EHCA_SECTSIZE;
-	end_section = phys_to_abs((pfn + nr_pages) * PAGE_SIZE) / EHCA_SECTSIZE;
+	start_section = (pfn * PAGE_SIZE) / EHCA_SECTSIZE;
+	end_section = ((pfn + nr_pages) * PAGE_SIZE) / EHCA_SECTSIZE;
 	for (i = start_section; i < end_section; i++) {
 		int ret;
 		top = ehca_calc_index(i, EHCA_TOP_INDEX_SHIFT);
-- 
1.7.9.5
