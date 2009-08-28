Return-Path: <brking@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9C1B3B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 29 Aug 2009 08:06:40 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e31.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n7SM0pno025658
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 16:00:51 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n7SM6VLd166376
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 16:06:32 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n7SM6VQE011137
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2009 16:06:31 -0600
Message-Id: <200908282206.n7SM6UK1011114@d03av01.boulder.ibm.com>
Subject: [PATCH 1/1] powerpc: Fix to handle slb resize across migration
To: benh@kernel.crashing.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 28 Aug 2009 17:06:29 -0500
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


The SLB can change sizes across a live migration, which was not
being handled, resulting in possible machine crashes during
migration if migrating to a machine which has a smaller max SLB
size than the source machine. Fix this by first reducing the
SLB size to the minimum possible value, which is 32, prior to
migration. Then during the device tree update which occurs after
migration, we make the call to ensure the SLB gets updated. Also
add the slb_size to the lparcfg output so that the migration
tools can check to make sure the kernel has this capability
before allowing migration in scenarios where the SLB size will change.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 arch/powerpc/include/asm/mmu-hash64.h     |    2 ++
 arch/powerpc/kernel/lparcfg.c             |    3 +++
 arch/powerpc/kernel/rtas.c                |    7 ++++++-
 arch/powerpc/mm/slb.c                     |   16 ++++++++++++----
 arch/powerpc/platforms/pseries/reconfig.c |    9 ++++++++-
 5 files changed, 31 insertions(+), 6 deletions(-)

diff -puN arch/powerpc/kernel/rtas.c~powerpc_slb_resize arch/powerpc/kernel/rtas.c
--- linux-2.6/arch/powerpc/kernel/rtas.c~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/rtas.c	2009-08-21 16:14:41.000000000 -0500
@@ -39,6 +39,7 @@
 #include <asm/smp.h>
 #include <asm/atomic.h>
 #include <asm/time.h>
+#include <asm/mmu-hash64.h>
 
 struct rtas_t rtas = {
 	.lock = __RAW_SPIN_LOCK_UNLOCKED
@@ -713,6 +714,7 @@ static void rtas_percpu_suspend_me(void
 {
 	long rc = H_SUCCESS;
 	unsigned long msr_save;
+	u16 slb_size = mmu_slb_size;
 	int cpu;
 	struct rtas_suspend_me_data *data =
 		(struct rtas_suspend_me_data *)info;
@@ -735,13 +737,16 @@ static void rtas_percpu_suspend_me(void
 		/* All other cpus are in H_JOIN, this cpu does
 		 * the suspend.
 		 */
+		slb_set_size(SLB_MIN_SIZE);
 		printk(KERN_DEBUG "calling ibm,suspend-me on cpu %i\n",
 		       smp_processor_id());
 		data->error = rtas_call(data->token, 0, 1, NULL);
 
-		if (data->error)
+		if (data->error) {
 			printk(KERN_DEBUG "ibm,suspend-me returned %d\n",
 			       data->error);
+			slb_set_size(slb_size);
+		}
 	} else {
 		printk(KERN_ERR "H_JOIN on cpu %i failed with rc = %ld\n",
 		       smp_processor_id(), rc);
diff -puN arch/powerpc/include/asm/mmu-hash64.h~powerpc_slb_resize arch/powerpc/include/asm/mmu-hash64.h
--- linux-2.6/arch/powerpc/include/asm/mmu-hash64.h~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/include/asm/mmu-hash64.h	2009-08-21 16:14:41.000000000 -0500
@@ -41,6 +41,7 @@ extern char initial_stab[];
 
 #define SLB_NUM_BOLTED		3
 #define SLB_CACHE_ENTRIES	8
+#define SLB_MIN_SIZE		32
 
 /* Bits in the SLB ESID word */
 #define SLB_ESID_V		ASM_CONST(0x0000000008000000) /* valid */
@@ -296,6 +297,7 @@ extern void slb_flush_and_rebolt(void);
 extern void stab_initialize(unsigned long stab);
 
 extern void slb_vmalloc_update(void);
+extern void slb_set_size(u16 size);
 #endif /* __ASSEMBLY__ */
 
 /*
diff -puN arch/powerpc/mm/slb.c~powerpc_slb_resize arch/powerpc/mm/slb.c
--- linux-2.6/arch/powerpc/mm/slb.c~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/mm/slb.c	2009-08-21 16:14:41.000000000 -0500
@@ -240,14 +240,22 @@ void switch_slb(struct task_struct *tsk,
 static inline void patch_slb_encoding(unsigned int *insn_addr,
 				      unsigned int immed)
 {
-	/* Assume the instruction had a "0" immediate value, just
-	 * "or" in the new value
-	 */
-	*insn_addr |= immed;
+	*insn_addr = (*insn_addr & 0xffff0000) | immed;
 	flush_icache_range((unsigned long)insn_addr, 4+
 			   (unsigned long)insn_addr);
 }
 
+void slb_set_size(u16 size)
+{
+	extern unsigned int *slb_compare_rr_to_size;
+
+	if (mmu_slb_size == size)
+		return;
+
+	mmu_slb_size = size;
+	patch_slb_encoding(slb_compare_rr_to_size, mmu_slb_size);
+}
+
 void slb_initialize(void)
 {
 	unsigned long linear_llp, vmalloc_llp, io_llp;
diff -puN arch/powerpc/platforms/pseries/reconfig.c~powerpc_slb_resize arch/powerpc/platforms/pseries/reconfig.c
--- linux-2.6/arch/powerpc/platforms/pseries/reconfig.c~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/reconfig.c	2009-08-28 13:36:55.000000000 -0500
@@ -20,6 +20,7 @@
 #include <asm/machdep.h>
 #include <asm/uaccess.h>
 #include <asm/pSeries_reconfig.h>
+#include <asm/mmu-hash64.h>
 
 
 
@@ -439,9 +440,15 @@ static int do_update_property(char *buf,
 	if (!newprop)
 		return -ENOMEM;
 
+	if (!strcmp(name, "slb-size") || !strcmp(name, "ibm,slb-size"))
+		slb_set_size(*(int *)value);
+
 	oldprop = of_find_property(np, name,NULL);
-	if (!oldprop)
+	if (!oldprop) {
+		if (strlen(name))
+			return prom_add_property(np, newprop);
 		return -ENODEV;
+	}
 
 	rc = prom_update_property(np, newprop, oldprop);
 	if (rc)
diff -puN arch/powerpc/kernel/lparcfg.c~powerpc_slb_resize arch/powerpc/kernel/lparcfg.c
--- linux-2.6/arch/powerpc/kernel/lparcfg.c~powerpc_slb_resize	2009-08-21 16:14:41.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/kernel/lparcfg.c	2009-08-21 16:14:41.000000000 -0500
@@ -35,6 +35,7 @@
 #include <asm/prom.h>
 #include <asm/vdso_datapage.h>
 #include <asm/vio.h>
+#include <asm/mmu-hash64.h>
 
 #define MODULE_VERS "1.8"
 #define MODULE_NAME "lparcfg"
@@ -537,6 +538,8 @@ static int pseries_lparcfg_data(struct s
 
 	seq_printf(m, "shared_processor_mode=%d\n", lppaca[0].shared_proc);
 
+	seq_printf(m, "slb_size=%d\n", mmu_slb_size);
+
 	return 0;
 }
 
_
