Return-Path: <wd@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 840E4B7085
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 17 Jul 2009 07:42:30 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id CC36DDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Jul 2009 07:42:29 +1000 (EST)
From: Wolfgang Denk <wd@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2 v4] fs_enet/mii-fec.c: fix MII speed calculation
Date: Thu, 16 Jul 2009 23:42:25 +0200
Message-Id: <1247780546-4426-1-git-send-email-wd@denx.de>
In-Reply-To: <1247671133-12148-1-git-send-email-wd@denx.de>
References: <1247671133-12148-1-git-send-email-wd@denx.de>
Cc: netdev@vger.kernel.org, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MII speed calculation was based on the CPU clock (ppc_proc_freq),
but for MPC512x we must use the bus clock instead.

This patch makes it use the correct clock and makes sure we don't
clobber reserved bits in the MII_SPEED register.

Signed-off-by: Wolfgang Denk <wd@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: <netdev@vger.kernel.org>

Signed-off-by: Wolfgang Denk <wd@denx.de>
---
 drivers/net/fs_enet/mii-fec.c |   35 +++++++++++++++++++++++++++++++----
 1 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/net/fs_enet/mii-fec.c b/drivers/net/fs_enet/mii-fec.c
index 75a0999..62b2d7a 100644
--- a/drivers/net/fs_enet/mii-fec.c
+++ b/drivers/net/fs_enet/mii-fec.c
@@ -103,11 +103,11 @@ static int fs_enet_fec_mii_reset(struct mii_bus *bus)
 static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
                                         const struct of_device_id *match)
 {
-	struct device_node *np = NULL;
 	struct resource res;
 	struct mii_bus *new_bus;
 	struct fec_info *fec;
-	int ret = -ENOMEM, i;
+	int (*get_bus_freq)(struct device_node *) = match->data;
+	int ret = -ENOMEM, clock, speed;
 
 	new_bus = mdiobus_alloc();
 	if (!new_bus)
@@ -133,13 +133,34 @@ static int __devinit fs_enet_mdio_probe(struct of_device *ofdev,
 	if (!fec->fecp)
 		goto out_fec;
 
-	fec->mii_speed = ((ppc_proc_freq + 4999999) / 5000000) << 1;
+	if (get_bus_freq) {
+		clock = get_bus_freq(ofdev->node);
+
+		if (!clock) {
+			dev_err(&ofdev->dev, "could not determine IPS/IPB clock\n");
+			goto out_unmap_regs;
+		}
+	} else
+		clock = ppc_proc_freq;
+
+	/* scale for a MII clock <= 2.5 MHz */
+	speed = (clock + 2499999) / 2500000;
+
+	/* only 6 bits (25:30) available for MII speed */
+	if (speed > 0x3F) {
+		speed = 0x3F;
+		dev_err(&ofdev->dev,
+			"MII clock (%d Hz) exceeds max (2.5 MHz)\n",
+			clock / speed);
+	}
+
+	fec->mii_speed = speed << 1;
 
 	setbits32(&fec->fecp->fec_r_cntrl, FEC_RCNTRL_MII_MODE);
 	setbits32(&fec->fecp->fec_ecntrl, FEC_ECNTRL_PINMUX |
 	                                  FEC_ECNTRL_ETHER_EN);
 	out_be32(&fec->fecp->fec_ievent, FEC_ENET_MII);
-	out_be32(&fec->fecp->fec_mii_speed, fec->mii_speed);
+	clrsetbits_be32(&fec->fecp->fec_mii_speed, 0x7E, fec->mii_speed);
 
 	new_bus->phy_mask = ~0;
 	new_bus->irq = kmalloc(sizeof(int) * PHY_MAX_ADDR, GFP_KERNEL);
@@ -188,6 +209,12 @@ static struct of_device_id fs_enet_mdio_fec_match[] = {
 	{
 		.compatible = "fsl,pq1-fec-mdio",
 	},
+#if defined(CONFIG_PPC_MPC512x)
+	{
+		.compatible = "fsl,mpc5121-fec-mdio",
+		.data = mpc5xxx_get_bus_frequency,
+	},
+#endif
 	{},
 };
 
-- 
1.6.0.6
