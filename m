Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC5182C007F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 23:20:37 +1000 (EST)
Received: from mail161-ch1 (localhost [127.0.0.1])	by
 mail161-ch1-R.bigfish.com (Postfix) with ESMTP id 6596B1C010A	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:20:32 +0000 (UTC)
Received: from CH1EHSMHS039.bigfish.com (snatpool2.int.messaging.microsoft.com
 [10.43.68.235])	by mail161-ch1.bigfish.com (Postfix) with ESMTP id
 C0C3D200056	for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 13:20:30
 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 tx30smr01.am.freescale.net (8.14.3/8.14.0) with ESMTP id q8JDKQ6E001889	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2012 06:20:27 -0700
From: <b16395@freescale.com>
To: <iommu@lists.linux-foundation.org>, <joerg.roedel@amd.com>,
 <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information pointer in
 archdata.
Date: Wed, 19 Sep 2012 18:47:10 +0530
Message-ID: <1348060632-12997-2-git-send-email-b16395@freescale.com>
In-Reply-To: <1348060632-12997-1-git-send-email-b16395@freescale.com>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
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

From: Varun Sethi <Varun.Sethi@freescale.com>

Add a new field in the device (powerpc) archdata structure for storing iommu domain
information pointer. This pointer is stored when the device is attached to a particular
domain.

Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
---
 arch/powerpc/include/asm/device.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index 77e97dd..6dc79fe 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -28,6 +28,10 @@ struct dev_archdata {
 		void		*iommu_table_base;
 	} dma_data;
 
+	/* IOMMU domain information pointer. This would be set
+	 * when this device is attached to an iommu_domain.
+	 */
+	void			*iommu_domain;
 #ifdef CONFIG_SWIOTLB
 	dma_addr_t		max_direct_dma_addr;
 #endif
-- 
1.7.4.1
