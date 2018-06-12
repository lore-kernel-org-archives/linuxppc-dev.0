Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 414kjv5fb5zF4D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jun 2018 19:14:59 +1000 (AEST)
Message-Id: <3ce192afa184bf3e0f5b949f82b33a3e1fc3f34e.1528791416.git.christophe.leroy@c-s.fr>
In-Reply-To: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
References: <85de16f5629ac9f4a815230cced361908758b53a.1528791416.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v6 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 12 Jun 2018 09:14:55 +0000 (UTC)
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
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 .../testing/selftests/powerpc/stringloops/Makefile |  3 +--
 .../selftests/powerpc/stringloops/asm/cache.h      |  1 +
 .../selftests/powerpc/stringloops/asm/ppc_asm.h    | 30 ++++++++++++++++++++++
 .../testing/selftests/powerpc/stringloops/string.S |  1 +
 4 files changed, 33 insertions(+), 2 deletions(-)
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
index 136242ec4b0e..5226bd8bc39f 100644
--- a/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
+++ b/tools/testing/selftests/powerpc/stringloops/asm/ppc_asm.h
@@ -1,4 +1,18 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#if !defined(CONFIG_PPC64) && !defined(CONFIG_PPC32)
+#ifdef __powerpc64__
+#define CONFIG_PPC64
+#else
+#define CONFIG_PPC32
+#endif
+#endif
+
+#ifdef __LITTLE_ENDIAN__
+#define CONFIG_CPU_LITTLE_ENDIAN
+#else
+#define CONFIG_CPU_BIG_ENDIAN
+#endif
+
 #include <ppc-asm.h>
 
 #ifndef r1
@@ -6,3 +20,19 @@
 #endif
 
 #define _GLOBAL(A) FUNC_START(test_ ## A)
+
+#ifdef __powerpc64__
+#define SZL		8
+#define PPC_LLU		ldu
+#define PPC_LCMPI	cmpldi
+#define PPC_ROTLI	rotldi
+#define PPC_CNTLZL	cntlzd
+#define PPC_SRLI	srdi
+#else
+#define SZL		4
+#define PPC_LLU		lwzu
+#define PPC_LCMPI	cmplwi
+#define PPC_ROTLI	rotlwi
+#define PPC_CNTLZL	cntlzw
+#define PPC_SRLI	srwi
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
