Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 07/18] IB/ehca: Remove uses of virt_to_abs() and abs_to_virt()
Date: Thu, 26 Jul 2012 17:19:53 +1000
Message-Id: <1343287204-7700-7-git-send-email-michael@ellerman.id.au>
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

abs_to_virt() simply calls __va() and we'd like to get rid of it,
so replace all abs_to_virt() uses with __va().

__va() returns void *, so when assigning to a pointer there's no need
to cast.

Similarly virt_to_abs() just calls __pa().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/infiniband/hw/ehca/ehca_cq.c    |    2 +-
 drivers/infiniband/hw/ehca/ehca_eq.c    |    2 +-
 drivers/infiniband/hw/ehca/ehca_mrmw.c  |   16 ++++++++--------
 drivers/infiniband/hw/ehca/ehca_qp.c    |    6 +++---
 drivers/infiniband/hw/ehca/ehca_reqs.c  |    2 +-
 drivers/infiniband/hw/ehca/ehca_tools.h |    1 -
 drivers/infiniband/hw/ehca/hcp_if.c     |   12 ++++++------
 drivers/infiniband/hw/ehca/ipz_pt_fn.c  |    2 +-
 8 files changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_cq.c b/drivers/infiniband/hw/ehca/ehca_cq.c
index d9b0ebc..8f52901 100644
--- a/drivers/infiniband/hw/ehca/ehca_cq.c
+++ b/drivers/infiniband/hw/ehca/ehca_cq.c
@@ -220,7 +220,7 @@ struct ib_cq *ehca_create_cq(struct ib_device *device, int cqe, int comp_vector,
 			cq = ERR_PTR(-EAGAIN);
 			goto create_cq_exit4;
 		}
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 
 		h_ret = hipz_h_register_rpage_cq(adapter_handle,
 						 my_cq->ipz_cq_handle,
diff --git a/drivers/infiniband/hw/ehca/ehca_eq.c b/drivers/infiniband/hw/ehca/ehca_eq.c
index 818d721..90da674 100644
--- a/drivers/infiniband/hw/ehca/ehca_eq.c
+++ b/drivers/infiniband/hw/ehca/ehca_eq.c
@@ -101,7 +101,7 @@ int ehca_create_eq(struct ehca_shca *shca,
 		if (!vpage)
 			goto create_eq_exit2;
 
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 		h_ret = hipz_h_register_rpage_eq(shca->ipz_hca_handle,
 						 eq->ipz_eq_handle,
 						 &eq->pf,
diff --git a/drivers/infiniband/hw/ehca/ehca_mrmw.c b/drivers/infiniband/hw/ehca/ehca_mrmw.c
index 47baa54..8784486 100644
--- a/drivers/infiniband/hw/ehca/ehca_mrmw.c
+++ b/drivers/infiniband/hw/ehca/ehca_mrmw.c
@@ -1136,7 +1136,7 @@ int ehca_reg_mr_rpages(struct ehca_shca *shca,
 		}
 
 		if (rnum > 1) {
-			rpage = virt_to_abs(kpage);
+			rpage = __pa(kpage);
 			if (!rpage) {
 				ehca_err(&shca->ib_device, "kpage=%p i=%x",
 					 kpage, i);
@@ -1231,7 +1231,7 @@ inline int ehca_rereg_mr_rereg1(struct ehca_shca *shca,
 			 pginfo->num_kpages, pginfo->num_hwpages, kpage);
 		goto ehca_rereg_mr_rereg1_exit1;
 	}
-	rpage = virt_to_abs(kpage);
+	rpage = __pa(kpage);
 	if (!rpage) {
 		ehca_err(&shca->ib_device, "kpage=%p", kpage);
 		ret = -EFAULT;
@@ -1525,7 +1525,7 @@ static inline void *ehca_calc_sectbase(int top, int dir, int idx)
 	unsigned long ret = idx;
 	ret |= dir << EHCA_DIR_INDEX_SHIFT;
 	ret |= top << EHCA_TOP_INDEX_SHIFT;
-	return abs_to_virt(ret << SECTION_SIZE_BITS);
+	return __va(ret << SECTION_SIZE_BITS);
 }
 
 #define ehca_bmap_valid(entry) \
@@ -1537,7 +1537,7 @@ static u64 ehca_reg_mr_section(int top, int dir, int idx, u64 *kpage,
 {
 	u64 h_ret = 0;
 	unsigned long page = 0;
-	u64 rpage = virt_to_abs(kpage);
+	u64 rpage = __pa(kpage);
 	int page_count;
 
 	void *sectbase = ehca_calc_sectbase(top, dir, idx);
@@ -1553,7 +1553,7 @@ static u64 ehca_reg_mr_section(int top, int dir, int idx, u64 *kpage,
 		for (rnum = 0; (rnum < MAX_RPAGES) && (page < page_count);
 		     rnum++) {
 			void *pg = sectbase + ((page++) * pginfo->hwpage_size);
-			kpage[rnum] = virt_to_abs(pg);
+			kpage[rnum] = __pa(pg);
 		}
 
 		h_ret = hipz_h_register_rpage_mr(shca->ipz_hca_handle, mr,
@@ -1926,7 +1926,7 @@ static int ehca_check_kpages_per_ate(struct scatterlist *page_list,
 		u64 pgaddr = page_to_pfn(sg_page(&page_list[t])) << PAGE_SHIFT;
 		if (ehca_debug_level >= 3)
 			ehca_gen_dbg("chunk_page=%llx value=%016llx", pgaddr,
-				     *(u64 *)abs_to_virt(pgaddr));
+				     *(u64 *)__va(pgaddr));
 		if (pgaddr - PAGE_SIZE != *prev_pgaddr) {
 			ehca_gen_err("uncontiguous page found pgaddr=%llx "
 				     "prev_pgaddr=%llx page_list_i=%x",
@@ -1993,7 +1993,7 @@ static int ehca_set_pagebuf_user2(struct ehca_mr_pginfo *pginfo,
 						 ~(pginfo->hwpage_size - 1);
 				}
 				if (ehca_debug_level >= 3) {
-					u64 val = *(u64 *)abs_to_virt(pgaddr);
+					u64 val = *(u64 *)__va(pgaddr);
 					ehca_gen_dbg("kpage=%llx chunk_page=%llx "
 						     "value=%016llx",
 						     *kpage, pgaddr, val);
@@ -2503,7 +2503,7 @@ static u64 ehca_map_vaddr(void *caddr)
 	if (!ehca_bmap)
 		return EHCA_INVAL_ADDR;
 
-	abs_addr = virt_to_abs(caddr);
+	abs_addr = __pa(caddr);
 	top = ehca_calc_index(abs_addr, EHCA_TOP_INDEX_SHIFT + EHCA_SECTSHIFT);
 	if (!ehca_bmap_valid(ehca_bmap->top[top]))
 		return EHCA_INVAL_ADDR;
diff --git a/drivers/infiniband/hw/ehca/ehca_qp.c b/drivers/infiniband/hw/ehca/ehca_qp.c
index 964f855..1493939 100644
--- a/drivers/infiniband/hw/ehca/ehca_qp.c
+++ b/drivers/infiniband/hw/ehca/ehca_qp.c
@@ -321,7 +321,7 @@ static inline int init_qp_queue(struct ehca_shca *shca,
 			ret = -EINVAL;
 			goto init_qp_queue1;
 		}
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 
 		h_ret = hipz_h_register_rpage_qp(ipz_hca_handle,
 						 my_qp->ipz_qp_handle,
@@ -1094,7 +1094,7 @@ static int prepare_sqe_rts(struct ehca_qp *my_qp, struct ehca_shca *shca,
 	ehca_dbg(&shca->ib_device, "qp_num=%x bad_send_wqe_p=%p",
 		 qp_num, bad_send_wqe_p);
 	/* convert wqe pointer to vadr */
-	bad_send_wqe_v = abs_to_virt((u64)bad_send_wqe_p);
+	bad_send_wqe_v = __va((u64)bad_send_wqe_p);
 	if (ehca_debug_level >= 2)
 		ehca_dmp(bad_send_wqe_v, 32, "qp_num=%x bad_wqe", qp_num);
 	squeue = &my_qp->ipz_squeue;
@@ -1138,7 +1138,7 @@ static int calc_left_cqes(u64 wqe_p, struct ipz_queue *ipz_queue,
 	/* convert real to abs address */
 	wqe_p = wqe_p & (~(1UL << 63));
 
-	wqe_v = abs_to_virt(wqe_p);
+	wqe_v = __va(wqe_p);
 
 	if (ipz_queue_abs_to_offset(ipz_queue, wqe_p, &q_ofs)) {
 		ehca_gen_err("Invalid offset for calculating left cqes "
diff --git a/drivers/infiniband/hw/ehca/ehca_reqs.c b/drivers/infiniband/hw/ehca/ehca_reqs.c
index fd05f48..47f9498 100644
--- a/drivers/infiniband/hw/ehca/ehca_reqs.c
+++ b/drivers/infiniband/hw/ehca/ehca_reqs.c
@@ -135,7 +135,7 @@ static void trace_send_wr_ud(const struct ib_send_wr *send_wr)
 				     mad_hdr->attr_mod);
 		}
 		for (j = 0; j < send_wr->num_sge; j++) {
-			u8 *data = (u8 *)abs_to_virt(sge->addr);
+			u8 *data = __va(sge->addr);
 			ehca_gen_dbg("send_wr#%x sge#%x addr=%p length=%x "
 				     "lkey=%x",
 				     idx, j, data, sge->length, sge->lkey);
diff --git a/drivers/infiniband/hw/ehca/ehca_tools.h b/drivers/infiniband/hw/ehca/ehca_tools.h
index 54c0d23..d280b12 100644
--- a/drivers/infiniband/hw/ehca/ehca_tools.h
+++ b/drivers/infiniband/hw/ehca/ehca_tools.h
@@ -59,7 +59,6 @@
 #include <linux/device.h>
 
 #include <linux/atomic.h>
-#include <asm/abs_addr.h>
 #include <asm/ibmebus.h>
 #include <asm/io.h>
 #include <asm/pgtable.h>
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index e6f9cdd..2d41d04 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -396,7 +396,7 @@ u64 hipz_h_query_port(const struct ipz_adapter_handle adapter_handle,
 		      struct hipz_query_port *query_port_response_block)
 {
 	u64 ret;
-	u64 r_cb = virt_to_abs(query_port_response_block);
+	u64 r_cb = __pa(query_port_response_block);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
 		ehca_gen_err("response block not page aligned");
@@ -438,7 +438,7 @@ u64 hipz_h_modify_port(const struct ipz_adapter_handle adapter_handle,
 u64 hipz_h_query_hca(const struct ipz_adapter_handle adapter_handle,
 		     struct hipz_query_hca *query_hca_rblock)
 {
-	u64 r_cb = virt_to_abs(query_hca_rblock);
+	u64 r_cb = __pa(query_hca_rblock);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
 		ehca_gen_err("response_block=%p not page aligned",
@@ -577,7 +577,7 @@ u64 hipz_h_modify_qp(const struct ipz_adapter_handle adapter_handle,
 				adapter_handle.handle, /* r4 */
 				qp_handle.handle,      /* r5 */
 				update_mask,	       /* r6 */
-				virt_to_abs(mqpcb),    /* r7 */
+				__pa(mqpcb),	       /* r7 */
 				0, 0, 0, 0, 0);
 
 	if (ret == H_NOT_ENOUGH_RESOURCES)
@@ -595,7 +595,7 @@ u64 hipz_h_query_qp(const struct ipz_adapter_handle adapter_handle,
 	return ehca_plpar_hcall_norets(H_QUERY_QP,
 				       adapter_handle.handle, /* r4 */
 				       qp_handle.handle,      /* r5 */
-				       virt_to_abs(qqpcb),    /* r6 */
+				       __pa(qqpcb),	      /* r6 */
 				       0, 0, 0, 0);
 }
 
@@ -787,7 +787,7 @@ u64 hipz_h_register_rpage_mr(const struct ipz_adapter_handle adapter_handle,
 		if (count > 1) {
 			u64 *kpage;
 			int i;
-			kpage = (u64 *)abs_to_virt(logical_address_of_page);
+			kpage = __va(logical_address_of_page);
 			for (i = 0; i < count; i++)
 				ehca_gen_dbg("kpage[%d]=%p",
 					     i, (void *)kpage[i]);
@@ -944,7 +944,7 @@ u64 hipz_h_error_data(const struct ipz_adapter_handle adapter_handle,
 		      void *rblock,
 		      unsigned long *byte_count)
 {
-	u64 r_cb = virt_to_abs(rblock);
+	u64 r_cb = __pa(rblock);
 
 	if (r_cb & (EHCA_PAGESIZE-1)) {
 		ehca_gen_err("rblock not page aligned.");
diff --git a/drivers/infiniband/hw/ehca/ipz_pt_fn.c b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
index 1898d6e..62c71fa 100644
--- a/drivers/infiniband/hw/ehca/ipz_pt_fn.c
+++ b/drivers/infiniband/hw/ehca/ipz_pt_fn.c
@@ -81,7 +81,7 @@ int ipz_queue_abs_to_offset(struct ipz_queue *queue, u64 addr, u64 *q_offset)
 {
 	int i;
 	for (i = 0; i < queue->queue_length / queue->pagesize; i++) {
-		u64 page = (u64)virt_to_abs(queue->queue_pages[i]);
+		u64 page = __pa(queue->queue_pages[i]);
 		if (addr >= page && addr < page + queue->pagesize) {
 			*q_offset = addr - page + i * queue->pagesize;
 			return 0;
-- 
1.7.9.5
