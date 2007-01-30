Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 30C22DE209
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 10:20:38 +1100 (EST)
Message-ID: <45BFD2C2.70000@am.sony.com>
Date: Tue, 30 Jan 2007 15:20:34 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 3/4] PS3: Fix DMA scatter-gather
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add the missing pieces to support DMA scatter-gather on the PS3 system bus.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

USB mass storage works properly now.

 arch/powerpc/platforms/ps3/system-bus.c |   23 +++++++++++++++++++++--
 1 files changed, 21 insertions(+), 2 deletions(-)

--- ps3-linux-dev.orig/arch/powerpc/platforms/ps3/system-bus.c
+++ ps3-linux-dev/arch/powerpc/platforms/ps3/system-bus.c
@@ -272,10 +272,29 @@ static void ps3_unmap_single(struct devi
 static int ps3_map_sg(struct device *_dev, struct scatterlist *sg, int nents,
 	enum dma_data_direction direction)
 {
+	struct ps3_system_bus_device *dev = to_ps3_system_bus_device(_dev);
+	int i;
+
 #if defined(CONFIG_PS3_DYNAMIC_DMA)
 	BUG_ON("do");
+	return -EPERM;
+#else
+	for (i = 0; i < nents; i++, sg++) {
+		int result = ps3_dma_map(dev->d_region,
+			page_to_phys(sg->page) + sg->offset, sg->length,
+			&sg->dma_address);
+
+		if (result) {
+			pr_debug("%s:%d: ps3_dma_map failed (%d)\n",
+				__func__, __LINE__, result);
+			return -EINVAL;
+		}
+
+		sg->dma_length = sg->length;
+	}
+
+	return nents;
 #endif
-	return 0;
 }
 
 static void ps3_unmap_sg(struct device *_dev, struct scatterlist *sg,
@@ -288,7 +307,7 @@ static void ps3_unmap_sg(struct device *
 
 static int ps3_dma_supported(struct device *_dev, u64 mask)
 {
-	return 1;
+	return mask >= DMA_32BIT_MASK;
 }
 
 static struct dma_mapping_ops ps3_dma_ops = {
