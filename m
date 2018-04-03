Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Ftsv6RvSzF24G
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Apr 2018 01:53:23 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Fix copyloops build since Power4 assembler
 change
Date: Wed,  4 Apr 2018 01:53:18 +1000
Message-Id: <20180403155318.18266-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent commit 15a3204d24a3 ("powerpc/64s: Set assembler machine
type to POWER4") set the machine type in our ASFLAGS when building the
kernel, and removed some ".machine power4" directives from various asm
files.

This broke the selftests build on old toolchains (that don't assume
Power4), because we build the kernel source files into the selftests
using different ASFLAGS.

The fix is simply to add -mpower4 to the selftest ASFLAGS as well.

Fixes: 15a3204d24a3 ("powerpc/64s: Set assembler machine type to POWER4")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/copyloops/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index ac4a52e19e59..eedce3366f64 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -5,8 +5,8 @@ CFLAGS += -I$(CURDIR)
 CFLAGS += -D SELFTEST
 CFLAGS += -maltivec
 
-# Use our CFLAGS for the implicit .S rule
-ASFLAGS = $(CFLAGS)
+# Use our CFLAGS for the implicit .S rule & set the asm machine type
+ASFLAGS = $(CFLAGS) -Wa,-mpower4
 
 TEST_GEN_PROGS := copyuser_64 copyuser_power7 memcpy_64 memcpy_power7
 EXTRA_SOURCES := validate.c ../harness.c
-- 
2.14.1
