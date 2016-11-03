Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8YK158L8zDvQQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 16:23:17 +1100 (AEDT)
Date: Thu, 3 Nov 2016 16:20:32 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/4] selftests/powerpc/64: Test all paths through copy routines
Message-ID: <20161103052032.GD8368@fergus.ozlabs.ibm.com>
References: <20161103051949.GC8368@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161103051949.GC8368@fergus.ozlabs.ibm.com>
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
 arch/powerpc/lib/copyuser_power7.S                 | 21 ++++++++-------
 arch/powerpc/lib/memcpy_64.S                       |  9 +++++--
 arch/powerpc/lib/memcpy_power7.S                   | 22 ++++++++--------
 tools/testing/selftests/powerpc/copyloops/Makefile | 30 +++++++++++++++++-----
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      | 21 ++++++++-------
 6 files changed, 68 insertions(+), 42 deletions(-)

diff --git a/arch/powerpc/lib/copyuser_64.S b/arch/powerpc/lib/copyuser_64.S
index 1c5247c..668d816 100644
--- a/arch/powerpc/lib/copyuser_64.S
+++ b/arch/powerpc/lib/copyuser_64.S
@@ -10,6 +10,11 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 
+#ifndef SELFTEST_CASE
+/* 0 == most CPUs, 1 == POWER6, 2 == Cell */
+#define SELFTEST_CASE	0
+#endif
+
 #ifdef __BIG_ENDIAN__
 #define sLd sld		/* Shift towards low-numbered address. */
 #define sHd srd		/* Shift towards high-numbered address. */
@@ -77,6 +82,7 @@ _GLOBAL(__copy_tofrom_user_base)
  * At the time of writing the only CPU that has this combination of bits
  * set is Power6.
  */
+test_feature = (SELFTEST_CASE == 1)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
@@ -86,6 +92,7 @@ ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
 .Ldst_aligned:
 	addi	r3,r3,-16
 r3_offset = 16
+test_feature = (SELFTEST_CASE == 0)
 BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
diff --git a/arch/powerpc/lib/copyuser_power7.S b/arch/powerpc/lib/copyuser_power7.S
index da0c568..b2f7211 100644
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
@@ -92,7 +97,6 @@
 
 
 _GLOBAL(__copy_tofrom_user_power7)
-#ifdef CONFIG_ALTIVEC
 	cmpldi	r5,16
 	cmpldi	cr1,r5,4096
 
@@ -101,16 +105,11 @@ _GLOBAL(__copy_tofrom_user_power7)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
 
 	blt	.Lshort_copy
-	bgt	cr1,.Lvmx_copy
-#else
-	cmpldi	r5,16
 
-	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
-	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
-
-	blt	.Lshort_copy
-#endif
+test_feature = SELFTEST_CASE
+BEGIN_FTR_SECTION
+	bgt	cr1,.Lvmx_copy
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC_COMP)
 
 .Lnonvmx_copy:
 	/* Get the source 8B aligned */
@@ -290,8 +289,8 @@ err1;	stb	r0,0(r3)
 	addi	r1,r1,STACKFRAMESIZE
 	b	.Lnonvmx_copy
 
-#ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
+#ifdef CONFIG_ALTIVEC
 	mflr	r0
 	std	r0,16(r1)
 	stdu	r1,-STACKFRAMESIZE(r1)
diff --git a/arch/powerpc/lib/memcpy_64.S b/arch/powerpc/lib/memcpy_64.S
index f4d6088..ea363ad 100644
--- a/arch/powerpc/lib/memcpy_64.S
+++ b/arch/powerpc/lib/memcpy_64.S
@@ -10,6 +10,11 @@
 #include <asm/ppc_asm.h>
 #include <asm/export.h>
 
+#ifndef SELFTEST_CASE
+/* For big-endian, 0 == most CPUs, 1 == POWER6, 2 == Cell */
+#define SELFTEST_CASE	0
+#endif
+
 	.align	7
 _GLOBAL_TOC(memcpy)
 BEGIN_FTR_SECTION
@@ -19,9 +24,7 @@ BEGIN_FTR_SECTION
 	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)	/* save destination pointer for return value */
 #endif
 FTR_SECTION_ELSE
-#ifndef SELFTEST
 	b	memcpy_power7
-#endif
 ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
 #ifdef __LITTLE_ENDIAN__
 	/* dumb little-endian memcpy that will get replaced at runtime */
@@ -45,6 +48,7 @@ ALT_FTR_SECTION_END_IFCLR(CPU_FTR_VMX_COPY)
    cleared.
    At the time of writing the only CPU that has this combination of bits
    set is Power6. */
+test_feature = (SELFTEST_CASE == 1)
 BEGIN_FTR_SECTION
 	nop
 FTR_SECTION_ELSE
@@ -53,6 +57,7 @@ ALT_FTR_SECTION_END(CPU_FTR_UNALIGNED_LD_STD | CPU_FTR_CP_USE_DCBTZ, \
                     CPU_FTR_UNALIGNED_LD_STD)
 .Ldst_aligned:
 	addi	r3,r3,-16
+test_feature = (SELFTEST_CASE == 0)
 BEGIN_FTR_SECTION
 	andi.	r0,r4,7
 	bne	.Lsrc_unaligned
diff --git a/arch/powerpc/lib/memcpy_power7.S b/arch/powerpc/lib/memcpy_power7.S
index 786234f..c4f4e3b 100644
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
@@ -29,21 +32,16 @@ _GLOBAL(memcpy_power7)
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
 
-	std	r3,-STACKFRAMESIZE+STK_REG(R31)(r1)
-
-	blt	.Lshort_copy
-#endif
+test_feature = SELFTEST_CASE
+BEGIN_FTR_SECTION
+	bgt	cr1, .Lvmx_copy
+END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC_COMP)
 
 .Lnonvmx_copy:
 	/* Get the source 8B aligned */
@@ -223,8 +221,8 @@ _GLOBAL(memcpy_power7)
 	addi	r1,r1,STACKFRAMESIZE
 	b	.Lnonvmx_copy
 
-#ifdef CONFIG_ALTIVEC
 .Lvmx_copy:
+#ifdef CONFIG_ALTIVEC
 	mflr	r0
 	std	r4,-STACKFRAMESIZE+STK_REG(R30)(r1)
 	std	r5,-STACKFRAMESIZE+STK_REG(R29)(r1)
diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 384843e..1b351c3 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -7,17 +7,35 @@ CFLAGS += -maltivec
 # Use our CFLAGS for the implicit .S rule
 ASFLAGS = $(CFLAGS)
 
-TEST_PROGS := copyuser_64 copyuser_power7 memcpy_64 memcpy_power7
+TEST_PROGS :=	copyuser_64_t0 copyuser_64_t1 copyuser_64_t2 \
+		copyuser_p7_t0 copyuser_p7_t1 \
+		memcpy_64_t0 memcpy_64_t1 memcpy_64_t2 \
+		memcpy_p7_t0 memcpy_p7_t1
+
 EXTRA_SOURCES := validate.c ../harness.c
 
 all: $(TEST_PROGS)
 
-copyuser_64:     CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_base
-copyuser_power7: CPPFLAGS += -D COPY_LOOP=test___copy_tofrom_user_power7
-memcpy_64:       CPPFLAGS += -D COPY_LOOP=test_memcpy
-memcpy_power7:   CPPFLAGS += -D COPY_LOOP=test_memcpy_power7
+copyuser_64_t%:	copyuser_64.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test___copy_tofrom_user_base \
+		-D SELFTEST_CASE=$(subst copyuser_64_t,,$@) -o $@ $^
+
+copyuser_p7_t%:	copyuser_power7.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test___copy_tofrom_user_power7 \
+		-D SELFTEST_CASE=$(subst copyuser_p7_t,,$@) -o $@ $^
+
+# Strictly speaking, we only need the memcpy_64 test cases for big-endian
+memcpy_64_t%:	memcpy_64.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test_memcpy \
+		-D SELFTEST_CASE=$(subst memcpy_64_t,,$@) -o $@ $^
 
-$(TEST_PROGS): $(EXTRA_SOURCES)
+memcpy_p7_t%:	memcpy_power7.S $(EXTRA_SOURCES)
+	$(CC) $(CPPFLAGS) $(CFLAGS) \
+		-D COPY_LOOP=test_memcpy_power7 \
+		-D SELFTEST_CASE=$(subst memcpy_p7_t,,$@) -o $@ $^
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 50ae7d2..7eb0cd6 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -40,17 +40,16 @@ FUNC_START(enter_vmx_copy)
 FUNC_START(exit_vmx_copy)
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
2.10.1
