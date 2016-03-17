Return-Path: <afleming@gmail.com>
Received: from mail-oi0-x241.google.com (mail-oi0-x241.google.com
 [IPv6:2607:f8b0:4003:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qQZlx0045zDqWX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Mar 2016 15:15:55 +1100 (AEDT)
Received: by mail-oi0-x241.google.com with SMTP id c129so3782649oif.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 21:15:55 -0700 (PDT)
From: Andy Fleming <afleming@gmail.com>
To: joro@8bytes.org
Cc: iommu@lists.linux-foundation.org, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Fix incorrect PPC32 PAMU dependency
Date: Wed, 16 Mar 2016 23:15:44 -0500
Message-Id: <1458188144-10331-1-git-send-email-afleming@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The Freescale PAMU can be enabled on both 32 and 64-bit Power
chips. Commit 477ab7a19cec8409e4e2dd10e7348e4cac3c06e5
(iommu: Make more drivers depend on COMPILE_TEST)
restricted PAMU to PPC32. PPC covers both.

Signed-off-by: Andy Fleming <afleming@gmail.com>
---

v2: Implemented Michael Ellerman's suggestion to clean up the
    dependency chain

 drivers/iommu/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index a1e75cb..70c79ce 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -57,8 +57,7 @@ config IOMMU_DMA
 
 config FSL_PAMU
 	bool "Freescale IOMMU support"
-	depends on PPC32
-	depends on PPC_E500MC || COMPILE_TEST
+	depends on PPC_E500MC || (COMPILE_TEST && PPC)
 	select IOMMU_API
 	select GENERIC_ALLOCATOR
 	help
-- 
1.9.1
