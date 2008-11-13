Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 803F3DDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 20:24:50 +1100 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] xsysace: use resource_size_t instead of unsigned long
Date: Thu, 13 Nov 2008 11:43:17 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200811131143.17752.yur@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

This patch adds using resource_size_t for physical address of SystemACE
chip. This makes the driver workable on 32 bit systems with 64-bit resources
(e.g. PPC440SPe).

Signed-off-by: Yuri Tikhonov <yur@emcraft.com>
Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---
 drivers/block/xsysace.c |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index ecab9e6..f847305 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -194,7 +194,7 @@ struct ace_device {
 	int in_irq;
 
 	/* Details of hardware device */
-	unsigned long physaddr;
+	resource_size_t physaddr;
 	void __iomem *baseaddr;
 	int irq;
 	int bus_width;		/* 0 := 8 bit; 1 := 16 bit */
@@ -935,7 +935,7 @@ static int __devinit ace_setup(struct ace_device *ace)
 	int rc;
 
 	dev_dbg(ace->dev, "ace_setup(ace=0x%p)\n", ace);
-	dev_dbg(ace->dev, "physaddr=0x%lx irq=%i\n", ace->physaddr, ace->irq);
+	dev_dbg(ace->dev, "physaddr=0x%llx irq=%i\n", (u64)ace->physaddr, ace->irq);
 
 	spin_lock_init(&ace->lock);
 	init_completion(&ace->id_completion);
@@ -1017,8 +1017,8 @@ static int __devinit ace_setup(struct ace_device *ace)
 	/* Print the identification */
 	dev_info(ace->dev, "Xilinx SystemACE revision %i.%i.%i\n",
 		 (version >> 12) & 0xf, (version >> 8) & 0x0f, version & 0xff);
-	dev_dbg(ace->dev, "physaddr 0x%lx, mapped to 0x%p, irq=%i\n",
-		ace->physaddr, ace->baseaddr, ace->irq);
+	dev_dbg(ace->dev, "physaddr 0x%llx, mapped to 0x%p, irq=%i\n",
+		(u64)ace->physaddr, ace->baseaddr, ace->irq);
 
 	ace->media_change = 1;
 	ace_revalidate_disk(ace->gd);
@@ -1035,8 +1035,8 @@ err_alloc_disk:
 err_blk_initq:
 	iounmap(ace->baseaddr);
 err_ioremap:
-	dev_info(ace->dev, "xsysace: error initializing device at 0x%lx\n",
-	       ace->physaddr);
+	dev_info(ace->dev, "xsysace: error initializing device at 0x%llx\n",
+	       (u64)ace->physaddr);
 	return -ENOMEM;
 }
 
@@ -1059,7 +1059,7 @@ static void __devexit ace_teardown(struct ace_device *ace)
 }
 
 static int __devinit
-ace_alloc(struct device *dev, int id, unsigned long physaddr,
+ace_alloc(struct device *dev, int id, resource_size_t physaddr,
 	  int irq, int bus_width)
 {
 	struct ace_device *ace;
@@ -1119,7 +1119,7 @@ static void __devexit ace_free(struct device *dev)
 
 static int __devinit ace_probe(struct platform_device *dev)
 {
-	unsigned long physaddr = 0;
+	resource_size_t physaddr = 0;
 	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
 	int id = dev->id;
 	int irq = NO_IRQ;
@@ -1165,7 +1165,7 @@ static int __devinit
 ace_of_probe(struct of_device *op, const struct of_device_id *match)
 {
 	struct resource res;
-	unsigned long physaddr;
+	resource_size_t physaddr;
 	const u32 *id;
 	int irq, bus_width, rc;
 
-- 
1.5.6.1

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
