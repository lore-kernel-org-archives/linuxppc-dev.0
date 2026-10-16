Return-Path: <linuxppc-dev+bounces-29610-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9B4CCF2C6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 16 Oct 2026 19:40:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j5wJH3HdZz2ynZ;
	Sat, 17 Oct 2026 06:39:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=178.251.229.89
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792179599;
	cv=none; b=FKSeIgePZKFbAmYX/oYFda5DpWjetBbtt6VrgeUwhSfe/uUvVNkfQSupnzeSKQoO473HLbuWs1NVXVJNhu3UVulGQM3+h6omiPb2jJja3RYirpYfw2NB38bZLxpsd4K8LC9B53XMsbmfpJtqKaULxbF9vWXB5GV9U8/MO5FAzVeV1vc/Ddr/sVkSZrHqa2EBZBYsPQDhO+gnVgc403y9+Om5Qz51xX5jxioxZ+A48uzttR3I1YdE8MK7+3TndoqF3NHbg+1zD2n/B2d69k/ReLtqHZ+u6pTfN2PZcOwEryHZ4gFXv+ikkAGK1IDvzHFe6ZsImduNv/cOhUFtlXGArA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792179599; c=relaxed/relaxed;
	bh=FZL8PfkThKX2iAppqn/43ztzq+aJ7s8ZsROCzA6oW9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XdF0YoY24k5grdyvdygyYa/Z6pM6V0/2vIiIkjrVe1GdvXT+L2u4Xp14THMb0RPodTUArWFeBgAp0klPgnWEgHPYUPb0Nz0cYibIblFy1DnzKf9BeVxNKs8cJVsybYtco80aaUkax4NNfeuOEcWFWRlToK8cwJY3T7VvHtv1mTLTZ497WG1hWkXgZukCDjigLTTv4cEzLQTXqLPzY+6hgatT9TuqCER8FVAYHYyyO+NHuQnJsKErKoFk9ElPrmmFhybszOmDAVsz17GSJvxaqRJ1sy6fTpPwqR5tdq8I52hrvh8oXuVKVxgEknhTfm6QZ6mVl2OviQldGY0Nl9VOsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CKdELMX1; dkim-atps=neutral; spf=pass (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org) smtp.mailfrom=nabladev.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.a=rsa-sha256 header.s=dkim header.b=CKdELMX1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=nabladev.com (client-ip=178.251.229.89; helo=mx.nabladev.com; envelope-from=marex@nabladev.com; receiver=lists.ozlabs.org)
X-Greylist: delayed 352 seconds by postgrey-1.37 at boromir; Sat, 17 Oct 2026 06:39:56 AEDT
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j5wJD5k3Dz2yjN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Oct 2026 06:39:56 +1100 (AEDT)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C506109A06;
	Fri, 16 Oct 2026 21:33:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1792179236; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=FZL8PfkThKX2iAppqn/43ztzq+aJ7s8ZsROCzA6oW9I=;
	b=CKdELMX1Ka+hgZceWrxbziJUGxXJLD1NH7LslvieXtRG38CvVFUHQ0v6FKg5oFgB9qybbL
	S8rArappOpt7gvdGhhBEXhV/rk44WloddUG+nv1Ujw4Ak4ocCCK9jdvDxME9vqvCi9KA6L
	u9Mkoukrpd7mOSMyP8iwXdsUgshQdlfXHZ8ZaaWYkJgvC8F6EHILEB5nGqqwN/fjSNT10D
	v1SS14O8ldYPfw612YWryLyCVtn63NoIwxWMOkfI7aV6OiRj/VLVpJpKgT7R7RE91pNsYY
	oZb+zaB0Jnmgj3PHw8RHNd/YZdn0iS0u8DgGFCPKPpMDgFuo7aTs4M1YYalfiA==
From: Marek Vasut <marex@nabladev.com>
To: netdev@vger.kernel.org
Cc: Marek Vasut <marex@nabladev.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	UNGLinuxDriver@microchip.com,
	Wei Fang <wei.fang@nxp.com>,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [net-next,PATCH 2/2] enetc: Make eMDIO MDC rate configurable from DT
Date: Fri, 16 Oct 2026 21:32:01 +0200
Message-ID: <20261016193344.115518-2-marex@nabladev.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016193344.115518-1-marex@nabladev.com>
References: <20261016193344.115518-1-marex@nabladev.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The current eMDIO MDC rate is hard-coded in the drivers which use the
eMDIO MDC, this is not flexible for various deployments of SoCs which
use the eMDIO interface, for example i.MX95 B0 MDC clock is currently
set to 644 kHz.

Introduce enetc_mdio_priv .mdc_div field which contains the divider
used for MDC clock and pass it around, including into functions which
configure the MDC clock. This way, drivers which use the eMDIO can set
the divider as needed. Introduce enetc_mdio_update_mdc_div() function
which calculates the divider from upstream clock and clock-frequency
DT property, both of which are optional to retain compatibility with
older DTs. This is modeled according to xgmac_mdio_set_mdc_freq().

Suggested-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Marek Vasut <marex@nabladev.com>
---
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Clark Wang <xiaoning.wang@nxp.com>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>
Cc: Conor Dooley <conor+dt@kernel.org>
Cc: Eric Dumazet <edumazet@kernel.org>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>
Cc: UNGLinuxDriver@microchip.com
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Wei Fang <wei.fang@nxp.com>
Cc: devicetree@vger.kernel.org
Cc: imx@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: netdev@vger.kernel.org
---
NOTE: I could only test i.MX95 , I could not test LS or Felix
---
 drivers/net/dsa/ocelot/felix_vsc9959.c        |  5 +++
 .../net/ethernet/freescale/enetc/enetc_mdio.c | 39 ++++++++++++++++---
 .../ethernet/freescale/enetc/enetc_pci_mdio.c |  5 +++
 .../freescale/enetc/enetc_pf_common.c         | 10 +++++
 include/linux/fsl/enetc_mdio.h                |  6 +++
 5 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 8387dd208adb9..dbeec1b229325 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -1008,8 +1008,13 @@ static int vsc9959_mdio_bus_alloc(struct ocelot *ocelot)
 	 * starting with the proper offset.
 	 */
 	mdio_priv->mdio_base = 0;
+	mdio_priv->mdc_div = ENETC_MDIO_DEFAULT_DIVIDER;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
 
+	rc = enetc_mdio_update_mdc_div(bus);
+	if (rc)
+		return rc;
+
 	/* Needed in order to initialize the bus mutex lock */
 	rc = mdiobus_register(bus);
 	if (rc < 0) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
index 998aaa394e9c4..93d61c2f1464f 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
 /* Copyright 2019 NXP */
 
+#include <linux/clk.h>
 #include <linux/fsl/enetc_mdio.h>
 #include <linux/mdio.h>
 #include <linux/of_mdio.h>
@@ -22,9 +23,9 @@
  /* external MDIO only - driven on neg MDC edge */
 #define MDIO_CFG_NEG		BIT(23)
 
-#define ENETC_EMDIO_CFG \
+#define ENETC_EMDIO_CFG(mdc_div) \
 	(MDIO_CFG_HOLD(2) | \
-	 MDIO_CFG_CLKDIV(258) | \
+	 MDIO_CFG_CLKDIV(mdc_div) | \
 	 MDIO_CFG_NEG)
 
 #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)
@@ -63,7 +64,7 @@ int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
 	u16 dev_addr;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	dev_addr = regnum & 0x1f;
 	mdio_cfg &= ~MDIO_CFG_ENC45;
 
@@ -95,7 +96,7 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int dev_addr,
 	u32 mdio_ctl, mdio_cfg;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	mdio_cfg |= MDIO_CFG_ENC45;
 
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
@@ -133,7 +134,7 @@ int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum)
 	u16 dev_addr, value;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	dev_addr = regnum & 0x1f;
 	mdio_cfg &= ~MDIO_CFG_ENC45;
 
@@ -176,7 +177,7 @@ int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int dev_addr,
 	u16 value;
 	int ret;
 
-	mdio_cfg = ENETC_EMDIO_CFG;
+	mdio_cfg = ENETC_EMDIO_CFG(mdio_priv->mdc_div);
 	mdio_cfg |= MDIO_CFG_ENC45;
 
 	enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);
@@ -231,6 +232,32 @@ struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs)
 }
 EXPORT_SYMBOL_GPL(enetc_hw_alloc);
 
+int enetc_mdio_update_mdc_div(struct mii_bus *bus)
+{
+	struct enetc_mdio_priv *mdio_priv = bus->priv;
+	struct device *dev = bus->parent;
+	struct clk *enet_clk;
+	u32 div, mdc_freq;
+
+	if (device_property_read_u32(dev, "clock-frequency", &mdc_freq))
+		return 0;
+
+	enet_clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(enet_clk))
+		return dev_err_probe(dev, PTR_ERR(enet_clk),
+				     "Input clock unknown, not changing MDC frequency\n");
+
+	div = ((clk_get_rate(enet_clk) / mdc_freq) - 1) / 4;
+	if (div < 5 || div > 0x1ff)
+		return dev_err_probe(dev, -EINVAL,
+				     "Requested MDC frequency is out of range, ignoring\n");
+
+	mdio_priv->mdc_div = div;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(enetc_mdio_update_mdc_div);
+
 /* Lock for MDIO access errata on LS1028A */
 DEFINE_RWLOCK(enetc_mdio_lock);
 EXPORT_SYMBOL_GPL(enetc_mdio_lock);
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
index e108cac8288d3..4ff182d7d21ec 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pci_mdio.c
@@ -71,8 +71,13 @@ static int enetc_pci_mdio_probe(struct pci_dev *pdev,
 	mdio_priv = bus->priv;
 	mdio_priv->hw = hw;
 	mdio_priv->mdio_base = ENETC_EMDIO_BASE;
+	mdio_priv->mdc_div = ENETC_MDIO_DEFAULT_DIVIDER;
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
+	err = enetc_mdio_update_mdc_div(bus);
+	if (err)
+		return err;
+
 	pcie_flr(pdev);
 	err = pci_enable_device_mem(pdev);
 	if (err) {
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 8206884294a47..adba3fdea32dc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -300,6 +300,7 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 	bus->parent = dev;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdc_div = ENETC_MDIO_DEFAULT_DIVIDER;
 
 	if (is_enetc_rev1(pf->si))
 		mdio_priv->mdio_base = ENETC_EMDIO_BASE;
@@ -308,6 +309,10 @@ static int enetc_mdio_probe(struct enetc_pf *pf, struct device_node *np)
 
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s", dev_name(dev));
 
+	err = enetc_mdio_update_mdc_div(bus);
+	if (err)
+		return err;
+
 	err = of_mdiobus_register(bus, np);
 	if (err)
 		return dev_err_probe(dev, err, "cannot register MDIO bus\n");
@@ -350,6 +355,7 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 	bus->phy_mask = ~0;
 	mdio_priv = bus->priv;
 	mdio_priv->hw = &pf->si->hw;
+	mdio_priv->mdc_div = ENETC_MDIO_DEFAULT_DIVIDER;
 
 	if (is_enetc_rev1(pf->si))
 		mdio_priv->mdio_base = ENETC_PM_IMDIO_BASE;
@@ -358,6 +364,10 @@ static int enetc_imdio_create(struct enetc_pf *pf)
 
 	snprintf(bus->id, MII_BUS_ID_SIZE, "%s-imdio", dev_name(dev));
 
+	err = enetc_mdio_update_mdc_div(bus);
+	if (err)
+		return err;
+
 	err = mdiobus_register(bus);
 	if (err) {
 		dev_err(dev, "cannot register internal MDIO bus (%d)\n", err);
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 623ccfcbf39c3..13eb6939efe29 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -6,6 +6,8 @@
 
 #include <linux/phy.h>
 
+#define ENETC_MDIO_DEFAULT_DIVIDER		258
+
 /* PCS registers */
 #define ENETC_PCS_LINK_TIMER1			0x12
 #define ENETC_PCS_LINK_TIMER1_VAL		0x06a0
@@ -33,6 +35,7 @@ struct enetc_hw;
 struct enetc_mdio_priv {
 	struct enetc_hw *hw;
 	int mdio_base;
+	int mdc_div;
 };
 
 #if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
@@ -44,6 +47,7 @@ int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id, int devad, int regnum);
 int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad, int regnum,
 			 u16 value);
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs);
+int enetc_mdio_update_mdc_div(struct mii_bus *bus);
 
 #else
 
@@ -62,6 +66,8 @@ static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
 static inline struct enetc_hw *enetc_hw_alloc(struct device *dev,
 					      void __iomem *port_regs)
 { return ERR_PTR(-EINVAL); }
+static inline int enetc_mdio_update_mdc_div(struct mii_bus *bus)
+{ return -EINVAL; }
 
 #endif
 
-- 
2.53.0


