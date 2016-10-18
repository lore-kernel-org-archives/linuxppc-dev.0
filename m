Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sypS70yrmzDt39
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 19:40:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [RFC PATCH 2/3] powerpc/pseries: Define & use a type for the
 plpar_hcall() retvals
Date: Tue, 18 Oct 2016 19:40:31 +1100
Message-Id: <1476780032-21643-2-git-send-email-mpe@ellerman.id.au>
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
return buffer, and change the argument of plpar_hcall() to be of that
type, meaning the compiler will check for us that we passed the right
size buffer.

There isn't an easy way to do this incrementally, without introducing a
new function name, eg. plpar_hcall_with_struct(), which is ugly as hell.
So just do it in one tree-wide change.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---

If anyone can think of a tricky way of doing this without requiring us to
update all usages of retbuf[x], then let me know.

 arch/powerpc/include/asm/hvcall.h          | 16 +++++-----
 arch/powerpc/include/asm/plpar_wrappers.h  | 44 +++++++++++++-------------
 arch/powerpc/kernel/rtas.c                 |  6 ++--
 arch/powerpc/platforms/pseries/hvconsole.c | 10 +++---
 arch/powerpc/platforms/pseries/lparcfg.c   | 14 ++++-----
 arch/powerpc/platforms/pseries/rng.c       |  6 ++--
 arch/powerpc/platforms/pseries/suspend.c   |  6 ++--
 arch/powerpc/sysdev/xics/icp-hv.c          |  6 ++--
 drivers/char/hw_random/pseries-rng.c       |  6 ++--
 drivers/misc/cxl/hcalls.c                  | 50 +++++++++++++++---------------
 drivers/net/ethernet/ibm/ibmveth.h         |  6 ++--
 drivers/net/ethernet/ibm/ibmvnic.c         |  8 ++---
 12 files changed, 90 insertions(+), 88 deletions(-)

diff --git a/arch/powerpc/include/asm/hvcall.h b/arch/powerpc/include/asm/hvcall.h
index 708edebcf147..b3a6c6ec6b6f 100644
--- a/arch/powerpc/include/asm/hvcall.h
+++ b/arch/powerpc/include/asm/hvcall.h
@@ -318,32 +318,34 @@
  */
 long plpar_hcall_norets(unsigned long opcode, ...);
 
+struct plpar_hcall_retvals
+{
+	unsigned long v[4];
+};
+
 /**
  * plpar_hcall: - Make a pseries hypervisor call
  * @opcode: The hypervisor call to make.
  * @retbuf: Buffer to store up to 4 return arguments in.
  *
- * This call supports up to 6 arguments and 4 return arguments. Use
- * PLPAR_HCALL_BUFSIZE to size the return argument buffer.
+ * This call supports up to 6 arguments and 4 return arguments.
  *
  * Used for all but the craziest of phyp interfaces (see plpar_hcall9)
  */
-#define PLPAR_HCALL_BUFSIZE 4
-long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall(unsigned long opcode, struct plpar_hcall_retvals *retvals, ...);
 
 /**
  * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
  * @opcode: The hypervisor call to make.
  * @retbuf: Buffer to store up to 4 return arguments in.
  *
- * This call supports up to 6 arguments and 4 return arguments. Use
- * PLPAR_HCALL_BUFSIZE to size the return argument buffer.
+ * This call supports up to 6 arguments and 4 return arguments.
  *
  * Used when phyp interface needs to be called in real mode. Similar to
  * plpar_hcall, but plpar_hcall_raw works in real mode and does not
  * calculate hypervisor call statistics.
  */
-long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
+long plpar_hcall_raw(unsigned long opcode, struct plpar_hcall_retvals *retvals, ...);
 
 /**
  * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
diff --git a/arch/powerpc/include/asm/plpar_wrappers.h b/arch/powerpc/include/asm/plpar_wrappers.h
index 1b394247afc2..17885cd60fb9 100644
--- a/arch/powerpc/include/asm/plpar_wrappers.h
+++ b/arch/powerpc/include/asm/plpar_wrappers.h
@@ -131,12 +131,12 @@ static inline long plpar_pte_enter(unsigned long flags,
 		unsigned long hpte_group, unsigned long hpte_v,
 		unsigned long hpte_r, unsigned long *slot)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall(H_ENTER, retbuf, flags, hpte_group, hpte_v, hpte_r);
+	rc = plpar_hcall(H_ENTER, &retvals, flags, hpte_group, hpte_v, hpte_r);
 
-	*slot = retbuf[0];
+	*slot = retvals.v[0];
 
 	return rc;
 }
@@ -145,13 +145,13 @@ static inline long plpar_pte_remove(unsigned long flags, unsigned long ptex,
 		unsigned long avpn, unsigned long *old_pteh_ret,
 		unsigned long *old_ptel_ret)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall(H_REMOVE, retbuf, flags, ptex, avpn);
+	rc = plpar_hcall(H_REMOVE, &retvals, flags, ptex, avpn);
 
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
+	*old_pteh_ret = retvals.v[0];
+	*old_ptel_ret = retvals.v[1];
 
 	return rc;
 }
@@ -161,13 +161,13 @@ static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
 		unsigned long avpn, unsigned long *old_pteh_ret,
 		unsigned long *old_ptel_ret)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall_raw(H_REMOVE, retbuf, flags, ptex, avpn);
+	rc = plpar_hcall_raw(H_REMOVE, &retvals, flags, ptex, avpn);
 
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
+	*old_pteh_ret = retvals.v[0];
+	*old_ptel_ret = retvals.v[1];
 
 	return rc;
 }
@@ -175,13 +175,13 @@ static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
 static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
 		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall(H_READ, retbuf, flags, ptex);
+	rc = plpar_hcall(H_READ, &retvals, flags, ptex);
 
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
+	*old_pteh_ret = retvals.v[0];
+	*old_ptel_ret = retvals.v[1];
 
 	return rc;
 }
@@ -190,13 +190,13 @@ static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
 static inline long plpar_pte_read_raw(unsigned long flags, unsigned long ptex,
 		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall_raw(H_READ, retbuf, flags, ptex);
+	rc = plpar_hcall_raw(H_READ, &retvals, flags, ptex);
 
-	*old_pteh_ret = retbuf[0];
-	*old_ptel_ret = retbuf[1];
+	*old_pteh_ret = retvals.v[0];
+	*old_ptel_ret = retvals.v[1];
 
 	return rc;
 }
@@ -245,12 +245,12 @@ static inline long plpar_pte_protect(unsigned long flags, unsigned long ptex,
 static inline long plpar_tce_get(unsigned long liobn, unsigned long ioba,
 		unsigned long *tce_ret)
 {
+	struct plpar_hcall_retvals retvals;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
 
-	rc = plpar_hcall(H_GET_TCE, retbuf, liobn, ioba);
+	rc = plpar_hcall(H_GET_TCE, &retvals, liobn, ioba);
 
-	*tce_ret = retbuf[0];
+	*tce_ret = retvals.v[0];
 
 	return rc;
 }
diff --git a/arch/powerpc/kernel/rtas.c b/arch/powerpc/kernel/rtas.c
index 6a3e5de544ce..7193b08d0c64 100644
--- a/arch/powerpc/kernel/rtas.c
+++ b/arch/powerpc/kernel/rtas.c
@@ -937,7 +937,7 @@ int rtas_ibm_suspend_me(u64 handle)
 {
 	long state;
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	struct rtas_suspend_me_data data;
 	DECLARE_COMPLETION_ONSTACK(done);
 	cpumask_var_t offline_mask;
@@ -947,9 +947,9 @@ int rtas_ibm_suspend_me(u64 handle)
 		return -ENOSYS;
 
 	/* Make sure the state is valid */
-	rc = plpar_hcall(H_VASI_STATE, retbuf, handle);
+	rc = plpar_hcall(H_VASI_STATE, &retvals, handle);
 
-	state = retbuf[0];
+	state = retvals.v[0];
 
 	if (rc) {
 		printk(KERN_ERR "rtas_ibm_suspend_me: vasi_state returned %ld\n",rc);
diff --git a/arch/powerpc/platforms/pseries/hvconsole.c b/arch/powerpc/platforms/pseries/hvconsole.c
index 74da18de853a..d3fd9a312ce2 100644
--- a/arch/powerpc/platforms/pseries/hvconsole.c
+++ b/arch/powerpc/platforms/pseries/hvconsole.c
@@ -41,15 +41,15 @@
 int hvc_get_chars(uint32_t vtermno, char *buf, int count)
 {
 	long ret;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	unsigned long *lbuf = (unsigned long *)buf;
 
-	ret = plpar_hcall(H_GET_TERM_CHAR, retbuf, vtermno);
-	lbuf[0] = be64_to_cpu(retbuf[1]);
-	lbuf[1] = be64_to_cpu(retbuf[2]);
+	ret = plpar_hcall(H_GET_TERM_CHAR, &retvals, vtermno);
+	lbuf[0] = be64_to_cpu(retvals.v[1]);
+	lbuf[1] = be64_to_cpu(retvals.v[2]);
 
 	if (ret == H_SUCCESS)
-		return retbuf[0];
+		return retvals.v[0];
 
 	return 0;
 }
diff --git a/arch/powerpc/platforms/pseries/lparcfg.c b/arch/powerpc/platforms/pseries/lparcfg.c
index afa05a2cb702..dabc899ae8ea 100644
--- a/arch/powerpc/platforms/pseries/lparcfg.c
+++ b/arch/powerpc/platforms/pseries/lparcfg.c
@@ -139,12 +139,12 @@ static unsigned h_pic(unsigned long *pool_idle_time,
 		      unsigned long *num_procs)
 {
 	unsigned long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 
-	rc = plpar_hcall(H_PIC, retbuf);
+	rc = plpar_hcall(H_PIC, &retvals);
 
-	*pool_idle_time = retbuf[0];
-	*num_procs = retbuf[1];
+	*pool_idle_time = retvals.v[0];
+	*num_procs = retvals.v[1];
 
 	return rc;
 }
@@ -423,11 +423,11 @@ static void splpar_dispatch_data(struct seq_file *m)
 
 static void parse_em_data(struct seq_file *m)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 
 	if (firmware_has_feature(FW_FEATURE_LPAR) &&
-	    plpar_hcall(H_GET_EM_PARMS, retbuf) == H_SUCCESS)
-		seq_printf(m, "power_mode_data=%016lx\n", retbuf[0]);
+	    plpar_hcall(H_GET_EM_PARMS, &retvals) == H_SUCCESS)
+		seq_printf(m, "power_mode_data=%016lx\n", retvals.v[0]);
 }
 
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
diff --git a/arch/powerpc/platforms/pseries/rng.c b/arch/powerpc/platforms/pseries/rng.c
index 31ca557af60b..86b91a4cb817 100644
--- a/arch/powerpc/platforms/pseries/rng.c
+++ b/arch/powerpc/platforms/pseries/rng.c
@@ -18,10 +18,10 @@
 
 static int pseries_get_random_long(unsigned long *v)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 
-	if (plpar_hcall(H_RANDOM, retbuf) == H_SUCCESS) {
-		*v = retbuf[0];
+	if (plpar_hcall(H_RANDOM, &retvals) == H_SUCCESS) {
+		*v = retvals.v[0];
 		return 1;
 	}
 
diff --git a/arch/powerpc/platforms/pseries/suspend.c b/arch/powerpc/platforms/pseries/suspend.c
index e76aefae2aa2..16b16f64e399 100644
--- a/arch/powerpc/platforms/pseries/suspend.c
+++ b/arch/powerpc/platforms/pseries/suspend.c
@@ -45,12 +45,12 @@ static atomic_t suspending;
 static int pseries_suspend_begin(suspend_state_t state)
 {
 	long vasi_state, rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 
 	/* Make sure the state is valid */
-	rc = plpar_hcall(H_VASI_STATE, retbuf, stream_id);
+	rc = plpar_hcall(H_VASI_STATE, &retvals, stream_id);
 
-	vasi_state = retbuf[0];
+	vasi_state = retvals.v[0];
 
 	if (rc) {
 		pr_err("pseries_suspend_begin: vasi_state returned %ld\n",rc);
diff --git a/arch/powerpc/sysdev/xics/icp-hv.c b/arch/powerpc/sysdev/xics/icp-hv.c
index e7fa26c4ff73..5f3279e3440a 100644
--- a/arch/powerpc/sysdev/xics/icp-hv.c
+++ b/arch/powerpc/sysdev/xics/icp-hv.c
@@ -24,13 +24,13 @@
 
 static inline unsigned int icp_hv_get_xirr(unsigned char cppr)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	long rc;
 	unsigned int ret = XICS_IRQ_SPURIOUS;
 
-	rc = plpar_hcall(H_XIRR, retbuf, cppr);
+	rc = plpar_hcall(H_XIRR, &retvals, cppr);
 	if (rc == H_SUCCESS) {
-		ret = (unsigned int)retbuf[0];
+		ret = (unsigned int)retvals.v[0];
 	} else {
 		pr_err("%s: bad return code xirr cppr=0x%x returned %ld\n",
 			__func__, cppr, rc);
diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/pseries-rng.c
index 63ce51d09af1..c519a6a88d53 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -27,16 +27,16 @@
 
 static int pseries_rng_read(struct hwrng *rng, void *data, size_t max, bool wait)
 {
-	u64 buffer[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	size_t size = max < 8 ? max : 8;
 	int rc;
 
-	rc = plpar_hcall(H_RANDOM, (unsigned long *)buffer);
+	rc = plpar_hcall(H_RANDOM, &retvals);
 	if (rc != H_SUCCESS) {
 		pr_err_ratelimited("H_RANDOM call failed %d\n", rc);
 		return -EIO;
 	}
-	memcpy(data, buffer, size);
+	memcpy(data, &retvals.v, size);
 
 	/* The hypervisor interface returns 64 bits */
 	return size;
diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index 01a8d917631c..c07b9607e1fb 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -50,15 +50,15 @@
 #define H_DOWNLOAD_CA_FACILITY_VALIDATE         2 /* validate adapter image */
 
 
-#define _CXL_LOOP_HCALL(call, rc, retbuf, fn, ...)			\
+#define _CXL_LOOP_HCALL(call, rc, retvals, fn, ...)			\
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
@@ -165,25 +165,25 @@ long cxl_h_attach_process(u64 unit_address,
 			struct cxl_process_element_hcall *element,
 			u64 *process_token, u64 *mmio_addr, u64 *mmio_size)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	long rc;
 
-	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_ATTACH_CA_PROCESS, unit_address, virt_to_phys(element));
+	CXL_H_WAIT_UNTIL_DONE(rc, retvals, H_ATTACH_CA_PROCESS, unit_address, virt_to_phys(element));
 	_PRINT_MSG(rc, "cxl_h_attach_process(%#.16llx, %#.16lx): %li\n",
 		unit_address, virt_to_phys(element), rc);
-	trace_cxl_hcall_attach(unit_address, virt_to_phys(element), retbuf[0], retbuf[1], retbuf[2], rc);
+	trace_cxl_hcall_attach(unit_address, virt_to_phys(element), retvals.v[0], retvals.v[1], retvals.v[2], rc);
 
 	pr_devel("token: 0x%.8lx mmio_addr: 0x%lx mmio_size: 0x%lx\nProcess Element Structure:\n",
-		retbuf[0], retbuf[1], retbuf[2]);
+		retvals.v[0], retvals.v[1], retvals.v[2]);
 	cxl_dump_debug_buffer(element, sizeof(*element));
 
 	switch (rc) {
 	case H_SUCCESS:       /* The process info is attached to the coherent platform function */
-		*process_token = retbuf[0];
+		*process_token = retvals.v[0];
 		if (mmio_addr)
-			*mmio_addr = retbuf[1];
+			*mmio_addr = retvals.v[1];
 		if (mmio_size)
-			*mmio_size = retbuf[2];
+			*mmio_size = retvals.v[2];
 		return 0;
 	case H_PARAMETER:     /* An incorrect parameter was supplied. */
 	case H_FUNCTION:      /* The function is not supported. */
@@ -206,10 +206,10 @@ long cxl_h_attach_process(u64 unit_address,
  */
 long cxl_h_detach_process(u64 unit_address, u64 process_token)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	long rc;
 
-	CXL_H_WAIT_UNTIL_DONE(rc, retbuf, H_DETACH_CA_PROCESS, unit_address, process_token);
+	CXL_H_WAIT_UNTIL_DONE(rc, retvals, H_DETACH_CA_PROCESS, unit_address, process_token);
 	_PRINT_MSG(rc, "cxl_h_detach_process(%#.16llx, 0x%.8llx): %li\n", unit_address, process_token, rc);
 	trace_cxl_hcall_detach(unit_address, process_token, rc);
 
@@ -471,19 +471,19 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
 long cxl_h_control_faults(u64 unit_address, u64 process_token,
 			  u64 control_mask, u64 reset_mask)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	long rc;
 
-	memset(retbuf, 0, sizeof(retbuf));
+	memset(&retvals, 0, sizeof(retvals));
 
-	rc = plpar_hcall(H_CONTROL_CA_FAULTS, retbuf, unit_address,
+	rc = plpar_hcall(H_CONTROL_CA_FAULTS, &retvals, unit_address,
 			H_CONTROL_CA_FAULTS_RESPOND_PSL, process_token,
 			control_mask, reset_mask);
 	_PRINT_MSG(rc, "cxl_h_control_faults(%#.16llx, 0x%llx, %#llx, %#llx): %li (%#lx)\n",
 		unit_address, process_token, control_mask, reset_mask,
-		rc, retbuf[0]);
+		rc, retvals.v[0]);
 	trace_cxl_hcall_control_faults(unit_address, process_token,
-				control_mask, reset_mask, retbuf[0], rc);
+				control_mask, reset_mask, retvals.v[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:    /* Faults were successfully controlled for the function. */
@@ -592,7 +592,7 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 				    u64 list_address, u64 num,
 				    u64 *out)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	unsigned int delay, total_delay = 0;
 	u64 token = 0;
 	long rc;
@@ -600,12 +600,12 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 	if (*out != 0)
 		token = *out;
 
-	memset(retbuf, 0, sizeof(retbuf));
+	memset(&retvals, 0, sizeof(retvals));
 	while (1) {
-		rc = plpar_hcall(H_DOWNLOAD_CA_FACILITY, retbuf,
+		rc = plpar_hcall(H_DOWNLOAD_CA_FACILITY, &retvals,
 				 unit_address, op, list_address, num,
 				 token);
-		token = retbuf[0];
+		token = retvals.v[0];
 		if (rc != H_BUSY && !H_IS_LONG_BUSY(rc))
 			break;
 
@@ -623,8 +623,8 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 		}
 	}
 	_PRINT_MSG(rc, "cxl_h_download_facility(%#.16llx, %s(%#llx, %#llx), %#lx): %li\n",
-		 unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
-	trace_cxl_hcall_download_facility(unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retbuf[0], rc);
+		 unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retvals.v[0], rc);
+	trace_cxl_hcall_download_facility(unit_address, OP_STR_DOWNLOAD_ADAPTER(op), list_address, num, retvals.v[0], rc);
 
 	switch (rc) {
 	case H_SUCCESS:       /* The operation is completed for the coherent platform facility */
@@ -641,7 +641,7 @@ static long cxl_h_download_facility(u64 unit_address, u64 op,
 	case H_BUSY:
 		return -EBUSY;
 	case H_CONTINUE:
-		*out = retbuf[0];
+		*out = retvals.v[0];
 		return 1;  /* More data is needed for the complete image */
 	default:
 		WARN(1, "Unexpected return code: %lx", rc);
diff --git a/drivers/net/ethernet/ibm/ibmveth.h b/drivers/net/ethernet/ibm/ibmveth.h
index 4eade67fe30c..36f76d18ccef 100644
--- a/drivers/net/ethernet/ibm/ibmveth.h
+++ b/drivers/net/ethernet/ibm/ibmveth.h
@@ -86,12 +86,12 @@ static inline long h_illan_attributes(unsigned long unit_address,
 				      unsigned long *ret_attributes)
 {
 	long rc;
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 
-	rc = plpar_hcall(H_ILLAN_ATTRIBUTES, retbuf, unit_address,
+	rc = plpar_hcall(H_ILLAN_ATTRIBUTES, &retvals, unit_address,
 			 reset_mask, set_mask);
 
-	*ret_attributes = retbuf[0];
+	*ret_attributes = retvals.v[0];
 
 	return rc;
 }
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index bfe17d9c022d..b90a9b65438c 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -150,12 +150,12 @@ static long h_reg_sub_crq(unsigned long unit_address, unsigned long token,
 			  unsigned long length, unsigned long *number,
 			  unsigned long *irq)
 {
-	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
+	struct plpar_hcall_retvals retvals;
 	long rc;
 
-	rc = plpar_hcall(H_REG_SUB_CRQ, retbuf, unit_address, token, length);
-	*number = retbuf[0];
-	*irq = retbuf[1];
+	rc = plpar_hcall(H_REG_SUB_CRQ, &retvals, unit_address, token, length);
+	*number = retvals.v[0];
+	*irq = retvals.v[1];
 
 	return rc;
 }
-- 
2.7.4
