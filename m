Return-Path: <nacc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D1EDB70D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 14:35:59 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9R3XX0b003465
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:33:33 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9R3Zh6D196086
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o9R3Zh2o032350
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Oct 2010 21:35:43 -0600
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 1/7 v2] macio: ensure all dma routines get copied over
Date: Tue, 26 Oct 2010 20:35:11 -0700
Message-Id: <1288150518-4026-2-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
References: <1288150518-4026-1-git-send-email-nacc@us.ibm.com>
Cc: sonnyrao@us.ibm.com, miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also add a comment to dev_archdata, indicating that changes there need
to be verified against the driver code.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/include/asm/device.h |    6 ++++++
 drivers/macintosh/macio_asic.c    |    7 +++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/device.h b/arch/powerpc/include/asm/device.h
index a3954e4..16d25c0 100644
--- a/arch/powerpc/include/asm/device.h
+++ b/arch/powerpc/include/asm/device.h
@@ -9,6 +9,12 @@
 struct dma_map_ops;
 struct device_node;
 
+/*
+ * Arch extensions to struct device.
+ *
+ * When adding fields, consider macio_add_one_device in
+ * drivers/macintosh/macio_asic.c
+ */
 struct dev_archdata {
 	/* DMA operations on that device */
 	struct dma_map_ops	*dma_ops;
diff --git a/drivers/macintosh/macio_asic.c b/drivers/macintosh/macio_asic.c
index b6e7ddc..4daf9e5 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -387,11 +387,10 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	/* Set the DMA ops to the ones from the PCI device, this could be
 	 * fishy if we didn't know that on PowerMac it's always direct ops
 	 * or iommu ops that will work fine
+	 *
+	 * To get all the fields, copy all archdata
 	 */
-	dev->ofdev.dev.archdata.dma_ops =
-		chip->lbus.pdev->dev.archdata.dma_ops;
-	dev->ofdev.dev.archdata.dma_data =
-		chip->lbus.pdev->dev.archdata.dma_data;
+	dev->ofdev.dev.archdata = chip->lbus.pdev->dev.archdata;
 #endif /* CONFIG_PCI */
 
 #ifdef DEBUG
-- 
1.7.1
