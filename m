Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 678EDB70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 11:02:48 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, galak@kernel.crashing.org,
	kim.phillips@freescale.com, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [REPOST][PATCH] mpc8308: fix USB DR controller initialization
Date: Wed, 27 Oct 2010 02:02:36 +0200
Message-Id: <1288137756-3389-1-git-send-email-yanok@emcraft.com>
In-Reply-To: <1282906641-25351-1-git-send-email-yanok@emcraft.com>
References: <1282906641-25351-1-git-send-email-yanok@emcraft.com>
Cc: Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

MPC8308 has ULPI pin muxing settings in SICRH register, bits 17-18
which is different from both MPC8313 and MPC8315.
Also MPC8308 doesn't have REFSEL, UTMI_PHY_EN and OTG_PORT fields
in the USB DR controller CONTROL register.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
---

Kim, Kumar,

Please consider including this patch. Without it USB initialization code
writes to the wrong bits on the MPC8308RDB.

Regards, Ilya.

 arch/powerpc/boot/dts/mpc8308rdb.dts  |    2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
 arch/powerpc/platforms/83xx/usb.c     |   21 ++++++++++++++++-----
 3 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8308rdb.dts b/arch/powerpc/boot/dts/mpc8308rdb.dts
index a97eb2d..1e2b888 100644
--- a/arch/powerpc/boot/dts/mpc8308rdb.dts
+++ b/arch/powerpc/boot/dts/mpc8308rdb.dts
@@ -109,7 +109,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		compatible = "fsl,mpc8315-immr", "simple-bus";
+		compatible = "fsl,mpc8308-immr", "simple-bus";
 		ranges = <0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 0fea881..82a4345 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -35,6 +35,8 @@
 
 /* system i/o configuration register high */
 #define MPC83XX_SICRH_OFFS         0x118
+#define MPC8308_SICRH_USB_MASK     0x000c0000
+#define MPC8308_SICRH_USB_ULPI     0x00040000
 #define MPC834X_SICRH_USB_UTMI     0x00020000
 #define MPC831X_SICRH_USB_MASK     0x000000e0
 #define MPC831X_SICRH_USB_ULPI     0x000000a0
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 3ba4bb7..2c64164 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -127,7 +127,8 @@ int mpc831x_usb_cfg(void)
 
 	/* Configure clock */
 	immr_node = of_get_parent(np);
-	if (immr_node && of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
+	if (immr_node && (of_device_is_compatible(immr_node, "fsl,mpc8315-immr") ||
+			of_device_is_compatible(immr_node, "fsl,mpc8308-immr")))
 		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
 		                MPC8315_SCCR_USB_MASK,
 		                MPC8315_SCCR_USB_DRCM_01);
@@ -138,7 +139,11 @@ int mpc831x_usb_cfg(void)
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
-		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr")) {
+		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr")) {
+			clrsetbits_be32(immap + MPC83XX_SICRH_OFFS,
+					MPC8308_SICRH_USB_MASK,
+					MPC8308_SICRH_USB_ULPI);
+		} else if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr")) {
 			clrsetbits_be32(immap + MPC83XX_SICRL_OFFS,
 					MPC8315_SICRL_USB_MASK,
 					MPC8315_SICRL_USB_ULPI);
@@ -173,6 +178,9 @@ int mpc831x_usb_cfg(void)
 		     !strcmp(prop, "utmi"))) {
 		u32 refsel;
 
+		if (of_device_is_compatible(immr_node, "fsl,mpc8308-immr"))
+			goto out;
+
 		if (of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
 			refsel = CONTROL_REFSEL_24MHZ;
 		else
@@ -186,9 +194,11 @@ int mpc831x_usb_cfg(void)
 		temp = CONTROL_PHY_CLK_SEL_ULPI;
 #ifdef CONFIG_USB_OTG
 		/* Set OTG_PORT */
-		dr_mode = of_get_property(np, "dr_mode", NULL);
-		if (dr_mode && !strcmp(dr_mode, "otg"))
-			temp |= CONTROL_OTG_PORT;
+		if (!of_device_is_compatible(immr_node, "fsl,mpc8308-immr")) {
+			dr_mode = of_get_property(np, "dr_mode", NULL);
+			if (dr_mode && !strcmp(dr_mode, "otg"))
+				temp |= CONTROL_OTG_PORT;
+		}
 #endif /* CONFIG_USB_OTG */
 		out_be32(usb_regs + FSL_USB2_CONTROL_OFFS, temp);
 	} else {
@@ -196,6 +206,7 @@ int mpc831x_usb_cfg(void)
 		ret = -EINVAL;
 	}
 
+out:
 	iounmap(usb_regs);
 	of_node_put(np);
 	return ret;
-- 
1.7.2.3
