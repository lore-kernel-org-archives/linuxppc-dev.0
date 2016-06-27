Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRYf6JqJzDqmL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:29:58 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 05/38] powerpc: Factor do_feature_fixup calls
Date: Mon, 27 Jun 2016 21:29:03 +1000
Message-Id: <1467026976-7974-6-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

32 and 64-bit do a similar set of calls early on, we move it all to
a single common function to make the boot code more readable.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/feature-fixups.h |  4 ++++
 arch/powerpc/include/asm/synch.h          |  1 -
 arch/powerpc/kernel/setup_32.c            | 17 ++---------------
 arch/powerpc/kernel/setup_64.c            | 13 +------------
 arch/powerpc/lib/feature-fixups.c         | 31 +++++++++++++++++++++++++++++--
 5 files changed, 36 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 9a67a38..57fec8a 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -184,4 +184,8 @@ label##3:					       	\
 	FTR_ENTRY_OFFSET label##1b-label##3b;		\
 	.popsection;
 
+#ifndef __ASSEMBLY__
+void apply_feature_fixups(void);
+#endif
+
 #endif /* __ASM_POWERPC_FEATURE_FIXUPS_H */
diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
index c508686..78efe8d 100644
--- a/arch/powerpc/include/asm/synch.h
+++ b/arch/powerpc/include/asm/synch.h
@@ -13,7 +13,6 @@
 extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
 extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
 			     void *fixup_end);
-extern void do_final_fixups(void);
 
 static inline void eieio(void)
 {
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index d544fa3..3d06fab 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -73,7 +73,6 @@ int ucache_bsize;
 notrace unsigned long __init early_init(unsigned long dt_ptr)
 {
 	unsigned long offset = reloc_offset();
-	struct cpu_spec *spec;
 
 	/* First zero the BSS -- use memset_io, some platforms don't have
 	 * caches on yet */
@@ -84,21 +83,9 @@ notrace unsigned long __init early_init(unsigned long dt_ptr)
 	 * Identify the CPU type and fix up code sections
 	 * that depend on which cpu we have.
 	 */
-	spec = identify_cpu(offset, mfspr(SPRN_PVR));
+	identify_cpu(offset, mfspr(SPRN_PVR));
 
-	do_feature_fixups(spec->cpu_features,
-			  PTRRELOC(&__start___ftr_fixup),
-			  PTRRELOC(&__stop___ftr_fixup));
-
-	do_feature_fixups(spec->mmu_features,
-			  PTRRELOC(&__start___mmu_ftr_fixup),
-			  PTRRELOC(&__stop___mmu_ftr_fixup));
-
-	do_lwsync_fixups(spec->cpu_features,
-			 PTRRELOC(&__start___lwsync_fixup),
-			 PTRRELOC(&__stop___lwsync_fixup));
-
-	do_final_fixups();
+	apply_feature_fixups();
 
 	return KERNELBASE + offset;
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 96d4a2b..996bed2 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -468,18 +468,7 @@ void __init setup_system(void)
 {
 	DBG(" -> setup_system()\n");
 
-	/* Apply the CPUs-specific and firmware specific fixups to kernel
-	 * text (nop out sections not relevant to this CPU or this firmware)
-	 */
-	do_feature_fixups(cur_cpu_spec->cpu_features,
-			  &__start___ftr_fixup, &__stop___ftr_fixup);
-	do_feature_fixups(cur_cpu_spec->mmu_features,
-			  &__start___mmu_ftr_fixup, &__stop___mmu_ftr_fixup);
-	do_feature_fixups(powerpc_firmware_features,
-			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
-	do_lwsync_fixups(cur_cpu_spec->cpu_features,
-			 &__start___lwsync_fixup, &__stop___lwsync_fixup);
-	do_final_fixups();
+	apply_feature_fixups();
 
 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 7ce3870..d0c72aa 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -20,7 +20,8 @@
 #include <asm/code-patching.h>
 #include <asm/page.h>
 #include <asm/sections.h>
-
+#include <asm/setup.h>
+#include <asm/firmware.h>
 
 struct fixup_entry {
 	unsigned long	mask;
@@ -130,7 +131,7 @@ void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 	}
 }
 
-void do_final_fixups(void)
+static void do_final_fixups(void)
 {
 #if defined(CONFIG_PPC64) && defined(CONFIG_RELOCATABLE)
 	int *src, *dest;
@@ -151,6 +152,32 @@ void do_final_fixups(void)
 #endif
 }
 
+void apply_feature_fixups(void)
+{
+	struct cpu_spec *spec = *PTRRELOC(&cur_cpu_spec);
+
+	/* Apply the CPUs-specific and firmware specific fixups to kernel
+	 * text (nop out sections not relevant to this CPU or this firmware)
+	 */
+	do_feature_fixups(spec->cpu_features,
+			  PTRRELOC(&__start___ftr_fixup),
+			  PTRRELOC(&__stop___ftr_fixup));
+
+	do_feature_fixups(spec->mmu_features,
+			  PTRRELOC(&__start___mmu_ftr_fixup),
+			  PTRRELOC(&__stop___mmu_ftr_fixup));
+
+	do_lwsync_fixups(spec->cpu_features,
+			 PTRRELOC(&__start___lwsync_fixup),
+			 PTRRELOC(&__stop___lwsync_fixup));
+
+#ifdef CONFIG_PPC64
+	do_feature_fixups(powerpc_firmware_features,
+			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
+#endif
+	do_final_fixups();
+}
+
 #ifdef CONFIG_FTR_FIXUP_SELFTEST
 
 #define check(x)	\
-- 
2.7.4
