Return-Path: <grant.likely@secretlab.ca>
Received: from mail-pz0-f201.google.com (mail-pz0-f201.google.com
	[209.85.222.201]) by ozlabs.org (Postfix) with ESMTP id 58F29B87FE
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Mar 2010 05:05:50 +1100 (EST)
Received: by mail-pz0-f201.google.com with SMTP id 39so169281pzk.15
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 10:05:49 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH 21/37] drivers/ata: use .dev.of_node instead of .node in
	struct of_device
To: monstr@monstr.eu, gregkh@suse.de, benh@kernel.crashing.org,
	akpm@linux-foundation.org, davem@davemloft.net,
	sfr@canb.auug.org.au, jgarzik@pobox.com, ben-linux@fluff.org,
	dwmw2@infradead.org, jeremy.kerr@canonical.com,
	James.Bottomley@suse.de, broonie@opensource.wolfsonmicro.com,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux-ide@vger.kernel.org, netdev@vger.kernel.org,
	linux-i2c@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-scsi@vger.kernel.org, alsa-devel@alsa-project.org
Date: Thu, 11 Mar 2010 11:05:44 -0700
Message-ID: <20100311180543.4824.70491.stgit@angua>
In-Reply-To: <20100311174830.4824.19820.stgit@angua>
References: <20100311174830.4824.19820.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

.node is being removed

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 drivers/ata/pata_macio.c       |    2 +-
 drivers/ata/pata_of_platform.c |    2 +-
 drivers/ide/pmac.c             |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/ata/pata_macio.c b/drivers/ata/pata_macio.c
index 4cc7bbd..2cf31e7 100644
--- a/drivers/ata/pata_macio.c
+++ b/drivers/ata/pata_macio.c
@@ -1138,7 +1138,7 @@ static int __devinit pata_macio_attach(struct macio_dev *mdev,
 			"Failed to allocate private memory\n");
 		return -ENOMEM;
 	}
-	priv->node = of_node_get(mdev->ofdev.node);
+	priv->node = of_node_get(mdev->ofdev.dev.of_node);
 	priv->mdev = mdev;
 	priv->dev = &mdev->ofdev.dev;
 
diff --git a/drivers/ata/pata_of_platform.c b/drivers/ata/pata_of_platform.c
index 1f18ad9..19da29f 100644
--- a/drivers/ata/pata_of_platform.c
+++ b/drivers/ata/pata_of_platform.c
@@ -18,7 +18,7 @@ static int __devinit pata_of_platform_probe(struct of_device *ofdev,
 					    const struct of_device_id *match)
 {
 	int ret;
-	struct device_node *dn = ofdev->node;
+	struct device_node *dn = ofdev->dev.of_node;
 	struct resource io_res;
 	struct resource ctl_res;
 	struct resource irq_res;
diff --git a/drivers/ide/pmac.c b/drivers/ide/pmac.c
index 850ee45..9697de9 100644
--- a/drivers/ide/pmac.c
+++ b/drivers/ide/pmac.c
@@ -1152,7 +1152,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 
 	if (macio_resource_count(mdev) == 0) {
 		printk(KERN_WARNING "ide-pmac: no address for %s\n",
-				    mdev->ofdev.node->full_name);
+				    mdev->ofdev.dev.of_node->full_name);
 		rc = -ENXIO;
 		goto out_free_pmif;
 	}
@@ -1160,7 +1160,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 	/* Request memory resource for IO ports */
 	if (macio_request_resource(mdev, 0, "ide-pmac (ports)")) {
 		printk(KERN_ERR "ide-pmac: can't request MMIO resource for "
-				"%s!\n", mdev->ofdev.node->full_name);
+				"%s!\n", mdev->ofdev.dev.of_node->full_name);
 		rc = -EBUSY;
 		goto out_free_pmif;
 	}
@@ -1172,7 +1172,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 	 */
 	if (macio_irq_count(mdev) == 0) {
 		printk(KERN_WARNING "ide-pmac: no intrs for device %s, using "
-				    "13\n", mdev->ofdev.node->full_name);
+				    "13\n", mdev->ofdev.dev.of_node->full_name);
 		irq = irq_create_mapping(NULL, 13);
 	} else
 		irq = macio_irq(mdev, 0);
@@ -1181,7 +1181,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 	regbase = (unsigned long) base;
 
 	pmif->mdev = mdev;
-	pmif->node = mdev->ofdev.node;
+	pmif->node = mdev->ofdev.dev.of_node;
 	pmif->regbase = regbase;
 	pmif->irq = irq;
 	pmif->kauai_fcr = NULL;
@@ -1190,7 +1190,7 @@ pmac_ide_macio_attach(struct macio_dev *mdev, const struct of_device_id *match)
 		if (macio_request_resource(mdev, 1, "ide-pmac (dma)"))
 			printk(KERN_WARNING "ide-pmac: can't request DMA "
 					    "resource for %s!\n",
-					    mdev->ofdev.node->full_name);
+					    mdev->ofdev.dev.of_node->full_name);
 		else
 			pmif->dma_regs = ioremap(macio_resource_start(mdev, 1), 0x1000);
 	} else
