Return-Path: <diana.craciun@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414Ccg4r5YzF3bX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jun 2018 22:53:39 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v2 2/3] powerpc/fsl: Add barrier_nospec implementation for NXP
 PowerPC Book3E
Date: Mon, 11 Jun 2018 15:53:27 +0300
Message-Id: <1528721608-15443-3-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
References: <1528721608-15443-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement the barrier_nospec as a isync;sync instruction sequence.
The implementation uses the infrastructure built for BOOK3S 64.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
 arch/powerpc/include/asm/barrier.h | 10 ++++++++++
 arch/powerpc/include/asm/setup.h   |  2 +-
 arch/powerpc/kernel/Makefile       |  2 +-
 arch/powerpc/kernel/module.c       |  5 +++--
 arch/powerpc/kernel/security.c     | 15 +++++++++++++++
 arch/powerpc/kernel/setup_32.c     |  5 +++++
 arch/powerpc/kernel/setup_64.c     |  6 ++++++
 arch/powerpc/kernel/vmlinux.lds.S  |  4 +++-
 arch/powerpc/lib/feature-fixups.c  | 35 ++++++++++++++++++++++++++++++++++-
 9 files changed, 78 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index f67b3f6..405d572 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -86,6 +86,16 @@ do {									\
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+/*
+ * Prevent the execution of subsequent instructions speculatively using a
+ * isync;sync instruction sequence.
+ */
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop; nop
+
+// This also acts as a compiler barrier due to the memory clobber.
+#define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
+
 #else /* !CONFIG_PPC_BOOK3S_64 */
 #define barrier_nospec_asm
 #define barrier_nospec()
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8721fd0..67a2810 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -56,7 +56,7 @@ void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_FSL_BOOK3E)
 void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 #else
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b2..d9dee43 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -76,7 +76,7 @@ endif
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(BITS).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
-obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
+obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o security.o
 obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 1b3c683..96a9821 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,13 +72,14 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
-
+#endif /* CONFIG_PPC64 */
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_FSL_BOOK3E)
 	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
 	if (sect != NULL)
 		do_barrier_nospec_fixups_range(barrier_nospec_enabled,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
-#endif
+#endif /* CONFIG_PPC64 || CONFIG_PPC_FSL_BOOK3E */
 
 	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
 	if (sect != NULL)
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index c55e102..797c975 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -13,7 +13,9 @@
 #include <asm/setup.h>
 
 
+#ifdef CONFIG_PPC_BOOK3S_64
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 bool barrier_nospec_enabled;
 static bool no_nospec;
@@ -24,6 +26,7 @@ static void enable_barrier_nospec(bool enable)
 	do_barrier_nospec_fixups(enable);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 void setup_barrier_nospec(void)
 {
 	bool enable;
@@ -46,6 +49,15 @@ void setup_barrier_nospec(void)
 	if (!no_nospec)
 		enable_barrier_nospec(enable);
 }
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void setup_barrier_nospec(void)
+{
+	if (!no_nospec)
+		enable_barrier_nospec(true);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
 
 static int __init handle_nospectre_v1(char *p)
 {
@@ -92,6 +104,7 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -168,3 +181,5 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 	return s.len;
 }
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 7445748..80c1e6e 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -116,6 +116,11 @@ notrace void __init machine_init(u64 dt_ptr)
 	/* Do some early initialization based on the flat device tree */
 	early_init_devtree(__va(dt_ptr));
 
+	/* Apply the speculation barrier fixup */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	setup_barrier_nospec();
+#endif
+
 	early_init_mmu();
 
 	setup_kdump_trampoline();
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 7a7ce8a..b2a644a 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -327,6 +327,12 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Apply all the dynamic patching */
 	apply_feature_fixups();
+
+	/* Apply the speculation barrier fixup */
+#ifdef CONFIG_PPC_FSL_BOOK3E
+	setup_barrier_nospec();
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
 	setup_feature_keys();
 
 	/* Initialize the hash table or TLB handling */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index ff73f49..af513e6 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -139,14 +139,16 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+#endif /* CONFIG_PPC64 */
 
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_FSL_BOOK3E)
 	. = ALIGN(8);
 	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
 		__start___barrier_nospec_fixup = .;
 		*(__barrier_nospec_fixup)
 		__stop___barrier_nospec_fixup = .;
 	}
-#endif
+#endif /* CONFIG_PPC64 || CONFIG_PPC_FSL_BOOK3E */
 
 	EXCEPTION_TABLE(0)
 
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 2b9173d..bea2b87 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -188,7 +188,40 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_FSL_BOOK3E
+void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
+{
+	unsigned int instr[2], *dest;
+	long *start, *end;
+	int i;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	instr[0] = PPC_INST_NOP;
+	instr[1] = PPC_INST_NOP;
+
+	if (enable) {
+		pr_info("barrier_nospec; using isync; sync as a speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
 
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+	}
+
+	pr_debug("barrier-nospec: patched %d locations\n", i);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
+
+#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_FSL_BOOK3E)
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -199,7 +232,7 @@ void do_barrier_nospec_fixups(bool enable)
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
 
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_BOOK3S_64 || CONFIG_PPC_FSL_BOOK3E */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
-- 
2.5.5
