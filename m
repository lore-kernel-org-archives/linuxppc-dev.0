Return-Path: <diana.craciun@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40rRTc1Z4tzF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 May 2018 19:06:43 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Diana Craciun <diana.craciun@nxp.com>
Subject: [RESEND RFC PATCH] powerpc/fsl: Add barrier_nospec implementation for
 NXP PowerPC Book E
Date: Wed, 23 May 2018 11:56:45 +0300
Message-Id: <1527065805-4230-1-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
References: <1526973031-9543-1-git-send-email-diana.craciun@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implement the barrier_nospec as a isync;sync instruction sequence.
The implementation uses the infrastructure built for BOOK3S 64
with the difference that for NXP platforms there is no firmware involved
and the need for a speculation barrier is read from the device tree.
I have used the same name for the property:
fsl,needs-spec-barrier-for-bounds-check

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
---
The patches were created on top of the BOOK3S 64 patches:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2018-April/172137.html

 arch/powerpc/include/asm/barrier.h            | 12 ++++++++-
 arch/powerpc/include/asm/setup.h              |  2 +-
 arch/powerpc/kernel/Makefile                  |  2 +-
 arch/powerpc/kernel/module.c                  |  2 ++
 arch/powerpc/kernel/security.c                | 12 ++++++++-
 arch/powerpc/kernel/vmlinux.lds.S             |  2 ++
 arch/powerpc/lib/feature-fixups.c             | 38 +++++++++++++++++++++++++--
 arch/powerpc/platforms/85xx/corenet_generic.c | 17 ++++++++++++
 8 files changed, 81 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index f67b3f6..1379386 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -86,7 +86,17 @@ do {									\
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
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
+#else /* !CONFIG_PPC_BOOK3S_64 && !CONFIG_PPC_FSL_BOOK3E */
 #define barrier_nospec_asm
 #define barrier_nospec()
 #endif
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index aeb175e8..fbc3ef7 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -55,7 +55,7 @@ void do_rfi_flush_fixups(enum l1d_flush_type types);
 void setup_barrier_nospec(void);
 void do_barrier_nospec_fixups(bool enable);
 
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
index a72698c..ede64a5 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,7 +72,9 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
+#endif
 
+#if defined(CONFIG_PPC64) || defined(CONFIG_PPC_FSL_BOOK3E)
 	sect = find_section(hdr, sechdrs, "__spec_barrier_fixup");
 	if (sect != NULL)
 		do_barrier_nospec_fixups_range(true,
diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
index d1b9639..01b6c55 100644
--- a/arch/powerpc/kernel/security.c
+++ b/arch/powerpc/kernel/security.c
@@ -12,8 +12,9 @@
 #include <asm/security_features.h>
 #include <asm/setup.h>
 
-
+#ifdef CONFIG_PPC_BOOK3S_64
 unsigned long powerpc_security_features __read_mostly = SEC_FTR_DEFAULT;
+#endif
 
 static bool barrier_nospec_enabled;
 
@@ -23,6 +24,7 @@ static void enable_barrier_nospec(bool enable)
 	do_barrier_nospec_fixups(enable);
 }
 
+#ifdef CONFIG_PPC_BOOK3S_64
 void setup_barrier_nospec(void)
 {
 	bool enable;
@@ -44,6 +46,12 @@ void setup_barrier_nospec(void)
 
 	enable_barrier_nospec(enable);
 }
+#elif CONFIG_PPC_FSL_BOOK3E
+void setup_barrier_nospec(void)
+{
+	enable_barrier_nospec(true);
+}
+#endif
 
 #ifdef CONFIG_DEBUG_FS
 static int barrier_nospec_set(void *data, u64 val)
@@ -82,6 +90,7 @@ static __init int barrier_nospec_debugfs_init(void)
 device_initcall(barrier_nospec_debugfs_init);
 #endif /* CONFIG_DEBUG_FS */
 
+#ifdef CONFIG_PPC_BOOK3S_64
 ssize_t cpu_show_meltdown(struct device *dev, struct device_attribute *attr, char *buf)
 {
 	bool thread_priv;
@@ -155,3 +164,4 @@ ssize_t cpu_show_spectre_v2(struct device *dev, struct device_attribute *attr, c
 
 	return s.len;
 }
+#endif
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index ff73f49..e3c0ef2 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -139,7 +139,9 @@ SECTIONS
 		*(__rfi_flush_fixup)
 		__stop___rfi_flush_fixup = .;
 	}
+#endif
 
+#if defined(CONFIG_PPC64) || defined (CONFIG_PPC_FSL_BOOK3E)
 	. = ALIGN(8);
 	__spec_barrier_fixup : AT(ADDR(__spec_barrier_fixup) - LOAD_OFFSET) {
 		__start___barrier_nospec_fixup = .;
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 3b37529..033ef28 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -162,7 +162,6 @@ void do_rfi_flush_fixups(enum l1d_flush_type types)
 		(types &  L1D_FLUSH_MTTRIG)     ? "mttrig type"
 						: "unknown");
 }
-
 void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_end)
 {
 	unsigned int instr, *dest;
@@ -188,7 +187,9 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
+#if defined(CONFIG_PPC_BOOK3S_64) || defined(CONFIG_PPC_FSL_BOOK3E)
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -199,7 +200,40 @@ void do_barrier_nospec_fixups(bool enable)
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
 
-#endif /* CONFIG_PPC_BOOK3S_64 */
+#endif /* CONFIG_PPC_BOOK3S_64 || CONFIG_PPC_FSL_BOOK3E */
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
+	instr[0] = PPC_INST_NOP; /* nop */
+	instr[1] = PPC_INST_NOP; /* nop */
+
+	if (enable) {
+		pr_info("barrier_nospec: using isync; sync as a speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+
+	}
+
+	pr_debug("barrier-nospec: patched %d locations\n", i);
+
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index ac191a7..11bce3d 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -59,6 +59,21 @@ void __init corenet_gen_pic_init(void)
 	}
 }
 
+static void setup_spec_barrier(void)
+{
+	struct device_node *np = of_find_node_by_name(NULL, "cpus");
+
+	if (np) {
+		struct property *prop;
+
+		prop = of_find_property(np,
+		       "fsl,needs-spec-barrier-for-bounds-check", NULL);
+		if (prop)
+			setup_barrier_nospec();
+		of_node_put(np);
+	}
+}
+
 /*
  * Setup the architecture
  */
@@ -80,6 +95,8 @@ void __init corenet_gen_setup_arch(void)
 
 	pr_info("%s board\n", ppc_md.name);
 
+	setup_spec_barrier();
+
 	mpc85xx_qe_init();
 }
 
-- 
2.5.5
