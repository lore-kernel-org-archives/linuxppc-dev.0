Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qrRkx69rKzDqgb
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2016 04:15:53 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?q?M=C3=A5ns=20Rullg=C3=A5rd?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 06/23] ata: sata_dwc_460ex: select only core part of DMA
 driver
Date: Thu, 21 Apr 2016 21:15:27 +0300
Message-Id: <1461262544-115408-7-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1461262544-115408-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There is no need to have a platform driver compiled since the DMA driver is
used as a library.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index cfa936a..7c6e43a 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -314,7 +314,7 @@ config ATA_PIIX
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
 	depends on 460EX
-	select DW_DMAC
+	select DW_DMAC_CORE
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
-- 
2.8.0.rc3
