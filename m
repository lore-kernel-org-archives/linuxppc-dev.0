Return-Path: <afleming@gmail.com>
Received: from mail-ob0-x22e.google.com (mail-ob0-x22e.google.com
 [IPv6:2607:f8b0:4003:c01::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 625C91A0221
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Feb 2016 13:16:21 +1100 (AEDT)
Received: by mail-ob0-x22e.google.com with SMTP id wb13so78421234obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 04 Feb 2016 18:16:21 -0800 (PST)
From: Andy Fleming <afleming@gmail.com>
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Thu,  4 Feb 2016 20:16:06 -0600
Message-Id: <1454638566-1953-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale PAMU can also be enabled on 64-bit power
chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
(iommu: Make more drivers depend on COMPILE_TEST)
added this false dependency. Fixed it by allowing PPC64, too.

Signed-off-by: Andy Fleming <afleming@gmail.com>
---
 drivers/iommu/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a1e75cb..63ec7ae 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -57,7 +57,7 @@ config IOMMU_DMA
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-	depends on PPC32
+	depends on PPC32 || PPC64
 	depends on PPC_E500MC || COMPILE_TEST
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
-- 
1.9.1
