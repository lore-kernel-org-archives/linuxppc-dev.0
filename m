Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x235.google.com (mail-ea0-x235.google.com
 [IPv6:2a00:1450:4013:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2DC612C034F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:33:15 +1000 (EST)
Received: by mail-ea0-f181.google.com with SMTP id a11so5475371eae.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:33:12 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 05/13] net: mv643xx_eth: proper initialization for Kirkwood
 SoCs
Date: Wed, 29 May 2013 21:32:47 +0200
Message-Id: <1369855975-21489-6-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1369855975-21489-1-git-send-email-sebastian.hesselbarth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>, Lennert Buytenhek <buytenh@wantstofly.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ethernet controllers found on Kirkwood SoCs not only suffer from loosing
MAC address register contents on clock gating but also some important
registers are reset to values that would break ethernet. This patch
clears the CLK125_BYPASS_EN bit for DT enabled Kirkwood only by using
of_device_is_compatible() instead of #ifdefs. Non-DT Kirkwood is not
affected as it installs a clock gating workaround because of the MAC
address issue above. Other Orion SoCs do not suffer from register reset,
do not have the bit in question, or do not have the register at all.
Moreover, system controllers on PPC using this driver should also be
protected from clearing that bit.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Note: In contrast to the reset value of 0 for CLK125_BYPASS_EN bit as
stated in Kirkwood datasheet, we confirmed that reset value is 1 instead.
Either datasheet is wrong about it, there is some post-boot self-check or
BootROM flips that bit.

Changelog
v4->v5:
- check for device compatible instead of machine compatible
  (Suggested by Jason Gunthorpe)

Cc: David Miller <davem@davemloft.net>
Cc: Lennert Buytenhek <buytenh@wantstofly.org>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: netdev@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/net/ethernet/marvell/mv643xx_eth.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/ethernet/marvell/mv643xx_eth.c b/drivers/net/ethernet/marvell/mv643xx_eth.c
index fa8c84a..5b375ee 100644
--- a/drivers/net/ethernet/marvell/mv643xx_eth.c
+++ b/drivers/net/ethernet/marvell/mv643xx_eth.c
@@ -116,6 +116,8 @@ static char mv643xx_eth_driver_version[] = "1.4";
 #define  LINK_UP			0x00000002
 #define TXQ_COMMAND			0x0048
 #define TXQ_FIX_PRIO_CONF		0x004c
+#define PORT_SERIAL_CONTROL1		0x004c
+#define  CLK125_BYPASS_EN		0x00000010
 #define TX_BW_RATE			0x0050
 #define TX_BW_MTU			0x0058
 #define TX_BW_BURST			0x005c
@@ -2701,6 +2703,15 @@ static int mv643xx_eth_probe(struct platform_device *pdev)
 
 	mp->dev = dev;
 
+	/* Kirkwood resets some registers on gated clocks. Especially
+	 * CLK125_BYPASS_EN must be cleared but is not available on
+	 * all other SoCs/System Controllers using this driver.
+	 */
+	if (of_device_is_compatible(pdev->dev.of_node,
+				    "marvell,kirkwood-eth-port"))
+		wrlp(mp, PORT_SERIAL_CONTROL1,
+		     rdlp(mp, PORT_SERIAL_CONTROL1) & ~CLK125_BYPASS_EN);
+
 	/*
 	 * Start with a default rate, and if there is a clock, allow
 	 * it to override the default.
-- 
1.7.10.4
