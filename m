Return-Path: <diana.craciun@nxp.com>
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41RvPp1CwBzDr10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Jul 2018 23:52:29 +1000 (AEST)
From: Diana Craciun <diana.craciun@nxp.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, oss@buserror.net, leoyang.li@nxp.com,
 bharat.bhushan@nxp.com, Diana Craciun <diana.craciun@nxp.com>
Subject: [PATCH v3 5/6] powerpc/fsl: Add barrier_nospec implementation for NXP
 PowerPC Book3E
Date: Fri, 13 Jul 2018 16:52:14 +0300
Message-Id: <1531489935-17473-6-git-send-email-diana.craciun@nxp.com>
In-Reply-To: <1531489935-17473-1-git-send-email-diana.craciun@nxp.com>
References: <1531489935-17473-1-git-send-email-diana.craciun@nxp.com>
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
History:

v2-->v3
- added PPC_NOSPEC Kconfig
- addressed the review comments

It was a discussion at the previous review cycle about the place in the code
where to call setup_barrier_nospec. I have chosen to call the function in the
common code in order to be re-used on multiple platforms. However, I am not sure
that changes concerning powernv/pseries are correct, I need some input here.

 arch/powerpc/include/asm/barrier.h     | 12 +++++++++---
 arch/powerpc/include/asm/setup.h       |  6 +++++-
 arch/powerpc/kernel/Makefile           |  3 ++-
 arch/powerpc/kernel/module.c           |  4 +++-
 arch/powerpc/kernel/setup-common.c     |  2 ++
 arch/powerpc/kernel/vmlinux.lds.S      |  4 +++-
 arch/powerpc/lib/feature-fixups.c      | 35 +++++++++++++++++++++++++++++++++-
 arch/powerpc/platforms/powernv/setup.c |  1 -
 arch/powerpc/platforms/pseries/setup.c |  1 -
 9 files changed, 58 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/barrier.h b/arch/powerpc/include/asm/barrier.h
index f67b3f6..0bdfa81 100644
--- a/arch/powerpc/include/asm/barrier.h
+++ b/arch/powerpc/include/asm/barrier.h
@@ -77,19 +77,25 @@ do {									\
 })
 
 #ifdef CONFIG_PPC_BOOK3S_64
+#define NOSPEC_BARRIER_SLOT   nop
+#elif defined(CONFIG_PPC_FSL_BOOK3E)
+#define NOSPEC_BARRIER_SLOT   nop; nop
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_NOSPEC
 /*
  * Prevent execution of subsequent instructions until preceding branches have
  * been fully resolved and are no longer executing speculatively.
  */
-#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; nop
+#define barrier_nospec_asm NOSPEC_BARRIER_FIXUP_SECTION; NOSPEC_BARRIER_SLOT
 
 // This also acts as a compiler barrier due to the memory clobber.
 #define barrier_nospec() asm (stringify_in_c(barrier_nospec_asm) ::: "memory")
 
-#else /* !CONFIG_PPC_BOOK3S_64 */
+#else /* !CONFIG_PPC_NOSPEC */
 #define barrier_nospec_asm
 #define barrier_nospec()
-#endif
+#endif /* CONFIG_PPC_NOSPEC */
 
 #include <asm-generic/barrier.h>
 
diff --git a/arch/powerpc/include/asm/setup.h b/arch/powerpc/include/asm/setup.h
index 8721fd0..1abe152 100644
--- a/arch/powerpc/include/asm/setup.h
+++ b/arch/powerpc/include/asm/setup.h
@@ -52,11 +52,15 @@ enum l1d_flush_type {
 
 void setup_rfi_flush(enum l1d_flush_type, bool enable);
 void do_rfi_flush_fixups(enum l1d_flush_type types);
+#ifdef CONFIG_PPC_NOSPEC
 void setup_barrier_nospec(void);
+#else
+void setup_barrier_nospec(void) { };
+#endif
 void do_barrier_nospec_fixups(bool enable);
 extern bool barrier_nospec_enabled;
 
-#ifdef CONFIG_PPC_BOOK3S_64
+#ifdef CONFIG_PPC_NOSPEC
 void do_barrier_nospec_fixups_range(bool enable, void *start, void *end);
 #else
 static inline void do_barrier_nospec_fixups_range(bool enable, void *start, void *end) { };
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 2b4c40b2..cd0eb38 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -42,9 +42,10 @@ obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
 obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_ppc970.o cpu_setup_pa6t.o
-obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o security.o
+obj-$(CONFIG_PPC_BOOK3S_64)	+= cpu_setup_power.o
 obj-$(CONFIG_PPC_BOOK3S_64)	+= mce.o mce_power.o
 obj-$(CONFIG_PPC_BOOK3E_64)	+= exceptions-64e.o idle_book3e.o
+obj-$(CONFIG_PPC_NOSPEC) += security.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o
 obj-$(CONFIG_PPC_970_NAP)	+= idle_power4.o
diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 1b3c683..a0c4967 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -72,13 +72,15 @@ int module_finalize(const Elf_Ehdr *hdr,
 		do_feature_fixups(powerpc_firmware_features,
 				  (void *)sect->sh_addr,
 				  (void *)sect->sh_addr + sect->sh_size);
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
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 40b44bb..93fa0c9 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -972,6 +972,8 @@ void __init setup_arch(char **cmdline_p)
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
+	setup_barrier_nospec();
+
 	paging_init();
 
 	/* Initialize the MMU context management stuff. */
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 5baac79..6087b02 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -153,14 +153,16 @@ SECTIONS
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
index 8b69f86..41f372e 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -304,6 +304,9 @@ void do_barrier_nospec_fixups_range(bool enable, void *fixup_start, void *fixup_
 	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
 }
 
+#endif /* CONFIG_PPC_BOOK3S_64 */
+
+#ifdef CONFIG_PPC_NOSPEC
 void do_barrier_nospec_fixups(bool enable)
 {
 	void *start, *end;
@@ -313,8 +316,38 @@ void do_barrier_nospec_fixups(bool enable)
 
 	do_barrier_nospec_fixups_range(enable, start, end);
 }
+#endif /* CONFIG_PPC_NOSPEC */
 
-#endif /* CONFIG_PPC_BOOK3S_64 */
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
+		pr_info("barrier-nospec: using isync; sync as speculation barrier\n");
+		instr[0] = PPC_INST_ISYNC;
+		instr[1] = PPC_INST_SYNC;
+	}
+
+	for (i = 0; start < end; start++, i++) {
+		dest = (void *)start + *start;
+
+		pr_devel("patching dest %lx\n", (unsigned long)dest);
+		patch_instruction(dest, instr[0]);
+		patch_instruction(dest + 1, instr[1]);
+	}
+
+	printk(KERN_DEBUG "barrier-nospec: patched %d locations\n", i);
+}
+#endif /* CONFIG_PPC_FSL_BOOK3E */
 
 void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index f96df0a..1ab6dc7 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -124,7 +124,6 @@ static void pnv_setup_rfi_flush(void)
 		  security_ftr_enabled(SEC_FTR_L1D_FLUSH_HV));
 
 	setup_rfi_flush(type, enable);
-	setup_barrier_nospec();
 }
 
 static void __init pnv_setup_arch(void)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 139f0af..fdb32e0 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -534,7 +534,6 @@ void pseries_setup_rfi_flush(void)
 		 security_ftr_enabled(SEC_FTR_L1D_FLUSH_PR);
 
 	setup_rfi_flush(types, enable);
-	setup_barrier_nospec();
 }
 
 #ifdef CONFIG_PCI_IOV
-- 
2.5.5
