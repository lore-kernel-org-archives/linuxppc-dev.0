Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FC7EDE14E
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jan 2008 05:46:29 +1100 (EST)
Date: Wed, 30 Jan 2008 12:46:19 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>, Kumar Gala
	<galak@kernel.crashing.org>
Subject: [PATCH v3] powerpc: configure USB clock for MPC8315E
Message-Id: <20080130124619.32484395.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: olof@lixom.net, Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

SCCR USB bits are in a different location on the mpc8315.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
changed to detect parent node compatibility with fsl,mpc8315-immr, and
do a of_node_put when done.

 arch/powerpc/boot/dts/mpc8315erdb.dts |    2 +-
 arch/powerpc/platforms/83xx/mpc83xx.h |    2 ++
 arch/powerpc/platforms/83xx/usb.c     |   17 +++++++++++++----
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8315erdb.dts b/arch/powerpc/boot/dts/mpc8315erdb.dts
index b582032..d7a1ece 100644
--- a/arch/powerpc/boot/dts/mpc8315erdb.dts
+++ b/arch/powerpc/boot/dts/mpc8315erdb.dts
@@ -96,7 +96,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
-		compatible = "simple-bus";
+		compatible = "fsl,mpc8315-immr", "simple-bus";
 		ranges = <0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index 88bb748..68065e6 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -14,6 +14,8 @@
 #define MPC83XX_SCCR_USB_DRCM_11   0x00300000
 #define MPC83XX_SCCR_USB_DRCM_01   0x00100000
 #define MPC83XX_SCCR_USB_DRCM_10   0x00200000
+#define MPC8315_SCCR_USB_MASK      0x00c00000
+#define MPC8315_SCCR_USB_DRCM_11   0x00c00000
 #define MPC837X_SCCR_USB_DRCM_11   0x00c00000
 
 /* system i/o configuration register low */
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index 681230a..471fdd8 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -104,6 +104,7 @@ int mpc831x_usb_cfg(void)
 	u32 temp;
 	void __iomem *immap, *usb_regs;
 	struct device_node *np = NULL;
+	struct device_node *immr_node = NULL;
 	const void *prop;
 	struct resource res;
 	int ret = 0;
@@ -124,10 +125,15 @@ int mpc831x_usb_cfg(void)
 	}
 
 	/* Configure clock */
-	temp = in_be32(immap + MPC83XX_SCCR_OFFS);
-	temp &= ~MPC83XX_SCCR_USB_MASK;
-	temp |= MPC83XX_SCCR_USB_DRCM_11;  /* 1:3 */
-	out_be32(immap + MPC83XX_SCCR_OFFS, temp);
+	immr_node = of_get_parent(np);
+	if (immr_node && of_device_is_compatible(immr_node, "fsl,mpc8315-immr"))
+		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
+		                MPC8315_SCCR_USB_MASK,
+		                MPC8315_SCCR_USB_DRCM_11);
+	else
+		clrsetbits_be32(immap + MPC83XX_SCCR_OFFS,
+		                MPC83XX_SCCR_USB_MASK,
+		                MPC83XX_SCCR_USB_DRCM_11);
 
 	/* Configure pin mux for ULPI.  There is no pin mux for UTMI */
 	if (prop && !strcmp(prop, "ulpi")) {
@@ -144,6 +150,9 @@ int mpc831x_usb_cfg(void)
 
 	iounmap(immap);
 
+	if (immr_node)
+		of_node_put(immr_node);
+
 	/* Map USB SOC space */
 	ret = of_address_to_resource(np, 0, &res);
 	if (ret) {
-- 
1.5.2.2
