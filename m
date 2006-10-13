Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E85867D08
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 18:04:42 +1000 (EST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id k9D8D3Au017087
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Oct 2006 03:13:04 -0500
Subject: [PATCH 3/5] powerpc: Support feature fixups in vdso's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Fri, 13 Oct 2006 18:04:29 +1000
Message-Id: <1160726669.4792.224.camel@localhost.localdomain>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch reworks the feature fixup mecanism so vdso's can be fixed up.
The main issue was that the construct:

        .long   label  (or .llong on 64 bits)

will not work in the case of a shared library like the vdso. It will
generate an empty placeholder in the fixup table along with a reloc,
which is not something we can deal with in the vdso.

The idea here (thanks Alan Modra !) is to instead use something like:

1:
        .long   label - 1b

That is, the feature fixup tables no longer contain addresses of bits of
code to patch, but offsets of such code from the fixup table entry
itself. That is properly resolved by ld when building the .so's. I've
modified the fixup mecanism generically to use that method for the rest
of the kernel as well.

Another trick is that the 32 bits vDSO included in the 64 bits kernel
need to have a table in the 64 bits format. However, gas does not
support 32 bits code with a statement of the form:

        .llong  label - 1b  (Or even just .llong label)

That is, it cannot emit the right fixup/relocation for the linker to use
to assign a 32 bits address to an .llong field. Thus, in the specific
case of the 32 bits vdso built as part of the 64 bits kernel, we are
using a modified macro that generates:

        .long   0xffffffff
        .llong  label - 1b

Note that is assumes that the value is negative which is enforced by
the .lds (those offsets are always negative as the .text is always
before the fixup table and gas doesn't support emiting the reloc the
other way around).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-cell/arch/powerpc/kernel/vdso.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/vdso.c	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/vdso.c	2006-10-13 16:58:13.000000000 +1000
@@ -36,6 +36,8 @@
 #include <asm/vdso.h>
 #include <asm/vdso_datapage.h>
 
+#include "setup.h"
+
 #undef DEBUG
 
 #ifdef DEBUG
@@ -586,6 +588,43 @@ static __init int vdso_fixup_datapage(st
 	return 0;
 }
 
+
+static __init int vdso_fixup_features(struct lib32_elfinfo *v32,
+				      struct lib64_elfinfo *v64)
+{
+	void *start32;
+	unsigned long size32;
+
+#ifdef CONFIG_PPC64
+	void *start64;
+	unsigned long size64;
+
+	start64 = find_section64(v64->hdr, "__ftr_fixup", &size64);
+	if (start64)
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+				  start64, start64 + size64);
+
+	start64 = find_section64(v64->hdr, "__fw_ftr_fixup", &size64);
+	if (start64)
+		do_feature_fixups(powerpc_firmware_features,
+				  start64, start64 + size64);
+#endif /* CONFIG_PPC64 */
+
+	start32 = find_section32(v32->hdr, "__ftr_fixup", &size32);
+	if (start32)
+		do_feature_fixups(cur_cpu_spec->cpu_features,
+				  start32, start32 + size32);
+
+#ifdef CONFIG_PPC64
+	start32 = find_section32(v32->hdr, "__fw_ftr_fixup", &size32);
+	if (start32)
+		do_feature_fixups(powerpc_firmware_features,
+				  start32, start32 + size32);
+#endif /* CONFIG_PPC64 */
+
+	return 0;
+}
+
 static __init int vdso_fixup_alt_funcs(struct lib32_elfinfo *v32,
 				       struct lib64_elfinfo *v64)
 {
@@ -634,6 +673,9 @@ static __init int vdso_setup(void)
 	if (vdso_fixup_datapage(&v32, &v64))
 		return -1;
 
+	if (vdso_fixup_features(&v32, &v64))
+		return -1;
+
 	if (vdso_fixup_alt_funcs(&v32, &v64))
 		return -1;
 
@@ -714,6 +756,7 @@ void __init vdso_init(void)
 	 * Setup the syscall map in the vDOS
 	 */
 	vdso_setup_syscall_map();
+
 	/*
 	 * Initialize the vDSO images in memory, that is do necessary
 	 * fixups of vDSO symbols, locate trampolines, etc...
Index: linux-cell/arch/powerpc/kernel/vdso32/vdso32.lds.S
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/vdso32/vdso32.lds.S	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/vdso32/vdso32.lds.S	2006-10-13 16:58:13.000000000 +1000
@@ -32,6 +32,18 @@ SECTIONS
   PROVIDE (_etext = .);
   PROVIDE (etext = .);
 
+  . = ALIGN(8);
+  __ftr_fixup : {
+    *(__ftr_fixup)
+  }
+
+#ifdef CONFIG_PPC64
+  . = ALIGN(8);
+  __fw_ftr_fixup : {
+    *(__fw_ftr_fixup)
+  }
+#endif
+
   /* Other stuff is appended to the text segment: */
   .rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
   .rodata1		: { *(.rodata1) }
Index: linux-cell/arch/powerpc/kernel/vdso64/vdso64.lds.S
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/vdso64/vdso64.lds.S	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/vdso64/vdso64.lds.S	2006-10-13 16:58:13.000000000 +1000
@@ -31,6 +31,16 @@ SECTIONS
   PROVIDE (_etext = .);
   PROVIDE (etext = .);
 
+  . = ALIGN(8);
+  __ftr_fixup : {
+    *(__ftr_fixup)
+  }
+
+  . = ALIGN(8);
+  __fw_ftr_fixup : {
+    *(__fw_ftr_fixup)
+  }
+
   /* Other stuff is appended to the text segment: */
   .rodata         : { *(.rodata .rodata.* .gnu.linkonce.r.*) }
   .rodata1        : { *(.rodata1) }
Index: linux-cell/arch/powerpc/kernel/setup-common.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup-common.c	2006-10-13 16:39:03.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup-common.c	2006-10-13 16:58:55.000000000 +1000
@@ -521,14 +521,13 @@ void __init setup_panic(void)
 	atomic_notifier_chain_register(&panic_notifier_list, &ppc_panic_block);
 }
 
-void do_feature_fixups(unsigned long offset, unsigned long value,
-		       void *fixup_start, void *fixup_end)
+void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 {
 	struct fixup_entry {
 		unsigned long	mask;
 		unsigned long	value;
-		unsigned int	*start;
-		unsigned int	*end;
+		long		start_off;
+		long		end_off;
 	} *fcur, *fend;
 
 	fcur = fixup_start;
@@ -543,8 +542,8 @@ void do_feature_fixups(unsigned long off
 		/* These PTRRELOCs will disappear once the new scheme for
 		 * modules and vdso is implemented
 		 */
-		pstart = PTRRELOC(fcur->start);
-		pend = PTRRELOC(fcur->end);
+		pstart = ((unsigned int *)fcur) + (fcur->start_off / 4);
+		pend = ((unsigned int *)fcur) + (fcur->end_off / 4);
 
 		for (p = pstart; p < pend; p++) {
 			*p = 0x60000000u;
Index: linux-cell/arch/powerpc/kernel/setup.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup.h	2006-10-13 16:06:24.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup.h	2006-10-13 16:58:13.000000000 +1000
@@ -4,8 +4,8 @@
 extern void check_for_initrd(void);
 extern void do_init_bootmem(void);
 extern void setup_panic(void);
-extern void do_feature_fixups(unsigned long offset, unsigned long value,
-			      void *fixup_start, void *fixup_end);
+extern void do_feature_fixups(unsigned long value, void *fixup_start,
+			      void *fixup_end);
 
 extern int do_early_xmon;
 
Index: linux-cell/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_32.c	2006-10-13 16:38:21.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_32.c	2006-10-13 16:59:28.000000000 +1000
@@ -104,7 +104,7 @@ unsigned long __init early_init(unsigned
 	 */
 	spec = identify_cpu(offset);
 
-	do_feature_fixups(offset, spec->cpu_features,
+	do_feature_fixups(spec->cpu_features,
 			  PTRRELOC(&__start___ftr_fixup),
 			  PTRRELOC(&__stop___ftr_fixup));
 
Index: linux-cell/arch/powerpc/kernel/setup_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/setup_64.c	2006-10-13 16:42:44.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/setup_64.c	2006-10-13 16:58:13.000000000 +1000
@@ -357,9 +357,9 @@ void __init setup_system(void)
 	/* Apply the CPUs-specific and firmware specific fixups to kernel
 	 * text (nop out sections not relevant to this CPU or this firmware)
 	 */
-	do_feature_fixups(0, cur_cpu_spec->cpu_features,
+	do_feature_fixups(cur_cpu_spec->cpu_features,
 			  &__start___ftr_fixup, &__stop___ftr_fixup);
-	do_feature_fixups(0, powerpc_firmware_features,
+	do_feature_fixups(powerpc_firmware_features,
 			  &__start___fw_ftr_fixup, &__stop___fw_ftr_fixup);
 
 	/*
Index: linux-cell/include/asm-powerpc/asm-compat.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/asm-compat.h	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/include/asm-powerpc/asm-compat.h	2006-10-13 16:58:13.000000000 +1000
@@ -14,6 +14,58 @@
 #  define ASM_CONST(x)		__ASM_CONST(x)
 #endif
 
+
+/*
+ * Feature section common macros
+ *
+ * Note that the entries now contain offsets between the table entry
+ * and the code rather than absolute code pointers in order to be
+ * useable with the vdso shared library. There is also an assumption
+ * that values will be negative, that is, the fixup table has to be
+ * located after the code it fixes up.
+ */
+#ifdef CONFIG_PPC64
+#ifdef __powerpc64__
+/* 64 bits kernel, 64 bits code */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:							\
+	.section sect,"a";				\
+	.align 3;					\
+98:						       	\
+	.llong msk;					\
+	.llong val;					\
+	.llong label##b-98b;				\
+	.llong 99b-98b;		 			\
+	.previous
+#else /* __powerpc64__ */
+/* 64 bits kernel, 32 bits code (ie. vdso32) */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:							\
+	.section sect,"a";				\
+	.align 3;					\
+98:						       	\
+	.llong msk;					\
+	.llong val;					\
+	.long 0xffffffff;      				\
+	.long label##b-98b;				\
+	.long 0xffffffff;	       			\
+	.long 99b-98b;		 			\
+	.previous
+#endif /* !__powerpc64__ */
+#else /* CONFIG_PPC64 */
+/* 32 bits kernel, 32 bits code */
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
+99:						       	\
+	.section sect,"a";			       	\
+	.align 2;				       	\
+98:						       	\
+	.long msk;				       	\
+	.long val;				       	\
+	.long label##b-98b;			       	\
+	.long 99b-98b;				       	\
+	.previous
+#endif /* !CONFIG_PPC64 */
+
 #ifdef __powerpc64__
 
 /* operations for longs and pointers */
Index: linux-cell/include/asm-powerpc/cputable.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/cputable.h	2006-10-13 16:58:07.000000000 +1000
+++ linux-cell/include/asm-powerpc/cputable.h	2006-10-13 16:58:13.000000000 +1000
@@ -431,32 +431,11 @@ static inline int cpu_has_feature(unsign
 #ifdef __ASSEMBLY__
 
 #define BEGIN_FTR_SECTION_NESTED(label)	label:
-#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(98)
-
-#ifndef __powerpc64__
-#define END_FTR_SECTION_NESTED(msk, val, label) \
-99:						\
-	.section __ftr_fixup,"a";		\
-	.align 2;				\
-	.long msk;				\
-	.long val;				\
-	.long label##b;				\
-	.long 99b;				\
-	.previous
-#else /* __powerpc64__ */
+#define BEGIN_FTR_SECTION		BEGIN_FTR_SECTION_NESTED(97)
 #define END_FTR_SECTION_NESTED(msk, val, label) \
-99:						\
-	.section __ftr_fixup,"a";		\
-	.align 3;				\
-	.llong msk;				\
-	.llong val;				\
-	.llong label##b;				\
-	.llong 99b;	 			\
-	.previous
-#endif /* __powerpc64__ */
-
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __ftr_fixup)
 #define END_FTR_SECTION(msk, val)		\
-	END_FTR_SECTION_NESTED(msk, val, 98)
+	END_FTR_SECTION_NESTED(msk, val, 97)
 
 #define END_FTR_SECTION_IFSET(msk)	END_FTR_SECTION((msk), (msk))
 #define END_FTR_SECTION_IFCLR(msk)	END_FTR_SECTION((msk), 0)
Index: linux-cell/include/asm-powerpc/firmware.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/firmware.h	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/include/asm-powerpc/firmware.h	2006-10-13 16:58:13.000000000 +1000
@@ -98,17 +98,12 @@ extern int fwnmi_active;
 
 #else /* __ASSEMBLY__ */
 
-#define BEGIN_FW_FTR_SECTION		96:
-
+#define BEGIN_FW_FTR_SECTION_NESTED(label)	label:
+#define BEGIN_FW_FTR_SECTION			BEGIN_FW_FTR_SECTION_NESTED(97)
+#define END_FW_FTR_SECTION_NESTED(msk, val, label) \
+	MAKE_FTR_SECTION_ENTRY(msk, val, label, __fw_ftr_fixup)
 #define END_FW_FTR_SECTION(msk, val)		\
-97:						\
-	.section __fw_ftr_fixup,"a";		\
-	.align 3;				\
-	.llong msk;				\
-	.llong val;				\
-	.llong 96b;				\
-	.llong 97b;				\
-	.previous
+	END_FW_FTR_SECTION_NESTED(msk, val, 97)
 
 #define END_FW_FTR_SECTION_IFSET(msk)	END_FW_FTR_SECTION((msk), (msk))
 #define END_FW_FTR_SECTION_IFCLR(msk)	END_FW_FTR_SECTION((msk), 0)
Index: linux-cell/include/asm-powerpc/timex.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/timex.h	2006-10-13 16:00:27.000000000 +1000
+++ linux-cell/include/asm-powerpc/timex.h	2006-10-13 16:58:13.000000000 +1000
@@ -30,13 +30,15 @@ static inline cycles_t get_cycles(void)
 	ret = 0;
 
 	__asm__ __volatile__(
-		"98:	mftb %0\n"
+		"97:	mftb %0\n"
 		"99:\n"
 		".section __ftr_fixup,\"a\"\n"
+		".align 2\n"
+		"98:\n"
 		"	.long %1\n"
 		"	.long 0\n"
-		"	.long 98b\n"
-		"	.long 99b\n"
+		"	.long 97b-98b\n"
+		"	.long 99b-98b\n"
 		".previous"
 		: "=r" (ret) : "i" (CPU_FTR_601));
 #endif
