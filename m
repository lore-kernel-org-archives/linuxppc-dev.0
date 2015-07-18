Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1D5811A1998
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Jul 2015 06:09:37 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
CC: Tiejun Chen <tiejun.chen@intel.com>, <kexec@lists.infradead.org>, "Scott
 Wood" <scottwood@freescale.com>
Subject: [RFC PATCH 14/17] powerpc/book3e-64/kexec: Enable SMP release
Date: Sat, 18 Jul 2015 15:08:51 -0500
Message-ID: <1437250134-307-15-git-send-email-scottwood@freescale.com>
In-Reply-To: <1437250134-307-1-git-send-email-scottwood@freescale.com>
References: <1437250134-307-1-git-send-email-scottwood@freescale.com>
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

booted_from_exec is similar to __run_at_load, except that it is set for
regular kexec as well as kdump.

The flag is needed because the SMP release mechanism for FSL book3e is
different from when booting with normal hardware.  In theory we could
simulate the normal spin table mechanism, but not at the addresses
U-Boot put in the device tree -- so there'd need to be even more
communication between the kernel and kexec to set that up.  Since
there's already a similar flag being set (for kdump only), this seemed
like a reasonable approach.

Unlike __run_at_kexec in http://patchwork.ozlabs.org/patch/257657/
("book3e/kexec/kdump: introduce a kexec kernel flag"), this flag is at
a fixed address for ABI stability, and actually gets set properly in
the kdump case (i.e. on the crash kernel, not on the crashing kernel).

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
This depends on the kexec-tools patch "ppc64: Add a flag to tell the
kernel it's booting from kexec":
http://lists.infradead.org/pipermail/kexec/2015-July/014048.html
---
 arch/powerpc/include/asm/smp.h    |  1 +
 arch/powerpc/kernel/head_64.S     | 15 +++++++++++++++
 arch/powerpc/kernel/setup_64.c    | 14 +++++++++++++-
 arch/powerpc/platforms/85xx/smp.c | 16 ++++++++++++----
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index 825663c..f9245df 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -197,6 +197,7 @@ extern void generic_secondary_thread_init(void);
 extern unsigned long __secondary_hold_spinloop;
 extern unsigned long __secondary_hold_acknowledge;
 extern char __secondary_hold;
+extern u32 booted_from_kexec;
 
 extern void __early_start(void);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index 1b77956..ae2d6b5 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -91,6 +91,21 @@ __secondary_hold_spinloop:
 __secondary_hold_acknowledge:
 	.llong	0x0
 
+	/* Do not move this variable as kexec-tools knows about it. */
+	. = 0x58
+	.globl	booted_from_kexec
+booted_from_kexec:
+	/*
+	 * "nkxc" -- not (necessarily) from kexec by default
+	 *
+	 * This flag is set to 1 by a loader if the kernel is being
+	 * booted by kexec.  Older kexec-tools don't know about this
+	 * flag, so platforms other than fsl-book3e should treat a value
+	 * of "nkxc" as inconclusive.  fsl-book3e relies on this to
+	 * know how to release secondary cpus.
+	 */
+	.long	0x6e6b7863
+
 #ifdef CONFIG_RELOCATABLE
 	/* This flag is set to 1 by a loader if the kernel should run
 	 * at the loaded address instead of the linked address.  This
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 505ec2c..baeddcc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -340,11 +340,23 @@ void early_setup_secondary(void)
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_SMP) || defined(CONFIG_KEXEC)
+static bool use_spinloop(void)
+{
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	return booted_from_kexec == 1;
+#else
+	return true;
+#endif
+}
+
 void smp_release_cpus(void)
 {
 	unsigned long *ptr;
 	int i;
 
+	if (!use_spinloop())
+		return;
+
 	DBG(" -> smp_release_cpus()\n");
 
 	/* All secondary cpus are spinning on a common spinloop, release them
@@ -524,7 +536,7 @@ void __init setup_system(void)
 	 * Freescale Book3e parts spin in a loop provided by firmware,
 	 * so smp_release_cpus() does nothing for them
 	 */
-#if defined(CONFIG_SMP) && !defined(CONFIG_PPC_FSL_BOOK3E)
+#if defined(CONFIG_SMP)
 	/* Release secondary cpus out of their spinloops at 0x60 now that
 	 * we can map physical -> logical CPU ids
 	 */
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index 5152289..4abda43 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -20,6 +20,7 @@
 #include <linux/highmem.h>
 #include <linux/cpu.h>
 
+#include <asm/kexec.h>
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
@@ -203,6 +204,7 @@ static int smp_85xx_kick_cpu(int nr)
 	int hw_cpu = get_hard_smp_processor_id(nr);
 	int ioremappable;
 	int ret = 0;
+	bool have_spin_table = true;
 
 	WARN_ON(nr < 0 || nr >= NR_CPUS);
 	WARN_ON(hw_cpu < 0 || hw_cpu >= NR_CPUS);
@@ -210,6 +212,9 @@ static int smp_85xx_kick_cpu(int nr)
 	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
 
 #ifdef CONFIG_PPC64
+	if (booted_from_kexec == 1 && system_state != SYSTEM_RUNNING)
+		have_spin_table = false;
+
 	/* Threads don't use the spin table */
 	if (cpu_thread_in_core(nr) != 0) {
 		int primary = cpu_first_thread_sibling(nr);
@@ -305,10 +310,13 @@ static int smp_85xx_kick_cpu(int nr)
 		__secondary_hold_acknowledge = -1;
 	}
 #endif
-	flush_spin_table(spin_table);
-	out_be32(&spin_table->pir, hw_cpu);
-	out_be32(&spin_table->addr_l, __pa(__early_start));
-	flush_spin_table(spin_table);
+
+	if (have_spin_table) {
+		flush_spin_table(spin_table);
+		out_be32(&spin_table->pir, hw_cpu);
+		out_be32(&spin_table->addr_l, __pa(__early_start));
+		flush_spin_table(spin_table);
+	}
 
 	/* Wait a bit for the CPU to ack. */
 	if (!spin_event_timeout(__secondary_hold_acknowledge == hw_cpu,
-- 
2.1.4
