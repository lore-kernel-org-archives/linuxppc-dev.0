Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ea0-x22c.google.com (mail-ea0-x22c.google.com
 [IPv6:2a00:1450:4013:c01::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 56A332C038F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 05:33:21 +1000 (EST)
Received: by mail-ea0-f172.google.com with SMTP id d10so5789337eaj.31
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 12:33:18 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH v5 11/13] ARM: kirkwood: remove legacy clk alias for
 mv643xx_eth
Date: Wed, 29 May 2013 21:32:53 +0200
Message-Id: <1369855975-21489-12-git-send-email-sebastian.hesselbarth@gmail.com>
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

With all boards converted to DT enabled mv643xx_eth we can now
remove the clock alias for gbe clocks.

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
 arch/arm/mach-kirkwood/board-dt.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e9647b8..8db388a 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -66,12 +66,10 @@ static void __init kirkwood_legacy_clk_init(void)
 	 */
 	clkspec.args[0] = CGC_BIT_GE0;
 	clk = of_clk_get_from_provider(&clkspec);
-	orion_clkdev_add(NULL, "mv643xx_eth_port.0", clk);
 	clk_prepare_enable(clk);
 
 	clkspec.args[0] = CGC_BIT_GE1;
 	clk = of_clk_get_from_provider(&clkspec);
-	orion_clkdev_add(NULL, "mv643xx_eth_port.1", clk);
 	clk_prepare_enable(clk);
 }
 
-- 
1.7.10.4
