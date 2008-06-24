Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <fbc099d1e3e9cfe3f6d20b1b990dc6144f4a3374.1214271072.git.michael@ellerman.id.au>
In-Reply-To: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 13/14] powerpc: Add self-tests of the feature fixup code
Date: Tue, 24 Jun 2008 11:33:03 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This commit adds tests of the feature fixup code, they are run during
boot if CONFIG_FTR_FIXUP_SELFTEST=y. Some of the tests manually invoke
the patching routines to check their behaviour, and others use the
macros and so are patched during the normal patching done during boot.

Because we have two sets of macros with different names, we use a macro
to generate the test of the macros, very niiiice.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug             |    5 +
 arch/powerpc/lib/Makefile              |    1 +
 arch/powerpc/lib/feature-fixups-test.S |  727 ++++++++++++++++++++++++++++++++
 arch/powerpc/lib/feature-fixups.c      |  206 +++++++++
 4 files changed, 939 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index dc58939..2840ab6 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -62,6 +62,11 @@ config CODE_PATCHING_SELFTEST
 	depends on DEBUG_KERNEL
 	default n
 
+config FTR_FIXUP_SELFTEST
+	bool "Run self-tests of the feature-fixup code."
+	depends on DEBUG_KERNEL
+	default n
+
 choice
 	prompt "Serial Port"
 	depends on KGDB
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4afcf3a..9469f99 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -27,3 +27,4 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-y			+= code-patching.o
 obj-y			+= feature-fixups.o
+obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
new file mode 100644
index 0000000..10d038b
--- /dev/null
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -0,0 +1,727 @@
+/*
+ * Copyright 2008 Michael Ellerman, IBM Corporation.
+ *
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <asm/feature-fixups.h>
+#include <asm/ppc_asm.h>
+
+	.text
+
+#define globl(x)		\
+	.globl x;	\
+x:
+
+globl(ftr_fixup_test1)
+	or	1,1,1
+	or	2,2,2	/* fixup will nop out this instruction */
+	or	3,3,3
+
+globl(end_ftr_fixup_test1)
+
+globl(ftr_fixup_test1_orig)
+	or	1,1,1
+	or	2,2,2
+	or	3,3,3
+
+globl(ftr_fixup_test1_expected)
+	or	1,1,1
+	nop
+	or	3,3,3
+
+globl(ftr_fixup_test2)
+	or	1,1,1
+	or	2,2,2	/* fixup will replace this with ftr_fixup_test2_alt */
+	or	3,3,3
+
+globl(end_ftr_fixup_test2)
+
+globl(ftr_fixup_test2_orig)
+	or	1,1,1
+	or	2,2,2
+	or	3,3,3
+
+globl(ftr_fixup_test2_alt)
+	or	31,31,31
+
+globl(ftr_fixup_test2_expected)
+	or	1,1,1
+	or	31,31,31
+	or	3,3,3
+
+globl(ftr_fixup_test3)
+	or	1,1,1
+	or	2,2,2	/* fixup will fail to replace this */
+	or	3,3,3
+
+globl(end_ftr_fixup_test3)
+
+globl(ftr_fixup_test3_orig)
+	or	1,1,1
+	or	2,2,2
+	or	3,3,3
+
+globl(ftr_fixup_test3_alt)
+	or	31,31,31
+	or	31,31,31
+
+globl(ftr_fixup_test4)
+	or	1,1,1
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	3,3,3
+
+globl(end_ftr_fixup_test4)
+
+globl(ftr_fixup_test4_expected)
+	or	1,1,1
+	or	31,31,31
+	or	31,31,31
+	nop
+	nop
+	or	3,3,3
+
+globl(ftr_fixup_test4_orig)
+	or	1,1,1
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	3,3,3
+
+globl(ftr_fixup_test4_alt)
+	or	31,31,31
+	or	31,31,31
+
+
+globl(ftr_fixup_test5)
+	or	1,1,1
+BEGIN_FTR_SECTION
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+FTR_SECTION_ELSE
+2:	b	3f
+3:	or	5,5,5
+	beq	3b
+	b	1f
+	or	6,6,6
+	b	2b
+1:	bdnz	3b
+ALT_FTR_SECTION_END(0, 1)
+	or	1,1,1
+
+globl(end_ftr_fixup_test5)
+
+globl(ftr_fixup_test5_expected)
+	or	1,1,1
+2:	b	3f
+3:	or	5,5,5
+	beq	3b
+	b	1f
+	or	6,6,6
+	b	2b
+1:	bdnz	3b
+	or	1,1,1
+
+globl(ftr_fixup_test6)
+1:	or	1,1,1
+BEGIN_FTR_SECTION
+	or	5,5,5
+2:	cmpdi	r3,0
+	beq	4f
+	blt	2b
+	b	1b
+	b	4f
+FTR_SECTION_ELSE
+2:	or	2,2,2
+	cmpdi	r3,1
+	beq	3f
+	blt	2b
+	b	3f
+	b	1b
+ALT_FTR_SECTION_END(0, 1)
+3:	or	1,1,1
+	or	2,2,2
+4:	or	3,3,3
+
+globl(end_ftr_fixup_test6)
+
+globl(ftr_fixup_test6_expected)
+1:	or	1,1,1
+2:	or	2,2,2
+	cmpdi	r3,1
+	beq	3f
+	blt	2b
+	b	3f
+	b	1b
+2:	or	1,1,1
+	or	2,2,2
+3:	or	3,3,3
+
+
+#define	MAKE_MACRO_TEST(TYPE)						\
+globl(ftr_fixup_test_ ##TYPE##_macros)					\
+	or	1,1,1;							\
+	/* Basic test, this section should all be nop'ed */		\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic test, this section should NOT be nop'ed */		\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, inner section should be nop'ed */		\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(80)					\
+	or	3,3,3;							\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 1, 80)					\
+	or	2,2,2;							\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, whole section should be nop'ed */		\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(80)					\
+	or	3,3,3;							\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 0, 80)					\
+	or	2,2,2;							\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, none should be nop'ed */			\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(80)					\
+	or	3,3,3;							\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 0, 80)					\
+	or	2,2,2;							\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic alt section test, default case should be taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	5,5,5;							\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic alt section test, else case should be taken */		\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+	or	31,31,31;						\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt with smaller else case, should be padded with nops */	\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in default case */		\
+	/* Default case should be taken, with nop'ed inner section */	\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	3,3,3;							\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 1, 95)					\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+ALT_##TYPE##_SECTION_END(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in else, default taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	5,5,5;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 1, 95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in else, else taken & nop */	\
+BEGIN_##TYPE##_SECTION							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+##TYPE##_SECTION_ELSE							\
+	or	5,5,5;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	3,3,3;							\
+END_##TYPE##_SECTION_NESTED(0, 1, 95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, default taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95)				\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, else taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95)				\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, all nop'ed */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95)				\
+	or	2,2,2;							\
+END_##TYPE##_SECTION(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, default with inner default taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95)				\
+	or	2,2,2;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+BEGIN_##TYPE##_SECTION_NESTED(94)					\
+	or	5,5,5;							\
+##TYPE##_SECTION_ELSE_NESTED(94)					\
+	or	1,1,1;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94)				\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, default with inner else taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95)				\
+	or	2,2,2;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+BEGIN_##TYPE##_SECTION_NESTED(94)					\
+	or	5,5,5;							\
+##TYPE##_SECTION_ELSE_NESTED(94)					\
+	or	1,1,1;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94)				\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 0)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else with inner default taken */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95)				\
+	or	2,2,2;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+BEGIN_##TYPE##_SECTION_NESTED(94)					\
+	or	5,5,5;							\
+##TYPE##_SECTION_ELSE_NESTED(94)					\
+	or	1,1,1;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94)				\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else with inner else taken */		\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+BEGIN_##TYPE##_SECTION_NESTED(95)					\
+	or	1,1,1;							\
+##TYPE##_SECTION_ELSE_NESTED(95)					\
+	or	5,5,5;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95)				\
+	or	2,2,2;							\
+##TYPE##_SECTION_ELSE							\
+	or	31,31,31;						\
+BEGIN_##TYPE##_SECTION_NESTED(94)					\
+	or	5,5,5;							\
+##TYPE##_SECTION_ELSE_NESTED(94)					\
+	or	1,1,1;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 94)				\
+	or	31,31,31;						\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else can have large else case */	\
+BEGIN_##TYPE##_SECTION							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+##TYPE##_SECTION_ELSE 							\
+BEGIN_##TYPE##_SECTION_NESTED(94) 					\
+	or	5,5,5;							\
+	or	5,5,5;							\
+	or	5,5,5;							\
+	or	5,5,5;							\
+##TYPE##_SECTION_ELSE_NESTED(94) 					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	or	1,1,1;							\
+ALT_##TYPE##_SECTION_END_NESTED(0, 1, 94)				\
+ALT_##TYPE##_SECTION_END(0, 1)						\
+	or	1,1,1;							\
+	or	1,1,1;
+
+#define	MAKE_MACRO_TEST_EXPECTED(TYPE)					\
+globl(ftr_fixup_test_ ##TYPE##_macros_expected)				\
+	or	1,1,1;							\
+	/* Basic test, this section should all be nop'ed */		\
+/* BEGIN_##TYPE##_SECTION */						\
+	nop;								\
+	nop;								\
+	nop;								\
+/* END_##TYPE##_SECTION(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic test, this section should NOT be nop'ed */		\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+	or	2,2,2;							\
+	or	2,2,2;							\
+/* END_##TYPE##_SECTION(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, inner section should be nop'ed */		\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(80) */					\
+	nop;								\
+	nop;								\
+/* END_##TYPE##_SECTION_NESTED(0, 1, 80) */				\
+	or	2,2,2;							\
+	or	2,2,2;							\
+/* END_##TYPE##_SECTION(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, whole section should be nop'ed */		\
+	/* NB. inner section is not nop'ed, but then entire outer is */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	nop;								\
+	nop;								\
+/* BEGIN_##TYPE##_SECTION_NESTED(80) */					\
+	nop;								\
+	nop;								\
+/* END_##TYPE##_SECTION_NESTED(0, 0, 80) */				\
+	nop;								\
+	nop;								\
+/* END_##TYPE##_SECTION(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nesting test, none should be nop'ed */			\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(80) */					\
+	or	3,3,3;							\
+	or	3,3,3;							\
+/* END_##TYPE##_SECTION_NESTED(0, 0, 80) */				\
+	or	2,2,2;							\
+	or	2,2,2;							\
+/* END_##TYPE##_SECTION(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic alt section test, default case should be taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+/* ##TYPE##_SECTION_ELSE */						\
+	/* or	5,5,5; */						\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Basic alt section test, else case should be taken */		\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+	or	31,31,31;						\
+	or	31,31,31;						\
+	or	31,31,31;						\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt with smaller else case, should be padded with nops */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+	or	31,31,31;						\
+	nop;								\
+	nop;								\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in default case */		\
+	/* Default case should be taken, with nop'ed inner section */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	3,3,3;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	nop;								\
+	nop;								\
+/* END_##TYPE##_SECTION_NESTED(0, 1, 95) */				\
+	or	3,3,3;							\
+/* ##TYPE##_SECTION_ELSE */						\
+	/* or	2,2,2; */						\
+	/* or	2,2,2; */						\
+/* ALT_##TYPE##_SECTION_END(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in else, default taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	3,3,3;							\
+	or	3,3,3;							\
+	or	3,3,3;							\
+/* ##TYPE##_SECTION_ELSE */						\
+	/* or	5,5,5; */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	/* or	3,3,3; */						\
+/* END_##TYPE##_SECTION_NESTED(0, 1, 95) */				\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Alt section with nested section in else, else taken & nop */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+	/* or	3,3,3; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+	or	5,5,5;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	nop;								\
+/* END_##TYPE##_SECTION_NESTED(0, 1, 95) */				\
+	or	5,5,5;							\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, default taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	or	1,1,1;							\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95) */				\
+	or	2,2,2;							\
+/* END_##TYPE##_SECTION(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, else taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	/* or	1,1,1; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	or	5,5,5;							\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95) */				\
+	or	2,2,2;							\
+/* END_##TYPE##_SECTION(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Feature section with nested alt section, all nop'ed */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	nop;								\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	nop;								\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95) */				\
+	nop;								\
+/* END_##TYPE##_SECTION(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, default with inner default taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	or	1,1,1;							\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 95) */				\
+	or	2,2,2;							\
+/* ##TYPE##_SECTION_ELSE */						\
+	/* or	31,31,31; */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(94) */					\
+	/* or	5,5,5; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(94) */					\
+	/* or	1,1,1; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94) */				\
+	/* or	31,31,31; */						\
+/* ALT_##TYPE##_SECTION_END(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, default with inner else taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	or	2,2,2;							\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	/* or	1,1,1; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	or	5,5,5;							\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95) */				\
+	or	2,2,2;							\
+/* ##TYPE##_SECTION_ELSE */						\
+	/* or	31,31,31; */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(94) */					\
+	/* or	5,5,5; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(94) */					\
+	/* or	1,1,1; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94) */				\
+	/* or	31,31,31; */						\
+/* ALT_##TYPE##_SECTION_END(0, 0) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else with inner default taken */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	2,2,2; */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	/* or	1,1,1; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95) */				\
+	/* or	2,2,2; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+	or	31,31,31;						\
+/* BEGIN_##TYPE##_SECTION_NESTED(94) */					\
+	or	5,5,5;							\
+/* ##TYPE##_SECTION_ELSE_NESTED(94) */					\
+	/* or	1,1,1; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 0, 94) */				\
+	or	31,31,31;						\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else with inner else taken */		\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	2,2,2; */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(95) */					\
+	/* or	1,1,1; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(95) */					\
+	/* or	5,5,5; */						\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 95) */				\
+	/* or	2,2,2; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+	or	31,31,31;						\
+/* BEGIN_##TYPE##_SECTION_NESTED(94) */					\
+	/* or	5,5,5; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(94) */					\
+	or	1,1,1;							\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 94) */				\
+	or	31,31,31;						\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	/* Nested alt sections, else can have large else case */	\
+/* BEGIN_##TYPE##_SECTION */						\
+	/* or	2,2,2; */						\
+	/* or	2,2,2; */						\
+	/* or	2,2,2; */						\
+	/* or	2,2,2; */						\
+/* ##TYPE##_SECTION_ELSE */						\
+/* BEGIN_##TYPE##_SECTION_NESTED(94) */					\
+	/* or	5,5,5; */						\
+	/* or	5,5,5; */						\
+	/* or	5,5,5; */						\
+	/* or	5,5,5; */						\
+/* ##TYPE##_SECTION_ELSE_NESTED(94) */					\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	or	1,1,1;							\
+	or	1,1,1;							\
+/* ALT_##TYPE##_SECTION_END_NESTED(0, 1, 94) */				\
+/* ALT_##TYPE##_SECTION_END(0, 1) */					\
+	or	1,1,1;							\
+	or	1,1,1;
+
+MAKE_MACRO_TEST(FTR);
+MAKE_MACRO_TEST_EXPECTED(FTR);
+
+#ifdef CONFIG_PPC64
+MAKE_MACRO_TEST(FW_FTR);
+MAKE_MACRO_TEST_EXPECTED(FW_FTR);
+#endif
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 174c1eb..48e1ed8 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -13,6 +13,8 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/init.h>
 #include <asm/cputable.h>
 #include <asm/code-patching.h>
 
@@ -107,3 +109,207 @@ void do_feature_fixups(unsigned long value, void *fixup_start, void *fixup_end)
 		}
 	}
 }
+
+#ifdef CONFIG_FTR_FIXUP_SELFTEST
+
+#define check(x)	\
+	if (!(x)) printk("feature-fixups: test failed at line %d\n", __LINE__);
+
+/* This must be after the text it fixes up, vmlinux.lds.S enforces that atm */
+static struct fixup_entry fixup;
+
+static long calc_offset(struct fixup_entry *entry, unsigned int *p)
+{
+	return (unsigned long)p - (unsigned long)entry;
+}
+
+void test_basic_patching(void)
+{
+	extern unsigned int ftr_fixup_test1;
+	extern unsigned int end_ftr_fixup_test1;
+	extern unsigned int ftr_fixup_test1_orig;
+	extern unsigned int ftr_fixup_test1_expected;
+	int size = &end_ftr_fixup_test1 - &ftr_fixup_test1;
+
+	fixup.value = fixup.mask = 8;
+	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test1 + 1);
+	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test1 + 2);
+	fixup.alt_start_off = fixup.alt_end_off = 0;
+
+	/* Sanity check */
+	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+
+	/* Check we don't patch if the value matches */
+	patch_feature_section(8, &fixup);
+	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+
+	/* Check we do patch if the value doesn't match */
+	patch_feature_section(0, &fixup);
+	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_expected, size) == 0);
+
+	/* Check we do patch if the mask doesn't match */
+	memcpy(&ftr_fixup_test1, &ftr_fixup_test1_orig, size);
+	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_orig, size) == 0);
+	patch_feature_section(~8, &fixup);
+	check(memcmp(&ftr_fixup_test1, &ftr_fixup_test1_expected, size) == 0);
+}
+
+static void test_alternative_patching(void)
+{
+	extern unsigned int ftr_fixup_test2;
+	extern unsigned int end_ftr_fixup_test2;
+	extern unsigned int ftr_fixup_test2_orig;
+	extern unsigned int ftr_fixup_test2_alt;
+	extern unsigned int ftr_fixup_test2_expected;
+	int size = &end_ftr_fixup_test2 - &ftr_fixup_test2;
+
+	fixup.value = fixup.mask = 0xF;
+	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test2 + 1);
+	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test2 + 2);
+	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test2_alt);
+	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test2_alt + 1);
+
+	/* Sanity check */
+	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+
+	/* Check we don't patch if the value matches */
+	patch_feature_section(0xF, &fixup);
+	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+
+	/* Check we do patch if the value doesn't match */
+	patch_feature_section(0, &fixup);
+	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_expected, size) == 0);
+
+	/* Check we do patch if the mask doesn't match */
+	memcpy(&ftr_fixup_test2, &ftr_fixup_test2_orig, size);
+	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_orig, size) == 0);
+	patch_feature_section(~0xF, &fixup);
+	check(memcmp(&ftr_fixup_test2, &ftr_fixup_test2_expected, size) == 0);
+}
+
+static void test_alternative_case_too_big(void)
+{
+	extern unsigned int ftr_fixup_test3;
+	extern unsigned int end_ftr_fixup_test3;
+	extern unsigned int ftr_fixup_test3_orig;
+	extern unsigned int ftr_fixup_test3_alt;
+	int size = &end_ftr_fixup_test3 - &ftr_fixup_test3;
+
+	fixup.value = fixup.mask = 0xC;
+	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test3 + 1);
+	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test3 + 2);
+	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test3_alt);
+	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test3_alt + 2);
+
+	/* Sanity check */
+	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+
+	/* Expect nothing to be patched, and the error returned to us */
+	check(patch_feature_section(0xF, &fixup) == 1);
+	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(patch_feature_section(0, &fixup) == 1);
+	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+	check(patch_feature_section(~0xF, &fixup) == 1);
+	check(memcmp(&ftr_fixup_test3, &ftr_fixup_test3_orig, size) == 0);
+}
+
+static void test_alternative_case_too_small(void)
+{
+	extern unsigned int ftr_fixup_test4;
+	extern unsigned int end_ftr_fixup_test4;
+	extern unsigned int ftr_fixup_test4_orig;
+	extern unsigned int ftr_fixup_test4_alt;
+	extern unsigned int ftr_fixup_test4_expected;
+	int size = &end_ftr_fixup_test4 - &ftr_fixup_test4;
+	unsigned long flag;
+
+	/* Check a high-bit flag */
+	flag = 1UL << ((sizeof(unsigned long) - 1) * 8);
+	fixup.value = fixup.mask = flag;
+	fixup.start_off = calc_offset(&fixup, &ftr_fixup_test4 + 1);
+	fixup.end_off = calc_offset(&fixup, &ftr_fixup_test4 + 5);
+	fixup.alt_start_off = calc_offset(&fixup, &ftr_fixup_test4_alt);
+	fixup.alt_end_off = calc_offset(&fixup, &ftr_fixup_test4_alt + 2);
+
+	/* Sanity check */
+	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+
+	/* Check we don't patch if the value matches */
+	patch_feature_section(flag, &fixup);
+	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+
+	/* Check we do patch if the value doesn't match */
+	patch_feature_section(0, &fixup);
+	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_expected, size) == 0);
+
+	/* Check we do patch if the mask doesn't match */
+	memcpy(&ftr_fixup_test4, &ftr_fixup_test4_orig, size);
+	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_orig, size) == 0);
+	patch_feature_section(~flag, &fixup);
+	check(memcmp(&ftr_fixup_test4, &ftr_fixup_test4_expected, size) == 0);
+}
+
+static void test_alternative_case_with_branch(void)
+{
+	extern unsigned int ftr_fixup_test5;
+	extern unsigned int end_ftr_fixup_test5;
+	extern unsigned int ftr_fixup_test5_expected;
+	int size = &end_ftr_fixup_test5 - &ftr_fixup_test5;
+
+	check(memcmp(&ftr_fixup_test5, &ftr_fixup_test5_expected, size) == 0);
+}
+
+static void test_alternative_case_with_external_branch(void)
+{
+	extern unsigned int ftr_fixup_test6;
+	extern unsigned int end_ftr_fixup_test6;
+	extern unsigned int ftr_fixup_test6_expected;
+	int size = &end_ftr_fixup_test6 - &ftr_fixup_test6;
+
+	check(memcmp(&ftr_fixup_test6, &ftr_fixup_test6_expected, size) == 0);
+}
+
+static void test_cpu_macros(void)
+{
+	extern void ftr_fixup_test_FTR_macros;
+	extern void ftr_fixup_test_FTR_macros_expected;
+	unsigned long size = &ftr_fixup_test_FTR_macros_expected -
+			     &ftr_fixup_test_FTR_macros;
+
+	/* The fixups have already been done for us during boot */
+	check(memcmp(&ftr_fixup_test_FTR_macros,
+		     &ftr_fixup_test_FTR_macros_expected, size) == 0);
+}
+
+static void test_fw_macros(void)
+{
+#ifdef CONFIG_PPC64
+	extern void ftr_fixup_test_FW_FTR_macros;
+	extern void ftr_fixup_test_FW_FTR_macros_expected;
+	unsigned long size = &ftr_fixup_test_FW_FTR_macros_expected -
+			     &ftr_fixup_test_FW_FTR_macros;
+
+	/* The fixups have already been done for us during boot */
+	check(memcmp(&ftr_fixup_test_FW_FTR_macros,
+		     &ftr_fixup_test_FW_FTR_macros_expected, size) == 0);
+#endif
+}
+
+static int __init test_feature_fixups(void)
+{
+	printk(KERN_DEBUG "Running feature fixup self-tests ...\n");
+
+	test_basic_patching();
+	test_alternative_patching();
+	test_alternative_case_too_big();
+	test_alternative_case_too_small();
+	test_alternative_case_with_branch();
+	test_alternative_case_with_external_branch();
+	test_cpu_macros();
+	test_fw_macros();
+
+	return 0;
+}
+late_initcall(test_feature_fixups);
+
+#endif /* CONFIG_FTR_FIXUP_SELFTEST */
-- 
1.5.5
