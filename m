Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yLrzY0g81zDqYv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 22:44:56 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i5so19483124pfe.6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Oct 2017 04:44:56 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64: set DSCR default initially from SPR
Date: Tue, 24 Oct 2017 21:44:44 +1000
Message-Id: <20171024114444.13933-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Take the DSCR value set by firmware as the dscr_default value,
rather than zero.

POWER9 recommends DSCR default to a non-zero value.

From: Nicholas Piggin <npiggin@gmail.com>
---
This has a problem that OS which set the DSCR to non-default
then kexec to Linux will be used as our default. I send a
corresponding patch to skiboot which resets SPRs in opal_reinit_cpus
which will make this do the right thing in that case.

 arch/powerpc/kernel/setup.h    |  6 ++++++
 arch/powerpc/kernel/setup_64.c |  9 +++++++++
 arch/powerpc/kernel/sysfs.c    | 11 +++++++++++
 3 files changed, 26 insertions(+)

diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index cfba134b3024..21c18071d9d5 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -45,6 +45,12 @@ void emergency_stack_init(void);
 static inline void emergency_stack_init(void) { };
 #endif
 
+#ifdef CONFIG_PPC64
+void record_spr_defaults(void);
+#else
+static inline void record_spr_defaults(void) { };
+#endif
+
 /*
  * Having this in kvm_ppc.h makes include dependencies too
  * tricky to solve for setup-common.c so have it here.
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index b89c6aac48c9..911c4d606453 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -69,6 +69,8 @@
 #include <asm/opal.h>
 #include <asm/cputhreads.h>
 
+#include "setup.h"
+
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
 #else
@@ -317,6 +319,13 @@ void __init early_setup(unsigned long dt_ptr)
 	early_init_mmu();
 
 	/*
+	 * After firmware and early platform setup code has set things up,
+	 * we note the SPR values for configurable control/performance
+	 * registers, and use those as initial defaults.
+	 */
+	record_spr_defaults();
+
+	/*
 	 * At this point, we can let interrupts switch to virtual mode
 	 * (the MMU has been setup), so adjust the MSR in the PACA to
 	 * have IR and DR set and enable AIL if it exists
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 4437c70c7c2b..d60f6f5c7b0c 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -590,6 +590,17 @@ static void sysfs_create_dscr_default(void)
 	if (cpu_has_feature(CPU_FTR_DSCR))
 		err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
 }
+
+void record_spr_defaults(void)
+{
+	int cpu;
+
+	if (cpu_has_feature(CPU_FTR_DSCR)) {
+		dscr_default = mfspr(SPRN_DSCR);
+		for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+			paca[cpu].dscr_default = dscr_default;
+	}
+}
 #endif /* CONFIG_PPC64 */
 
 #ifdef HAS_PPC_PMC_PA6T
-- 
2.13.3
