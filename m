Return-Path: <grant.likely@secretlab.ca>
Received: from pd2mo1so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 80FBEDDF88
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Oct 2007 08:58:45 +1000 (EST)
Received: from pd2mr5so.prod.shaw.ca (pd2mr5so-qfe3.prod.shaw.ca [10.0.141.8])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP70093WEFWID80@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:32 -0600 (MDT)
Received: from pn2ml3so.prod.shaw.ca ([10.0.121.147])
	by pd2mr5so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JP700IFXEFMNJ00@pd2mr5so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Sun, 30 Sep 2007 16:57:32 -0600 (MDT)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15
	2004))
	with ESMTP id <0JP70021ZEFL8UJ0@l-daemon> for linuxppc-dev@ozlabs.org;
	Sun, 30 Sep 2007 16:57:21 -0600 (MDT)
Date: Sun, 30 Sep 2007 16:57:21 -0600
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH v2 4/6] Sysace: minor rework and cleanup changes
In-reply-to: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	axboe@kernel.dk
Message-id: <20070930225720.2476.45305.stgit@trillian.cg.shawcable.net>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20070930225112.2476.49914.stgit@trillian.cg.shawcable.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Miscellanious rework to the sysace driver; Not critical, but makes the
subsequent addition of the of_platform bus binding a wee bit cleaner

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/block/xsysace.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/xsysace.c b/drivers/block/xsysace.c
index 555939b..10bb4e5 100644
--- a/drivers/block/xsysace.c
+++ b/drivers/block/xsysace.c
@@ -158,6 +158,9 @@ MODULE_LICENSE("GPL");
 #define ACE_FIFO_SIZE (32)
 #define ACE_BUF_PER_SECTOR (ACE_SECTOR_SIZE / ACE_FIFO_SIZE)
 
+#define ACE_BUS_WIDTH_8  0
+#define ACE_BUS_WIDTH_16 1
+
 struct ace_reg_ops;
 
 struct ace_device {
@@ -931,9 +934,11 @@ static int __devinit ace_setup(struct ace_device *ace)
 {
 	u16 version;
 	u16 val;
-
 	int rc;
 
+	dev_dbg(ace->dev, "ace_setup(ace=0x%p)\n", ace);
+	dev_dbg(ace->dev, "physaddr=0x%lx irq=%i\n", ace->physaddr, ace->irq);
+
 	spin_lock_init(&ace->lock);
 	init_completion(&ace->id_completion);
 
@@ -982,7 +987,7 @@ static int __devinit ace_setup(struct ace_device *ace)
 	snprintf(ace->gd->disk_name, 32, "xs%c", ace->id + 'a');
 
 	/* set bus width */
-	if (ace->bus_width == 1) {
+	if (ace->bus_width == ACE_BUS_WIDTH_16) {
 		/* 0x0101 should work regardless of endianess */
 		ace_out_le16(ace, ACE_BUSMODE, 0x0101);
 
@@ -1117,7 +1122,7 @@ static void __devexit ace_free(struct device *dev)
 static int __devinit ace_probe(struct platform_device *dev)
 {
 	unsigned long physaddr = 0;
-	int bus_width = 1; /* FIXME: should not be hard coded */
+	int bus_width = ACE_BUS_WIDTH_16; /* FIXME: should not be hard coded */
 	int id = dev->id;
 	int irq = NO_IRQ;
 	int i;
@@ -1166,6 +1171,7 @@ static int __init ace_init(void)
 		goto err_blk;
 	}
 
+	pr_debug("xsysace: registering platform binding\n");
 	if ((rc = platform_driver_register(&ace_platform_driver)) != 0)
 		goto err_plat;
 
