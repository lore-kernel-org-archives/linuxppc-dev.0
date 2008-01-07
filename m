Return-Path: <LeoLi@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C0CE2DDE18
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jan 2008 22:53:41 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m07BrZph000151
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 04:53:35 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net
	[10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m07BrVDM024529
	for <linuxppc-dev@ozlabs.org>; Mon, 7 Jan 2008 05:53:34 -0600 (CST)
From: Li Yang <leoli@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org
Subject: [PATCH 2/3] add MPC837x USB platform support
Date: Mon,  7 Jan 2008 20:03:19 +0800
Message-Id: <1199707400-23588-2-git-send-email-leoli@freescale.com>
In-Reply-To: <1199707400-23588-1-git-send-email-leoli@freescale.com>
References: <1199707400-23588-1-git-send-email-leoli@freescale.com>
Cc: Li Yang <leoli@freescale.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add chip specific and board specific initialization for MPC837x USB.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 arch/powerpc/platforms/83xx/mpc837x_mds.c |   48 +++++++++++++++++++++++++++++
 arch/powerpc/platforms/83xx/mpc83xx.h     |    3 ++
 arch/powerpc/platforms/83xx/usb.c         |   39 +++++++++++++++++++++++
 3 files changed, 90 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/83xx/mpc837x_mds.c b/arch/powerpc/platforms/83xx/mpc837x_mds.c
index 166c111..de60872 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_mds.c
@@ -27,6 +27,53 @@ unsigned long isa_io_base = 0;
 unsigned long isa_mem_base = 0;
 #endif
 
+#define BCSR12_USB_SER_MASK	0x8a
+#define BCSR12_USB_SER_PIN	0x80
+#define BCSR12_USB_SER_DEVICE	0x02
+extern int mpc837x_usb_cfg(void);
+
+static int mpc837xmds_usb_cfg(void)
+{
+	struct device_node *np;
+	const void *phy_type, *mode;
+	void __iomem *bcsr_regs = NULL;
+	u8 bcsr12;
+	int ret;
+
+	ret = mpc837x_usb_cfg();
+	if (ret)
+		return ret;
+	/* Map BCSR area */
+	np = of_find_node_by_name(NULL, "bcsr");
+	if (np) {
+		struct resource res;
+
+		of_address_to_resource(np, 0, &res);
+		bcsr_regs = ioremap(res.start, res.end - res.start + 1);
+		of_node_put(np);
+	}
+	if (!bcsr_regs)
+		return -1;
+
+	np = of_find_node_by_name(NULL, "usb");
+	phy_type = of_get_property(np, "phy_type", NULL);
+	if (phy_type && !strcmp(phy_type, "ulpi")) {
+		clrbits8(bcsr_regs + 12, BCSR12_USB_SER_PIN);
+	} else if (phy_type && !strcmp(phy_type, "serial")) {
+		mode = of_get_property(np, "dr_mode", NULL);
+		bcsr12 = in_8(bcsr_regs + 12) & ~BCSR12_USB_SER_MASK;
+		bcsr12 |= BCSR12_USB_SER_PIN;
+		if (mode && !strcmp(mode, "peripheral"))
+			bcsr12 |= BCSR12_USB_SER_DEVICE;
+		out_8(bcsr_regs + 12, bcsr12);
+	} else {
+		printk(KERN_ERR "USB DR: unsupported PHY\n");
+	}
+
+	iounmap(bcsr_regs);
+	return 0;
+}
+
 /* ************************************************************************
  *
  * Setup the architecture
@@ -45,6 +92,7 @@ static void __init mpc837x_mds_setup_arch(void)
 	for_each_compatible_node(np, "pci", "fsl,mpc8349-pci")
 		mpc83xx_add_bridge(np);
 #endif
+	mpc837xmds_usb_cfg();
 }
 
 static struct of_device_id mpc837x_ids[] = {
diff --git a/arch/powerpc/platforms/83xx/mpc83xx.h b/arch/powerpc/platforms/83xx/mpc83xx.h
index b778cb4..88bb748 100644
--- a/arch/powerpc/platforms/83xx/mpc83xx.h
+++ b/arch/powerpc/platforms/83xx/mpc83xx.h
@@ -14,6 +14,7 @@
 #define MPC83XX_SCCR_USB_DRCM_11   0x00300000
 #define MPC83XX_SCCR_USB_DRCM_01   0x00100000
 #define MPC83XX_SCCR_USB_DRCM_10   0x00200000
+#define MPC837X_SCCR_USB_DRCM_11   0x00c00000
 
 /* system i/o configuration register low */
 #define MPC83XX_SICRL_OFFS         0x114
@@ -22,6 +23,8 @@
 #define MPC834X_SICRL_USB1         0x20000000
 #define MPC831X_SICRL_USB_MASK     0x00000c00
 #define MPC831X_SICRL_USB_ULPI     0x00000800
+#define MPC837X_SICRL_USB_MASK     0xf0000000
+#define MPC837X_SICRL_USB_ULPI     0x50000000
 
 /* system i/o configuration register high */
 #define MPC83XX_SICRH_OFFS         0x118
diff --git a/arch/powerpc/platforms/83xx/usb.c b/arch/powerpc/platforms/83xx/usb.c
index b45160f..2985c9c 100644
--- a/arch/powerpc/platforms/83xx/usb.c
+++ b/arch/powerpc/platforms/83xx/usb.c
@@ -179,3 +179,42 @@ int mpc831x_usb_cfg(void)
 	return ret;
 }
 #endif /* CONFIG_PPC_MPC831x */
+
+#ifdef CONFIG_PPC_MPC837x
+int mpc837x_usb_cfg(void)
+{
+	void __iomem *immap;
+	struct device_node *np = NULL;
+	const void *prop;
+	int ret = 0;
+
+	np = of_find_compatible_node(NULL, "usb", "fsl-usb2-dr");
+	if (!np)
+		return -ENODEV;
+	prop = of_get_property(np, "phy_type", NULL);
+
+	if (strcmp(prop, "ulpi") && strcmp(prop, "serial")) {
+		printk(KERN_WARNING "837x USB PHY type not supported\n");
+		return -EINVAL;
+	}
+
+	/* Map IMMR space for pin and clock settings */
+	immap = ioremap(get_immrbase(), 0x1000);
+	if (!immap) {
+		of_node_put(np);
+		return -ENOMEM;
+	}
+
+	/* Configure clock */
+	clrsetbits_be32(immap + MPC83XX_SCCR_OFFS, MPC837X_SCCR_USB_DRCM_11,
+			MPC837X_SCCR_USB_DRCM_11);
+
+	/* Configure pin mux for ULPI/serial */
+	clrsetbits_be32(immap + MPC83XX_SICRL_OFFS, MPC837X_SICRL_USB_MASK,
+			MPC837X_SICRL_USB_ULPI);
+
+	iounmap(immap);
+	of_node_put(np);
+	return ret;
+}
+#endif /* CONFIG_PPC_MPC837x */
-- 
1.5.3.5.643.g40e25
