Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x230.google.com (mail-ea0-x230.google.com
 [IPv6:2a00:1450:4013:c01::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A517A2C034F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:33:13 +1000 (EST)
Received: by mail-ea0-f176.google.com with SMTP id k11so5458370eaj.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:33:09 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 03/13] net: mv643xx_eth: add phy_node to platform_data
 struct
Date: Wed, 29 May 2013 21:32:45 +0200
Message-Id: <1369855975-21489-4-git-send-email-sebastian.hesselbarth@gmail.com>
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

This adds a struct device_node pointer for a phy passed by phandle
to mv643xx_eth node.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
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
 include/linux/mv643xx_eth.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/mv643xx_eth.h b/include/linux/mv643xx_eth.h
index 141d395..6e8215b 100644
--- a/include/linux/mv643xx_eth.h
+++ b/include/linux/mv643xx_eth.h
@@ -30,6 +30,7 @@ struct mv643xx_eth_shared_platform_data {
 #define MV643XX_ETH_PHY_ADDR(x)		(0x80 | (x))
 #define MV643XX_ETH_PHY_NONE		0xff
 
+struct device_node;
 struct mv643xx_eth_platform_data {
 	/*
 	 * Pointer back to our parent instance, and our port number.
@@ -41,6 +42,7 @@ struct mv643xx_eth_platform_data {
 	 * Whether a PHY is present, and if yes, at which address.
 	 */
 	int			phy_addr;
+	struct device_node	*phy_node;
 
 	/*
 	 * Use this MAC address if it is valid, overriding the
-- 
1.7.10.4
