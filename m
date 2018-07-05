Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Ls962wHFzF1LY
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 18:54:02 +1000 (AEST)
Message-Id: <e8ab1af859386fe663840843f787bd4d41045529.1530780629.git.christophe.leroy@c-s.fr>
In-Reply-To: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
References: <a272622d3444a1787a0fc4bf61e9192fb0c3cd64.1530780629.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 2/3] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC64
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Thu,  5 Jul 2018 08:53:59 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds a test for testing the new assembly strlen() for PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 Untested

 tools/testing/selftests/powerpc/stringloops/Makefile      |  5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h | 12 ++++++++++++
 tools/testing/selftests/powerpc/stringloops/strlen_64.S   |  1 +
 3 files changed, 17 insertions(+), 1 deletion(-)
 create mode 120000 tools/testing/selftests/powerpc/stringloops/strlen_64.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 2f0bd203e18a..bff66284375c 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -16,9 +16,12 @@ $(OUTPUT)/string.o: string.c
 $(OUTPUT)/strlen_32: strlen.c
 $(OUTPUT)/strlen_32: CFLAGS += -m32
 
+$(OUTPUT)/strlen_64: strlen.c
+$(OUTPUT)/strlen_64: CFLAGS += -m64
+
 ASFLAGS = $(CFLAGS)
 
-TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32
+TEST_GEN_PROGS := memcmp_32 memcmp_64 strlen strlen_32 strlen_64
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 161a7ee54005..891092990217 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#ifdef __LITTLE_ENDIAN__
+#define CONFIG_CPU_LITTLE_ENDIAN
+#else
+#define CONFIG_CPU_BIG_ENDIAN
+#endif
 
 #include <ppc-asm.h>
 
@@ -15,4 +20,11 @@
 #define PPC_ROTLI	rotlwi
 #define PPC_CNTLZL	cntlzw
 #define PPC_SRLI	srwi
+#else
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#define PPC_CNTLZL	cntlzd
+#define PPC_SRLI	srdi
 #endif
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen_64.S b/tools/testing/selftests/powerpc/stringloops/strlen_64.S
new file mode 120000
index 000000000000..d720a2766ec3
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen_64.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/strlen_64.S
\ No newline at end of file
-- 
2.13.3
