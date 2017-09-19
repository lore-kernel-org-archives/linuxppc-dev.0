Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxJPq1Ks2zDqTc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 20:04:30 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id m30so1783886pgn.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 03:04:30 -0700 (PDT)
From: wei.guo.simon@gmail.com
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Simon Guo <wei.guo.simon@gmail.com>
Subject: [PATCH v1 3/3] powerpc:selftest update memcmp selftest according to
 kernel change
Date: Tue, 19 Sep 2017 18:03:59 +0800
Message-Id: <1505815439-18720-4-git-send-email-wei.guo.simon@gmail.com>
In-Reply-To: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Simon Guo <wei.guo.simon@gmail.com>

This patch adjust selftest files related with memcmp so that memcmp
selftest can be compiled successfully.

Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
---
 .../selftests/powerpc/copyloops/asm/ppc_asm.h      |  2 +-
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 31 ++++++++++++++++++++++
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
index 80d34a9..a9da02d 100644
--- a/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/copyloops/asm/ppc_asm.h
@@ -35,7 +35,7 @@
 	li	r3,0
 	blr
 
-FUNC_START(enter_vmx_copy)
+FUNC_START(enter_vmx_ops)
 	li	r3,1
 	blr
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 11bece8..793ee54 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,3 +1,5 @@
+#ifndef _PPC_ASM_H
+#define __PC_ASM_H
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -5,3 +7,32 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#define CONFIG_ALTIVEC
+
+#define R14 r14
+#define R15 r15
+#define R16 r16
+#define R17 r17
+#define R18 r18
+#define R19 r19
+#define R20 r20
+#define R21 r21
+#define R22 r22
+#define R29 r29
+#define R30 r30
+#define R31 r31
+
+#define STACKFRAMESIZE	256
+#define STK_REG(i)	(112 + ((i)-14)*8)
+
+#define _GLOBAL(A) FUNC_START(test_ ## A)
+#define _GLOBAL_TOC(A) _GLOBAL(A)
+
+#define PPC_MTOCRF(A, B)	mtocrf A, B
+
+FUNC_START(enter_vmx_ops)
+	li      r3, 1
+	blr
+
+#endif
-- 
1.8.3.1
