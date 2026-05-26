Return-Path: <linuxppc-dev+bounces-21507-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4B1CD5BD2
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 10:27:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPpq85rc2z2y8t;
	Tue, 26 May 2026 20:27:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779791268;
	cv=none; b=LKwD2qq4xYAHPaBa0OJO+Bggmwv2XY6gSsC08tUINrSTUcRt9VGluyne6hWduwvA4AiPk93Ed1tYey0LFSML7U1Su26m0K5V7iJpus7JoGNxyhuZ3iFwI7OcPyrnYM6lug9n8Pvtn657aY4YAkCsAaoPofGxRsaCyBfidjcwoyi7nTB5xcvnREljfFlIAuVQtt6mpkmAuwcdodUXyj3kkWj7j4yDjvXCqV7LDayMwNBdzfKKIahHDYcl99+tplngLUabFsddiHnnHPhmC0sHnDcjDERNlpjSE7lNGQxgkTS9mEb3abM+ClRgkyOa9dWaN0C5s5UfifWISGvP+Zpezg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779791268; c=relaxed/relaxed;
	bh=1BZk2y1KGNMX+ccHuEp6KWVVbr1Nr9TPnS/MltAXFTI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TVQ9T8fs8QZzpfs3TmuvXAfw2DBDabDZAy3TQRvsRoKaS3vzwFqQBurzVj8lPi7a75yFFA9RVOaGTMtyGuoWC31hcc7lgHwOaFfnRi6zYaQsHG2h1gbPrpcni+xhwAjNPE+gRJrdOM+CFzhOZtABDdrzzsQ3VgJX9LQdJDgBhDDPcNfabz2XX7Uz3iccwapX8zFeIaX0DIMCdPc+T802Lcg9prZSeYK7cYbYUsaXdVNJjV9cQUmMhLh65EF0YOiIMkKVr/7RDYBLnZtoM43Qyb8y6thT1lSkD091jpP6Ekrz/wX9Kl1NI+94yycA5Hq+VDHD8RMi4rveZ/7yEJYA3g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyKKdCFN; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SyKKdCFN;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=arnd@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPpq76PPsz2xPb
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2026 20:27:47 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 29A4444425;
	Tue, 26 May 2026 10:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9501F00A3A;
	Tue, 26 May 2026 10:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779791265;
	bh=1BZk2y1KGNMX+ccHuEp6KWVVbr1Nr9TPnS/MltAXFTI=;
	h=From:To:Cc:Subject:Date;
	b=SyKKdCFN9GuMHt9XiHa/sVOfiYznVkXy51REaRbImzrnSeusFP4ZZH97TCZI3bhYy
	 NwMHKfeb0ufokz91E2VRVvKNojYtjNC8ITkf/cnzS4JRbSxd7wOHXOJpcNn0EvAjj1
	 e21iIdzG7x7CI9kmYC7lZbegajNZQ51RTPQRduko3ZU4/TykQb7lgfvSgvD7e6y7FS
	 XjFBFL+ZPlW6Ohwrg3X9cTyFUK68gsu9FpyfK9LRg5JNHn7AjcpdRnLpAfKk5cBfIR
	 pteTvV+A7+zqTXBjlwvNwaLfmH5daveHG2uIYkaa0ZB+U+ATPGHKpHSIppjn/dwzYs
	 qmBmaC1iWrt0Q==
From: Arnd Bergmann <arnd@kernel.org>
To: Wei Fang <wei.fang@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH] [net-next] net: dsa: netc: fix enetc dependencies
Date: Tue, 26 May 2026 12:26:37 +0200
Message-Id: <20260526102708.2837129-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
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

From: Arnd Bergmann <arnd@arndb.de>

The newly added netc dsa support has incorrect Kconfig dependencies,
leading to Kconfig and link failures:

WARNING: unmet direct dependencies detected for FSL_ENETC_MDIO
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=n] && NET_VENDOR_FREESCALE [=n] && PCI [=y] && PHYLIB [=y]
  Selected by [y]:
  - NET_DSA_NETC_SWITCH [=y] && NETDEVICES [=y] && (ARM64 || COMPILE_TEST [=y]) && NET_DSA [=y] && PCI [=y]
WARNING: unmet direct dependencies detected for NXP_NTMP
  Depends on [n]: NETDEVICES [=y] && ETHERNET [=n] && NET_VENDOR_FREESCALE [=n]
  Selected by [m]:
  - NET_DSA_NETC_SWITCH [=m] && NETDEVICES [=y] && (ARM64 || COMPILE_TEST [=y]) && NET_DSA [=m] && PCI [=y]
ERROR: modpost: "enetc_mdio_read_c22" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!
ERROR: modpost: "ntmp_fdbt_delete_entry" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!
ERROR: modpost: "enetc_mdio_read_c45" [drivers/net/dsa/netc/nxp-netc-switch.ko] undefined!

Add the required 'NET_VENDOR_FREESCALE' dependency to make it possible
to select both the PHY and NTMP library modules. Originally this was
meant to be done through an 'IS_REACHABLE' check in the header file,
but that did not work because the drivers/net/ethernet/freescale
directory is not even entered in this case. IS_REACHABLE() is generally
counterproductive because even when it works as intended, it turns
a helpful link-time error into a silent runtime failure that is
harder to debug. In this case, it clearly did not even do anything.

Fixes: 187fbae024c8 ("net: dsa: netc: introduce NXP NETC switch driver for i.MX94")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/dsa/netc/Kconfig   |  1 +
 include/linux/fsl/enetc_mdio.h | 22 ----------------------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/net/dsa/netc/Kconfig b/drivers/net/dsa/netc/Kconfig
index d2f78d74ac23..eaad3cb5babe 100644
--- a/drivers/net/dsa/netc/Kconfig
+++ b/drivers/net/dsa/netc/Kconfig
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config NET_DSA_NETC_SWITCH
 	tristate "NXP NETC Ethernet switch support"
+	depends on NET_VENDOR_FREESCALE
 	depends on ARM64 || COMPILE_TEST
 	depends on NET_DSA && PCI
 	select NET_DSA_TAG_NETC
diff --git a/include/linux/fsl/enetc_mdio.h b/include/linux/fsl/enetc_mdio.h
index 623ccfcbf39c..7cd5be694cc4 100644
--- a/include/linux/fsl/enetc_mdio.h
+++ b/include/linux/fsl/enetc_mdio.h
@@ -35,8 +35,6 @@ struct enetc_mdio_priv {
 	int mdio_base;
 };
 
-#if IS_REACHABLE(CONFIG_FSL_ENETC_MDIO)
-
 int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id, int regnum);
 int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id, int regnum,
 			 u16 value);
@@ -45,24 +43,4 @@ int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id, int devad, int regnum,
 			 u16 value);
 struct enetc_hw *enetc_hw_alloc(struct device *dev, void __iomem *port_regs);
 
-#else
-
-static inline int enetc_mdio_read_c22(struct mii_bus *bus, int phy_id,
-				      int regnum)
-{ return -EINVAL; }
-static inline int enetc_mdio_write_c22(struct mii_bus *bus, int phy_id,
-				       int regnum, u16 value)
-{ return -EINVAL; }
-static inline int enetc_mdio_read_c45(struct mii_bus *bus, int phy_id,
-				      int devad, int regnum)
-{ return -EINVAL; }
-static inline int enetc_mdio_write_c45(struct mii_bus *bus, int phy_id,
-				       int devad, int regnum, u16 value)
-{ return -EINVAL; }
-static inline struct enetc_hw *enetc_hw_alloc(struct device *dev,
-					      void __iomem *port_regs)
-{ return ERR_PTR(-EINVAL); }
-
-#endif
-
 #endif
-- 
2.39.5


