Return-Path: <joe.hamman@embeddedspecialties.com>
Received: from mail.embeddedspecialties.com (mail.embeddedspecialties.com
	[74.94.113.177])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12930DDF13
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 08:57:37 +1000 (EST)
Subject: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
From: Joe Hamman <joe.hamman@embeddedspecialties.com>
To: galak@kernel.crashing.org
Content-Type: text/plain
Date: Mon, 13 Aug 2007 17:37:49 -0500
Message-Id: <1187044669.10295.4.camel@server>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: joe.hamman@embeddedspecialties.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Allow the address of the Ten Bit Interface (TBI) to be changed in the
event of a conflict with another device.

Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>
---

Please ignore the last patch - I missed a cut & paste error on the range
that my testing didn't catch.
---

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 81ef81c..b4813d9 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -2276,6 +2276,14 @@ config GFAR_NAPI
 	bool "NAPI Support"
 	depends on GIANFAR
 
+config GFAR_TBIPA_VALUE
+	hex "Ten Bit Interface Port Address Value"
+	depends on GIANFAR
+	range 0 0x1f
+	default "0x1f"
+	help
+	  Select an address that does not conflict with other addresses on the board.
+
 config UCC_GETH
 	tristate "Freescale QE Gigabit Ethernet"
 	depends on QUICC_ENGINE
diff --git a/drivers/net/gianfar.c b/drivers/net/gianfar.c
index f926905..91ae0d3 100644
--- a/drivers/net/gianfar.c
+++ b/drivers/net/gianfar.c
@@ -490,15 +490,15 @@ static void gfar_configure_serdes(struct net_device *dev)
 	/* Initialise TBI i/f to communicate with serdes (lynx phy) */
 
 	/* Single clk mode, mii mode off(for aerdes communication) */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_TBICON, TBICON_CLK_SELECT);
+	gfar_local_mdio_write(regs, CONFIG_GFAR_TBIPA_VALUE, MII_TBICON, TBICON_CLK_SELECT);
 
 	/* Supported pause and full-duplex, no half-duplex */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_ADVERTISE,
+	gfar_local_mdio_write(regs, CONFIG_GFAR_TBIPA_VALUE, MII_ADVERTISE,
 			ADVERTISE_1000XFULL | ADVERTISE_1000XPAUSE |
 			ADVERTISE_1000XPSE_ASYM);
 
 	/* ANEG enable, restart ANEG, full duplex mode, speed[1] set */
-	gfar_local_mdio_write(regs, TBIPA_VALUE, MII_BMCR, BMCR_ANENABLE |
+	gfar_local_mdio_write(regs, CONFIG_GFAR_TBIPA_VALUE, MII_BMCR, BMCR_ANENABLE |
 			BMCR_ANRESTART | BMCR_FULLDPLX | BMCR_SPEED1000);
 }
 
@@ -547,7 +547,7 @@ static void init_registers(struct net_device *dev)
 	gfar_write(&priv->regs->minflr, MINFLR_INIT_SETTINGS);
 
 	/* Assign the TBI an address which won't conflict with the PHYs */
-	gfar_write(&priv->regs->tbipa, TBIPA_VALUE);
+	gfar_write(&priv->regs->tbipa, CONFIG_GFAR_TBIPA_VALUE);
 }
 
 
diff --git a/drivers/net/gianfar.h b/drivers/net/gianfar.h
index d8e779c..0fd1c02 100644
--- a/drivers/net/gianfar.h
+++ b/drivers/net/gianfar.h
@@ -131,7 +131,6 @@ extern const char gfar_driver_version[];
 #define DEFAULT_RXCOUNT	16
 #define DEFAULT_RXTIME	4
 
-#define TBIPA_VALUE		0x1f
 #define MIIMCFG_INIT_VALUE	0x00000007
 #define MIIMCFG_RESET           0x80000000
 #define MIIMIND_BUSY            0x00000001
