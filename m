Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zrr580MBdzF0lq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Feb 2018 20:35:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] selftests/powerpc: Fix missing clean of pmu/lib.o
Date: Wed, 28 Feb 2018 20:32:57 +1100
Message-Id: <20180228093257.13049-1-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The tm-resched-dscr test links against pmu/lib.o, but we don't have a
rule to clean pmu/lib.o. This can lead to a build break if you build
for big endian and then little, or vice versa.

Fix it by making tm-resched-dscr depend on pmu/lib.c, causing the code
to be built directly in, meaning no .o is generated.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/tm/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index a23453943ad2..5c72ff978f27 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -16,7 +16,7 @@ $(OUTPUT)/tm-syscall: tm-syscall-asm.S
 $(OUTPUT)/tm-syscall: CFLAGS += -I../../../../../usr/include
 $(OUTPUT)/tm-tmspr: CFLAGS += -pthread
 $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
-$(OUTPUT)/tm-resched-dscr: ../pmu/lib.o
+$(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
 $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
 
-- 
2.14.1
