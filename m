Return-Path: <prvs=07276f4170=gerlando.falauto@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2507E1A0281
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 18:19:07 +1100 (AEDT)
From: Gerlando Falauto <gerlando.falauto@keymile.com>
To: netdev@vger.kernel.org, timur@tabi.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: ogabbay@advaoptical.com, bigeasy@linutronix.de,
 Gerlando Falauto <gerlando.falauto@keymile.com>,
 "David S. Miller" <davem@davemloft.net>,
 Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v2 1/2] net/fsl_pq_mdio: check TBI address for consistency
 with mapped range
Date: Mon, 12 Oct 2015 09:18:40 +0200
Message-Id: <1444634321-14902-1-git-send-email-gerlando.falauto@keymile.com>
In-Reply-To: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
References: <1371041258-15298-1-git-send-email-ogabbay@advaoptical.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When configuring the MDIO subsystem it is also necessary to configure
the TBI register. Make sure the TBI is contained within the mapped
register range in order to:
a) make sure the address is computed correctly
b) make users aware that we're actually accessing that register

In case of error, print a message but continue anyway.

Signed-off-by: Gerlando Falauto <gerlando.falauto@keymile.com>
Cc: Timur Tabi <timur@tabi.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Kumar Gala <galak@kernel.crashing.org>
---
Changes from v1:
- Added type cast & fixed range
- removed freescale recipients

 drivers/net/ethernet/freescale/fsl_pq_mdio.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 3c40f6b..5333d0a 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -445,6 +445,16 @@ static int fsl_pq_mdio_probe(struct platform_device *pdev)
 
 			tbipa = data->get_tbipa(priv->map);
 
+			/*
+			 * Add consistency check to make sure TBI is contained
+			 * within the mapped range (not because we would get a
+			 * segfault, rather to catch bugs in computing TBI
+			 * address). Print error message but continue anyway.
+			 */
+			if ((void *)tbipa > priv->map + resource_size(&res) - 4)
+				dev_err(&pdev->dev, "invalid register map (should be at least 0x%04x to contain TBI address)\n",
+					((void *)tbipa - priv->map) + 4);
+
 			iowrite32be(be32_to_cpup(prop), tbipa);
 		}
 	}
-- 
1.8.0.1
