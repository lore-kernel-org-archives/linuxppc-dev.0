Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412JMd6BCjzDqsx
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 20:20:44 +1000 (AEST)
Message-Id: <a348f4ffda6349467e4270e754d12150fa773462.1528452373.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v4 1/4] selftests/powerpc: add test for 32 bits memcmp
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 wei.guo.simon@gmail.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Fri,  8 Jun 2018 10:20:37 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch renames memcmp test to memcmp_64 and adds
a memcmp_32 test for testing the 32 bits version of memcmp()

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 v4: new

 tools/testing/selftests/powerpc/stringloops/Makefile    |  14 +++++++++++---
 tools/testing/selftests/powerpc/stringloops/memcmp_32   | Bin 0 -> 9092 bytes
 tools/testing/selftests/powerpc/stringloops/memcmp_32.S |   1 +
 3 files changed, 12 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/powerpc/stringloops/memcmp_32
 create mode 120000 tools/testing/selftests/powerpc/stringloops/memcmp_32.S

diff --git a/tools/testing/selftests/powerpc/stringloops/Makefile b/tools/testing/selftests/powerpc/stringloops/Makefile
index 1125e489055e..1e7301d4bac9 100644
--- a/tools/testing/selftests/powerpc/stringloops/Makefile
+++ b/tools/testing/selftests/powerpc/stringloops/Makefile
@@ -1,10 +1,18 @@
 # SPDX-License-Identifier: GPL-2.0
 # The loops are all 64-bit code
-CFLAGS += -m64
 CFLAGS += -I$(CURDIR)
 
-TEST_GEN_PROGS := memcmp
-EXTRA_SOURCES := memcmp_64.S ../harness.c
+EXTRA_SOURCES := ../harness.c
+
+$(OUTPUT)/memcmp_64: memcmp.c
+$(OUTPUT)/memcmp_64: CFLAGS += -m64
+
+$(OUTPUT)/memcmp_32: memcmp.c
+$(OUTPUT)/memcmp_32: CFLAGS += -m32
+
+ASFLAGS = $(CFLAGS)
+
+TEST_GEN_PROGS := memcmp_32 memcmp_64
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp_32 b/tools/testing/selftests/powerpc/stringloops/memcmp_32
new file mode 100755
index 0000000000000000000000000000000000000000..413a02181daf59b0bdd7f0e2e05b74c4c702e7ad
GIT binary patch
literal 9092
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
NWdlI3fToj__kRhC;J5$)

literal 0
HcmV?d00001

diff --git a/tools/testing/selftests/powerpc/stringloops/memcmp_32.S b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
new file mode 120000
index 000000000000..056f2b3af789
--- /dev/null
+++ b/tools/testing/selftests/powerpc/stringloops/memcmp_32.S
@@ -0,0 +1 @@
+../../../../../arch/powerpc/lib/memcmp_32.S
\ No newline at end of file
-- 
2.13.3
