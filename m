Return-Path: <nacc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8A46DB71B9
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  9 Oct 2010 04:33:31 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o98HIcZP011964
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:18:38 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o98HXSCi378106
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 13:33:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o98HXQU3032339
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Oct 2010 14:33:27 -0300
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 01/11] macio: ensure all dma routines get copied over
Date: Fri,  8 Oct 2010 10:33:02 -0700
Message-Id: <1286559192-10898-2-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, miltonm@bga.com,
	Andreas Schwab <schwab@linux-m68k.org>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
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
index b6e7ddc..18bf7a9 100644
--- a/drivers/macintosh/macio_asic.c
+++ b/drivers/macintosh/macio_asic.c
@@ -387,11 +387,10 @@ static struct macio_dev * macio_add_one_device(struct macio_chip *chip,
 	/* Set the DMA ops to the ones from the PCI device, this could be
 	 * fishy if we didn't know that on PowerMac it's always direct ops
 	 * or iommu ops that will work fine
+         *
+         * To get all the fields, copy all archdata
 	 */
-	dev->ofdev.dev.archdata.dma_ops =
-		chip->lbus.pdev->dev.archdata.dma_ops;
-	dev->ofdev.dev.archdata.dma_data =
-		chip->lbus.pdev->dev.archdata.dma_data;
+        dev->ofdev.dev.archdata = chip->lbus.pdev->dev.archdata;
 #endif /* CONFIG_PCI */
 
 #ifdef DEBUG
-- 
1.7.1
