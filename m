Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ytJ0K0SmzzDrYp
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Dec 2017 14:35:44 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id q20so5963366pgv.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Dec 2017 19:35:44 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>
Subject: [resend-without-rfc] powernv/kdump: Fix cases where the kdump kernel
 can get HMI's
Date: Fri,  8 Dec 2017 14:35:33 +1100
Message-Id: <20171208033533.8014-1-bsingharora@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Certain HMI's such as malfunction error propagate through
all threads/core on the system. If a thread was offline
prior to us crashing the system and jumping to the kdump
kernel, bad things happen when it wakes up due to an HMI
in the kdump kernel.

There are several possible ways to solve this problem

1. Put the offline cores in a state such that they are
not woken up for machine check and HMI errors. This
does not work, since we might need to wake up offline
threads occasionally to handle TB errors
2. Ignore HMI errors, setup HMEER to mask HMI errors,
but this still leads the window open for any MCEs
and masking them for the duration of the dump might
be a concern
3. Wake up offline CPUs, as in send them to crash_ipi_callback
(not wake them up as in mark them online as seen by
the scheduler). kexec does a wake_online_cpus() call,
this patch does something similar, but instead sends
an IPI and forces them to crash_ipi_callback

Care is taken to enable this only for powenv platforms
via crash_wake_offline (a global value set at setup
time). The crash code sends out IPI's to all CPU's
which then move to crash_ipi_callback and kexec_smp_wait().
We don't grab the pt_regs for offline CPU's.

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

Nick reviewed the patches and asked if

1. We need to do anything on the otherside of the kernel?
The answer is not clear at this point, but I don't want
to block this patch as it fixes a critical problem with
kdump in SMT=2/1 mode
2. We should do this for other platforms
The answer is same as above, other platforms require testing
and I can selectively enable them as needed as I test them

 arch/powerpc/include/asm/kexec.h     |  2 ++
 arch/powerpc/kernel/crash.c          | 18 +++++++++++++-----
 arch/powerpc/kernel/smp.c            | 11 ++++++++---
 arch/powerpc/platforms/powernv/smp.c | 23 +++++++++++++++++++----
 4 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/kexec.h b/arch/powerpc/include/asm/kexec.h
index 4419d435639a..9dcbfa6bbb91 100644
--- a/arch/powerpc/include/asm/kexec.h
+++ b/arch/powerpc/include/asm/kexec.h
@@ -73,6 +73,8 @@ extern void kexec_smp_wait(void);	/* get and clear naca physid, wait for
 					  master to copy new code to 0 */
 extern int crashing_cpu;
 extern void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *));
+extern void crash_ipi_callback(struct pt_regs *);
+extern int crash_wake_offline;
 
 struct kimage;
 struct pt_regs;
diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index cbabb5adccd9..7e2ddfa9213e 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -44,6 +44,14 @@
 #define REAL_MODE_TIMEOUT	10000
 
 static int time_to_dump;
+/*
+ * crash_wake_offline should be set to 1 by platforms that intend to wake
+ * up offline cpus prior to jumping to a kdump kernel. Currently powernv
+ * sets it to 1, since we want to avoid things from happening when an
+ * offline CPU wakes up due to something like an HMI (malfunction error),
+ * which propagates to all threads.
+ */
+int crash_wake_offline;
 
 #define CRASH_HANDLER_MAX 3
 /* List of shutdown handles */
@@ -63,17 +71,14 @@ static int handle_fault(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 
 static atomic_t cpus_in_crash;
-static void crash_ipi_callback(struct pt_regs *regs)
+void crash_ipi_callback(struct pt_regs *regs)
 {
 	static cpumask_t cpus_state_saved = CPU_MASK_NONE;
 
 	int cpu = smp_processor_id();
 
-	if (!cpu_online(cpu))
-		return;
-
 	hard_irq_disable();
-	if (!cpumask_test_cpu(cpu, &cpus_state_saved)) {
+	if (cpu_online(cpu) && !cpumask_test_cpu(cpu, &cpus_state_saved)) {
 		crash_save_cpu(regs, cpu);
 		cpumask_set_cpu(cpu, &cpus_state_saved);
 	}
@@ -109,6 +114,9 @@ static void crash_kexec_prepare_cpus(int cpu)
 
 	printk(KERN_EMERG "Sending IPI to other CPUs\n");
 
+	if (crash_wake_offline)
+		ncpus = num_present_cpus() - 1;
+
 	crash_send_ipi(crash_ipi_callback);
 	smp_wmb();
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e0a4c1f82e25..f485db54c2f9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -429,10 +429,12 @@ static void do_smp_send_nmi_ipi(int cpu)
 	} else {
 		int c;
 
-		for_each_online_cpu(c) {
+		for_each_present_cpu(c) {
 			if (c == raw_smp_processor_id())
 				continue;
-			do_message_pass(c, PPC_MSG_NMI_IPI);
+			if (cpu_online(c) ||
+				(kdump_in_progress() && crash_wake_offline))
+				do_message_pass(c, PPC_MSG_NMI_IPI);
 		}
 	}
 }
@@ -485,7 +487,10 @@ int smp_send_nmi_ipi(int cpu, void (*fn)(struct pt_regs *), u64 delay_us)
 
 	if (cpu < 0) {
 		/* ALL_OTHERS */
-		cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
+		if (kdump_in_progress() && crash_wake_offline)
+			cpumask_copy(&nmi_ipi_pending_mask, cpu_present_mask);
+		else
+			cpumask_copy(&nmi_ipi_pending_mask, cpu_online_mask);
 		cpumask_clear_cpu(me, &nmi_ipi_pending_mask);
 	} else {
 		/* cpumask starts clear */
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index ba030669eca1..a8d8f6aaeb11 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -37,6 +37,7 @@
 #include <asm/kvm_ppc.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cpuidle.h>
+#include <asm/kexec.h>
 
 #include "powernv.h"
 
@@ -187,6 +188,14 @@ static void pnv_smp_cpu_kill_self(void)
 		WARN_ON(lazy_irq_pending());
 
 		/*
+		 * For kdump kernels, we process the ipi and jump to
+		 * crash_ipi_callback. For more details see the description
+		 * at crash_wake_offline
+		 */
+		if (kdump_in_progress())
+			crash_ipi_callback(NULL);
+
+		/*
 		 * If the SRR1 value indicates that we woke up due to
 		 * an external interrupt, then clear the interrupt.
 		 * We clear the interrupt before checking for the
@@ -324,14 +333,17 @@ static int pnv_cause_nmi_ipi(int cpu)
 		 * exactly what semantics Linux wants or the firmware should
 		 * provide.
 		 */
-		for_each_online_cpu(c) {
+		for_each_present_cpu(c) {
 			if (c == smp_processor_id())
 				continue;
 
-			rc = opal_signal_system_reset(
+			if (cpu_online(c) ||
+				(kdump_in_progress() && crash_wake_offline)) {
+				rc = opal_signal_system_reset(
 						get_hard_smp_processor_id(c));
-			if (rc != OPAL_SUCCESS)
-				success = false;
+				if (rc != OPAL_SUCCESS)
+					success = false;
+			}
 		}
 		if (success)
 			return 1;
@@ -371,5 +383,8 @@ void __init pnv_smp_init(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	ppc_md.cpu_die	= pnv_smp_cpu_kill_self;
+#ifdef CONFIG_KEXEC_CORE
+	crash_wake_offline = 1;
+#endif
 #endif
 }
-- 
2.13.6
