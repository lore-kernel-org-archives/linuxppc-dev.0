Return-Path: <Varun.Sethi@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0106.outbound.protection.outlook.com [207.46.100.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BCEE1A03C3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 May 2015 04:41:27 +1000 (AEST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <jroedel@suse.de>, <joro@8bytes.org>,
 <iommu@lists.linux-foundation.org>, <scottwood@freescale.com>
Subject: [PATCH] iommu/fsl: Fix the dependency check for PAMU driver.
Date: Thu, 14 May 2015 23:11:12 +0530
Message-ID: <1431625272-17869-1-git-send-email-Varun.Sethi@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix the build dependency for the PAMU driver. PPC32 build dependecy is incorrect.
Add the CORENET_GENERIC build dependency for PAMU driver.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 drivers/iommu/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 1ae4e54..4ace8db 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -50,7 +50,7 @@ config OF_IOMMU
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-	depends on PPC32
+	depends on CORENET_GENERIC
 	depends on PPC_E500MC || COMPILE_TEST
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
-- 
1.7.9.5
