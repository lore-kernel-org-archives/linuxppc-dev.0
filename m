Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sypS80B8szDt39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 19:40:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 3/3] powerpc/pseries: Define & use a type for the
 plpar_hcall9() retvals
Date: Tue, 18 Oct 2016 19:40:32 +1100
Message-Id: <1476780032-21643-3-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
References: <1476780032-21643-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have now had two nasty stack corruption bugs caused by incorrect
sizing of the return buffer for plpar_hcall()/plpar_hcall9().

To avoid any more such bugs, define a type which encodes the size of the
return buffer, and change the argument of plpar_hcall9() to be of that
type, meaning the compiler will check for us that we passed the right
size buffer.

There isn't an easy way to do this incrementally, without introducing a
new function name, eg. plpar_hcall9_with_struct(), which is ugly as hell.
So just do it in one tree-wide change.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/hvcall.h               |  15 ++--
 arch/powerpc/include/asm/plpar_wrappers.h       |  12 +--
 arch/powerpc/mm/numa.c                          |   6 +-
 arch/powerpc/platforms/pseries/lpar.c           |  46 +++++-----
 arch/powerpc/platforms/pseries/lparcfg.c        |  28 +++----
 arch/powerpc/platforms/pseries/pseries_energy.c |  12 +--
 drivers/misc/cxl/hcalls.c                       |  32 +++----
 drivers/net/ethernet/ibm/ehea/ehea_phyp.c       | 107 ++++++++++++------------
 drivers/net/ethernet/ibm/ibmveth.h              |   8 +-
 9 files changed, 136 insertions(+), 130 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index b3a6c6ec6b6f..c2728ab84b4f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -347,17 +347,20 @@ long plpar_hcall(unsigned long opcode, struct plpar_hcall_retvals *retvals, ...)
  */
 long plpar_hcall_raw(unsigned long opcode, struct plpar_hcall_retvals *retvals, ...);
 
+struct plpar_hcall9_retvals
+{
+	unsigned long v[9];
+};
+
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
  * @opcode: The hypervisor call to make.
- * @retbuf: Buffer to store up to 9 return arguments in.
+ * @retvals: Buffer to store up to 9 return arguments in.
  *
- * This call supports up to 9 arguments and 9 return arguments. Use
- * PLPAR_HCALL9_BUFSIZE to size the return argument buffer.
+ * This call supports up to 9 arguments and 9 return arguments.
  */
-#define PLPAR_HCALL9_BUFSIZE 9
-long plpar_hcall9(unsigned long opcode, unsigned long *retbuf, ...);
-long plpar_hcall9_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall9(unsigned long opcode, struct plpar_hcall9_retvals *retvals, ...);
+long plpar_hcall9_raw(unsigned long opcode, struct plpar_hcall9_retvals *retvals, ...);
 
 /* For hcall instrumentation.  One structure per-hcall, per-CPU */
 struct hcall_stats {
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 17885cd60fb9..865bc9a726e4 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -209,11 +209,11 @@ static inline long plpar_pte_read_4(unsigned long flags, unsigned long ptex,
 
 {
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 
-	rc = plpar_hcall9(H_READ, retbuf, flags | H_READ_4, ptex);
+	rc = plpar_hcall9(H_READ, &retvals, flags | H_READ_4, ptex);
 
-	memcpy(ptes, retbuf, 8*sizeof(unsigned long));
+	memcpy(ptes, &retvals.v, 8*sizeof(unsigned long));
 
 	return rc;
 }
@@ -227,11 +227,11 @@ static inline long plpar_pte_read_4_raw(unsigned long flags, unsigned long ptex,
 
 {
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 
-	rc = plpar_hcall9_raw(H_READ, retbuf, flags | H_READ_4, ptex);
+	rc = plpar_hcall9_raw(H_READ, &retvals, flags | H_READ_4, ptex);
 
-	memcpy(ptes, retbuf, 8*sizeof(unsigned long));
+	memcpy(ptes, &retvals.v, 8*sizeof(unsigned long));
 
 	return rc;
 }
diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
index 75b9cd6150cc..aeaf1b1cb893 100644
--- a/arch/powerpc/mm/numa.c
+++ b/arch/powerpc/mm/numa.c
@@ -1277,12 +1277,12 @@ static int update_cpu_associativity_changes_mask(void)
 static long hcall_vphn(unsigned long cpu, __be32 *associativity)
 {
 	long rc;
-	long retbuf[PLPAR_HCALL9_BUFSIZE] = {0};
+	struct plpar_hcall9_retvals retvals = { 0 };
 	u64 flags = 1;
 	int hwcpu = get_hard_smp_processor_id(cpu);
 
-	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, retbuf, flags, hwcpu);
-	vphn_unpack_associativity(retbuf, associativity);
+	rc = plpar_hcall9(H_HOME_NODE_ASSOCIATIVITY, &retvals, flags, hwcpu);
+	vphn_unpack_associativity(&retvals.v[0], associativity);
 
 	return rc;
 }
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index 86707e67843f..d191df0c1535 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -394,6 +394,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 					     int psize, int ssize)
 {
 	unsigned long param[8];
+	struct plpar_hcall9_retvals retvals;
 	int i = 0, pix = 0, rc;
 	unsigned long flags = 0;
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
@@ -411,7 +412,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 			param[pix+1] = hpte_encode_avpn(vpn[i], psize, ssize);
 			pix += 2;
 			if (pix == 8) {
-				rc = plpar_hcall9(H_BULK_REMOVE, param,
+				rc = plpar_hcall9(H_BULK_REMOVE, &retvals,
 						  param[0], param[1], param[2],
 						  param[3], param[4], param[5],
 						  param[6], param[7]);
@@ -422,7 +423,7 @@ static void __pSeries_lpar_hugepage_invalidate(unsigned long *slot,
 	}
 	if (pix) {
 		param[pix] = HBR_END;
-		rc = plpar_hcall9(H_BULK_REMOVE, param, param[0], param[1],
+		rc = plpar_hcall9(H_BULK_REMOVE, &retvals, param[0], param[1],
 				  param[2], param[3], param[4], param[5],
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
@@ -522,6 +523,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	unsigned long flags = 0;
 	struct ppc64_tlb_batch *batch = this_cpu_ptr(&ppc64_tlb_batch);
 	int lock_tlbie = !mmu_has_feature(MMU_FTR_LOCKLESS_TLBIE);
+	struct plpar_hcall9_retvals retvals;
 	unsigned long param[9];
 	unsigned long hash, index, shift, hidx, slot;
 	real_pte_t pte;
@@ -555,7 +557,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 								ssize);
 				pix += 2;
 				if (pix == 8) {
-					rc = plpar_hcall9(H_BULK_REMOVE, param,
+					rc = plpar_hcall9(H_BULK_REMOVE, &retvals,
 						param[0], param[1], param[2],
 						param[3], param[4], param[5],
 						param[6], param[7]);
@@ -567,7 +569,7 @@ static void pSeries_lpar_flush_hash_range(unsigned long number, int local)
 	}
 	if (pix) {
 		param[pix] = HBR_END;
-		rc = plpar_hcall9(H_BULK_REMOVE, param, param[0], param[1],
+		rc = plpar_hcall9(H_BULK_REMOVE, &retvals, param[0], param[1],
 				  param[2], param[3], param[4], param[5],
 				  param[6], param[7]);
 		BUG_ON(rc != H_SUCCESS);
@@ -760,23 +762,23 @@ void __trace_hcall_exit(long opcode, unsigned long retval,
 int h_get_mpp(struct hvcall_mpp_data *mpp_data)
 {
 	int rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 
-	rc = plpar_hcall9(H_GET_MPP, retbuf);
+	rc = plpar_hcall9(H_GET_MPP, &retvals);
 
-	mpp_data->entitled_mem = retbuf[0];
-	mpp_data->mapped_mem = retbuf[1];
+	mpp_data->entitled_mem = retvals.v[0];
+	mpp_data->mapped_mem = retvals.v[1];
 
-	mpp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
-	mpp_data->pool_num = retbuf[2] & 0xffff;
+	mpp_data->group_num = (retvals.v[2] >> 2 * 8) & 0xffff;
+	mpp_data->pool_num = retvals.v[2] & 0xffff;
 
-	mpp_data->mem_weight = (retbuf[3] >> 7 * 8) & 0xff;
-	mpp_data->unallocated_mem_weight = (retbuf[3] >> 6 * 8) & 0xff;
-	mpp_data->unallocated_entitlement = retbuf[3] & 0xffffffffffffUL;
+	mpp_data->mem_weight = (retvals.v[3] >> 7 * 8) & 0xff;
+	mpp_data->unallocated_mem_weight = (retvals.v[3] >> 6 * 8) & 0xff;
+	mpp_data->unallocated_entitlement = retvals.v[3] & 0xffffffffffffUL;
 
-	mpp_data->pool_size = retbuf[4];
-	mpp_data->loan_request = retbuf[5];
-	mpp_data->backing_mem = retbuf[6];
+	mpp_data->pool_size = retvals.v[4];
+	mpp_data->loan_request = retvals.v[5];
+	mpp_data->backing_mem = retvals.v[6];
 
 	return rc;
 }
@@ -785,14 +787,14 @@ EXPORT_SYMBOL(h_get_mpp);
 int h_get_mpp_x(struct hvcall_mpp_x_data *mpp_x_data)
 {
 	int rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE] = { 0 };
+	struct plpar_hcall9_retvals retvals = { 0 };
 
-	rc = plpar_hcall9(H_GET_MPP_X, retbuf);
+	rc = plpar_hcall9(H_GET_MPP_X, &retvals);
 
-	mpp_x_data->coalesced_bytes = retbuf[0];
-	mpp_x_data->pool_coalesced_bytes = retbuf[1];
-	mpp_x_data->pool_purr_cycles = retbuf[2];
-	mpp_x_data->pool_spurr_cycles = retbuf[3];
+	mpp_x_data->coalesced_bytes = retvals.v[0];
+	mpp_x_data->pool_coalesced_bytes = retvals.v[1];
+	mpp_x_data->pool_purr_cycles = retvals.v[2];
+	mpp_x_data->pool_spurr_cycles = retvals.v[3];
 
 	return rc;
 }
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index dabc899ae8ea..770727a109d3 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -112,25 +112,25 @@ struct hvcall_ppp_data {
 static unsigned int h_get_ppp(struct hvcall_ppp_data *ppp_data)
 {
 	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 
-	rc = plpar_hcall9(H_GET_PPP, retbuf);
+	rc = plpar_hcall9(H_GET_PPP, &retvals);
 
-	ppp_data->entitlement = retbuf[0];
-	ppp_data->unallocated_entitlement = retbuf[1];
+	ppp_data->entitlement = retvals.v[0];
+	ppp_data->unallocated_entitlement = retvals.v[1];
 
-	ppp_data->group_num = (retbuf[2] >> 2 * 8) & 0xffff;
-	ppp_data->pool_num = retbuf[2] & 0xffff;
+	ppp_data->group_num = (retvals.v[2] >> 2 * 8) & 0xffff;
+	ppp_data->pool_num = retvals.v[2] & 0xffff;
 
-	ppp_data->capped = (retbuf[3] >> 6 * 8) & 0x01;
-	ppp_data->weight = (retbuf[3] >> 5 * 8) & 0xff;
-	ppp_data->unallocated_weight = (retbuf[3] >> 4 * 8) & 0xff;
-	ppp_data->active_procs_in_pool = (retbuf[3] >> 2 * 8) & 0xffff;
-	ppp_data->active_system_procs = retbuf[3] & 0xffff;
+	ppp_data->capped = (retvals.v[3] >> 6 * 8) & 0x01;
+	ppp_data->weight = (retvals.v[3] >> 5 * 8) & 0xff;
+	ppp_data->unallocated_weight = (retvals.v[3] >> 4 * 8) & 0xff;
+	ppp_data->active_procs_in_pool = (retvals.v[3] >> 2 * 8) & 0xffff;
+	ppp_data->active_system_procs = retvals.v[3] & 0xffff;
 
-	ppp_data->phys_platform_procs = retbuf[4] >> 6 * 8;
-	ppp_data->max_proc_cap_avail = (retbuf[4] >> 3 * 8) & 0xffffff;
-	ppp_data->entitled_proc_cap_avail = retbuf[4] & 0xffffff;
+	ppp_data->phys_platform_procs = retvals.v[4] >> 6 * 8;
+	ppp_data->max_proc_cap_avail = (retvals.v[4] >> 3 * 8) & 0xffffff;
+	ppp_data->entitled_proc_cap_avail = retvals.v[4] & 0xffffff;
 
 	return rc;
 }
diff --git a/arch/powerpc/platforms/pseries/pseries_energy.c b/arch/powerpc/platforms/pseries/pseries_energy.c
index 164a13d3998a..602e75e371a9 100644
--- a/arch/powerpc/platforms/pseries/pseries_energy.c
+++ b/arch/powerpc/platforms/pseries/pseries_energy.c
@@ -115,7 +115,7 @@ static int drc_index_to_cpu(u32 drc_index)
 static ssize_t get_best_energy_list(char *page, int activate)
 {
 	int rc, cnt, i, cpu;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 	unsigned long flags = 0;
 	u32 *buf_page;
 	char *s = page;
@@ -128,14 +128,14 @@ static ssize_t get_best_energy_list(char *page, int activate)
 	if (activate)
 		flags |= FLAGS_ACTIVATE;
 
-	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags, 0, __pa(buf_page),
+	rc = plpar_hcall9(H_BEST_ENERGY, &retvals, flags, 0, __pa(buf_page),
 				0, 0, 0, 0, 0, 0);
 	if (rc != H_SUCCESS) {
 		free_page((unsigned long) buf_page);
 		return -EINVAL;
 	}
 
-	cnt = retbuf[0];
+	cnt = retvals.v[0];
 	for (i = 0; i < cnt; i++) {
 		cpu = drc_index_to_cpu(buf_page[2*i+1]);
 		if ((cpu_online(cpu) && !activate) ||
@@ -155,21 +155,21 @@ static ssize_t get_best_energy_data(struct device *dev,
 					char *page, int activate)
 {
 	int rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 	unsigned long flags = 0;
 
 	flags = FLAGS_MODE2;
 	if (activate)
 		flags |= FLAGS_ACTIVATE;
 
-	rc = plpar_hcall9(H_BEST_ENERGY, retbuf, flags,
+	rc = plpar_hcall9(H_BEST_ENERGY, &retvals, flags,
 				cpu_to_drc_index(dev->id),
 				0, 0, 0, 0, 0, 0, 0);
 
 	if (rc != H_SUCCESS)
 		return -EINVAL;
 
-	return sprintf(page, "%lu\n", retbuf[1] >> 32);
+	return sprintf(page, "%lu\n", retvals.v[1] >> 32);
 }
 
 /* Wrapper functions */
diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index c07b9607e1fb..07a46935071f 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -78,15 +78,15 @@
 		}							\
 	}
 
-#define _CXL_LOOP_HCALL9(call, rc, retbuf, fn, ...)			\
+#define _CXL_LOOP_HCALL9(call, rc, retvals, fn, ...)			\
 	{								\
 		unsigned int delay, total_delay = 0;			\
 		u64 token = 0;						\
 									\
-		memset(retbuf, 0, sizeof(retbuf));			\
+		memset(&retvals, 0, sizeof(retvals));			\
 		while (1) {						\
-			rc = call(fn, retbuf, __VA_ARGS__, token);	\
-			token = retbuf[0];				\
+			rc = call(fn, &retvals, __VA_ARGS__, token);	\
+			token = retvals.v[0];				\
 			if (rc != H_BUSY && !H_IS_LONG_BUSY(rc))	\
 				break;					\
 									\
@@ -238,20 +238,20 @@ long cxl_h_detach_process(u64 unit_address, u64 process_token)
 static long cxl_h_control_function(u64 unit_address, u64 op,
 				   u64 p1, u64 p2, u64 p3, u64 p4, u64 *out)
 {
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 	long rc;
 
-	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FUNCTION, unit_address, op, p1, p2, p3, p4);
+	CXL_H9_WAIT_UNTIL_DONE(rc, retvals, H_CONTROL_CA_FUNCTION, unit_address, op, p1, p2, p3, p4);
 	_PRINT_MSG(rc, "cxl_h_control_function(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
-		unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
-	trace_cxl_hcall_control_function(unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retbuf[0], rc);
+		unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retvals.v[0], rc);
+	trace_cxl_hcall_control_function(unit_address, OP_STR_AFU(op), p1, p2, p3, p4, retvals.v[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform function */
 		if ((op == H_CONTROL_CA_FUNCTION_GET_FUNCTION_ERR_INT ||
 		     op == H_CONTROL_CA_FUNCTION_READ_ERR_STATE ||
 		     op == H_CONTROL_CA_FUNCTION_COLLECT_VPD))
-			*out = retbuf[0];
+			*out = retvals.v[0];
 		return 0;
 	case H_PARAMETER:     /* An incorrect parameter was supplied. */
 	case H_FUNCTION:      /* The function is not supported. */
@@ -432,9 +432,9 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
 {
 	long rc;
 
-	BUG_ON(sizeof(*info) != sizeof(unsigned long[PLPAR_HCALL9_BUFSIZE]));
+	BUG_ON(sizeof(*info) != sizeof(struct plpar_hcall9_retvals));
 
-	rc = plpar_hcall9(H_COLLECT_CA_INT_INFO, (unsigned long *) info,
+	rc = plpar_hcall9(H_COLLECT_CA_INT_INFO, (struct plpar_hcall9_retvals *)info,
 			unit_address, process_token);
 	_PRINT_MSG(rc, "cxl_h_collect_int_info(%#.16llx, 0x%llx): %li\n",
 		unit_address, process_token, rc);
@@ -511,18 +511,18 @@ long cxl_h_control_faults(u64 unit_address, u64 process_token,
 static long cxl_h_control_facility(u64 unit_address, u64 op,
 				   u64 p1, u64 p2, u64 p3, u64 p4, u64 *out)
 {
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 	long rc;
 
-	CXL_H9_WAIT_UNTIL_DONE(rc, retbuf, H_CONTROL_CA_FACILITY, unit_address, op, p1, p2, p3, p4);
+	CXL_H9_WAIT_UNTIL_DONE(rc, retvals, H_CONTROL_CA_FACILITY, unit_address, op, p1, p2, p3, p4);
 	_PRINT_MSG(rc, "cxl_h_control_facility(%#.16llx, %s(%#llx, %#llx, %#llx, %#llx, R4: %#lx)): %li\n",
-		unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
-	trace_cxl_hcall_control_facility(unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retbuf[0], rc);
+		unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retvals.v[0], rc);
+	trace_cxl_hcall_control_facility(unit_address, OP_STR_CONTROL_ADAPTER(op), p1, p2, p3, p4, retvals.v[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
 		if (op == H_CONTROL_CA_FACILITY_COLLECT_VPD)
-			*out = retbuf[0];
+			*out = retvals.v[0];
 		return 0;
 	case H_PARAMETER:     /* An incorrect parameter was supplied. */
 	case H_FUNCTION:      /* The function is not supported. */
diff --git a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
index d3a130ccdcc8..c5409f150ed1 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_phyp.c
@@ -82,7 +82,7 @@ static long ehea_plpar_hcall_norets(unsigned long opcode,
 }
 
 static long ehea_plpar_hcall9(unsigned long opcode,
-			      unsigned long *outs, /* array of 9 outputs */
+			      struct plpar_hcall9_retvals *outs,
 			      unsigned long arg1,
 			      unsigned long arg2,
 			      unsigned long arg3,
@@ -125,8 +125,9 @@ static long ehea_plpar_hcall9(unsigned long opcode,
 			       opcode, ret,
 			       arg1, arg2, arg3, arg4, arg5,
 			       arg6, arg7, arg8, arg9,
-			       outs[0], outs[1], outs[2], outs[3], outs[4],
-			       outs[5], outs[6], outs[7], outs[8]);
+			       outs->v[0], outs->v[1], outs->v[2], outs->v[3],
+			       outs->v[4], outs->v[5], outs->v[6], outs->v[7],
+			       outs->v[8]);
 		return ret;
 	}
 
@@ -214,7 +215,7 @@ u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
 			     u64 *qp_handle, struct h_epas *h_epas)
 {
 	u64 hret;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	u64 allocate_controls =
 	    EHEA_BMASK_SET(H_ALL_RES_QP_EQPO, init_attr->low_lat_rq1 ? 1 : 0)
@@ -255,7 +256,7 @@ u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
 	    | EHEA_BMASK_SET(H_ALL_RES_QP_TH_RQ3, init_attr->rq3_threshold);
 
 	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 allocate_controls,		/* R5 */
 				 init_attr->send_cq_handle,	/* R6 */
@@ -266,17 +267,17 @@ u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
 				 r11_in,			/* R11 */
 				 threshold);			/* R12 */
 
-	*qp_handle = outs[0];
-	init_attr->qp_nr = (u32)outs[1];
+	*qp_handle = outs.v[0];
+	init_attr->qp_nr = (u32)outs.v[1];
 
 	init_attr->act_nr_send_wqes =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_SWQE, outs[2]);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_SWQE, outs.v[2]);
 	init_attr->act_nr_rwqes_rq1 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R1WQE, outs[2]);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R1WQE, outs.v[2]);
 	init_attr->act_nr_rwqes_rq2 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R2WQE, outs[2]);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R2WQE, outs.v[2]);
 	init_attr->act_nr_rwqes_rq3 =
-	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R3WQE, outs[2]);
+	    (u16)EHEA_BMASK_GET(H_ALL_RES_QP_ACT_R3WQE, outs.v[2]);
 
 	init_attr->act_wqe_size_enc_sq = init_attr->wqe_size_enc_sq;
 	init_attr->act_wqe_size_enc_rq1 = init_attr->wqe_size_enc_rq1;
@@ -284,25 +285,25 @@ u64 ehea_h_alloc_resource_qp(const u64 adapter_handle,
 	init_attr->act_wqe_size_enc_rq3 = init_attr->wqe_size_enc_rq3;
 
 	init_attr->nr_sq_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_SQ, outs[4]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_SQ, outs.v[4]);
 	init_attr->nr_rq1_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ1, outs[4]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ1, outs.v[4]);
 	init_attr->nr_rq2_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ2, outs[5]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ2, outs.v[5]);
 	init_attr->nr_rq3_pages =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ3, outs[5]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_SIZE_RQ3, outs.v[5]);
 
 	init_attr->liobn_sq =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_SQ, outs[7]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_SQ, outs.v[7]);
 	init_attr->liobn_rq1 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ1, outs[7]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ1, outs.v[7]);
 	init_attr->liobn_rq2 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ2, outs[8]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ2, outs.v[8]);
 	init_attr->liobn_rq3 =
-	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ3, outs[8]);
+	    (u32)EHEA_BMASK_GET(H_ALL_RES_QP_LIOBN_RQ3, outs.v[8]);
 
 	if (!hret)
-		hcp_epas_ctor(h_epas, outs[6], outs[6]);
+		hcp_epas_ctor(h_epas, outs.v[6], outs.v[6]);
 
 	return hret;
 }
@@ -312,10 +313,10 @@ u64 ehea_h_alloc_resource_cq(const u64 adapter_handle,
 			     u64 *cq_handle, struct h_epas *epas)
 {
 	u64 hret;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 H_ALL_RES_TYPE_CQ,		/* R5 */
 				 cq_attr->eq_handle,		/* R6 */
@@ -323,12 +324,12 @@ u64 ehea_h_alloc_resource_cq(const u64 adapter_handle,
 				 cq_attr->max_nr_of_cqes,	/* R8 */
 				 0, 0, 0, 0);			/* R9-R12 */
 
-	*cq_handle = outs[0];
-	cq_attr->act_nr_of_cqes = outs[3];
-	cq_attr->nr_pages = outs[4];
+	*cq_handle = outs.v[0];
+	cq_attr->act_nr_of_cqes = outs.v[3];
+	cq_attr->nr_pages = outs.v[4];
 
 	if (!hret)
-		hcp_epas_ctor(epas, outs[5], outs[6]);
+		hcp_epas_ctor(epas, outs.v[5], outs.v[6]);
 
 	return hret;
 }
@@ -374,7 +375,7 @@ u64 ehea_h_alloc_resource_eq(const u64 adapter_handle,
 			     struct ehea_eq_attr *eq_attr, u64 *eq_handle)
 {
 	u64 hret, allocate_controls;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	/* resource type */
 	allocate_controls =
@@ -384,19 +385,19 @@ u64 ehea_h_alloc_resource_eq(const u64 adapter_handle,
 	    | EHEA_BMASK_SET(H_ALL_RES_EQ_NON_NEQ_ISN, 1);
 
 	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 allocate_controls,		/* R5 */
 				 eq_attr->max_nr_of_eqes,	/* R6 */
 				 0, 0, 0, 0, 0, 0);		/* R7-R10 */
 
-	*eq_handle = outs[0];
-	eq_attr->act_nr_of_eqes = outs[3];
-	eq_attr->nr_pages = outs[4];
-	eq_attr->ist1 = outs[5];
-	eq_attr->ist2 = outs[6];
-	eq_attr->ist3 = outs[7];
-	eq_attr->ist4 = outs[8];
+	*eq_handle = outs.v[0];
+	eq_attr->act_nr_of_eqes = outs.v[3];
+	eq_attr->nr_pages = outs.v[4];
+	eq_attr->ist1 = outs.v[5];
+	eq_attr->ist2 = outs.v[6];
+	eq_attr->ist3 = outs.v[7];
+	eq_attr->ist4 = outs.v[8];
 
 	return hret;
 }
@@ -407,10 +408,10 @@ u64 ehea_h_modify_ehea_qp(const u64 adapter_handle, const u8 cat,
 			  u16 *out_swr, u16 *out_rwr)
 {
 	u64 hret;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	hret = ehea_plpar_hcall9(H_MODIFY_HEA_QP,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 (u64) cat,			/* R5 */
 				 qp_handle,			/* R6 */
@@ -418,10 +419,10 @@ u64 ehea_h_modify_ehea_qp(const u64 adapter_handle, const u8 cat,
 				 __pa(cb_addr),			/* R8 */
 				 0, 0, 0, 0);			/* R9-R12 */
 
-	*inv_attr_id = outs[0];
-	*out_swr = outs[3];
-	*out_rwr = outs[4];
-	*proc_mask = outs[5];
+	*inv_attr_id = outs.v[0];
+	*out_swr = outs.v[3];
+	*out_rwr = outs.v[4];
+	*proc_mask = outs.v[5];
 
 	return hret;
 }
@@ -449,10 +450,10 @@ u64 ehea_h_register_smr(const u64 adapter_handle, const u64 orig_mr_handle,
 			struct ehea_mr *mr)
 {
 	u64 hret;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	hret = ehea_plpar_hcall9(H_REGISTER_SMR,
-				 outs,
+				 &outs,
 				 adapter_handle	      ,		 /* R4 */
 				 orig_mr_handle,		 /* R5 */
 				 vaddr_in,			 /* R6 */
@@ -460,18 +461,18 @@ u64 ehea_h_register_smr(const u64 adapter_handle, const u64 orig_mr_handle,
 				 pd,				 /* R8 */
 				 0, 0, 0, 0);			 /* R9-R12 */
 
-	mr->handle = outs[0];
-	mr->lkey = (u32)outs[2];
+	mr->handle = outs.v[0];
+	mr->lkey = (u32)outs.v[2];
 
 	return hret;
 }
 
 u64 ehea_h_disable_and_get_hea(const u64 adapter_handle, const u64 qp_handle)
 {
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	return ehea_plpar_hcall9(H_DISABLE_AND_GET_HEA,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 H_DISABLE_GET_EHEA_WQE_P,	/* R5 */
 				 qp_handle,			/* R6 */
@@ -493,10 +494,10 @@ u64 ehea_h_alloc_resource_mr(const u64 adapter_handle, const u64 vaddr,
 			     const u32 pd, u64 *mr_handle, u32 *lkey)
 {
 	u64 hret;
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 
 	hret = ehea_plpar_hcall9(H_ALLOC_HEA_RESOURCE,
-				 outs,
+				 &outs,
 				 adapter_handle,		   /* R4 */
 				 5,				   /* R5 */
 				 vaddr,				   /* R6 */
@@ -505,8 +506,8 @@ u64 ehea_h_alloc_resource_mr(const u64 adapter_handle, const u64 vaddr,
 				 pd,				   /* R9 */
 				 0, 0, 0);			   /* R10-R12 */
 
-	*mr_handle = outs[0];
-	*lkey = (u32)outs[2];
+	*mr_handle = outs.v[0];
+	*lkey = (u32)outs.v[2];
 	return hret;
 }
 
@@ -564,7 +565,7 @@ u64 ehea_h_modify_ehea_port(const u64 adapter_handle, const u16 port_num,
 			    const u8 cb_cat, const u64 select_mask,
 			    void *cb_addr)
 {
-	unsigned long outs[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals outs;
 	u64 port_info;
 	u64 arr_index = 0;
 	u64 cb_logaddr = __pa(cb_addr);
@@ -575,7 +576,7 @@ u64 ehea_h_modify_ehea_port(const u64 adapter_handle, const u16 port_num,
 	ehea_dump(cb_addr, sizeof(struct hcp_ehea_port_cb0), "Before HCALL");
 #endif
 	return ehea_plpar_hcall9(H_MODIFY_HEA_PORT,
-				 outs,
+				 &outs,
 				 adapter_handle,		/* R4 */
 				 port_info,			/* R5 */
 				 select_mask,			/* R6 */
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 36f76d18ccef..6b124b29ec71 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -65,18 +65,18 @@ static inline long h_send_logical_lan(unsigned long unit_address,
 		unsigned long mss, unsigned long large_send_support)
 {
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL9_BUFSIZE];
+	struct plpar_hcall9_retvals retvals;
 
 	if (large_send_support)
-		rc = plpar_hcall9(H_SEND_LOGICAL_LAN, retbuf, unit_address,
+		rc = plpar_hcall9(H_SEND_LOGICAL_LAN, &retvals, unit_address,
 				  desc1, desc2, desc3, desc4, desc5, desc6,
 				  corellator_in, mss);
 	else
-		rc = plpar_hcall9(H_SEND_LOGICAL_LAN, retbuf, unit_address,
+		rc = plpar_hcall9(H_SEND_LOGICAL_LAN, &retvals, unit_address,
 				  desc1, desc2, desc3, desc4, desc5, desc6,
 				  corellator_in);
 
-	*corellator_out = retbuf[0];
+	*corellator_out = retvals.v[0];
 
 	return rc;
 }
-- 
2.7.4
