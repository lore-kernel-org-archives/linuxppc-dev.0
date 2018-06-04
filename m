Return-Path: <yangbo.lu@nxp.com>
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zmTB069wzF0dj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 17:16:45 +1000 (AEST)
From: Yangbo Lu <yangbo.lu@nxp.com>
To: netdev@vger.kernel.org, madalin.bucur@nxp.com,
 Richard Cochran <richardcochran@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 "David S . Miller" <davem@davemloft.net>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Yangbo Lu <yangbo.lu@nxp.com>
Subject: [PATCH 06/10] fsl/fman: add set_tstamp interface
Date: Mon,  4 Jun 2018 15:08:33 +0800
Message-Id: <20180604070837.19265-7-yangbo.lu@nxp.com>
In-Reply-To: <20180604070837.19265-1-yangbo.lu@nxp.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch is to add set_tstamp interface for memac,
dtsec, and 10GEC controllers to configure HW timestamping.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_dtsec.c |   27 ++++++++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_dtsec.h |    1 +
 drivers/net/ethernet/freescale/fman/fman_memac.c |    5 ++++
 drivers/net/ethernet/freescale/fman/fman_memac.h |    1 +
 drivers/net/ethernet/freescale/fman/fman_tgec.c  |   21 +++++++++++++++++
 drivers/net/ethernet/freescale/fman/fman_tgec.h  |    1 +
 drivers/net/ethernet/freescale/fman/mac.c        |    3 ++
 drivers/net/ethernet/freescale/fman/mac.h        |    1 +
 8 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index 57b1e2b..1ca543a 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -123,11 +123,13 @@
 #define DTSEC_ECNTRL_R100M		0x00000008
 #define DTSEC_ECNTRL_QSGMIIM		0x00000001
 
+#define TCTRL_TTSE			0x00000040
 #define TCTRL_GTS			0x00000020
 
 #define RCTRL_PAL_MASK			0x001f0000
 #define RCTRL_PAL_SHIFT			16
 #define RCTRL_GHTX			0x00000400
+#define RCTRL_RTSE			0x00000040
 #define RCTRL_GRS			0x00000020
 #define RCTRL_MPROM			0x00000008
 #define RCTRL_RSF			0x00000004
@@ -1136,6 +1138,31 @@ int dtsec_set_allmulti(struct fman_mac *dtsec, bool enable)
 	return 0;
 }
 
+int dtsec_set_tstamp(struct fman_mac *dtsec, bool enable)
+{
+	struct dtsec_regs __iomem *regs = dtsec->regs;
+	u32 rctrl, tctrl;
+
+	if (!is_init_done(dtsec->dtsec_drv_param))
+		return -EINVAL;
+
+	rctrl = ioread32be(&regs->rctrl);
+	tctrl = ioread32be(&regs->tctrl);
+
+	if (enable) {
+		rctrl |= RCTRL_RTSE;
+		tctrl |= TCTRL_TTSE;
+	} else {
+		rctrl &= ~RCTRL_RTSE;
+		tctrl &= ~TCTRL_TTSE;
+	}
+
+	iowrite32be(rctrl, &regs->rctrl);
+	iowrite32be(tctrl, &regs->tctrl);
+
+	return 0;
+}
+
 int dtsec_del_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr)
 {
 	struct dtsec_regs __iomem *regs = dtsec->regs;
diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.h b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
index 1a689ad..5149d96 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.h
@@ -56,5 +56,6 @@ int dtsec_set_exception(struct fman_mac *dtsec,
 int dtsec_del_hash_mac_address(struct fman_mac *dtsec, enet_addr_t *eth_addr);
 int dtsec_get_version(struct fman_mac *dtsec, u32 *mac_version);
 int dtsec_set_allmulti(struct fman_mac *dtsec, bool enable);
+int dtsec_set_tstamp(struct fman_mac *dtsec, bool enable);
 
 #endif /* __DTSEC_H */
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index 446a97b..bc6eb30 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -964,6 +964,11 @@ int memac_set_allmulti(struct fman_mac *memac, bool enable)
 	return 0;
 }
 
+int memac_set_tstamp(struct fman_mac *memac, bool enable)
+{
+	return 0; /* Always enabled. */
+}
+
 int memac_del_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr)
 {
 	struct memac_regs __iomem *regs = memac->regs;
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.h b/drivers/net/ethernet/freescale/fman/fman_memac.h
index b5a5033..b2c671e 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.h
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.h
@@ -58,5 +58,6 @@ int memac_set_exception(struct fman_mac *memac,
 int memac_add_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr);
 int memac_del_hash_mac_address(struct fman_mac *memac, enet_addr_t *eth_addr);
 int memac_set_allmulti(struct fman_mac *memac, bool enable);
+int memac_set_tstamp(struct fman_mac *memac, bool enable);
 
 #endif /* __MEMAC_H */
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.c b/drivers/net/ethernet/freescale/fman/fman_tgec.c
index 284735d..4070593 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.c
@@ -44,6 +44,7 @@
 #define TGEC_TX_IPG_LENGTH_MASK	0x000003ff
 
 /* Command and Configuration Register (COMMAND_CONFIG) */
+#define CMD_CFG_EN_TIMESTAMP		0x00100000
 #define CMD_CFG_NO_LEN_CHK		0x00020000
 #define CMD_CFG_PAUSE_IGNORE		0x00000100
 #define CMF_CFG_CRC_FWD			0x00000040
@@ -588,6 +589,26 @@ int tgec_set_allmulti(struct fman_mac *tgec, bool enable)
 	return 0;
 }
 
+int tgec_set_tstamp(struct fman_mac *tgec, bool enable)
+{
+	struct tgec_regs __iomem *regs = tgec->regs;
+	u32 tmp;
+
+	if (!is_init_done(tgec->cfg))
+		return -EINVAL;
+
+	tmp = ioread32be(&regs->command_config);
+
+	if (enable)
+		tmp |= CMD_CFG_EN_TIMESTAMP;
+	else
+		tmp &= ~CMD_CFG_EN_TIMESTAMP;
+
+	iowrite32be(tmp, &regs->command_config);
+
+	return 0;
+}
+
 int tgec_del_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr)
 {
 	struct tgec_regs __iomem *regs = tgec->regs;
diff --git a/drivers/net/ethernet/freescale/fman/fman_tgec.h b/drivers/net/ethernet/freescale/fman/fman_tgec.h
index cbbd3b4..3bfd106 100644
--- a/drivers/net/ethernet/freescale/fman/fman_tgec.h
+++ b/drivers/net/ethernet/freescale/fman/fman_tgec.h
@@ -52,5 +52,6 @@ int tgec_set_exception(struct fman_mac *tgec,
 int tgec_del_hash_mac_address(struct fman_mac *tgec, enet_addr_t *eth_addr);
 int tgec_get_version(struct fman_mac *tgec, u32 *mac_version);
 int tgec_set_allmulti(struct fman_mac *tgec, bool enable);
+int tgec_set_tstamp(struct fman_mac *tgec, bool enable);
 
 #endif /* __TGEC_H */
diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
index 7b5b95f..a847b9c 100644
--- a/drivers/net/ethernet/freescale/fman/mac.c
+++ b/drivers/net/ethernet/freescale/fman/mac.c
@@ -471,6 +471,7 @@ static void setup_dtsec(struct mac_device *mac_dev)
 	mac_dev->set_rx_pause		= dtsec_accept_rx_pause_frames;
 	mac_dev->set_exception		= dtsec_set_exception;
 	mac_dev->set_allmulti		= dtsec_set_allmulti;
+	mac_dev->set_tstamp		= dtsec_set_tstamp;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
@@ -490,6 +491,7 @@ static void setup_tgec(struct mac_device *mac_dev)
 	mac_dev->set_rx_pause		= tgec_accept_rx_pause_frames;
 	mac_dev->set_exception		= tgec_set_exception;
 	mac_dev->set_allmulti		= tgec_set_allmulti;
+	mac_dev->set_tstamp		= tgec_set_tstamp;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
@@ -509,6 +511,7 @@ static void setup_memac(struct mac_device *mac_dev)
 	mac_dev->set_rx_pause		= memac_accept_rx_pause_frames;
 	mac_dev->set_exception		= memac_set_exception;
 	mac_dev->set_allmulti		= memac_set_allmulti;
+	mac_dev->set_tstamp		= memac_set_tstamp;
 	mac_dev->set_multi		= set_multi;
 	mac_dev->start			= start;
 	mac_dev->stop			= stop;
diff --git a/drivers/net/ethernet/freescale/fman/mac.h b/drivers/net/ethernet/freescale/fman/mac.h
index b520cec..824a81a 100644
--- a/drivers/net/ethernet/freescale/fman/mac.h
+++ b/drivers/net/ethernet/freescale/fman/mac.h
@@ -68,6 +68,7 @@ struct mac_device {
 	int (*set_promisc)(struct fman_mac *mac_dev, bool enable);
 	int (*change_addr)(struct fman_mac *mac_dev, enet_addr_t *enet_addr);
 	int (*set_allmulti)(struct fman_mac *mac_dev, bool enable);
+	int (*set_tstamp)(struct fman_mac *mac_dev, bool enable);
 	int (*set_multi)(struct net_device *net_dev,
 			 struct mac_device *mac_dev);
 	int (*set_rx_pause)(struct fman_mac *mac_dev, bool en);
-- 
1.7.1
