Return-Path: <sebastian.hesselbarth@gmail.com>
Received: from mail-ee0-f45.google.com (mail-ee0-f45.google.com [74.125.83.45])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4B2042C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 06:04:16 +1000 (EST)
Received: by mail-ee0-f45.google.com with SMTP id l10so1447848eei.32
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 13:04:12 -0700 (PDT)
From: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
To: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH 1/2] ARM: kirkwood: proper retain MAC address workaround on DT
 ethernet
Date: Wed, 22 May 2013 22:04:01 +0200
Message-Id: <1369253042-15082-1-git-send-email-sebastian.hesselbarth@gmail.com>
In-Reply-To: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1369154510-4927-1-git-send-email-sebastian.hesselbarth@gmail.com>
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

Kirkwood ethernet controllers suffer from loosing MAC register content
on gated clocks. In the past this was prevented by not gating the ethernet
controller clocks. With DT support for mv643xx_eth and corresponding
nodes available, a different approach is more reasonable.

This patch replaces the former clock gating workaround by parsing the
ethernet controller nodes for *invalid* MAC addresses and overwrites
the local-mac-address property with MAC register contents early. The
clock can now properly gated in modular mv643xx_eth and DT agnostic
boot loader scenarios because mv643xx_eth will find the stored MAC
in the corresponding MAC address property.

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
 arch/arm/mach-kirkwood/board-dt.c |   67 +++++++++++++++++++++++++++++--------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index a86b41c..0aad9f7 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -13,6 +13,8 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_net.h>
 #include <linux/of_platform.h>
 #include <linux/clk-provider.h>
 #include <linux/clk/mvebu.h>
@@ -31,6 +33,56 @@ static struct of_device_id kirkwood_dt_match_table[] __initdata = {
 };
 
 /*
+ * Kirkwood ethernet controllers suffer from loosing the MAC address
+ * register content on gated clocks. Rather than always ungate the
+ * clocks, we get the MAC address early and put it into DT for those
+ * boot loaders that don't provide a valid MAC address property.
+ */
+#define ETH_MAC_ADDR_L(n)	(0x400 + ((n) * 0x400) + 0x14)
+#define ETH_MAC_ADDR_H(n)	(0x400 + ((n) * 0x400) + 0x18)
+
+static void __init kirkwood_dt_eth_quirk(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "marvell,orion-eth") {
+		struct device_node *pnp;
+		void __iomem *base;
+
+		if (!of_device_is_available(np))
+			continue;
+
+		base = of_iomap(np, 0);
+		if (!base)
+			continue;
+
+		for_each_available_child_of_node(np, pnp) {
+			const void *mac_addr;
+			struct property *p;
+			u32 n, reg[2];
+
+			mac_addr = of_get_mac_address(pnp);
+			if (mac_addr)
+				continue;
+
+			p = of_find_property(pnp, "local-mac-address", NULL);
+			if (!p || p->length != 6)
+				continue;
+
+			if (of_property_read_u32(pnp, "reg", &n))
+				continue;
+
+			reg[0] = cpu_to_be32(readl(base + ETH_MAC_ADDR_H(n)));
+			reg[1] = cpu_to_be32(readl(base +
+						   ETH_MAC_ADDR_L(n)) << 16);
+			memcpy((void *)p->value, reg, 6);
+		}
+
+		iounmap(base);
+	}
+}
+
+/*
  * There are still devices that doesn't know about DT yet.  Get clock
  * gates here and add a clock lookup alias, so that old platform
  * devices still work.
@@ -42,7 +94,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	struct device_node *np = of_find_compatible_node(
 		NULL, NULL, "marvell,kirkwood-gating-clock");
 	struct of_phandle_args clkspec;
-	struct clk *clk;
 
 	clkspec.np = np;
 	clkspec.args_count = 1;
@@ -58,19 +109,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clkspec.args[0] = CGC_BIT_SDIO;
 	orion_clkdev_add(NULL, "mvsdio",
 			 of_clk_get_from_provider(&clkspec));
-
-	/*
-	 * The ethernet interfaces forget the MAC address assigned by
-	 * u-boot if the clocks are turned off. Until proper DT support
-	 * is available we always enable them for now.
-	 */
-	clkspec.args[0] = CGC_BIT_GE0;
-	clk = of_clk_get_from_provider(&clkspec);
-	clk_prepare_enable(clk);
-
-	clkspec.args[0] = CGC_BIT_GE1;
-	clk = of_clk_get_from_provider(&clkspec);
-	clk_prepare_enable(clk);
 }
 
 static void __init kirkwood_of_clk_init(void)
@@ -97,6 +135,7 @@ static void __init kirkwood_dt_init(void)
 
 	/* Setup root of clk tree */
 	kirkwood_of_clk_init();
+	kirkwood_dt_eth_quirk();
 
 	kirkwood_cpuidle_init();
 
-- 
1.7.10.4
