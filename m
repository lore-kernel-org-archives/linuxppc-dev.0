Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe006.messaging.microsoft.com [216.32.180.189])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB0D22C00EB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Mar 2013 05:53:03 +1100 (EST)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: <joro@8bytes.org>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <galak@kernel.crashing.org>, <benh@kernel.crashing.org>,
 <scottwood@freescale.com>, <stuart.yoder@freescale.com>
Subject: [PATCH 2/5 v9] powerpc: Add iommu domain pointer to device archdata
Date: Thu, 14 Mar 2013 00:15:07 +0530
Message-ID: <1363200310-11513-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1363200310-11513-1-git-send-email-Varun.Sethi@freescale.com>
References: <1363200310-11513-1-git-send-email-Varun.Sethi@freescale.com>
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

Add an iommu domain pointer to device (powerpc) archdata.  Devices
are attached to iommu domains and this pointer provides a mechanism
to correlate between a device and the associated iommu domain.  This
field is set when a device is attached to a domain.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/device.h |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 77e97dd..2d5c1c5 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -28,6 +28,12 @@ struct dev_archdata {
 		void		*iommu_table_base;
 	} dma_data;
 
+	/* IOMMU domain information pointer. This would be set
+	 * when this device is attached to an iommu_domain.
+	 */
+#ifdef CONFIG_IOMMU_API
+	void			*iommu_domain;
+#endif
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
-- 
1.7.4.1
