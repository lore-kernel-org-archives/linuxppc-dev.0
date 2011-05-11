Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 519A5100935
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 11 May 2011 17:42:38 +1000 (EST)
To: <linuxppc-dev@lists.ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-Id: <ed4319ec825be60a30d7ce5fd50654cde2c5829d.1305092637.git.miltonm@bga.com>
In-Reply-To: <cover.1305092637.git.miltonm@bga.com>
References: <cover.1305092637.git.miltonm@bga.com>
From: Milton Miller <miltonm@bga.com>
Date: Wed, 11 May 2011 00:30:07 -0500
Subject: [PATCH 27/37] powerpc fsl_msi: don't abuse platform_data for
	driver_data
Cc: Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The msi platform device driver was abusing dev.platform_data for its
platform_driver_data.  Use the correct pointer for storage.

Platform_data is supposed to be for platforms to communicate to drivers
parameters that are not otherwise discoverable.  Its lifetime matches
the platform_device not the platform device driver.  It is generally
not needed for drivers that only support systems with device trees.

Signed-off-by: Milton Miller <miltonm@bga.com>
---
---
 arch/powerpc/sysdev/fsl_msi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index d5679dc..077776c 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -253,7 +253,7 @@ unlock:
 
 static int fsl_of_msi_remove(struct platform_device *ofdev)
 {
-	struct fsl_msi *msi = ofdev->dev.platform_data;
+	struct fsl_msi *msi = platform_get_drvdata(ofdev);
 	int virq, i;
 	struct fsl_msi_cascade_data *cascade_data;
 
@@ -327,7 +327,7 @@ static int __devinit fsl_of_msi_probe(struct platform_device *dev)
 		dev_err(&dev->dev, "No memory for MSI structure\n");
 		return -ENOMEM;
 	}
-	dev->dev.platform_data = msi;
+	platform_set_drvdata(dev, msi);
 
 	msi->irqhost = irq_alloc_host(dev->dev.of_node, IRQ_HOST_MAP_LINEAR,
 				      NR_MSI_IRQS, &fsl_msi_host_ops, 0);
-- 
1.7.0.4
