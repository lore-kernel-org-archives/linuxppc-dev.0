Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412JMg5trRzDqJl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 20:20:47 +1000 (AEST)
Message-Id: <d840d836f392b890c2e477d059b5a3a511a14631.1528452373.git.christophe.leroy@c-s.fr>
In-Reply-To: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
References: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:20:44 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch modifies the test for testing the new assembly strlen() instead
of the generic strlen()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile |  3 +--
 .../selftests/powerpc/stringloops/asm/cache.h        |  1 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h      | 20 ++++++++++++++++++++
 tools/testing/selftests/powerpc/stringloops/string.S |  1 +
 4 files changed, 23 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/cache.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/string.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index df663ee9ddb3..0c088a6d0369 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -10,8 +10,7 @@ $(OUTPUT)/memcmp_64: CFLAGS += -m64
 $(OUTPUT)/memcmp_32: memcmp.c
 $(OUTPUT)/memcmp_32: CFLAGS += -m32
 
-$(OUTPUT)/strlen: strlen.c string.o
-$(OUTPUT)/string.o: string.c
+$(OUTPUT)/strlen: strlen.c string.S
 
 ASFLAGS = $(CFLAGS)
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/cache.h b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
new file mode 100644
index 000000000000..8a2840831122
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
@@ -0,0 +1 @@
+#define	IFETCH_ALIGN_BYTES 4
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
index 136242ec4b0e..9f8e34ffc131 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_PPC32)
+#ifdef __powerpc64__
+#define CONFIG_PPC64
+#else
+#define CONFIG_PPC32
+#endif
+#endif
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +14,15 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifdef __powerpc64__
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#else
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#endif
diff --git a/tools/testing/selftests/powerpc/stringloops/string.S b/tools/testing/selftests/powerpc/stringloops/string.S
new file mode 120000
index 000000000000..9f5babec7d21
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/string.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/string.S
\ No newline at end of file
-- 
2.13.3
