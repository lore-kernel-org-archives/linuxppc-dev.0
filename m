Return-Path: <anton@samba.org>
Date: Fri, 21 Jan 2011 13:43:59 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 7/8] powerpc/kdump: Move crash_kexec_stop_spus to kdump
	crash handler
Message-ID: <20110121134359.17ace4de@kryten>
In-Reply-To: <20110107145954.4f421183@kryten>
References: <20110107145255.72cf30ba@kryten> <20110107145954.4f421183@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


And here's a version that actually compiles. Sorry Ben :)

Anton
--

Use the crash handler hooks to run the SPU stop code, just like we do for
ehea and cell RAS code.

While I'm here I noticed "CPUSs reliabally"

so fix the spelling MISTAKESs reliabally.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/kernel/crash.c
===================================================================
--- powerpc.git.orig/arch/powerpc/kernel/crash.c	2011-01-21 13:41:01.192747292 +1100
+++ powerpc.git/arch/powerpc/kernel/crash.c	2011-01-21 13:41:07.272364454 +1100
@@ -48,7 +48,7 @@ int crashing_cpu = -1;
 static cpumask_t cpus_in_crash = CPU_MASK_NONE;
 cpumask_t cpus_in_sr = CPU_MASK_NONE;
 
-#define CRASH_HANDLER_MAX 2
+#define CRASH_HANDLER_MAX 3
 /* NULL terminated list of shutdown handles */
 static crash_shutdown_t crash_shutdown_handles[CRASH_HANDLER_MAX+1];
 static DEFINE_SPINLOCK(crash_handlers_lock);
@@ -125,7 +125,7 @@ static void crash_kexec_prepare_cpus(int
 	smp_wmb();
 
 	/*
-	 * FIXME: Until we will have the way to stop other CPUSs reliabally,
+	 * FIXME: Until we will have the way to stop other CPUs reliably,
 	 * the crash CPU will send an IPI and wait for other CPUs to
 	 * respond.
 	 * Delay of at least 10 seconds.
@@ -254,72 +254,6 @@ void crash_kexec_secondary(struct pt_reg
 	cpus_in_sr = CPU_MASK_NONE;
 }
 #endif
-#ifdef CONFIG_SPU_BASE
-
-#include <asm/spu.h>
-#include <asm/spu_priv1.h>
-
-struct crash_spu_info {
-	struct spu *spu;
-	u32 saved_spu_runcntl_RW;
-	u32 saved_spu_status_R;
-	u32 saved_spu_npc_RW;
-	u64 saved_mfc_sr1_RW;
-	u64 saved_mfc_dar;
-	u64 saved_mfc_dsisr;
-};
-
-#define CRASH_NUM_SPUS	16	/* Enough for current hardware */
-static struct crash_spu_info crash_spu_info[CRASH_NUM_SPUS];
-
-static void crash_kexec_stop_spus(void)
-{
-	struct spu *spu;
-	int i;
-	u64 tmp;
-
-	for (i = 0; i < CRASH_NUM_SPUS; i++) {
-		if (!crash_spu_info[i].spu)
-			continue;
-
-		spu = crash_spu_info[i].spu;
-
-		crash_spu_info[i].saved_spu_runcntl_RW =
-			in_be32(&spu->problem->spu_runcntl_RW);
-		crash_spu_info[i].saved_spu_status_R =
-			in_be32(&spu->problem->spu_status_R);
-		crash_spu_info[i].saved_spu_npc_RW =
-			in_be32(&spu->problem->spu_npc_RW);
-
-		crash_spu_info[i].saved_mfc_dar    = spu_mfc_dar_get(spu);
-		crash_spu_info[i].saved_mfc_dsisr  = spu_mfc_dsisr_get(spu);
-		tmp = spu_mfc_sr1_get(spu);
-		crash_spu_info[i].saved_mfc_sr1_RW = tmp;
-
-		tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
-		spu_mfc_sr1_set(spu, tmp);
-
-		__delay(200);
-	}
-}
-
-void crash_register_spus(struct list_head *list)
-{
-	struct spu *spu;
-
-	list_for_each_entry(spu, list, full_list) {
-		if (WARN_ON(spu->number >= CRASH_NUM_SPUS))
-			continue;
-
-		crash_spu_info[spu->number].spu = spu;
-	}
-}
-
-#else
-static inline void crash_kexec_stop_spus(void)
-{
-}
-#endif /* CONFIG_SPU_BASE */
 
 /*
  * Register a function to be called on shutdown.  Only use this if you
@@ -439,8 +373,6 @@ void default_machine_crash_shutdown(stru
 	crash_shutdown_cpu = -1;
 	__debugger_fault_handler = old_handler;
 
-	crash_kexec_stop_spus();
-
 	if (ppc_md.kexec_cpu_down)
 		ppc_md.kexec_cpu_down(1, 0);
 }
Index: powerpc.git/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- powerpc.git.orig/arch/powerpc/platforms/cell/spu_base.c	2011-01-21 13:41:01.192747292 +1100
+++ powerpc.git/arch/powerpc/platforms/cell/spu_base.c	2011-01-21 13:42:12.358265951 +1100
@@ -37,6 +37,7 @@
 #include <asm/spu_csa.h>
 #include <asm/xmon.h>
 #include <asm/prom.h>
+#include <asm/kexec.h>
 
 const struct spu_management_ops *spu_management_ops;
 EXPORT_SYMBOL_GPL(spu_management_ops);
@@ -727,6 +728,75 @@ static ssize_t spu_stat_show(struct sys_
 
 static SYSDEV_ATTR(stat, 0644, spu_stat_show, NULL);
 
+#ifdef CONFIG_KEXEC
+
+struct crash_spu_info {
+	struct spu *spu;
+	u32 saved_spu_runcntl_RW;
+	u32 saved_spu_status_R;
+	u32 saved_spu_npc_RW;
+	u64 saved_mfc_sr1_RW;
+	u64 saved_mfc_dar;
+	u64 saved_mfc_dsisr;
+};
+
+#define CRASH_NUM_SPUS	16	/* Enough for current hardware */
+static struct crash_spu_info crash_spu_info[CRASH_NUM_SPUS];
+
+static void crash_kexec_stop_spus(void)
+{
+	struct spu *spu;
+	int i;
+	u64 tmp;
+
+	for (i = 0; i < CRASH_NUM_SPUS; i++) {
+		if (!crash_spu_info[i].spu)
+			continue;
+
+		spu = crash_spu_info[i].spu;
+
+		crash_spu_info[i].saved_spu_runcntl_RW =
+			in_be32(&spu->problem->spu_runcntl_RW);
+		crash_spu_info[i].saved_spu_status_R =
+			in_be32(&spu->problem->spu_status_R);
+		crash_spu_info[i].saved_spu_npc_RW =
+			in_be32(&spu->problem->spu_npc_RW);
+
+		crash_spu_info[i].saved_mfc_dar    = spu_mfc_dar_get(spu);
+		crash_spu_info[i].saved_mfc_dsisr  = spu_mfc_dsisr_get(spu);
+		tmp = spu_mfc_sr1_get(spu);
+		crash_spu_info[i].saved_mfc_sr1_RW = tmp;
+
+		tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
+		spu_mfc_sr1_set(spu, tmp);
+
+		__delay(200);
+	}
+}
+
+static void crash_register_spus(struct list_head *list)
+{
+	struct spu *spu;
+	int ret;
+
+	list_for_each_entry(spu, list, full_list) {
+		if (WARN_ON(spu->number >= CRASH_NUM_SPUS))
+			continue;
+
+		crash_spu_info[spu->number].spu = spu;
+	}
+
+	ret = crash_shutdown_register(&crash_kexec_stop_spus);
+	if (ret)
+		printk(KERN_ERR "Could not register SPU crash handler");
+}
+
+#else
+static inline void crash_register_spus(struct list_head *list)
+{
+}
+#endif
+
 static int __init init_spu_base(void)
 {
 	int i, ret = 0;
Index: powerpc.git/arch/powerpc/include/asm/spu.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/spu.h	2011-01-21 13:41:00.592785080 +1100
+++ powerpc.git/arch/powerpc/include/asm/spu.h	2011-01-21 13:42:12.358265951 +1100
@@ -203,14 +203,6 @@ void spu_irq_setaffinity(struct spu *spu
 void spu_setup_kernel_slbs(struct spu *spu, struct spu_lscsa *lscsa,
 		void *code, int code_size);
 
-#ifdef CONFIG_KEXEC
-void crash_register_spus(struct list_head *list);
-#else
-static inline void crash_register_spus(struct list_head *list)
-{
-}
-#endif
-
 extern void spu_invalidate_slbs(struct spu *spu);
 extern void spu_associate_mm(struct spu *spu, struct mm_struct *mm);
 int spu_64k_pages_available(void);
