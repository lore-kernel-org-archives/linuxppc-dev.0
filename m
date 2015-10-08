Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D479D1A0285
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Oct 2015 08:09:24 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: thuth@redhat.com
Subject: [PATCH 6/6] powerpc/kconfig: Cell CPU options should depend on
 PPC_CELL
Date: Fri,  9 Oct 2015 08:09:17 +1100
Message-Id: <1444338557-14988-6-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
References: <1444338557-14988-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If none of the Cell platforms are enabled then the resulting kernel can
never boot on a Cell machine, and so there's no sense offering to tune
or build for Cell CPUs.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 60b28e63c137..03c53f4418ad 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -91,7 +91,7 @@ config GENERIC_CPU
 
 config CELL_CPU
 	bool "Cell Broadband Engine"
-	depends on PPC_BOOK3S_64 && !CPU_LITTLE_ENDIAN
+	depends on PPC_CELL
 
 config POWER4_CPU
 	bool "POWER4"
@@ -140,7 +140,7 @@ config 6xx
 
 config TUNE_CELL
 	bool "Optimize for Cell Broadband Engine"
-	depends on PPC64 && PPC_BOOK3S
+	depends on PPC_CELL
 	help
 	  Cause the compiler to optimize for the PPE of the Cell Broadband
 	  Engine. This will make the code run considerably faster on Cell
-- 
2.1.4
