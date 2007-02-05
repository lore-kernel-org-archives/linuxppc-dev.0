Return-Path: <b07421@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 302B4DDECE
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 07:43:51 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	l15KhiRw001134
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 13:43:44 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l15Khhox013758
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 14:43:43 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32 [10.82.19.112])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	l15KPVnh013612
	for <linuxppc-dev@ozlabs.org>; Mon, 5 Feb 2007 14:25:32 -0600 (CST)
Received: from ld0162-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0162-tx32.am.freescale.net (Postfix) with ESMTP id 947244B927
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 14:43:37 -0600 (CST)
Received: (from b07421@localhost)
	by ld0162-tx32.am.freescale.net (8.12.11/8.12.11/Submit) id
	l15Khb7S003692
	for linuxppc-dev@ozlabs.org; Mon, 5 Feb 2007 14:43:37 -0600
Date: Mon, 5 Feb 2007 14:43:37 -0600
From: Scott Wood <scottwood@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 1/2] 83xx: ioremap() the entire IMMR for misc register blocks.
Message-ID: <20070205204337.GA3683@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than add each component of the IMMR to the device tree as a
separate device, the entire IMMR is made available for code which
wants to access registers at known locations.

This is intended to be used for simple things are very unlikely to be
moved or duplicated, such as reset registers.

To avoid accidentally touching another soc family in the event that
support for multiple families is built into the kernel (at some future
date where that is supported), a compatible property is added to the
device tree soc node.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/boot/dts/mpc8349emds.dts  |    1 +
 arch/powerpc/boot/dts/mpc8349emitx.dts |    1 +
 arch/powerpc/boot/dts/mpc8360emds.dts  |    1 +
 arch/powerpc/sysdev/fsl_soc.c          |   29 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.h          |    3 +++
 5 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/boot/dts/mpc8349emds.dts
index efceb34..c7ff2f1 100644
--- a/arch/powerpc/boot/dts/mpc8349emds.dts
+++ b/arch/powerpc/boot/dts/mpc8349emds.dts
@@ -47,6 +47,7 @@
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
 		bus-frequency = <0>;
+		compatible = "mpc8349\0mpc834x\0mpc83xx";
 
 		wdt@200 {
 			device_type = "watchdog";
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 27807fc..0a3dde8 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -46,6 +46,7 @@
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
 		bus-frequency = <0>;                    // from bootloader
+		compatible = "mpc8349\0mpc834x\0mpc83xx";
 
 		wdt@200 {
 			device_type = "watchdog";
diff --git a/arch/powerpc/boot/dts/mpc8360emds.dts b/arch/powerpc/boot/dts/mpc8360emds.dts
index 9022192..6e3f708 100644
--- a/arch/powerpc/boot/dts/mpc8360emds.dts
+++ b/arch/powerpc/boot/dts/mpc8360emds.dts
@@ -62,6 +62,7 @@
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 00000200>;
 		bus-frequency = <FBC5200>;
+		compatible = "mpc8360\0mpc836x\0mpc83xx";
 
 		wdt@200 {
 			device_type = "watchdog";
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index ad31e56..e395936 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -63,6 +63,35 @@ phys_addr_t get_immrbase(void)
 
 EXPORT_SYMBOL(get_immrbase);
 
+#ifdef CONFIG_83xx
+void __iomem *mpc83xx_immr;
+#endif
+
+static int __init map_immr(void)
+{
+	struct device_node *soc;
+
+	soc = of_find_node_by_type(NULL, "soc");
+	if (soc) {
+		struct resource res;
+		int ret = of_address_to_resource(soc, 0, &res);
+		if (ret)
+			return ret;
+
+#ifdef CONFIG_83xx
+		if (device_is_compatible(soc, "mpc83xx"))
+			mpc83xx_immr = ioremap(res.start,
+			                       res.end - res.start + 1);
+#endif
+
+		of_node_put(soc);
+	};
+
+	return 0;
+}
+
+arch_initcall(map_immr);
+
 #ifdef CONFIG_CPM2
 
 static u32 brgfreq = -1;
diff --git a/arch/powerpc/sysdev/fsl_soc.h b/arch/powerpc/sysdev/fsl_soc.h
index 04e145b..a02978e 100644
--- a/arch/powerpc/sysdev/fsl_soc.h
+++ b/arch/powerpc/sysdev/fsl_soc.h
@@ -2,11 +2,14 @@
 #define __PPC_FSL_SOC_H
 #ifdef __KERNEL__
 
+#include <linux/compiler.h>
 #include <asm/mmu.h>
 
 extern phys_addr_t get_immrbase(void);
 extern u32 get_brgfreq(void);
 extern u32 get_baudrate(void);
 
+extern void __iomem *mpc83xx_immr;
+
 #endif
 #endif
-- 
1.4.4
