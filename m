Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <5d62a2e5418155ab3108dec454e36ec4a5b14bfb.1289190144.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc: Ensure the else case of feature sections will fit
Date: Mon,  8 Nov 2010 15:22:29 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we create an alternative feature section, the else case must be the
same size or smaller than the body. This is because when we patch the
else case in we just overwrite the body, so there must be room.

Up to now we just did this by inspection, but it's quite easy to enforce
it in the assembler, so we should.

The only change is to add the ifgt block, but that effects the alignment
of the tabs and so the whole macro is modified.

Also add a test, but #if 0 it because we don't want to break the build.
Anyone who's modifying the feature macros should enable the test.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/include/asm/feature-fixups.h |   27 +++++++++++++++------------
 arch/powerpc/lib/feature-fixups-test.S    |   19 +++++++++++++++++++
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index 96a7d06..921a847 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -37,18 +37,21 @@ label##2:						\
 	.align 2;					\
 label##3:
 
-#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)	\
-label##4:						\
-	.popsection;					\
-	.pushsection sect,"a";				\
-	.align 3;					\
-label##5:					       	\
-	FTR_ENTRY_LONG msk;				\
-	FTR_ENTRY_LONG val;				\
-	FTR_ENTRY_OFFSET label##1b-label##5b;		\
-	FTR_ENTRY_OFFSET label##2b-label##5b;	 	\
-	FTR_ENTRY_OFFSET label##3b-label##5b;		\
-	FTR_ENTRY_OFFSET label##4b-label##5b;	 	\
+#define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)		\
+label##4:							\
+	.popsection;						\
+	.pushsection sect,"a";					\
+	.align 3;						\
+label##5:							\
+	FTR_ENTRY_LONG msk;					\
+	FTR_ENTRY_LONG val;					\
+	FTR_ENTRY_OFFSET label##1b-label##5b;			\
+	FTR_ENTRY_OFFSET label##2b-label##5b;			\
+	FTR_ENTRY_OFFSET label##3b-label##5b;			\
+	FTR_ENTRY_OFFSET label##4b-label##5b;			\
+	.ifgt (label##4b-label##3b)-(label##2b-label##1b);	\
+	.error "Feature section else case larger than body";	\
+	.endif;							\
 	.popsection;
 
 
diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index cb73748..f461311 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -172,6 +172,25 @@ globl(ftr_fixup_test6_expected)
 3:	or	3,3,3
 
 
+#if 0
+/* Test that if we have a larger else case the assembler spots it and
+ * reports an error. #if 0'ed so as not to break the build normally.
+ */
+ftr_fixup_test7:
+	or	1,1,1
+BEGIN_FTR_SECTION
+	or	2,2,2
+	or	2,2,2
+	or	2,2,2
+FTR_SECTION_ELSE
+	or	3,3,3
+	or	3,3,3
+	or	3,3,3
+	or	3,3,3
+ALT_FTR_SECTION_END(0, 1)
+	or	1,1,1
+#endif
+
 #define	MAKE_MACRO_TEST(TYPE)						\
 globl(ftr_fixup_test_ ##TYPE##_macros)					\
 	or	1,1,1;							\
-- 
1.7.1
