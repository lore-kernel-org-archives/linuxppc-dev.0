Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yxTpy6xd8zDrcx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 19:08:42 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b18so939334pgv.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Dec 2017 00:08:42 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, Balbir Singh <bsingharora@gmail.com>
Subject: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel can get
 HMI's
Date: Wed, 13 Dec 2017 19:08:28 +1100
Message-Id: <20171213080828.2800-2-bsingharora@gmail.com>
In-Reply-To: <20171213080828.2800-1-bsingharora@gmail.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
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
threads to handle TB errors
2. Ignore HMI errors, setup HMEER to mask HMI errors,
but this still leads the window open for any MCEs
and masking them for the duration of the dump might
be a concern
3. Wake up offline CPUs, as in send them to
crash_ipi_callback (not wake them up as in mark them
online as seen by the hotplug). kexec does a
wake_online_cpus() call, this patch does something
similar, but instead sends an IPI and forces them to
crash_ipi_callback()

This patch takes approach #3.

Care is taken to enable this only for powenv platforms
via crash_wake_offline (a global value set at setup
time). The crash code sends out IPI's to all CPU's
which then move to crash_ipi_callback and kexec_smp_wait().

Signed-off-by: Balbir Singh <bsingharora@gmail.com>
---

Changelog
 - Michael Ellerman recommended refactoring
   the code so as to not modify major portions of the
   NMI handling/IPI code.

 arch/powerpc/include/asm/kexec.h     |  2 ++
 arch/powerpc/kernel/crash.c          | 13 ++++++++++++-
 arch/powerpc/kernel/smp.c            | 18 ++++++++++++++++++
 arch/powerpc/platforms/powernv/smp.c | 17 +++++++++++++++++
 4 files changed, 49 insertions(+), 1 deletion(-)

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
index 29c56ca2ddfd..00b215125d3e 100644
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
@@ -63,7 +71,7 @@ static int handle_fault(struct pt_regs *regs)
 #ifdef CONFIG_SMP
 
 static atomic_t cpus_in_crash;
-static void crash_ipi_callback(struct pt_regs *regs)
+void crash_ipi_callback(struct pt_regs *regs)
 {
 	static cpumask_t cpus_state_saved = CPU_MASK_NONE;
 
@@ -106,6 +114,9 @@ static void crash_kexec_prepare_cpus(int cpu)
 
 	printk(KERN_EMERG "Sending IPI to other CPUs\n");
 
+	if (crash_wake_offline)
+		ncpus = num_present_cpus() - 1;
+
 	crash_send_ipi(crash_ipi_callback);
 	smp_wmb();
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index e0a4c1f82e25..bbe7634b3a43 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -543,7 +543,25 @@ void smp_send_debugger_break(void)
 #ifdef CONFIG_KEXEC_CORE
 void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
 {
+	int cpu;
+
 	smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
+	if (kdump_in_progress() && crash_wake_offline) {
+		for_each_present_cpu(cpu) {
+			if (cpu_online(cpu))
+				continue;
+			/*
+			 * crash_ipi_callback will wait for
+			 * all cpus, including offline CPUs.
+			 * We don't care about nmi_ipi_function.
+			 * Offline cpus will jump straight into
+			 * crash_ipi_callback, we can skip the
+			 * entire NMI dance and waiting for
+			 * cpus to clear pending mask, etc.
+			 */
+			do_smp_send_nmi_ipi(cpu);
+		}
+	}
 }
 #endif
 
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index ba030669eca1..49a23f9db5f0 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -37,6 +37,8 @@
 #include <asm/kvm_ppc.h>
 #include <asm/ppc-opcode.h>
 #include <asm/cpuidle.h>
+#include <asm/kexec.h>
+#include <asm/reg.h>
 
 #include "powernv.h"
 
@@ -212,6 +214,18 @@ static void pnv_smp_cpu_kill_self(void)
 		}
 		smp_mb();
 
+		/*
+		 * For kdump kernels, we process the ipi and jump to
+		 * crash_ipi_callback. For more details see the description
+		 * at crash_wake_offline
+		 */
+		if (kdump_in_progress()) {
+			struct pt_regs regs;
+
+			ppc_save_regs(&regs);
+			crash_ipi_callback(&regs);
+		}
+
 		if (cpu_core_split_required())
 			continue;
 
@@ -371,5 +385,8 @@ void __init pnv_smp_init(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 	ppc_md.cpu_die	= pnv_smp_cpu_kill_self;
+#ifdef CONFIG_KEXEC_CORE
+	crash_wake_offline = 1;
+#endif
 #endif
 }
-- 
2.13.6
