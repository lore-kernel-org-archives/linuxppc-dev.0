Return-Path: <abounine@ott.idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwMl50N1bzDqh7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 04:29:52 +1000 (AEST)
From: Alexandre Bounine <alexandre.bounine@idt.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
 Matt Porter <mporter@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Andre van Herk <andre.van.herk@prodrive-technologies.com>,
 Barry Wood <barry.wood@idt.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 10/13] rapidio: change inbound window size type to u64
Date: Thu, 21 Jul 2016 14:18:51 -0400
Message-Id: <1469125134-16523-11-git-send-email-alexandre.bounine@idt.com>
In-Reply-To: <1469125134-16523-1-git-send-email-alexandre.bounine@idt.com>
References: <1469125134-16523-1-git-send-email-alexandre.bounine@idt.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current definition of map_inb() mport operations callback uses u32 type to
specify required inbound window (IBW) size. This is limiting factor
because existing hardware - tsi721 and fsl_rio, both support IBW size
up to 16GB.

Changing type of size parameter to u64 to allow IBW size configurations
larger than 4GB.

Signed-off-by: Alexandre Bounine <alexandre.bounine@idt.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Andre van Herk <andre.van.herk@prodrive-technologies.com>
Cc: Barry Wood <barry.wood@idt.com>
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/sysdev/fsl_rio.c    |    4 ++--
 drivers/rapidio/devices/tsi721.c |   14 +++++++++-----
 include/linux/rio.h              |    2 +-
 3 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index f5bf38b9..1958838 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -289,7 +289,7 @@ static void fsl_rio_inbound_mem_init(struct rio_priv *priv)
 }
 
 int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
-	u64 rstart, u32 size, u32 flags)
+	u64 rstart, u64 size, u32 flags)
 {
 	struct rio_priv *priv = mport->priv;
 	u32 base_size;
@@ -298,7 +298,7 @@ int fsl_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
 	u32 riwar;
 	int i;
 
-	if ((size & (size - 1)) != 0)
+	if ((size & (size - 1)) != 0 || size > 0x400000000UL)
 		return -EINVAL;
 
 	base_size_log = ilog2(size);
diff --git a/drivers/rapidio/devices/tsi721.c b/drivers/rapidio/devices/tsi721.c
index 8e07cd5..53daf63 100644
--- a/drivers/rapidio/devices/tsi721.c
+++ b/drivers/rapidio/devices/tsi721.c
@@ -1090,7 +1090,7 @@ static void tsi721_init_pc2sr_mapping(struct tsi721_device *priv)
  * from rstart to lstart.
  */
 static int tsi721_rio_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
-		u64 rstart, u32 size, u32 flags)
+		u64 rstart, u64 size, u32 flags)
 {
 	struct tsi721_device *priv = mport->priv;
 	int i, avail = -1;
@@ -1103,6 +1103,10 @@ static int tsi721_rio_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
 	struct tsi721_ib_win_mapping *map = NULL;
 	int ret = -EBUSY;
 
+	/* Max IBW size supported by HW is 16GB */
+	if (size > 0x400000000UL)
+		return -EINVAL;
+
 	if (direct) {
 		/* Calculate minimal acceptable window size and base address */
 
@@ -1110,15 +1114,15 @@ static int tsi721_rio_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
 		ibw_start = lstart & ~(ibw_size - 1);
 
 		tsi_debug(IBW, &priv->pdev->dev,
-			"Direct (RIO_0x%llx -> PCIe_%pad), size=0x%x, ibw_start = 0x%llx",
+			"Direct (RIO_0x%llx -> PCIe_%pad), size=0x%llx, ibw_start = 0x%llx",
 			rstart, &lstart, size, ibw_start);
 
 		while ((lstart + size) > (ibw_start + ibw_size)) {
 			ibw_size *= 2;
 			ibw_start = lstart & ~(ibw_size - 1);
-			if (ibw_size > 0x80000000) { /* Limit max size to 2GB */
+			/* Check for crossing IBW max size 16GB */
+			if (ibw_size > 0x400000000UL)
 				return -EBUSY;
-			}
 		}
 
 		loc_start = ibw_start;
@@ -1129,7 +1133,7 @@ static int tsi721_rio_map_inb_mem(struct rio_mport *mport, dma_addr_t lstart,
 
 	} else {
 		tsi_debug(IBW, &priv->pdev->dev,
-			"Translated (RIO_0x%llx -> PCIe_%pad), size=0x%x",
+			"Translated (RIO_0x%llx -> PCIe_%pad), size=0x%llx",
 			rstart, &lstart, size);
 
 		if (!is_power_of_2(size) || size < 0x1000 ||
diff --git a/include/linux/rio.h b/include/linux/rio.h
index aa23238..f7ec35b 100644
--- a/include/linux/rio.h
+++ b/include/linux/rio.h
@@ -425,7 +425,7 @@ struct rio_ops {
 	int (*add_inb_buffer)(struct rio_mport *mport, int mbox, void *buf);
 	void *(*get_inb_message)(struct rio_mport *mport, int mbox);
 	int (*map_inb)(struct rio_mport *mport, dma_addr_t lstart,
-			u64 rstart, u32 size, u32 flags);
+			u64 rstart, u64 size, u32 flags);
 	void (*unmap_inb)(struct rio_mport *mport, dma_addr_t lstart);
 	int (*query_mport)(struct rio_mport *mport,
 			   struct rio_mport_attr *attr);
-- 
1.7.8.4
