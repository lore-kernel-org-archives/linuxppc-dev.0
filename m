Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFQ2xBTzDq9q
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:38 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 16/23] ata: sata_dwc_460ex: add __iomem to register base
 pointer
Date: Tue, 26 Apr 2016 12:03:17 +0300
Message-Id: <1461661404-1952-17-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mans Rullgard <mans@mansr.com>

The pointer to the mmio register base is missing the __iomem
annotation.  Fix this.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 90e3e14..25e00f2 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -145,7 +145,7 @@ struct sata_dwc_device {
 	struct ata_probe_ent	*pe;		/* ptr to probe-ent */
 	struct ata_host		*host;
 	u8 __iomem		*reg_base;
-	struct sata_dwc_regs	*sata_dwc_regs;	/* DW Synopsys SATA specific */
+	struct sata_dwc_regs __iomem *sata_dwc_regs;	/* DW SATA specific */
 	u32			sactive_issued;
 	u32			sactive_queued;
 	struct phy		*phy;
-- 
2.8.0.rc3
