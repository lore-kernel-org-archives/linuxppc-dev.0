Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F33F11A0008
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 20:02:21 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] selftests/powerpc: Build the copyloops with -maltivec
Date: Tue, 17 Mar 2015 20:02:18 +1100
Message-Id: <1426582938-11378-1-git-send-email-mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The recent change to remove the vrX defines exposed the fact that we are
building the copyloops tests without altivec enabled. It depends on the
toolchain as to whether altivec is on by default or not, so it only
breaks on some toolchains. But we should always enable it.

Fixes: c2ce6f9f3dc0 ("powerpc: Change vrX register defines to vX to match gcc and glibc")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 tools/testing/selftests/powerpc/copyloops/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/powerpc/copyloops/Makefile b/tools/testing/selftests/powerpc/copyloops/Makefile
index 6f2d3be227f9..9de81296ebc4 100644
--- a/tools/testing/selftests/powerpc/copyloops/Makefile
+++ b/tools/testing/selftests/powerpc/copyloops/Makefile
@@ -2,6 +2,7 @@
 CFLAGS += -m64
 CFLAGS += -I$(CURDIR)
 CFLAGS += -D SELFTEST
+CFLAGS += -maltivec
 
 # Use our CFLAGS for the implicit .S rule
 ASFLAGS = $(CFLAGS)
-- 
2.1.0
