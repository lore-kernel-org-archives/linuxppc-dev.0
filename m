Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1F4571A009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 10:30:48 +1100 (AEDT)
From: Scott Wood <oss@buserror.net>
To: linuxppc-dev@lists.ozlabs.org
Cc: Scott Wood <oss@buserror.net>, Brian Norris <computersforpeace@gmail.com>
Date: Tue,  8 Mar 2016 17:30:36 -0600
Message-Id: <1457479836-31918-1-git-send-email-oss@buserror.net>
Subject: [PATCH] powerpc/fsl: Remove FSL_SOC dependency from FSL_LBC
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This dependency led to kconfig errors when MTD_NAND_FSL_ELBC was
enabled, which selects FSL_LBC, in the absence of FSL_SOC, as reported
in http://patchwork.ozlabs.org/patch/564405/

It was originally suggested to add an FSL_SOC dependency to
MTD_NAND_FSL_ELBC, but the FSL_SOC symbol has been a growing problem
due to hardware being shared between PPC and ARM SoCs.  Even though
eLBC isn't found on ARM SoCs (the newer IFC is used instead), I don't
want to expand the use of FSL_SOC for things other than functions
exported by fsl_soc.c.  In particular, it would be odd to add it to
MTD_NAND_FSL_ELBC and then remove it from MTD_NAND_FSL_IFC.

Removing artificial dependencies also helps get compile-test exposure
via randconfig, allyesconfig, etc.

Reported-by: Brian Norris <computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Scott Wood <oss@buserror.net>
---
 arch/powerpc/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d500772..df42e09 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -774,7 +774,6 @@ config 4xx_SOC
 
 config FSL_LBC
 	bool "Freescale Local Bus support"
-	depends on FSL_SOC
 	help
 	  Enables reporting of errors from the Freescale local bus
 	  controller.  Also contains some common code used by
-- 
2.5.0
