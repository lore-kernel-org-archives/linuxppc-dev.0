Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 09/18] ehea: Remove uses of virt_to_abs() and abs_to_virt()
Date: Thu, 26 Jul 2012 17:19:55 +1000
Message-Id: <1343287204-7700-9-git-send-email-michael@ellerman.id.au>
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

Similarly virt_to_abs() just calls __pa().

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 drivers/net/ethernet/ibm/ehea/ehea.h      |    1 -
 drivers/net/ethernet/ibm/ehea/ehea_phyp.c |   12 ++++++------
 drivers/net/ethernet/ibm/ehea/ehea_qmr.c  |   14 +++++++-------
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea.h b/drivers/net/ethernet/ibm/ehea/ehea.h
index b8e46cc..6be7b98 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea.h
+++ b/drivers/net/ethernet/ibm/ehea/ehea.h
@@ -35,7 +35,6 @@
 #include <linux/if_vlan.h>
 
 #include <asm/ibmebus.h>
-#include <asm/abs_addr.h>
 #include <asm/io.h>
 
 #define DRV_NAME	"ehea"
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
index 30f9033..d3a130c 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
@@ -141,7 +141,7 @@ u64 ehea_h_query_ehea_qp(const u64 adapter_handle, const u8 qp_category,
 				       qp_category,		/* R5 */
 				       qp_handle,		/* R6 */
 				       sel_mask,		/* R7 */
-				       virt_to_abs(cb_addr),	/* R8 */
+				       __pa(cb_addr),		/* R8 */
 				       0, 0);
 }
 
@@ -415,7 +415,7 @@ u64 ehea_h_modify_ehea_qp(const u64 adapter_handle, const u8 cat,
 				 (u64) cat,			/* R5 */
 				 qp_handle,			/* R6 */
 				 sel_mask,			/* R7 */
-				 virt_to_abs(cb_addr),		/* R8 */
+				 __pa(cb_addr),			/* R8 */
 				 0, 0, 0, 0);			/* R9-R12 */
 
 	*inv_attr_id = outs[0];
@@ -528,7 +528,7 @@ u64 ehea_h_query_ehea(const u64 adapter_handle, void *cb_addr)
 {
 	u64 hret, cb_logaddr;
 
-	cb_logaddr = virt_to_abs(cb_addr);
+	cb_logaddr = __pa(cb_addr);
 
 	hret = ehea_plpar_hcall_norets(H_QUERY_HEA,
 				       adapter_handle,		/* R4 */
@@ -545,7 +545,7 @@ u64 ehea_h_query_ehea_port(const u64 adapter_handle, const u16 port_num,
 			   void *cb_addr)
 {
 	u64 port_info;
-	u64 cb_logaddr = virt_to_abs(cb_addr);
+	u64 cb_logaddr = __pa(cb_addr);
 	u64 arr_index = 0;
 
 	port_info = EHEA_BMASK_SET(H_MEHEAPORT_CAT, cb_cat)
@@ -567,7 +567,7 @@ u64 ehea_h_modify_ehea_port(const u64 adapter_handle, const u16 port_num,
 	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
 	u64 port_info;
 	u64 arr_index = 0;
-	u64 cb_logaddr = virt_to_abs(cb_addr);
+	u64 cb_logaddr = __pa(cb_addr);
 
 	port_info = EHEA_BMASK_SET(H_MEHEAPORT_CAT, cb_cat)
 		  | EHEA_BMASK_SET(H_MEHEAPORT_PN, port_num);
@@ -621,6 +621,6 @@ u64 ehea_h_error_data(const u64 adapter_handle, const u64 ressource_handle,
 	return ehea_plpar_hcall_norets(H_ERROR_DATA,
 				       adapter_handle,		/* R4 */
 				       ressource_handle,	/* R5 */
-				       virt_to_abs(rblock),	/* R6 */
+				       __pa(rblock),		/* R6 */
 				       0, 0, 0, 0);		/* R7-R12 */
 }
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
index 4fb47f1..d506ee2 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_qmr.c
@@ -163,7 +163,7 @@ struct ehea_cq *ehea_create_cq(struct ehea_adapter *adapter,
 			goto out_kill_hwq;
 		}
 
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 		hret = ehea_h_register_rpage(adapter->handle,
 					     0, EHEA_CQ_REGISTER_ORIG,
 					     cq->fw_handle, rpage, 1);
@@ -290,7 +290,7 @@ struct ehea_eq *ehea_create_eq(struct ehea_adapter *adapter,
 			goto out_kill_hwq;
 		}
 
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 
 		hret = ehea_h_register_rpage(adapter->handle, 0,
 					     EHEA_EQ_REGISTER_ORIG,
@@ -397,7 +397,7 @@ static int ehea_qp_alloc_register(struct ehea_qp *qp, struct hw_queue *hw_queue,
 			pr_err("hw_qpageit_get_inc failed\n");
 			goto out_kill_hwq;
 		}
-		rpage = virt_to_abs(vpage);
+		rpage = __pa(vpage);
 		hret = ehea_h_register_rpage(adapter->handle,
 					     0, h_call_q_selector,
 					     qp->fw_handle, rpage, 1);
@@ -792,7 +792,7 @@ u64 ehea_map_vaddr(void *caddr)
 	if (!ehea_bmap)
 		return EHEA_INVAL_ADDR;
 
-	index = virt_to_abs(caddr) >> SECTION_SIZE_BITS;
+	index = __pa(caddr) >> SECTION_SIZE_BITS;
 	top = (index >> EHEA_TOP_INDEX_SHIFT) & EHEA_INDEX_MASK;
 	if (!ehea_bmap->top[top])
 		return EHEA_INVAL_ADDR;
@@ -814,7 +814,7 @@ static inline void *ehea_calc_sectbase(int top, int dir, int idx)
 	unsigned long ret = idx;
 	ret |= dir << EHEA_DIR_INDEX_SHIFT;
 	ret |= top << EHEA_TOP_INDEX_SHIFT;
-	return abs_to_virt(ret << SECTION_SIZE_BITS);
+	return __va(ret << SECTION_SIZE_BITS);
 }
 
 static u64 ehea_reg_mr_section(int top, int dir, int idx, u64 *pt,
@@ -824,7 +824,7 @@ static u64 ehea_reg_mr_section(int top, int dir, int idx, u64 *pt,
 	void *pg;
 	u64 j, m, hret;
 	unsigned long k = 0;
-	u64 pt_abs = virt_to_abs(pt);
+	u64 pt_abs = __pa(pt);
 
 	void *sectbase = ehea_calc_sectbase(top, dir, idx);
 
@@ -832,7 +832,7 @@ static u64 ehea_reg_mr_section(int top, int dir, int idx, u64 *pt,
 
 		for (m = 0; m < EHEA_MAX_RPAGE; m++) {
 			pg = sectbase + ((k++) * EHEA_PAGESIZE);
-			pt[m] = virt_to_abs(pg);
+			pt[m] = __pa(pg);
 		}
 		hret = ehea_h_register_rpage_mr(adapter->handle, mr->handle, 0,
 						0, pt_abs, EHEA_MAX_RPAGE);
-- 
1.7.9.5
