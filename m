Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41hjYB24rSzF2D8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Aug 2018 20:13:18 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 41hjY974sYz9ryn
 for <linuxppc-dev@ozlabs.org>; Fri,  3 Aug 2018 20:13:17 +1000 (AEST)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/4] selftests/powerpc/64: Test all paths through copy
 routines
Date: Fri,  3 Aug 2018 20:13:04 +1000
Message-Id: <1533291186-5374-3-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
References: <1533291186-5374-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The hand-coded assembler 64-bit copy routines include feature sections
that select one code path or another depending on which CPU we are
executing on.  The self-tests for these copy routines end up testing
just one path.  This adds a mechanism for selecting any desired code
path at compile time, and makes 2 or 3 versions of each test, each
using a different code path, so as to cover all the possible paths.

Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
---
 arch/powerpc/lib/copyuser_64.S                     |  7 +++++
 arch/powerpc/lib/copyuser_power7.S                 | 21 ++++++-------
 arch/powerpc/lib/memcpy_64.S                       |  9 ++++--
 arch/powerpc/lib/memcpy_power7.S                   | 22 +++++++-------
 .../testing/selftests/powerpc/copyloops/.gitignore | 14 ++++++---
 tools/testing/selftests/powerpc/copyloops/Makefile | 34 ++++++++++++++++++----
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      | 21 +++++++------
 7 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 8c5033c..2197a35 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -12,6 +12,11 @@
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 
+#ifndef SELFTEST_CASE
+/* 0 == most CPUs, 1 == POWER6, 2 == Cell */
+#define SELFTEST_CASE	0
+#endif
+
 #ifdef __BIG_ENDIAN__
 #define sLd sld		/* Shift towards low-numbered address. */
 #define sHd srd		/* Shift towards high-numbered address. */
@@ -73,6 +78,7 @@ _GLOBAL(__copy_tofrom_user_base)
  * At the time of writing the only CPU that has this combination of bits
  * set is Power6.
  */
+test_feature = (SELFTEST_CASE == 1)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
@@ -82,6 +88,7 @@ ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
 .Ldst_aligned:
 	addi	r3,r3,-16
 r3_offset = 16
+test_feature = (SELFTEST_CASE == 0)
 BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index 215e476..1a1fe18 100644
--- a/arch/powerpc/lib/copyuser_power7.S
+++ b/arch/powerpc/lib/copyuser_power7.S
@@ -19,6 +19,11 @@
  */
 #include <asm/ppc_asm.h>
 
+#ifndef SELFTEST_CASE
+/* 0 == don't use VMX, 1 == use VMX */
+#define SELFTEST_CASE	0
+#endif
+
 #ifdef __BIG_ENDIAN__
 #define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
 #define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRA,VRB,VRC
@@ -80,7 +85,6 @@
 
 
 _GLOBAL(__copy_tofrom_user_power7)
-#ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,3328
 
@@ -89,15 +93,12 @@ _GLOBAL(__copy_tofrom_user_power7)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 
 	blt	.Lshort_copy
-	bge	cr1,.Lvmx_copy
-#else
-	cmpldi	r5,16
 
-	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
-	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
-
-	blt	.Lshort_copy
+#ifdef CONFIG_ALTIVEC
+test_feature = SELFTEST_CASE
+BEGIN_FTR_SECTION
+	bgt	cr1,.Lvmx_copy
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 
 .Lnonvmx_copy:
@@ -278,8 +279,8 @@ err1;	stb	r0,0(r3)
 	addi	r1,r1,STACKFRAMESIZE
 	b	.Lnonvmx_copy
 
-#ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
+#ifdef CONFIG_ALTIVEC
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index 94650d6..273ea67 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -12,6 +12,11 @@
 #include <asm/asm-compat.h>
 #include <asm/feature-fixups.h>
 
+#ifndef SELFTEST_CASE
+/* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
+#define SELFTEST_CASE	0
+#endif
+
 	.align	7
 _GLOBAL_TOC(memcpy)
 BEGIN_FTR_SECTION
@@ -22,10 +27,8 @@ BEGIN_FTR_SECTION
 #endif
 FTR_SECTION_ELSE
 #ifdef CONFIG_PPC_BOOK3S_64
-#ifndef SELFTEST
 	b	memcpy_power7
 #endif
-#endif
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 #ifdef __LITTLE_ENDIAN__
 	/* dumb little-endian memcpy that will get replaced at runtime */
@@ -49,6 +52,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
    cleared.
    At the time of writing the only CPU that has this combination of bits
    set is Power6. */
+test_feature = (SELFTEST_CASE == 1)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
@@ -57,6 +61,7 @@ ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
                     CPU_FTR_UNALIGNED_LD_STD)
 .Ldst_aligned:
 	addi	r3,r3,-16
+test_feature = (SELFTEST_CASE == 0)
 BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 070cdf6..89bfefc 100644
--- a/arch/powerpc/lib/memcpy_power7.S
+++ b/arch/powerpc/lib/memcpy_power7.S
@@ -19,7 +19,10 @@
  */
 #include <asm/ppc_asm.h>
 
-_GLOBAL(memcpy_power7)
+#ifndef SELFTEST_CASE
+/* 0 == don't use VMX, 1 == use VMX */
+#define SELFTEST_CASE	0
+#endif
 
 #ifdef __BIG_ENDIAN__
 #define LVS(VRT,RA,RB)		lvsl	VRT,RA,RB
@@ -29,20 +32,17 @@ _GLOBAL(memcpy_power7)
 #define VPERM(VRT,VRA,VRB,VRC)	vperm	VRT,VRB,VRA,VRC
 #endif
 
-#ifdef CONFIG_ALTIVEC
+_GLOBAL(memcpy_power7)
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
-
 	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-
 	blt	.Lshort_copy
-	bgt	cr1,.Lvmx_copy
-#else
-	cmpldi	r5,16
-
-	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
 
-	blt	.Lshort_copy
+#ifdef CONFIG_ALTIVEC
+test_feature = SELFTEST_CASE
+BEGIN_FTR_SECTION
+	bgt	cr1, .Lvmx_copy
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
 
 .Lnonvmx_copy:
@@ -223,8 +223,8 @@ _GLOBAL(memcpy_power7)
 	addi	r1,r1,STACKFRAMESIZE
 	b	.Lnonvmx_copy
 
-#ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
+#ifdef CONFIG_ALTIVEC
 	mflr	r0
 	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
diff --git a/tools/testing/selftests/powerpc/copyloops/.gitignore b/tools/testing/selftests/powerpc/copyloops/.gitignore
index 25a192f..bc6c4ba 100644
--- a/tools/testing/selftests/powerpc/copyloops/.gitignore
+++ b/tools/testing/selftests/powerpc/copyloops/.gitignore
@@ -1,4 +1,10 @@
-copyuser_64
-copyuser_power7
-memcpy_64
-memcpy_power7
+copyuser_64_t0
+copyuser_64_t1
+copyuser_64_t2
+copyuser_power7_t0
+copyuser_power7_t1
+memcpy_64_t0
+memcpy_64_t1
+memcpy_64_t2
+memcpy_power7_t0
+memcpy_power7_t1
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index eedce33..9a5b0d2 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -8,14 +8,36 @@ CFLAGS += -maltivec
 # Use our CFLAGS for the implicit .S rule & set the asm machine type
 ASFLAGS = $(CFLAGS) -Wa,-mpower4
 
-TEST_GEN_PROGS := copyuser_64 copyuser_power7 memcpy_64 memcpy_power7
+TEST_GEN_PROGS := copyuser_64_t0 copyuser_64_t1 copyuser_64_t2 \
+		copyuser_p7_t0 copyuser_p7_t1 \
+		memcpy_64_t0 memcpy_64_t1 memcpy_64_t2 \
+		memcpy_p7_t0 memcpy_p7_t1
+
 EXTRA_SOURCES := validate.c ../harness.c
 
 include ../../lib.mk
 
-$(OUTPUT)/copyuser_64:     CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_base
-$(OUTPUT)/copyuser_power7: CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_power7
-$(OUTPUT)/memcpy_64:       CPPFLAGS += -D COPY_LOOP=test_memcpy
-$(OUTPUT)/memcpy_power7:   CPPFLAGS += -D COPY_LOOP=test_memcpy_power7
+$(OUTPUT)/copyuser_64_t%:	copyuser_64.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test___copy_tofrom_user_base \
+		-D SELFTEST_CASE=$(subst copyuser_64_t,,$(notdir $@)) \
+		-o $@ $^
+
+$(OUTPUT)/copyuser_p7_t%:	copyuser_power7.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test___copy_tofrom_user_power7 \
+		-D SELFTEST_CASE=$(subst copyuser_p7_t,,$(notdir $@)) \
+		-o $@ $^
+
+# Strictly speaking, we only need the memcpy_64 test cases for big-endian
+$(OUTPUT)/memcpy_64_t%:	memcpy_64.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test_memcpy \
+		-D SELFTEST_CASE=$(subst memcpy_64_t,,$(notdir $@)) \
+		-o $@ $^
 
-$(TEST_GEN_PROGS): $(EXTRA_SOURCES)
+$(OUTPUT)/memcpy_p7_t%:	memcpy_power7.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test_memcpy_power7 \
+		-D SELFTEST_CASE=$(subst memcpy_p7_t,,$(notdir $@)) \
+		-o $@ $^
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index dfce161..91bc403 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -43,17 +43,16 @@ FUNC_START(enter_vmx_ops)
 FUNC_START(exit_vmx_ops)
 	blr
 
-FUNC_START(memcpy_power7)
-	blr
-
-FUNC_START(__copy_tofrom_user_power7)
-	blr
-
 FUNC_START(__copy_tofrom_user_base)
 	blr
 
-#define BEGIN_FTR_SECTION
-#define FTR_SECTION_ELSE
-#define ALT_FTR_SECTION_END_IFCLR(x)
-#define ALT_FTR_SECTION_END(x, y)
-#define END_FTR_SECTION_IFCLR(x)
+#define BEGIN_FTR_SECTION		.if test_feature
+#define FTR_SECTION_ELSE		.else
+#define ALT_FTR_SECTION_END_IFCLR(x)	.endif
+#define ALT_FTR_SECTION_END_IFSET(x)	.endif
+#define ALT_FTR_SECTION_END(x, y)	.endif
+#define END_FTR_SECTION_IFCLR(x)	.endif
+#define END_FTR_SECTION_IFSET(x)	.endif
+
+/* Default to taking the first of any alternative feature sections */
+test_feature = 1
-- 
2.7.4
