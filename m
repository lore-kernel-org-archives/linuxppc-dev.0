Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qvHFN2vV5zDqBK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 19:03:36 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Subject: [PATCH v2 15/23] ata: sata_dwc_460ex: get rid of incorrect cast
Date: Tue, 26 Apr 2016 12:03:16 +0300
Message-Id: <1461661404-1952-16-git-send-email-andriy.shevchenko@linux.intel.com>
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

The (void *__iomem) cast is wrong.  Change the target type of the
"base" pointer to void __iomem instead and drop the cast.

Tested-by: Christian Lamparter <chunkeey@googlemail.com>
Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/ata/sata_dwc_460ex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index 2912e4d..90e3e14 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1219,7 +1219,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	struct sata_dwc_device *hsdev;
 	u32 idr, versionr;
 	char *ver = (char *)&versionr;
-	u8 __iomem *base;
+	void __iomem *base;
 	int err = 0;
 	int irq;
 	struct ata_host *host;
@@ -1246,7 +1246,7 @@ static int sata_dwc_probe(struct platform_device *ofdev)
 	dev_dbg(&ofdev->dev, "ioremap done for SATA register address\n");
 
 	/* Synopsys DWC SATA specific Registers */
-	hsdev->sata_dwc_regs = (void *__iomem)(base + SATA_DWC_REG_OFFSET);
+	hsdev->sata_dwc_regs = base + SATA_DWC_REG_OFFSET;
 
 	/* Setup port */
 	host->ports[0]->ioaddr.cmd_addr = base;
-- 
2.8.0.rc3
