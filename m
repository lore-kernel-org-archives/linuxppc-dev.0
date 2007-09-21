Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id AA412DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Sep 2007 14:41:09 +1000 (EST)
Date: Fri, 21 Sep 2007 14:31:02 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH 02/11] [POWERPC] Simplify vio_bus_init a little for legacy
	iSeries
Message-Id: <20070921143102.eb30d770.sfr@canb.auug.org.au>
In-Reply-To: <20070921142928.64451ad8.sfr@canb.auug.org.au>
References: <20070921135533.461eecdf.sfr@canb.auug.org.au>
	<20070921142928.64451ad8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

iSeries_vio_dev was already statically initialised and we can remove
one set of #ifdef CONFIG_PPC_ISERIES guards.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/vio.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index 54645ba..ee15c22 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -64,6 +64,12 @@ static void __init iommu_vio_init(void)
 		printk("Virtual Bus VETH TCE table failed.\n");
 	if (!iommu_init_table(&vio_iommu_table, -1))
 		printk("Virtual Bus VIO TCE table failed.\n");
+	vio_bus_device.dev.archdata.dma_ops = &dma_iommu_ops;
+	vio_bus_device.dev.archdata.dma_data = &vio_iommu_table;
+}
+#else
+static void __init iommu_vio_init(void)
+{
 }
 #endif
 
@@ -282,14 +288,8 @@ static int __init vio_bus_init(void)
 	int err;
 	struct device_node *node_vroot;
 
-#ifdef CONFIG_PPC_ISERIES
-	if (firmware_has_feature(FW_FEATURE_ISERIES)) {
+	if (firmware_has_feature(FW_FEATURE_ISERIES))
 		iommu_vio_init();
-		vio_bus_device.dev.archdata.dma_ops = &dma_iommu_ops;
-		vio_bus_device.dev.archdata.dma_data = &vio_iommu_table;
-		iSeries_vio_dev = &vio_bus_device.dev;
-	}
-#endif /* CONFIG_PPC_ISERIES */
 
 	err = bus_register(&vio_bus_type);
 	if (err) {
-- 
1.5.3.2
