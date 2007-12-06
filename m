Return-Path: <fenkes@de.ibm.com>
Received: from mtagate6.uk.ibm.com (mtagate6.uk.ibm.com [195.212.29.139])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B003DDFD1
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 02:10:21 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate6.uk.ibm.com (8.13.8/8.13.8) with ESMTP id lB6F7uMx172802
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 15:07:56 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id lB6F7tQB1904658
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 15:07:55 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id lB6F7bWn001984
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 15:07:38 GMT
From: Joachim Fenkes <fenkes@de.ibm.com>
To: "LinuxPPC-Dev" <linuxppc-dev@ozlabs.org>,
	LKML <linux-kernel@vger.kernel.org>,
	"OF-General" <general@lists.openfabrics.org>,
	Roland Dreier <rolandd@cisco.com>, "OF-EWG" <ewg@lists.openfabrics.org>
Subject: [PATCH] IB/ehca: Serialize HCA-related hCalls on POWER5
MIME-Version: 1.0
Date: Thu, 6 Dec 2007 16:07:19 +0100
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712061607.20004.fenkes@de.ibm.com>
Cc: Stefan Roscher <stefan.roscher@de.ibm.com>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All firmware versions on POWER5 systems have a locking issue in the
HCA-related hCalls that can cause loss of Infiniband connectivity if
allocate and free calls happen in parallel. This may for example be caused
if two processes are using OpenMPI in parallel.
Circumvent this by serializing all HCA-related hCalls on POWER5.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---

We tested this patch, especially the autodetection, and it works okay.
Please review and apply for 2.6.24-rc5 - thanks!

 drivers/infiniband/hw/ehca/ehca_main.c |   16 ++++++++++++++++
 drivers/infiniband/hw/ehca/hcp_if.c    |   28 +++++++++++-----------------
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/ehca/ehca_main.c b/drivers/infiniband/hw/ehca/ehca_main.c
index 90d4334..8f33d06 100644
--- a/drivers/infiniband/hw/ehca/ehca_main.c
+++ b/drivers/infiniband/hw/ehca/ehca_main.c
@@ -43,6 +43,9 @@
 #ifdef CONFIG_PPC_64K_PAGES
 #include <linux/slab.h>
 #endif
+
+#include <asm/cputable.h>
+
 #include "ehca_classes.h"
 #include "ehca_iverbs.h"
 #include "ehca_mrmw.h"
@@ -66,6 +69,7 @@ int ehca_poll_all_eqs  = 1;
 int ehca_static_rate   = -1;
 int ehca_scaling_code  = 0;
 int ehca_mr_largepage  = 1;
+int ehca_lock_hcalls   = -1;
 
 module_param_named(open_aqp1,     ehca_open_aqp1,     int, S_IRUGO);
 module_param_named(debug_level,   ehca_debug_level,   int, S_IRUGO);
@@ -77,6 +81,7 @@ module_param_named(poll_all_eqs,  ehca_poll_all_eqs,  int, S_IRUGO);
 module_param_named(static_rate,   ehca_static_rate,   int, S_IRUGO);
 module_param_named(scaling_code,  ehca_scaling_code,  int, S_IRUGO);
 module_param_named(mr_largepage,  ehca_mr_largepage,  int, S_IRUGO);
+module_param_named(lock_hcalls,   ehca_lock_hcalls,   bool, S_IRUGO);
 
 MODULE_PARM_DESC(open_aqp1,
 		 "AQP1 on startup (0: no (default), 1: yes)");
@@ -102,6 +107,9 @@ MODULE_PARM_DESC(scaling_code,
 MODULE_PARM_DESC(mr_largepage,
 		 "use large page for MR (0: use PAGE_SIZE (default), "
 		 "1: use large page depending on MR size");
+MODULE_PARM_DESC(lock_hcalls,
+		 "serialize all hCalls made by the driver "
+		 "(default: autodetect)");
 
 DEFINE_RWLOCK(ehca_qp_idr_lock);
 DEFINE_RWLOCK(ehca_cq_idr_lock);
@@ -924,6 +932,14 @@ int __init ehca_module_init(void)
 	printk(KERN_INFO "eHCA Infiniband Device Driver "
 	       "(Version " HCAD_VERSION ")\n");
 
+	/* Autodetect hCall locking -- we can't read the firmware version
+	 * directly, but we know that starting with POWER6, all firmware
+	 * versions are good.
+	 */
+	if (ehca_lock_hcalls == -1)
+		ehca_lock_hcalls = !(cur_cpu_spec->cpu_user_features
+				     & PPC_FEATURE_ARCH_2_05);
+
 	ret = ehca_create_comp_pool();
 	if (ret) {
 		ehca_gen_err("Cannot create comp pool.");
diff --git a/drivers/infiniband/hw/ehca/hcp_if.c b/drivers/infiniband/hw/ehca/hcp_if.c
index c16a213..331b5e8 100644
--- a/drivers/infiniband/hw/ehca/hcp_if.c
+++ b/drivers/infiniband/hw/ehca/hcp_if.c
@@ -89,6 +89,7 @@
 #define HCALL9_REGS_FORMAT HCALL7_REGS_FORMAT " r11=%lx r12=%lx"
 
 static DEFINE_SPINLOCK(hcall_lock);
+extern int ehca_lock_hcalls;
 
 static u32 get_longbusy_msecs(int longbusy_rc)
 {
@@ -120,26 +121,21 @@ static long ehca_plpar_hcall_norets(unsigned long opcode,
 				    unsigned long arg7)
 {
 	long ret;
-	int i, sleep_msecs, do_lock;
-	unsigned long flags;
+	int i, sleep_msecs;
+	unsigned long flags = 0;
 
 	ehca_gen_dbg("opcode=%lx " HCALL7_REGS_FORMAT,
 		     opcode, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
 
-	/* lock H_FREE_RESOURCE(MR) against itself and H_ALLOC_RESOURCE(MR) */
-	if ((opcode == H_FREE_RESOURCE) && (arg7 == 5)) {
-		arg7 = 0; /* better not upset firmware */
-		do_lock = 1;
-	}
-
 	for (i = 0; i < 5; i++) {
-		if (do_lock)
+		/* serialize hCalls to work around firmware issue */
+		if (ehca_lock_hcalls)
 			spin_lock_irqsave(&hcall_lock, flags);
 
 		ret = plpar_hcall_norets(opcode, arg1, arg2, arg3, arg4,
 					 arg5, arg6, arg7);
 
-		if (do_lock)
+		if (ehca_lock_hcalls)
 			spin_unlock_irqrestore(&hcall_lock, flags);
 
 		if (H_IS_LONG_BUSY(ret)) {
@@ -174,24 +170,22 @@ static long ehca_plpar_hcall9(unsigned long opcode,
 			      unsigned long arg9)
 {
 	long ret;
-	int i, sleep_msecs, do_lock;
+	int i, sleep_msecs;
 	unsigned long flags = 0;
 
 	ehca_gen_dbg("INPUT -- opcode=%lx " HCALL9_REGS_FORMAT, opcode,
 		     arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
 
-	/* lock H_ALLOC_RESOURCE(MR) against itself and H_FREE_RESOURCE(MR) */
-	do_lock = ((opcode == H_ALLOC_RESOURCE) && (arg2 == 5));
-
 	for (i = 0; i < 5; i++) {
-		if (do_lock)
+		/* serialize hCalls to work around firmware issue */
+		if (ehca_lock_hcalls)
 			spin_lock_irqsave(&hcall_lock, flags);
 
 		ret = plpar_hcall9(opcode, outs,
 				   arg1, arg2, arg3, arg4, arg5,
 				   arg6, arg7, arg8, arg9);
 
-		if (do_lock)
+		if (ehca_lock_hcalls)
 			spin_unlock_irqrestore(&hcall_lock, flags);
 
 		if (H_IS_LONG_BUSY(ret)) {
@@ -821,7 +815,7 @@ u64 hipz_h_free_resource_mr(const struct ipz_adapter_handle adapter_handle,
 	return ehca_plpar_hcall_norets(H_FREE_RESOURCE,
 				       adapter_handle.handle,    /* r4 */
 				       mr->ipz_mr_handle.handle, /* r5 */
-				       0, 0, 0, 0, 5);
+				       0, 0, 0, 0, 0);
 }
 
 u64 hipz_h_reregister_pmr(const struct ipz_adapter_handle adapter_handle,
-- 
1.5.2
