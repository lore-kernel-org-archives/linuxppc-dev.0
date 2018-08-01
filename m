Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gS342ngmzF1mc
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2018 19:01:20 +1000 (AEST)
Message-Id: <eb2eb49e417297cddf85bc1bae59b77f53cb6660.1531511429.git.christophe.leroy@c-s.fr>
In-Reply-To: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1531511429.git.christophe.leroy@c-s.fr>
References: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1531511429.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v8 4/4] selftests/powerpc: update strlen() test to test the
 new assembly function for PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com, segher@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  1 Aug 2018 09:01:16 +0000 (UTC)
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
 v8: removed defines in ppc_asm.h that were added in v6 (not used anymore since v7) ; added missing link to strlen_32.S
 v7: reduced the scope to PPC32
 v6: added additional necessary defines in ppc_asm.h
 v5: no change
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    | 5 ++++-
 tools/testing/selftests/powerpc/stringloops/asm/cache.h | 1 +
 tools/testing/selftests/powerpc/stringloops/strlen_32.S | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/powerpc/stringloops/asm/cache.h
 create mode 120000 tools/testing/selftests/powerpc/stringloops/strlen_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 779b644461c4..9e510de2c07d 100644
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
 
diff --git a/tools/testing/selftests/powerpc/stringloops/asm/cache.h b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
new file mode 100644
index 000000000000..8a2840831122
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/asm/cache.h
@@ -0,0 +1 @@
+#define	IFETCH_ALIGN_BYTES 4
diff --git a/tools/testing/selftests/powerpc/stringloops/strlen_32.S b/tools/testing/selftests/powerpc/stringloops/strlen_32.S
new file mode 120000
index 000000000000..72b13731b24c
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/strlen_32.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/strlen_32.S
\ No newline at end of file
-- 
2.13.3
