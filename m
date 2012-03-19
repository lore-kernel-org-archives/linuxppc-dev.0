Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 94810B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2012 19:51:28 +1100 (EST)
From: Anatolij Gustschin <agust@denx.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/mpc52xx: setup port_config and CDM settings through DT
Date: Mon, 19 Mar 2012 09:51:22 +0100
Message-Id: <1332147082-4363-1-git-send-email-agust@denx.de>
In-Reply-To: <1303193045-20111-1-git-send-email-hs@denx.de>
References: <1303193045-20111-1-git-send-email-hs@denx.de>
Cc: devictree-discuss@lists.ozlabs.org, Heiko Schocher <hs@denx.de>,
 Grant Likely <glikely@secretlab.ca>, Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Heiko Schocher <hs@denx.de>

If firmware does not setup the "GPS Port Configuration Register"
and the "CDM 48MHz Fractional Divider Configuration Register",
it can be corrected by additional properties in the device tree.
Add appropriate code to utility functions and document used
bindings.

Signed-off-by: Heiko Schocher <hs@denx.de>
cc: devictree-discuss@lists.ozlabs.org
cc: linuxppc-dev@lists.ozlabs.org
cc: Grant Likely <glikely@secretlab.ca>
cc: Wolfgang Denk <wd@denx.de>
Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 .../devicetree/bindings/powerpc/fsl/mpc5200.txt    |   17 ++++++++++++
 arch/powerpc/platforms/52xx/mpc52xx_common.c       |   27 ++++++++++++++++++++
 2 files changed, 44 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
index 4ccb2cd..4478585 100644
--- a/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
+++ b/Documentation/devicetree/bindings/powerpc/fsl/mpc5200.txt
@@ -155,6 +155,10 @@ Each GPIO controller node should have the empty property gpio-controller and
 according to the bit numbers in the GPIO control registers. The second cell
 is for flags which is currently unused.
 
+If firmware does not setup pin-multiplexing (port_config) correct, it
+can be modified through the "fsl,init-port-config" property in the
+"fsl,mpc5200-gpio" node.
+
 fsl,mpc5200-fec nodes
 ---------------------
 The FEC node can specify one of the following properties to configure
@@ -196,3 +200,16 @@ External interrupts:
 fsl,mpc5200-mscan nodes
 -----------------------
 See file can.txt in this directory.
+
+fsl,mpc5200-cdm nodes
+---------------------
+- setup "CDM 48MHz Fractional Divider Configuration Register"
+  If firmware does not setup this register correct, you can
+  modify it using the following properties:
+
+  - fsl,init-ext-48mhz-en
+    see MPC5200BUM Table 5-11 Bits 5-7
+  - fsl,init-fd-enable
+    see MPC5200BUM Table 5-11 Bit 15
+  - fsl,init-fd-counters
+    see MPC5200BUM Table 5-11 Bits 16-31
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_common.c b/arch/powerpc/platforms/52xx/mpc52xx_common.c
index 369fd54..a499848 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_common.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -137,6 +137,8 @@ void __init
 mpc52xx_map_common_devices(void)
 {
 	struct device_node *np;
+	const u32 *prop;
+	int plen;
 
 	/* mpc52xx_wdt is mapped here and used in mpc52xx_restart,
 	 * possibly from a interrupt context. wdt is only implement
@@ -154,11 +156,36 @@ mpc52xx_map_common_devices(void)
 	/* Clock Distribution Module, used by PSC clock setting function */
 	np = of_find_matching_node(NULL, mpc52xx_cdm_ids);
 	mpc52xx_cdm = of_iomap(np, 0);
+	prop = of_get_property(np, "fsl,init-ext-48mhz-en", &plen);
+	if (prop) {
+		pr_debug("ext-48mhz-en: old:%x new:%x\n",
+			in_8(&mpc52xx_cdm->ext_48mhz_en), *prop);
+		out_8(&mpc52xx_cdm->ext_48mhz_en, *prop & 0x07);
+	}
+	prop = of_get_property(np, "fsl,init-fd-enable", &plen);
+	if (prop) {
+		pr_debug("fd-enable: old:%x new:%x\n",
+			in_8(&mpc52xx_cdm->fd_enable), *prop);
+		out_8(&mpc52xx_cdm->fd_enable, *prop & 0x01);
+	}
+	prop = of_get_property(np, "fsl,init-fd-counters", &plen);
+	if (prop) {
+		pr_debug("fd-counters: old:%x new:%x\n",
+			in_be16(&mpc52xx_cdm->fd_counters), *prop);
+		out_be16(&mpc52xx_cdm->fd_counters, *prop & 0x7777);
+	}
 	of_node_put(np);
 
 	/* simple_gpio registers */
 	np = of_find_matching_node(NULL, mpc52xx_gpio_simple);
 	simple_gpio = of_iomap(np, 0);
+	/* fixup the port_config register */
+	prop = of_get_property(np, "fsl,init-port-config", &plen);
+	if (prop) {
+		pr_debug("port-config: old:%x new:%x\n",
+			in_be32(&simple_gpio->port_config), *prop);
+		out_be32(&simple_gpio->port_config, *prop);
+	}
 	of_node_put(np);
 
 	/* wkup_gpio registers */
-- 
1.7.7.6
