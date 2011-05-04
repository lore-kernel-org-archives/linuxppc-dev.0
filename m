Return-Path: <nacc@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 026DD1007F3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 08:54:30 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p44Mh6nJ009327
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 16:43:06 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p44MsJ5N162408
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 16:54:19 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p44Grp5V023152
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 May 2011 10:53:51 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: ensure dtl buffers do not cross 4k boundary
Date: Wed,  4 May 2011 15:54:16 -0700
Message-Id: <1304549656-18109-1-git-send-email-nacc@us.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Future releases of fimrware will enforce a requirement that DTL buffers
do not cross a 4k boundary. Commit
127493d5dc73589cbe00ea5ec8357cc2a4c0d82a satisfies this requirement for
CONFIG_VIRT_CPU_ACCOUNTING=y kernels, but if !CONFIG_VIRT_CPU_ACCOUNTING
&& CONFIG_DTL=y, the current code will fail at dtl registration time.
Fix this by making the kmem cache from
127493d5dc73589cbe00ea5ec8357cc2a4c0d82a visible outside of setup.c and
using the same cache in both dtl.c and setup.c. This requires a bit of
reorganization to ensure ordering of the kmem cache and buffer
allocations.

Note: Since firmware now limits the size of the buffer, I made
dtl_buf_entries read-only in debugfs.

Tested with upcoming firmware with the 4 combinations of
CONFIG_VIRT_CPU_ACCOUNTING and CONFIG_DTL.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org

---
Paul, why should `cat /sys/kernel/debug/powerpc/dtl/cpu-0` return
EINVAL? I understand why it does from the code as the page size (4k or
64k) is not evenly divisble by 48 bytes, but is that EINVAL just to
avoid dealing with short reads?

 arch/powerpc/include/asm/lppaca.h      |    2 ++
 arch/powerpc/platforms/pseries/dtl.c   |   20 +++++++++++---------
 arch/powerpc/platforms/pseries/setup.c |   31 ++++++++++++++++++++++---------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index a077adc..e0298d2 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -210,6 +210,8 @@ struct dtl_entry {
 #define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
 #define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
 
+extern struct kmem_cache *dtl_cache;
+
 /*
  * When CONFIG_VIRT_CPU_ACCOUNTING = y, the cpu accounting code controls
  * reading from the dispatch trace log.  If other code wants to consume
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index c371bc0..e919007 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -52,10 +52,10 @@ static u8 dtl_event_mask = 0x7;
 
 
 /*
- * Size of per-cpu log buffers. Default is just under 16 pages worth.
+ * Size of per-cpu log buffers. Firmware requires that the buffer does
+ * not cross a 4k boundary.
  */
-static int dtl_buf_entries = (16 * 85);
-
+static int dtl_buf_entries = N_DISPATCH_LOG;
 
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 struct dtl_ring {
@@ -151,7 +151,7 @@ static int dtl_start(struct dtl *dtl)
 
 	/* Register our dtl buffer with the hypervisor. The HV expects the
 	 * buffer size to be passed in the second word of the buffer */
-	((u32 *)dtl->buf)[1] = dtl->buf_entries * sizeof(struct dtl_entry);
+	((u32 *)dtl->buf)[1] = DISPATCH_LOG_BYTES;
 
 	hwcpu = get_hard_smp_processor_id(dtl->cpu);
 	addr = __pa(dtl->buf);
@@ -196,13 +196,15 @@ static int dtl_enable(struct dtl *dtl)
 	long int rc;
 	struct dtl_entry *buf = NULL;
 
+	if (!dtl_cache)
+		return -ENOMEM;
+
 	/* only allow one reader */
 	if (dtl->buf)
 		return -EBUSY;
 
 	n_entries = dtl_buf_entries;
-	buf = kmalloc_node(n_entries * sizeof(struct dtl_entry),
-			GFP_KERNEL, cpu_to_node(dtl->cpu));
+	buf = kmem_cache_alloc_node(dtl_cache, GFP_KERNEL, cpu_to_node(dtl->cpu));
 	if (!buf) {
 		printk(KERN_WARNING "%s: buffer alloc failed for cpu %d\n",
 				__func__, dtl->cpu);
@@ -223,7 +225,7 @@ static int dtl_enable(struct dtl *dtl)
 	spin_unlock(&dtl->lock);
 
 	if (rc)
-		kfree(buf);
+		kmem_cache_free(dtl_cache, buf);
 	return rc;
 }
 
@@ -231,7 +233,7 @@ static void dtl_disable(struct dtl *dtl)
 {
 	spin_lock(&dtl->lock);
 	dtl_stop(dtl);
-	kfree(dtl->buf);
+	kmem_cache_free(dtl_cache, dtl->buf);
 	dtl->buf = NULL;
 	dtl->buf_entries = 0;
 	spin_unlock(&dtl->lock);
@@ -365,7 +367,7 @@ static int dtl_init(void)
 
 	event_mask_file = debugfs_create_x8("dtl_event_mask", 0600,
 				dtl_dir, &dtl_event_mask);
-	buf_entries_file = debugfs_create_u32("dtl_buf_entries", 0600,
+	buf_entries_file = debugfs_create_u32("dtl_buf_entries", 0400,
 				dtl_dir, &dtl_buf_entries);
 
 	if (!event_mask_file || !buf_entries_file) {
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 6c42cfd..b6ecd04 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -276,6 +276,8 @@ static struct notifier_block pci_dn_reconfig_nb = {
 	.notifier_call = pci_dn_reconfig_notifier,
 };
 
+struct kmem_cache *dtl_cache;
+
 #ifdef CONFIG_VIRT_CPU_ACCOUNTING
 /*
  * Allocate space for the dispatch trace log for all possible cpus
@@ -287,18 +289,12 @@ static int alloc_dispatch_logs(void)
 	int cpu, ret;
 	struct paca_struct *pp;
 	struct dtl_entry *dtl;
-	struct kmem_cache *dtl_cache;
 
 	if (!firmware_has_feature(FW_FEATURE_SPLPAR))
 		return 0;
 
-	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
-						DISPATCH_LOG_BYTES, 0, NULL);
-	if (!dtl_cache) {
-		pr_warn("Failed to create dispatch trace log buffer cache\n");
-		pr_warn("Stolen time statistics will be unreliable\n");
+	if (!dtl_cache)
 		return 0;
-	}
 
 	for_each_possible_cpu(cpu) {
 		pp = &paca[cpu];
@@ -332,10 +328,27 @@ static int alloc_dispatch_logs(void)
 
 	return 0;
 }
-
-early_initcall(alloc_dispatch_logs);
+#else /* !CONFIG_VIRT_CPU_ACCOUNTING */
+static inline int alloc_dispatch_logs(void)
+{
+	return 0;
+}
 #endif /* CONFIG_VIRT_CPU_ACCOUNTING */
 
+static int alloc_dispatch_log_kmem_cache(void)
+{
+	dtl_cache = kmem_cache_create("dtl", DISPATCH_LOG_BYTES,
+						DISPATCH_LOG_BYTES, 0, NULL);
+	if (!dtl_cache) {
+		pr_warn("Failed to create dispatch trace log buffer cache\n");
+		pr_warn("Stolen time statistics will be unreliable\n");
+		return 0;
+	}
+
+	return alloc_dispatch_logs();
+}
+early_initcall(alloc_dispatch_log_kmem_cache);
+
 static void __init pSeries_setup_arch(void)
 {
 	/* Discover PIC type and setup ppc_md accordingly */
-- 
1.7.4.1
