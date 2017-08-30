Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xj2GG6D2qzDqMY
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Aug 2017 20:45:26 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: [PATCH] selftests/powerpc: Force ptrace tests to build -fno-pie
Date: Wed, 30 Aug 2017 20:45:12 +1000
Message-Id: <20170830104512.13502-1-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently these tests won't build with a `--enable-default-pie`
compiler as they require r30 to be clobbered. This gives
an error:
  ptrace-tm-spd-gpr.c:41:2: error: PIC register clobbered by 'r30' in 'asm'

This forces these tests to be built no-pie.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 tools/testing/selftests/powerpc/ptrace/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/ptrace/Makefile b/tools/testing/selftests/powerpc/ptrace/Makefile
index fe6bc60dfc..8932263e5a 100644
--- a/tools/testing/selftests/powerpc/ptrace/Makefile
+++ b/tools/testing/selftests/powerpc/ptrace/Makefile
@@ -6,7 +6,7 @@ include ../../lib.mk
 
 all: $(TEST_PROGS)
 
-CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm
+CFLAGS += -m64 -I../../../../../usr/include -I../tm -mhtm -fno-pie
 
 $(TEST_PROGS): ../harness.c ../utils.c ../lib/reg.S ptrace.h
 
-- 
2.11.0
