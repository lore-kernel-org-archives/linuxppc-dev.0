Return-Path: <madalin.bucur@nxp.com>
Received: from NAM01-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam01on0042.outbound.protection.outlook.com [104.47.34.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vv4zP3ZwdzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Mar 2017 00:21:51 +1100 (AEDT)
From: Madalin Bucur <madalin.bucur@nxp.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Madalin Bucur <madalin.bucur@nxp.com>
Subject: [PATCH] fsl/fman: take into account all RGMII modes
Date: Thu, 30 Mar 2017 16:21:40 +0300
Message-ID: <1490880100-13373-1-git-send-email-madalin.bucur@nxp.com>
Reply-To: <madalin.bucur@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Accept the internal delay RGMII variants.

Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>
---
 drivers/net/ethernet/freescale/fman/fman_dtsec.c | 8 +++++++-
 drivers/net/ethernet/freescale/fman/fman_memac.c | 5 ++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
index 84ea130..98bba10 100644
--- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
+++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
@@ -381,6 +381,9 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
 
 	/* check RGMII support */
 	if (iface == PHY_INTERFACE_MODE_RGMII ||
+	    iface == PHY_INTERFACE_MODE_RGMII_ID ||
+	    iface == PHY_INTERFACE_MODE_RGMII_RXID ||
+	    iface == PHY_INTERFACE_MODE_RGMII_TXID ||
 	    iface == PHY_INTERFACE_MODE_RMII)
 		if (tmp & DTSEC_ID2_INT_REDUCED_OFF)
 			return -EINVAL;
@@ -390,7 +393,10 @@ static int init(struct dtsec_regs __iomem *regs, struct dtsec_cfg *cfg,
 		if (tmp & DTSEC_ID2_INT_REDUCED_OFF)
 			return -EINVAL;
 
-	is_rgmii = iface == PHY_INTERFACE_MODE_RGMII;
+	is_rgmii = iface == PHY_INTERFACE_MODE_RGMII ||
+		   iface == PHY_INTERFACE_MODE_RGMII_ID ||
+		   iface == PHY_INTERFACE_MODE_RGMII_RXID ||
+		   iface == PHY_INTERFACE_MODE_RGMII_TXID;
 	is_sgmii = iface == PHY_INTERFACE_MODE_SGMII;
 	is_qsgmii = iface == PHY_INTERFACE_MODE_QSGMII;
 
diff --git a/drivers/net/ethernet/freescale/fman/fman_memac.c b/drivers/net/ethernet/freescale/fman/fman_memac.c
index cd6a53e..c029688 100644
--- a/drivers/net/ethernet/freescale/fman/fman_memac.c
+++ b/drivers/net/ethernet/freescale/fman/fman_memac.c
@@ -443,7 +443,10 @@ static int init(struct memac_regs __iomem *regs, struct memac_cfg *cfg,
 		break;
 	default:
 		tmp |= IF_MODE_GMII;
-		if (phy_if == PHY_INTERFACE_MODE_RGMII)
+		if (phy_if == PHY_INTERFACE_MODE_RGMII ||
+		    phy_if == PHY_INTERFACE_MODE_RGMII_ID ||
+		    phy_if == PHY_INTERFACE_MODE_RGMII_RXID ||
+		    phy_if == PHY_INTERFACE_MODE_RGMII_TXID)
 			tmp |= IF_MODE_RGMII | IF_MODE_RGMII_AUTO;
 	}
 	iowrite32be(tmp, &regs->if_mode);
-- 
2.1.0
