Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0145.outbound.protection.outlook.com [157.56.111.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CAC51A023F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 20:28:16 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: <scottwood@freescale.com>
Subject: [PATCH v3 6/6] powerpc/mpc85xx: Add CPU hotplug support for E6500
Date: Fri, 20 Nov 2015 17:14:02 +0800
Message-ID: <1448010842-22345-6-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
References: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Support Freescale E6500 core-based platforms, like t4240.
Support disabling/enabling individual CPU thread dynamically.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---

changes for v3
* rebase patches on the latest code
* add const for info in wake_hw_thread()
* use r8 instead of r13 in the assemble code
* added some comments in code
* checked SPRN_BUCSR to see whether the current thread has been initialized
* changed the flow in smp_85xx_kick_cpu()
* changed that the code to start thread in generic_secondary_smp_init does not depend
  on which thread it is running

major changes for v2:
* start Thread1 by Thread0 when we want to boot Thread1 only replacing
  the method of changing cpu physical id
 arch/powerpc/include/asm/cputhreads.h |  6 +++
 arch/powerpc/include/asm/smp.h        |  1 +
 arch/powerpc/kernel/head_64.S         | 78 +++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/85xx/smp.c     | 70 +++++++++++++++++--------------
 4 files changed, 124 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/cputhreads.h b/arch/powerpc/include/asm/cputhreads.h
index e5a769d..9ec41e5 100644
--- a/arch/powerpc/include/asm/cputhreads.h
+++ b/arch/powerpc/include/asm/cputhreads.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_POWERPC_CPUTHREADS_H
 #define _ASM_POWERPC_CPUTHREADS_H
 
+#ifndef __ASSEMBLY__
 #include <linux/cpumask.h>
 
 /*
@@ -102,7 +103,12 @@ static inline u32 get_tensr(void)
 		return 1;
 }
 
+void book3e_start_thread(int thread, unsigned long addr);
 void book3e_stop_thread(int thread);
 
+#endif /* __ASSEMBLY__ */
+
+#define INVALID_THREAD_HWID	0x0fff
+
 #endif /* _ASM_POWERPC_CPUTHREADS_H */
 
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index bdb8111..174271e 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -200,6 +200,7 @@ extern void generic_secondary_thread_init(void);
 extern unsigned long __secondary_hold_spinloop;
 extern unsigned long __secondary_hold_acknowledge;
 extern char __secondary_hold;
+extern unsigned int booting_thread_hwid;
 
 extern void __early_start(void);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 6036253..2916283 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -40,6 +40,7 @@
 #include <asm/kvm_book3s_asm.h>
 #include <asm/ptrace.h>
 #include <asm/hw_irq.h>
+#include <asm/cputhreads.h>
 
 /* The physical memory is laid out such that the secondary processor
  * spin code sits at 0x0000...0x00ff. On server, the vectors follow
@@ -182,6 +183,45 @@ exception_marker:
 
 #ifdef CONFIG_PPC_BOOK3E
 /*
+ * The booting_thread_hwid holds the thread id we want to boot in cpu
+ * hotplug case. It is set by cpu hotplug code, and is invalid by default.
+ * The thread id is the same as the initial value of SPRN_PIR[THREAD_ID]
+ * bit field.
+ */
+	.globl	booting_thread_hwid
+booting_thread_hwid:
+	.long  INVALID_THREAD_HWID
+	.align 3
+/*
+ * start a thread in the same core
+ * input parameters:
+ * r3 = the thread physical id
+ * r4 = the entry point where thread starts
+ */
+_GLOBAL(book3e_start_thread)
+	LOAD_REG_IMMEDIATE(r5, MSR_KERNEL)
+	cmpi	0, r3, 0
+	beq	10f
+	cmpi	0, r3, 1
+	beq	11f
+	/* If the thread id is invalid, just exit. */
+	b	13f
+10:
+	mttmr	TMRN_IMSR0, r5
+	mttmr	TMRN_INIA0, r4
+	b	12f
+11:
+	mttmr	TMRN_IMSR1, r5
+	mttmr	TMRN_INIA1, r4
+12:
+	isync
+	li	r6, 1
+	sld	r6, r6, r3
+	mtspr	SPRN_TENS, r6
+13:
+	blr
+
+/*
  * stop a thread in the same core
  * input parameter:
  * r3 = the thread physical id
@@ -280,6 +320,44 @@ _GLOBAL(generic_secondary_smp_init)
 	mr	r3,r24
 	mr	r4,r25
 	bl	book3e_secondary_core_init
+
+/*
+ * After common core init has finished, check if the current thread is the
+ * one we wanted to boot. If not, start the specified thread and stop the
+ * current thread.
+ */
+	LOAD_REG_ADDR(r4, booting_thread_hwid)
+	lwz     r3, 0(r4)
+	li	r5, INVALID_THREAD_HWID
+	cmpw	r3, r5
+	beq	20f
+
+	/*
+	 * The value of booting_thread_hwid has been stored in r3,
+	 * so make it invalid.
+	 */
+	stw	r5, 0(r4)
+
+	/*
+	 * Get the current thread id and check if it is the one we wanted.
+	 * If not, start the one specified in booting_thread_hwid and stop
+	 * the current thread.
+	 */
+	mfspr	r8, SPRN_TIR
+	cmpw	r3, r8
+	beq	20f
+
+	/* start the specified thread */
+	LOAD_REG_ADDR(r5, fsl_secondary_thread_init)
+	ld	r4, 0(r5)
+	bl	book3e_start_thread
+
+	/* stop the current thread */
+	mr	r3, r8
+	bl	book3e_stop_thread
+10:
+	b	10b
+20:
 #endif
 
 generic_secondary_common_init:
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 0f56dd5..cc22737 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -182,24 +182,11 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
 static void wake_hw_thread(void *info)
 {
 	void fsl_secondary_thread_init(void);
-	unsigned long imsr, inia;
-	int nr = *(const int *)info;
+	unsigned long inia;
+	int cpu = *(const int *)info;
 
-	imsr = MSR_KERNEL;
 	inia = *(unsigned long *)fsl_secondary_thread_init;
-
-	if (cpu_thread_in_core(nr) == 0) {
-		/* For when we boot on a secondary thread with kdump */
-		mttmr(TMRN_IMSR0, imsr);
-		mttmr(TMRN_INIA0, inia);
-		mtspr(SPRN_TENS, TEN_THREAD(0));
-	} else {
-		mttmr(TMRN_IMSR1, imsr);
-		mttmr(TMRN_INIA1, inia);
-		mtspr(SPRN_TENS, TEN_THREAD(1));
-	}
-
-	smp_generic_kick_cpu(nr);
+	book3e_start_thread(cpu_thread_in_core(cpu), inia);
 }
 #endif
 
@@ -294,33 +281,54 @@ static int smp_85xx_kick_cpu(int nr)
 	pr_debug("kick CPU #%d\n", nr);
 
 #ifdef CONFIG_PPC64
-	/* Threads don't use the spin table */
-	if (cpu_thread_in_core(nr) != 0) {
-		int primary = cpu_first_thread_sibling(nr);
-
+	if (threads_per_core == 2) {
 		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
 			return -ENOENT;
 
-		if (cpu_thread_in_core(nr) != 1) {
-			pr_err("%s: cpu %d: invalid hw thread %d\n",
-			       __func__, nr, cpu_thread_in_core(nr));
-			return -ENOENT;
-		}
+		booting_thread_hwid = cpu_thread_in_core(nr);
+		primary = cpu_first_thread_sibling(nr);
 
-		if (!cpu_online(primary)) {
-			pr_err("%s: cpu %d: primary %d not online\n",
-			       __func__, nr, primary);
-			return -ENOENT;
+		if (qoriq_pm_ops)
+			qoriq_pm_ops->cpu_up_prepare(nr);
+
+		/*
+		 * If either thread in the core is online, use it to start
+		 * the other.
+		 */
+		if (cpu_online(primary)) {
+			smp_call_function_single(primary,
+					wake_hw_thread, &nr, 1);
+			goto done;
+		} else if (cpu_online(primary + 1)) {
+			smp_call_function_single(primary + 1,
+					wake_hw_thread, &nr, 1);
+			goto done;
 		}
 
-		smp_call_function_single(primary, wake_hw_thread, &nr, 0);
-		return 0;
+		/*
+		 * If getting here, it means both threads in the core are
+		 * offline. So start the primary thread, then it will start
+		 * the thread specified in booting_thread_hwid, the one
+		 * corresponding to nr.
+		 */
+
+	} else if (threads_per_core == 1) {
+		/*
+		 * If one core has only one thread, set booting_thread_hwid to
+		 * an invalid value.
+		 */
+		booting_thread_hwid = INVALID_THREAD_HWID;
+
+	} else if (threads_per_core > 2) {
+		pr_err("Do not support more than 2 threads per CPU.");
+		return -EINVAL;
 	}
 
 	ret = smp_85xx_start_cpu(primary);
 	if (ret)
 		return ret;
 
+done:
 	paca[nr].cpu_start = 1;
 	generic_set_cpu_up(nr);
 
-- 
1.9.1
