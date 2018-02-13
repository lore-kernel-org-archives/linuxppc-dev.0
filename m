Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zgmCH4kjhzF1PT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Feb 2018 02:08:59 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id a11so28416pgu.13
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 07:08:59 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 07/14] powerpc/64: move default SPR recording
Date: Wed, 14 Feb 2018 01:08:17 +1000
Message-Id: <20180213150824.27689-8-npiggin@gmail.com>
In-Reply-To: <20180213150824.27689-1-npiggin@gmail.com>
References: <20180213150824.27689-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move this into the early setup code, and don't iterate over CPU masks.
We don't want to call into sysfs so early from setup, and a future patch
won't initialize CPU masks by the time this is called.
---
 arch/powerpc/kernel/paca.c     |  3 +++
 arch/powerpc/kernel/setup.h    |  9 +++------
 arch/powerpc/kernel/setup_64.c |  8 ++++++++
 arch/powerpc/kernel/sysfs.c    | 18 +++++++-----------
 4 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/kernel/paca.c b/arch/powerpc/kernel/paca.c
index 2699f9009286..e560072f122b 100644
--- a/arch/powerpc/kernel/paca.c
+++ b/arch/powerpc/kernel/paca.c
@@ -133,6 +133,9 @@ void __init initialise_paca(struct paca_struct *new_paca, int cpu)
 	new_paca->kexec_state = KEXEC_STATE_NONE;
 	new_paca->__current = &init_task;
 	new_paca->data_offset = 0xfeeeeeeeeeeeeeeeULL;
+#ifdef CONFIG_PPC64
+	new_paca->dscr_default = spr_default_dscr;
+#endif
 #ifdef CONFIG_PPC_BOOK3S_64
 	new_paca->slb_shadow_ptr = NULL;
 #endif
diff --git a/arch/powerpc/kernel/setup.h b/arch/powerpc/kernel/setup.h
index 3fc11e30308f..d144df54ad40 100644
--- a/arch/powerpc/kernel/setup.h
+++ b/arch/powerpc/kernel/setup.h
@@ -45,14 +45,11 @@ void emergency_stack_init(void);
 static inline void emergency_stack_init(void) { };
 #endif
 
-#ifdef CONFIG_PPC64
-void record_spr_defaults(void);
-#else
-static inline void record_spr_defaults(void) { };
-#endif
-
 #ifdef CONFIG_PPC64
 u64 ppc64_bolted_size(void);
+
+/* Default SPR values from firmware/kexec */
+extern unsigned long spr_default_dscr;
 #endif
 
 /*
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 3ce12af4906f..dde34d35d1e7 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -254,6 +254,14 @@ static void cpu_ready_for_interrupts(void)
 	get_paca()->kernel_msr = MSR_KERNEL;
 }
 
+unsigned long spr_default_dscr = 0;
+
+void __init record_spr_defaults(void)
+{
+	if (early_cpu_has_feature(CPU_FTR_DSCR))
+		spr_default_dscr = mfspr(SPRN_DSCR);
+}
+
 /*
  * Early initialization entry point. This is called by head.S
  * with MMU translation disabled. We rely on the "feature" of
diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 1f9d94dac3a6..ab4eb61fe659 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -588,21 +588,17 @@ static DEVICE_ATTR(dscr_default, 0600,
 
 static void sysfs_create_dscr_default(void)
 {
-	int err = 0;
-	if (cpu_has_feature(CPU_FTR_DSCR))
-		err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
-}
-
-void __init record_spr_defaults(void)
-{
-	int cpu;
-
 	if (cpu_has_feature(CPU_FTR_DSCR)) {
-		dscr_default = mfspr(SPRN_DSCR);
-		for (cpu = 0; cpu < nr_cpu_ids; cpu++)
+		int err = 0;
+		int cpu;
+
+		for_each_possible_cpu(cpu)
 			paca_ptrs[cpu]->dscr_default = dscr_default;
+
+		err = device_create_file(cpu_subsys.dev_root, &dev_attr_dscr_default);
 	}
 }
+
 #endif /* CONFIG_PPC64 */
 
 #ifdef HAS_PPC_PMC_PA6T
-- 
2.16.1
