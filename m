Return-Path: <varuns@nmglablinux27.zin33.ap.freescale.net>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7BC0B2C0373
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 22:00:31 +1000 (EST)
Received: from mail205-co1 (localhost [127.0.0.1])	by
 mail205-co1-R.bigfish.com (Postfix) with ESMTP id E0263140058	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 12:00:24 +0000 (UTC)
Received: from CO1EHSMHS020.bigfish.com (unknown [10.243.78.236])	by
 mail205-co1.bigfish.com (Postfix) with ESMTP id E443BC80061	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2012 12:00:22 +0000 (UTC)
Received: from nmglablinux27.zin33.ap.freescale.net ([10.213.130.145])	by
 az84smr01.freescale.net (8.14.3/8.14.0) with ESMTP id q94C0IxG021127	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Oct 2012 05:00:19 -0700
From: <b16395@freescale.com>
To: <joerg.roedel@amd.com>, <iommu@lists.linux-foundation.org>,
 <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3 v2] iommu/fsl: Store iommu domain information pointer in
 archdata.
Date: Thu, 4 Oct 2012 17:26:46 +0530
Message-ID: <1349351808-7156-2-git-send-email-b16395@freescale.com>
In-Reply-To: <1349351808-7156-1-git-send-email-b16395@freescale.com>
References: <1349351808-7156-1-git-send-email-b16395@freescale.com>
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
