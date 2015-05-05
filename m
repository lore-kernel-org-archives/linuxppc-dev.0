Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id AF08E1A0767
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 19:14:09 +1000 (AEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Julian Margetson <runaway@candw.ms>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Subject: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
Date: Tue,  5 May 2015 12:14:03 +0300
Message-Id: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
user can still compile it.

Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index ee5209f..9dca4b9 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -270,6 +270,7 @@ config ATA_PIIX
 config SATA_DWC
 	tristate "DesignWare Cores SATA support"
 	depends on 460EX
+	select DW_DMAC
 	help
 	  This option enables support for the on-chip SATA controller of the
 	  AppliedMicro processor 460EX.
-- 
2.1.4
