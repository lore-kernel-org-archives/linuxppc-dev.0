Return-Path: <why@r54964-12.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0E6B1DDFD5
	for <linuxppc-dev@ozlabs.org>; Thu, 28 May 2009 23:20:08 +1000 (EST)
From: Haiying Wang <Haiying.Wang@freescale.com>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, galak@kernel.crashing.org
Subject: [PATCH 2/4] fsl_pq_mido: Set the first UCC as the mii management
	interface master
Date: Thu, 28 May 2009 09:20:28 -0400
Message-Id: <1243516833328-git-send-email-Haiying.Wang@freescale.com>
In-Reply-To: <12435168302841-git-send-email-Haiying.Wang@freescale.com>
References: <12435168302841-git-send-email-Haiying.Wang@freescale.com>
Cc: Haiying Wang <Haiying.Wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current code makes the UCC whose register range includes the current mdio
register to be the MII managemnt interface master of the QE. If there is more
than one mdio bus for QE, the UCC of the last mdio bus will be the MII
management interface master which will make the primary mdio bus working
unproperly, e.g. can notget the right clock. Normally the primary mdio bus is
the first UEC's mdio bus.
This patch allows the first UCC to be the MII management interface master of the
multiple UCC mdio buses.

Signed-off-by: Haiying Wang <Haiying.Wang@freescale.com>
---
 drivers/net/fsl_pq_mdio.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fsl_pq_mdio.c b/drivers/net/fsl_pq_mdio.c
index aa1eb88..fd317a0 100644
--- a/drivers/net/fsl_pq_mdio.c
+++ b/drivers/net/fsl_pq_mdio.c
@@ -338,13 +338,17 @@ static int fsl_pq_mdio_probe(struct of_device *ofdev,
 			of_device_is_compatible(np, "ucc_geth_phy")) {
 #ifdef CONFIG_UCC_GETH
 		u32 id;
+		static u32 mii_mng_master;
 
 		tbipa = &regs->utbipar;
 
 		if ((err = get_ucc_id_for_range(addr, addr + size, &id)))
 			goto err_free_irqs;
 
-		ucc_set_qe_mux_mii_mng(id - 1);
+		if (!mii_mng_master) {
+			mii_mng_master = id;
+			ucc_set_qe_mux_mii_mng(id - 1);
+		}
 #else
 		err = -ENODEV;
 		goto err_free_irqs;
-- 
1.6.0.2
