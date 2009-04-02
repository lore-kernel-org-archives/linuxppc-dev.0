Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 910F6DDD0B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 08:20:36 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id n32LKW25010850
	for <linuxppc-dev@ozlabs.org>; Thu, 2 Apr 2009 16:20:33 -0500
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/math-emu: Change types to work on ppc64
Date: Thu,  2 Apr 2009 16:20:32 -0500
Message-Id: <1238707232-22313-1-git-send-email-galak@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While normally we don't use the math emulation code on ppc64 it can be
useful for doing things like emulating the embedded FP instructions.

Since performance isn't critical in this scenario its easier to keep
the sizes of the various math-emu the same as on ppc32.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/include/asm/sfp-machine.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/sfp-machine.h b/arch/powerpc/include/asm/sfp-machine.h
index 3d9f831..3a7a67a 100644
--- a/arch/powerpc/include/asm/sfp-machine.h
+++ b/arch/powerpc/include/asm/sfp-machine.h
@@ -29,9 +29,9 @@
 
 /* basic word size definitions */
 #define _FP_W_TYPE_SIZE		32
-#define _FP_W_TYPE		unsigned long
-#define _FP_WS_TYPE		signed long
-#define _FP_I_TYPE		long
+#define _FP_W_TYPE		unsigned int
+#define _FP_WS_TYPE		signed int
+#define _FP_I_TYPE		int
 
 #define __ll_B			((UWtype) 1 << (W_TYPE_SIZE / 2))
 #define __ll_lowpart(t)		((UWtype) (t) & (__ll_B - 1))
-- 
1.5.6.6
