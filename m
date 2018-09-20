Return-Path: <madalin.bucur@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42GL1h4hwFzF3PD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Sep 2018 01:17:12 +1000 (AEST)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: leoyang.li@nxp.com
Cc: roy.pledge@nxp.com, claudiu.manoil@nxp.com, catalin.marinas@arm.com,
 oss@buserror.net, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH 2/4] soc/fsl/qbman: Add 64 bit DMA addressing requirement to
 QBMan
Date: Thu, 20 Sep 2018 18:06:49 +0300
Message-Id: <1537456011-10769-3-git-send-email-madalin.bucur@nxp.com>
In-Reply-To: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
References: <1537456011-10769-1-git-send-email-madalin.bucur@nxp.com>
Reply-to: madalin.bucur@nxp.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Roy Pledge <roy.pledge@nxp.com>

The QBMan block is memory mapped on SoCs above a 32 bit (4 Gigabyte)
boundary so enabling 64 bit DMA addressing is needed for QBMan to
be usable.

Signed-off-by: Roy Pledge <roy.pledge@nxp.com>
Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/soc/fsl/qbman/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/fsl/qbman/Kconfig b/drivers/soc/fsl/qbman/Kconfig
index d570cb5fd381..19d6f4621e23 100644
--- a/drivers/soc/fsl/qbman/Kconfig
+++ b/drivers/soc/fsl/qbman/Kconfig
@@ -1,6 +1,6 @@
 menuconfig FSL_DPAA
 	bool "QorIQ DPAA1 framework support"
-	depends on (FSL_SOC_BOOKE || ARCH_LAYERSCAPE)
+	depends on ((FSL_SOC_BOOKE || ARCH_LAYERSCAPE || ARM) && ARCH_DMA_ADDR_T_64BIT)
 	select GENERIC_ALLOCATOR
 	help
 	  The Freescale Data Path Acceleration Architecture (DPAA) is a set of
-- 
2.1.0
