Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40PrcN11tTzF1pD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 00:39:16 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Cc: paulus@samba.org,
	aik@ozlabs.ru
Subject: [PATCH 5/5] powerpc/lib: Add alt patching test of branching past the
 last instruction
Date: Tue, 17 Apr 2018 00:39:05 +1000
Message-Id: <20180416143905.2716-5-mpe@ellerman.id.au>
In-Reply-To: <20180416143905.2716-1-mpe@ellerman.id.au>
References: <20180416143905.2716-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add a test of the relative branch patching logic in the alternate
section feature fixup code. This tests that if we branch past the last
instruction of the alternate section, the branch is not patched.
That's because the assembler will have created a branch that already
points to the first instruction after the patched section, which is
correct and needs no further patching.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/lib/feature-fixups-test.S | 36 ++++++++++++++++++++++++++++++++++
 arch/powerpc/lib/feature-fixups.c      | 11 +++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/powerpc/lib/feature-fixups-test.S b/arch/powerpc/lib/feature-fixups-test.S
index dd05afcbcde3..f16cec989506 100644
--- a/arch/powerpc/lib/feature-fixups-test.S
+++ b/arch/powerpc/lib/feature-fixups-test.S
@@ -171,6 +171,42 @@ globl(ftr_fixup_test6_expected)
 	or	2,2,2
 	or	3,3,3
 
+globl(ftr_fixup_test7)
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
+	bdnz	3b
+1:
+ALT_FTR_SECTION_END(0, 1)
+	or	1,1,1
+	or	1,1,1
+
+globl(end_ftr_fixup_test7)
+	nop
+
+globl(ftr_fixup_test7_expected)
+	or	1,1,1
+2:	b	3f
+3:	or	5,5,5
+	beq	3b
+	b	1f
+	or	6,6,6
+	b	2b
+	bdnz	3b
+1:	or	1,1,1
 
 #if 0
 /* Test that if we have a larger else case the assembler spots it and
diff --git a/arch/powerpc/lib/feature-fixups.c b/arch/powerpc/lib/feature-fixups.c
index 097b45bd9de4..f3e46d4edd72 100644
--- a/arch/powerpc/lib/feature-fixups.c
+++ b/arch/powerpc/lib/feature-fixups.c
@@ -425,6 +425,16 @@ static void test_alternative_case_with_external_branch(void)
 	check(memcmp(ftr_fixup_test6, ftr_fixup_test6_expected, size) == 0);
 }
 
+static void test_alternative_case_with_branch_to_end(void)
+{
+	extern unsigned int ftr_fixup_test7[];
+	extern unsigned int end_ftr_fixup_test7[];
+	extern unsigned int ftr_fixup_test7_expected[];
+	int size = 4 * (end_ftr_fixup_test7 - ftr_fixup_test7);
+
+	check(memcmp(ftr_fixup_test7, ftr_fixup_test7_expected, size) == 0);
+}
+
 static void test_cpu_macros(void)
 {
 	extern u8 ftr_fixup_test_FTR_macros[];
@@ -480,6 +490,7 @@ static int __init test_feature_fixups(void)
 	test_alternative_case_too_small();
 	test_alternative_case_with_branch();
 	test_alternative_case_with_external_branch();
+	test_alternative_case_with_branch_to_end();
 	test_cpu_macros();
 	test_fw_macros();
 	test_lwsync_macros();
-- 
2.14.1
