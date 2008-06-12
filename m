Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C8FCDDDEEE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 10:32:42 +1000 (EST)
From: Vitaly Bordug <vitb@kernel.crashing.org>
Subject: [PATCH] [fs_enet] powerpc: Fix SCC Ethernet on CPM2,
	and crash in fs_enet_rx_napi()
To: jeff@garzik.org
Date: Thu, 12 Jun 2008 04:32:19 +0400
Message-ID: <20080612003219.12670.66981.stgit@vitb-lp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Heiko Schocher <hs@denx.de>

Initially posted on:
http://ozlabs.org/pipermail/linuxppc-dev/2008-January/049682.html
Feedback is addressed in this version (yes, this patch was floating around for a while...)

Signed-off-by: Heiko Schocher <hs@denx.de>
Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
---

 drivers/net/fs_enet/fs_enet-main.c |   10 +++++++++-
 drivers/net/fs_enet/mac-scc.c      |    8 +++++++-
 include/asm-powerpc/cpm2.h         |    5 +++++
 3 files changed, 21 insertions(+), 2 deletions(-)


diff --git a/drivers/net/fs_enet/fs_enet-main.c b/drivers/net/fs_enet/fs_enet-main.c
index a5baaf5..31c9693 100644
--- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -804,6 +804,10 @@ static int fs_enet_open(struct net_device *dev)
 	int r;
 	int err;
 
+	/* to initialize the fep->cur_rx,... */
+	/* not doing this, will cause a crash in fs_enet_rx_napi */
+	fs_init_bds(fep->ndev);
+
 	if (fep->fpi->use_napi)
 		napi_enable(&fep->napi);
 
@@ -982,6 +986,7 @@ static struct net_device *fs_init_instance(struct device *dev,
 	fep = netdev_priv(ndev);
 
 	fep->dev = dev;
+	fep->ndev = ndev;
 	dev_set_drvdata(dev, ndev);
 	fep->fpi = fpi;
 	if (fpi->init_ioports)
@@ -1085,7 +1090,6 @@ static struct net_device *fs_init_instance(struct device *dev,
 	}
 	registered = 1;
 
-
 	return ndev;
 
 err:
@@ -1354,6 +1358,10 @@ static struct of_device_id fs_enet_match[] = {
 		.compatible = "fsl,cpm1-scc-enet",
 		.data = (void *)&fs_scc_ops,
 	},
+	{
+		.compatible = "fsl,cpm2-scc-enet",
+		.data = (void *)&fs_scc_ops,
+	},
 #endif
 #ifdef CONFIG_FS_ENET_HAS_FCC
 	{
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index d7ca319..f2b64a7 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -50,7 +50,6 @@
 #include "fs_enet.h"
 
 /*************************************************/
-
 #if defined(CONFIG_CPM1)
 /* for a 8xx __raw_xxx's are sufficient */
 #define __fs_out32(addr, x)	__raw_writel(x, addr)
@@ -65,6 +64,8 @@
 #define __fs_out16(addr, x)	out_be16(addr, x)
 #define __fs_in32(addr)	in_be32(addr)
 #define __fs_in16(addr)	in_be16(addr)
+#define __fs_out8(addr, x)	out_8(addr, x)
+#define __fs_in8(addr)	in_8(addr)
 #endif
 
 /* write, read, set bits, clear bits */
@@ -297,8 +298,13 @@ static void restart(struct net_device *dev)
 
 	/* Initialize function code registers for big-endian.
 	 */
+#ifndef CONFIG_NOT_COHERENT_CACHE
+	W8(ep, sen_genscc.scc_rfcr, SCC_EB | SCC_GBL);
+	W8(ep, sen_genscc.scc_tfcr, SCC_EB | SCC_GBL);
+#else
 	W8(ep, sen_genscc.scc_rfcr, SCC_EB);
 	W8(ep, sen_genscc.scc_tfcr, SCC_EB);
+#endif
 
 	/* Set maximum bytes per receive buffer.
 	 * This appears to be an Ethernet frame size, not the buffer
diff --git a/include/asm-powerpc/cpm2.h b/include/asm-powerpc/cpm2.h
index 4c85ed9..3bdff75 100644
--- a/include/asm-powerpc/cpm2.h
+++ b/include/asm-powerpc/cpm2.h
@@ -343,6 +343,11 @@ typedef struct scc_param {
 	uint	scc_tcrc;	/* Internal */
 } sccp_t;
 
+/* Function code bits.
+*/
+#define SCC_EB	((u_char) 0x10)	/* Set big endian byte order */
+#define SCC_GBL	((u_char) 0x20) /* Snooping enabled */
+
 /* CPM Ethernet through SCC1.
  */
 typedef struct scc_enet {
