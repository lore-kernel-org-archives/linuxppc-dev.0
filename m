Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41LrcM70zjzF0wk
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 18:29:07 +1000 (AEST)
Message-Id: <b7fb5fcf7c6ff2c11520571f98ae137058d992bf.1530777873.git.christophe.leroy@c-s.fr>
In-Reply-To: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
References: <9f98f2bd0e9948b8042773f6190c0416d2577b5e.1530777873.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v7 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 08:29:04 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test for testing the new assembly strlen() for PPC32

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v7: reduced the scope to PPC32
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile      |  5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 10 ++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index df663ee9ddb3..2f0bd203e18a 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -13,9 +13,12 @@ $(OUTPUT)/memcmp_32: CFLAGS += -m32
 $(OUTPUT)/strlen: strlen.c string.o
 $(OUTPUT)/string.o: string.c
 
+$(OUTPUT)/strlen_32: strlen.c
+$(OUTPUT)/strlen_32: CFLAGS += -m32
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 136242ec4b0e..161a7ee54005 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +7,12 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifndef __powerpc64__
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#define PPC_CNTLZL	cntlzw
+#define PPC_SRLI	srwi
+#endif
-- 
2.13.3
