Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22b.google.com (mail-ea0-x22b.google.com
 [IPv6:2a00:1450:4013:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 35E1B2C0361
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:33:20 +1000 (EST)
Received: by mail-ea0-f171.google.com with SMTP id b15so5618331eae.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:33:16 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 10/13] ARM: dove: remove legacy mv643xx_eth setup
Date: Wed, 29 May 2013 21:32:52 +0200
Message-Id: <1369855975-21489-11-git-send-email-sebastian.hesselbarth@gmail.com>
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

With DT support for mv643xx_eth we do not need legacy platform_data
based setup for DT enabled boards anymore.

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
 arch/arm/mach-dove/board-dt.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 0b14280..048e942 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -34,10 +34,6 @@ static void __init dove_legacy_clk_init(void)
 	clkspec.np = np;
 	clkspec.args_count = 1;
 
-	clkspec.args[0] = CLOCK_GATING_BIT_GBE;
-	orion_clkdev_add(NULL, "mv643xx_eth_port.0",
-			 of_clk_get_from_provider(&clkspec));
-
 	clkspec.args[0] = CLOCK_GATING_BIT_PCIE0;
 	orion_clkdev_add("0", "pcie",
 			 of_clk_get_from_provider(&clkspec));
@@ -53,10 +49,6 @@ static void __init dove_of_clk_init(void)
 	dove_legacy_clk_init();
 }
 
-static struct mv643xx_eth_platform_data dove_dt_ge00_data = {
-	.phy_addr = MV643XX_ETH_PHY_ADDR_DEFAULT,
-};
-
 static void __init dove_dt_init(void)
 {
 	pr_info("Dove 88AP510 SoC\n");
@@ -70,7 +62,6 @@ static void __init dove_dt_init(void)
 	dove_of_clk_init();
 
 	/* Internal devices not ported to DT yet */
-	dove_ge00_init(&dove_dt_ge00_data);
 	dove_pcie_init(1, 1);
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-- 
1.7.10.4
