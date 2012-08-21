Return-Path: <abounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 756542C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Aug 2012 00:24:59 +1000 (EST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] rapidio/tsi721: modify mport name assignment
Date: Tue, 21 Aug 2012 10:23:54 -0400
Message-Id: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify mport device name assignment to provide clear reference to devices
in systems with multiple Tsi721 bridges.

This patch is applicable to kernel versions starting from v3.2.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
---
 drivers/rapidio/devices/tsi721.c |    3 ++-
 include/linux/rio.h              |    3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 5d44252..8533f36 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -2165,7 +2165,8 @@ static int __devinit tsi721_setup_mport(struct tsi721_device *priv)
 	rio_init_dbell_res(&mport->riores[RIO_DOORBELL_RESOURCE], 0, 0xffff);
 	rio_init_mbox_res(&mport->riores[RIO_INB_MBOX_RESOURCE], 0, 3);
 	rio_init_mbox_res(&mport->riores[RIO_OUTB_MBOX_RESOURCE], 0, 3);
-	strcpy(mport->name, "Tsi721 mport");
+	snprintf(mport->name, RIO_MAX_MPORT_NAME, "%s(%s)",
+		 dev_driver_string(&pdev->dev), dev_name(&pdev->dev));
 
 	/* Hook up interrupt handler */
 
diff --git a/include/linux/rio.h b/include/linux/rio.h
index a90ebad..1a7b6c7 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -30,6 +30,7 @@
 #define RIO_MAX_MPORTS		8
 #define RIO_MAX_MPORT_RESOURCES	16
 #define RIO_MAX_DEV_RESOURCES	16
+#define RIO_MAX_MPORT_NAME	40
 
 #define RIO_GLOBAL_TABLE	0xff	/* Indicates access of a switch's
 					   global routing table if it
@@ -255,7 +256,7 @@ struct rio_mport {
 				 */
 	enum rio_phy_type phy_type;	/* RapidIO phy type */
 	u32 phys_efptr;
-	unsigned char name[40];
+	unsigned char name[RIO_MAX_MPORT_NAME];
 	void *priv;		/* Master port private data */
 #ifdef CONFIG_RAPIDIO_DMA_ENGINE
 	struct dma_device	dma;
-- 
1.7.8.4
