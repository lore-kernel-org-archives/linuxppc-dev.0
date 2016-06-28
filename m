Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdtwS3MN4zDqmM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 15:02:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/pseries: HVC early debug options should depend on
 HVC_CONSOLE
Date: Tue, 28 Jun 2016 15:02:46 +1000
Message-Id: <1467090166-10261-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The pseries HVC early debug options, CONFIG_PPC_EARLY_DEBUG_LPAR and
CONFIG_PPC_EARLY_DEBUG_LPAR_HVSI both require code that is part of the
hvc driver. If we turn them on but not CONFIG_HVC_CONSOLE then we get:

  arch/powerpc/kernel/built-in.o: In function `.udbg_early_init':
  arch/powerpc/kernel/built-in.o:(.debug_addr+0x9a00): undefined reference to `udbg_init_debug_lpar'

Similarly for HVSI. So make them both depend on CONFIG_HVC_CONSOLE.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig.debug | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index d3fcf7e64e3a..cfe08eab90c6 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -149,14 +149,14 @@ config PPC_EARLY_DEBUG_BOOTX
 
 config PPC_EARLY_DEBUG_LPAR
 	bool "LPAR HV Console"
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES && HVC_CONSOLE
 	help
 	  Select this to enable early debugging for a machine with a HVC
 	  console on vterm 0.
 
 config PPC_EARLY_DEBUG_LPAR_HVSI
 	bool "LPAR HVSI Console"
-	depends on PPC_PSERIES
+	depends on PPC_PSERIES && HVC_CONSOLE
 	help
 	  Select this to enable early debugging for a machine with a HVSI
 	  console on a specified vterm.
-- 
2.5.0
