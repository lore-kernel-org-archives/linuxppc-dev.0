Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F279CDDF05
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 15:32:08 +1000 (EST)
Date: Tue, 1 Jul 2008 00:32:01 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: fixup lwsync at runtime
Message-ID: <Pine.LNX.4.64.0807010031241.23830@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

To allow for a single kernel image on e500 v1/v2/mc we need to fixup lwsync
at runtime.  On e500v1/v2 lwsync causes an illop so we need to patch up
the code.  We default to 'sync' since that is always safe and if the cpu
is capable we will replace 'sync' with 'lwsync'.

We introduce CPU_FTR_LWSYNC as a way to determine at runtime if this is
needed.  This flag could be moved elsewhere since we dont really use it
for the normal CPU_FTR purpose.

Finally we only store the relative offset in the fixup section to keep it
as small as possible rather than using a full fixup_entry.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---

Rebased against latest powerpc-next tree.

- k

 arch/powerpc/kernel/module.c            |    6 ++++++
 arch/powerpc/kernel/setup_32.c          |    4 ++++
 arch/powerpc/kernel/setup_64.c          |    2 ++
 arch/powerpc/kernel/vdso.c              |   10 ++++++++++
 arch/powerpc/kernel/vdso32/vdso32.lds.S |    3 +++
 arch/powerpc/kernel/vdso64/vdso64.lds.S |    3 +++
 arch/powerpc/kernel/vmlinux.lds.S       |    6 ++++++
 arch/powerpc/lib/feature-fixups.c       |   16 ++++++++++++++++
 include/asm-powerpc/code-patching.h     |    3 ++-
 include/asm-powerpc/cputable.h          |   21 +++++++++++----------
 include/asm-powerpc/synch.h             |   27 ++++++++++++++++++++++-----
 11 files changed, 85 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/kernel/module.c b/arch/powerpc/kernel/module.c
index 40dd52d..af07003 100644
--- a/arch/powerpc/kernel/module.c
+++ b/arch/powerpc/kernel/module.c
@@ -86,6 +86,12 @@ int module_finalize(const Elf_Ehdr *hdr,
 				  (void *)sect->sh_addr + sect->sh_size);
 #endif

+	sect = find_section(hdr, sechdrs, "__lwsync_fixup");
+	if (sect != NULL)
+		do_lwsync_fixups(cur_cpu_spec->cpu_features,
+				 (void *)sect->sh_addr,
+				 (void *)sect->sh_addr + sect->sh_size);
+
 	return 0;
 }

diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 9e83add..0109e7f 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -101,6 +101,10 @@ unsigned long __init early_init(unsigned long dt_ptr)
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));

+	do_lwsync_fixups(spec->cpu_features,
+			 PTRRELOC(&__start___lwsync_fixup),
+			 PTRRELOC(&__stop___lwsync_fixup));
+
 	return KERNELBASE + offset;
 }

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 098fd96..04d8de9 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -363,6 +363,8 @@ void __init setup_system(void)
 			  &__start___ftr_fixup, &__stop___ftr_fixup);
 	do_feature_fixups(powerpc_firmware_features,
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
+	do_lwsync_fixups(cur_cpu_spec->cpu_features,
+			 &__start___lwsync_fixup, &__stop___lwsync_fixup);

 	/*
 	 * Unflatten the device-tree passed by prom_init or kexec
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ce245a8..f177c60 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -571,6 +571,11 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 	if (start64)
 		do_feature_fixups(powerpc_firmware_features,
 				  start64, start64 + size64);
+
+	start64 = find_section64(v64->hdr, "__lwsync_fixup", &size64);
+	if (start64)
+		do_lwsync_fixups(cur_cpu_spec->cpu_features,
+				 start64, start64 + size64);
 #endif /* CONFIG_PPC64 */

 	start32 = find_section32(v32->hdr, "__ftr_fixup", &size32);
@@ -585,6 +590,11 @@ static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
 				  start32, start32 + size32);
 #endif /* CONFIG_PPC64 */

+	start32 = find_section32(v32->hdr, "__lwsync_fixup", &size32);
+	if (start32)
+		do_lwsync_fixups(cur_cpu_spec->cpu_features,
+				 start32, start32 + size32);
+
 	return 0;
 }

diff --git a/arch/powerpc/kernel/vdso32/vdso32.lds.S b/arch/powerpc/kernel/vdso32/vdso32.lds.S
index 2717935..be3b6a4 100644
--- a/arch/powerpc/kernel/vdso32/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso32/vdso32.lds.S
@@ -33,6 +33,9 @@ SECTIONS
 	. = ALIGN(8);
 	__ftr_fixup	: { *(__ftr_fixup) }

+	. = ALIGN(8);
+	__lwsync_fixup	: { *(__lwsync_fixup) }
+
 #ifdef CONFIG_PPC64
 	. = ALIGN(8);
 	__fw_ftr_fixup	: { *(__fw_ftr_fixup) }
diff --git a/arch/powerpc/kernel/vdso64/vdso64.lds.S b/arch/powerpc/kernel/vdso64/vdso64.lds.S
index e608d1b..d0b2526 100644
--- a/arch/powerpc/kernel/vdso64/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso64/vdso64.lds.S
@@ -35,6 +35,9 @@ SECTIONS
 	__ftr_fixup	: { *(__ftr_fixup) }

 	. = ALIGN(8);
+	__lwsync_fixup	: { *(__lwsync_fixup) }
+
+	. = ALIGN(8);
 	__fw_ftr_fixup	: { *(__fw_ftr_fixup) }

 	/*
diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
index 3c07811..6856f6c 100644
--- a/arch/powerpc/kernel/vmlinux.lds.S
+++ b/arch/powerpc/kernel/vmlinux.lds.S
@@ -127,6 +127,12 @@ SECTIONS
 		*(__ftr_fixup)
 		__stop___ftr_fixup = .;
 	}
+	. = ALIGN(8);
+	__lwsync_fixup : AT(ADDR(__lwsync_fixup) - LOAD_OFFSET) {
+		__start___lwsync_fixup = .;
+		*(__lwsync_fixup)
+		__stop___lwsync_fixup = .;
+	}
 #ifdef CONFIG_PPC64
 	. = ALIGN(8);
 	__fw_ftr_fixup : AT(ADDR(__fw_ftr_fixup) - LOAD_OFFSET) {
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 48e1ed8..ac5f5a1 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -110,6 +110,22 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 	}
 }

+void do_lwsync_fixups(unsigned long value, void *fixup_start, void *fixup_end)
+{
+	unsigned int *start, *end, *dest;
+
+	if (!(value & CPU_FTR_LWSYNC))
+		return ;
+
+	start = fixup_start;
+	end = fixup_end;
+
+	for (; start < end; start++) {
+		dest = (void *)start + *start;
+		patch_instruction(dest, PPC_LWSYNC_INSTR);
+	}
+}
+
 #ifdef CONFIG_FTR_FIXUP_SELFTEST

 #define check(x)	\
diff --git a/include/asm-powerpc/code-patching.h b/include/asm-powerpc/code-patching.h
index ef3a5d1..107d9b9 100644
--- a/include/asm-powerpc/code-patching.h
+++ b/include/asm-powerpc/code-patching.h
@@ -12,7 +12,8 @@

 #include <asm/types.h>

-#define PPC_NOP_INSTR	0x60000000
+#define PPC_NOP_INSTR		0x60000000
+#define PPC_LWSYNC_INSTR	0x7c2004ac

 /* Flags for create_branch:
  * "b"   == create_branch(addr, target, 0);
diff --git a/include/asm-powerpc/cputable.h b/include/asm-powerpc/cputable.h
index 4e4491c..3171ac9 100644
--- a/include/asm-powerpc/cputable.h
+++ b/include/asm-powerpc/cputable.h
@@ -156,6 +156,7 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 #define CPU_FTR_UNIFIED_ID_CACHE	ASM_CONST(0x0000000001000000)
 #define CPU_FTR_SPE			ASM_CONST(0x0000000002000000)
 #define CPU_FTR_NEED_PAIRED_STWCX	ASM_CONST(0x0000000004000000)
+#define CPU_FTR_LWSYNC			ASM_CONST(0x0000000008000000)

 /*
  * Add the 64-bit processor unique features in the top half of the word;
@@ -369,43 +370,43 @@ extern void do_feature_fixups(unsigned long value, void *fixup_start,
 	    CPU_FTR_NODSISRALIGN)
 #define CPU_FTRS_E500MC	(CPU_FTR_MAYBE_CAN_DOZE | CPU_FTR_USE_TB | \
 	    CPU_FTR_MAYBE_CAN_NAP | CPU_FTR_BIG_PHYS | CPU_FTR_NODSISRALIGN | \
-	    CPU_FTR_L2CSR)
+	    CPU_FTR_L2CSR | CPU_FTR_LWSYNC)
 #define CPU_FTRS_GENERIC_32	(CPU_FTR_COMMON | CPU_FTR_NODSISRALIGN)

 /* 64-bit CPUs */
-#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER3	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | CPU_FTR_PPC_LE)
-#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_RS64	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_IABR | \
 	    CPU_FTR_MMCRA | CPU_FTR_CTRL)
-#define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER4	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA)
-#define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_PPC970	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CAN_NAP | CPU_FTR_MMCRA)
-#define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER5	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR)
-#define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER6 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
-#define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | \
+#define CPU_FTRS_POWER7 (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_COHERENT_ICACHE | CPU_FTR_LOCKLESS_TLBIE | \
 	    CPU_FTR_PURR | CPU_FTR_SPURR | CPU_FTR_REAL_LE | \
 	    CPU_FTR_DSCR)
-#define CPU_FTRS_CELL	(CPU_FTR_USE_TB | \
+#define CPU_FTRS_CELL	(CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | CPU_FTR_CTRL | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_MMCRA | CPU_FTR_SMT | \
 	    CPU_FTR_PAUSE_ZERO | CPU_FTR_CI_LARGE_PAGE | CPU_FTR_CELL_TB_BUG)
-#define CPU_FTRS_PA6T (CPU_FTR_USE_TB | \
+#define CPU_FTRS_PA6T (CPU_FTR_USE_TB | CPU_FTR_LWSYNC | \
 	    CPU_FTR_HPTE_TABLE | CPU_FTR_PPCAS_ARCH_V2 | \
 	    CPU_FTR_ALTIVEC_COMP | CPU_FTR_CI_LARGE_PAGE | \
 	    CPU_FTR_PURR | CPU_FTR_REAL_LE | CPU_FTR_NO_SLBIE_B)
diff --git a/include/asm-powerpc/synch.h b/include/asm-powerpc/synch.h
index 42a1ef5..4737c61 100644
--- a/include/asm-powerpc/synch.h
+++ b/include/asm-powerpc/synch.h
@@ -3,20 +3,37 @@
 #ifdef __KERNEL__

 #include <linux/stringify.h>
+#include <asm/feature-fixups.h>

-#if defined(__powerpc64__) || defined(CONFIG_PPC_E500MC)
-#define __SUBARCH_HAS_LWSYNC
-#endif
+#ifndef __ASSEMBLY__
+extern unsigned int __start___lwsync_fixup, __stop___lwsync_fixup;
+extern void do_lwsync_fixups(unsigned long value, void *fixup_start,
+			     void *fixup_end);
+#endif /* __ASSEMBLY__ */
+
+#define START_LWSYNC_SECTION(label)	label##1:
+#define MAKE_LWSYNC_SECTION_ENTRY(label, sect)		\
+label##4:						\
+	.pushsection sect,"a";				\
+	.align 2;					\
+label##5:					       	\
+	.long label##1b-label##5b;			\
+	.popsection;

-#ifdef __SUBARCH_HAS_LWSYNC
+#if defined(__powerpc64__)
 #    define LWSYNC	lwsync
+#elif defined(CONFIG_E500)
+#    define LWSYNC					\
+	START_LWSYNC_SECTION(97);			\
+	sync;						\
+	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
 #else
 #    define LWSYNC	sync
 #endif

 #ifdef CONFIG_SMP
 #define ISYNC_ON_SMP	"\n\tisync\n"
-#define LWSYNC_ON_SMP	__stringify(LWSYNC) "\n"
+#define LWSYNC_ON_SMP	stringify_in_c(LWSYNC) "\n"
 #else
 #define ISYNC_ON_SMP
 #define LWSYNC_ON_SMP
-- 
1.5.5.1
