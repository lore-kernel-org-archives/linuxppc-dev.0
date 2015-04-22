Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABDB51A0317
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Apr 2015 15:36:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Little endian should depend on PPC_BOOK3S_64
Date: Wed, 22 Apr 2015 15:36:50 +1000
Message-Id: <1429681010-32671-1-git-send-email-mpe@ellerman.id.au>
Cc: scottwood@freescale.com, sam.mj@au1.ibm.com,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The only little endian configuration we support is ppc64le, all other
configurations are big endian.

So we should only offer a choice of endian if we're building for 64-bit
Book3S, ie. PPC_BOOK3S_64.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig.cputype | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 7264e91190be..c8ae35f564fd 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -421,6 +421,7 @@ config CPU_BIG_ENDIAN
 
 config CPU_LITTLE_ENDIAN
 	bool "Build little endian kernel"
+	depends on PPC_BOOK3S_64
 	select PPC64_BOOT_WRAPPER
 	help
 	  Build a little endian kernel.
-- 
2.1.0
