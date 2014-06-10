Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 22E571A00D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 22:23:17 +1000 (EST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/4] selftests/powerpc: Fix instruction loop for ABIv2 (LE)
Date: Tue, 10 Jun 2014 22:23:07 +1000
Message-Id: <1402402990-31925-1-git-send-email-mpe@ellerman.id.au>
Cc: sam.bobroff@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/pmu/loop.S | 73 ++++++++++++++----------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/powerpc/pmu/loop.S b/tools/testing/selftests/powerpc/pmu/loop.S
index 8820e3d..20c1f08 100644
--- a/tools/testing/selftests/powerpc/pmu/loop.S
+++ b/tools/testing/selftests/powerpc/pmu/loop.S
@@ -3,44 +3,41 @@
  * Licensed under GPLv2.
  */
 
+#include <ppc-asm.h>
+
 	.text
 
-	.global thirty_two_instruction_loop
-	.type .thirty_two_instruction_loop,@function
-	.section ".opd","aw",@progbits
-thirty_two_instruction_loop:
-	.quad .thirty_two_instruction_loop, .TOC.@tocbase, 0
-	.previous
-.thirty_two_instruction_loop:
-	cmpwi	%r3,0
+FUNC_START(thirty_two_instruction_loop)
+	cmpdi	r3,0
 	beqlr
-	addi	%r4,%r3,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1
-	addi	%r4,%r4,1	# 28 addi's
-	subi	%r3,%r3,1
-	b	.thirty_two_instruction_loop
+	addi	r4,r3,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1
+	addi	r4,r4,1	# 28 addi's
+	subi	r3,r3,1
+	b	FUNC_NAME(thirty_two_instruction_loop)
+FUNC_END(thirty_two_instruction_loop)
-- 
1.9.1
