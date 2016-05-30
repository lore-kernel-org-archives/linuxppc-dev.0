Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ5zR2vrVzDqJd
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 16:18:43 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id gp3so13598731pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 May 2016 23:18:43 -0700 (PDT)
From: Rashmica Gupta <rashmicy@gmail.com>
To: mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
 nfont@linux.vnet.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/5] powerpc/pseries: Remove MPIC from pseries smp
Date: Mon, 30 May 2016 16:18:12 +1000
Message-Id: <1464589095-442-2-git-send-email-rashmicy@gmail.com>
In-Reply-To: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
References: <1464589095-442-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPIC was only used by Power3 which is now unsupported, so remove MPIC
code. XICS is now the only supported interrupt controller for
pSeries so do some cleanups too.

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/platforms/pseries/pseries.h |  6 ++----
 arch/powerpc/platforms/pseries/setup.c   |  2 +-
 arch/powerpc/platforms/pseries/smp.c     | 31 +++++--------------------------
 3 files changed, 8 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/pseries.h b/arch/powerpc/platforms/pseries/pseries.h
index 7aa83f00ac62..edeaec74b656 100644
--- a/arch/powerpc/platforms/pseries/pseries.h
+++ b/arch/powerpc/platforms/pseries/pseries.h
@@ -31,11 +31,9 @@ extern int pSeries_system_reset_exception(struct pt_regs *regs);
 extern int pSeries_machine_check_exception(struct pt_regs *regs);
 
 #ifdef CONFIG_SMP
-extern void smp_init_pseries_mpic(void);
-extern void smp_init_pseries_xics(void);
+extern void smp_init_pseries(void);
 #else
-static inline void smp_init_pseries_mpic(void) { };
-static inline void smp_init_pseries_xics(void) { };
+static inline void smp_init_pseries(void) { };
 #endif
 
 #ifdef CONFIG_KEXEC
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index f83ac9be7f34..32a224d3eaa1 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -437,7 +437,7 @@ static void __init pSeries_setup_arch(void)
 
 	/* Discover PIC type and setup ppc_md accordingly */
 	setup_kexec_cpu_down_xics();
-	smp_init_pseries_xics();
+	smp_init_pseries();
 
 
 	/* openpic global configuration register (64-bit format). */
diff --git a/arch/powerpc/platforms/pseries/smp.c b/arch/powerpc/platforms/pseries/smp.c
index 6932ea803e33..93a8a67006c7 100644
--- a/arch/powerpc/platforms/pseries/smp.c
+++ b/arch/powerpc/platforms/pseries/smp.c
@@ -38,7 +38,6 @@
 #include <asm/cputable.h>
 #include <asm/firmware.h>
 #include <asm/rtas.h>
-#include <asm/mpic.h>
 #include <asm/vdso_datapage.h>
 #include <asm/cputhreads.h>
 #include <asm/xics.h>
@@ -140,7 +139,7 @@ out:
 	return 1;
 }
 
-static void smp_xics_setup_cpu(int cpu)
+static void smp_setup_cpu(int cpu)
 {
 	if (cpu != boot_cpuid)
 		xics_setup_cpu();
@@ -207,28 +206,22 @@ static __init void pSeries_smp_probe(void)
 	}
 }
 
-static struct smp_ops_t pSeries_mpic_smp_ops = {
-	.message_pass	= smp_mpic_message_pass,
-	.probe		= smp_mpic_probe,
-	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_mpic_setup_cpu,
-};
-
-static struct smp_ops_t pSeries_xics_smp_ops = {
+static struct smp_ops_t pSeries_smp_ops = {
 	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
 	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
 	.probe		= pSeries_smp_probe,
 	.kick_cpu	= smp_pSeries_kick_cpu,
-	.setup_cpu	= smp_xics_setup_cpu,
+	.setup_cpu	= smp_setup_cpu,
 	.cpu_bootable	= smp_generic_cpu_bootable,
 };
 
 /* This is called very early */
-static void __init smp_init_pseries(void)
+void __init smp_init_pseries(void)
 {
 	int i;
 
 	pr_debug(" -> smp_init_pSeries()\n");
+	smp_ops = &pSeries_smp_ops;
 
 	alloc_bootmem_cpumask_var(&of_spin_mask);
 
@@ -258,17 +251,3 @@ static void __init smp_init_pseries(void)
 
 	pr_debug(" <- smp_init_pSeries()\n");
 }
-
-void __init smp_init_pseries_mpic(void)
-{
-	smp_ops = &pSeries_mpic_smp_ops;
-
-	smp_init_pseries();
-}
-
-void __init smp_init_pseries_xics(void)
-{
-	smp_ops = &pSeries_xics_smp_ops;
-
-	smp_init_pseries();
-}
-- 
2.5.0
