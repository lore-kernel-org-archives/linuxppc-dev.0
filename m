Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0258DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 14:50:22 +1100 (EST)
From: Kumar Gala <galak@kernel.crashing.org>
To: dwmw2@infradead.org
Subject: [PATCH] mtd: remove dead Kconfig associated with !CONFIG_PPC_MERGE
Date: Thu,  9 Oct 2008 22:50:06 -0500
Message-Id: <1223610606-13096-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Removed the Kconfig associated with 'NDFC NanD Flash Controller'.
We can't enable !CONFIG_PPC_MERGE so there is no way to enable
this.  Additionally the code needs to get updated for arch/powerpc.

For the time being lets just remove the Kconfig option so we can
actually remove CONFIG_PPC_MERGE.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 drivers/mtd/nand/Kconfig |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 41f361c..1acdff7 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -163,13 +163,6 @@ config MTD_NAND_S3C2410_HWECC
 	  incorrect ECC generation, and if using these, the default of
 	  software ECC is preferable.
 
-config MTD_NAND_NDFC
-	tristate "NDFC NanD Flash Controller"
-	depends on 4xx && !PPC_MERGE
-	select MTD_NAND_ECC_SMC
-	help
-	 NDFC Nand Flash Controllers are integrated in IBM/AMCC's 4xx SoCs
-
 config MTD_NAND_S3C2410_CLKSTOP
 	bool "S3C2410 NAND IDLE clock stop"
 	depends on MTD_NAND_S3C2410
-- 
1.5.5.1
