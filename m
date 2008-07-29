Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC88CDE55F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 06:29:48 +1000 (EST)
Date: Tue, 29 Jul 2008 15:29:24 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/fsl: proliferate simple-bus compatibility to soc nodes
Message-Id: <20080729152924.65a02311.kim.phillips@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: mr.scada@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

add simple-bus compatible property to soc nodes for 83xx/85xx platforms
that were missing them.  Add same to platform probe code.

This fixes SoC device drivers (such as talitos) to succeed in matching
devices present in the soc node.

also update mpc836x_rdk dts to new SEC bindings (overlooked in commit
3fd4473: powerpc/fsl: update crypto node definition and device tree
instances).

Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
---
 arch/powerpc/boot/dts/mpc832x_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc832x_rdb.dts     |    1 +
 arch/powerpc/boot/dts/mpc8349emitx.dts    |    1 +
 arch/powerpc/boot/dts/mpc8349emitxgp.dts  |    1 +
 arch/powerpc/boot/dts/mpc834x_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc836x_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc836x_rdk.dts     |   16 ++++++----------
 arch/powerpc/boot/dts/mpc8377_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc8378_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc8379_mds.dts     |    1 +
 arch/powerpc/boot/dts/mpc8536ds.dts       |    1 +
 arch/powerpc/boot/dts/mpc8540ads.dts      |    1 +
 arch/powerpc/boot/dts/mpc8541cds.dts      |    1 +
 arch/powerpc/boot/dts/mpc8544ds.dts       |    1 +
 arch/powerpc/boot/dts/mpc8548cds.dts      |    1 +
 arch/powerpc/boot/dts/mpc8555cds.dts      |    1 +
 arch/powerpc/boot/dts/mpc8560ads.dts      |    1 +
 arch/powerpc/boot/dts/mpc8568mds.dts      |    1 +
 arch/powerpc/boot/dts/mpc8572ds.dts       |    1 +
 arch/powerpc/platforms/83xx/mpc832x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc832x_rdb.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    1 +
 arch/powerpc/platforms/83xx/mpc834x_mds.c |    1 +
 arch/powerpc/platforms/83xx/mpc836x_mds.c |    1 +
 arch/powerpc/platforms/83xx/sbc834x.c     |    1 +
 arch/powerpc/platforms/85xx/ksi8560.c     |    1 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 arch/powerpc/platforms/85xx/sbc8560.c     |    1 +
 31 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 7345743..fbc9304 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -68,6 +68,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <132000000>;
diff --git a/arch/powerpc/boot/dts/mpc832x_rdb.dts b/arch/powerpc/boot/dts/mpc832x_rdb.dts
index e74c045..b157d18 100644
--- a/arch/powerpc/boot/dts/mpc832x_rdb.dts
+++ b/arch/powerpc/boot/dts/mpc832x_rdb.dts
@@ -51,6 +51,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8349emitx.dts b/arch/powerpc/boot/dts/mpc8349emitx.dts
index 8dfab56..700e076 100644
--- a/arch/powerpc/boot/dts/mpc8349emitx.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitx.dts
@@ -52,6 +52,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;                    // from bootloader
diff --git a/arch/powerpc/boot/dts/mpc8349emitxgp.dts b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
index 49ca349..cdd3063 100644
--- a/arch/powerpc/boot/dts/mpc8349emitxgp.dts
+++ b/arch/powerpc/boot/dts/mpc8349emitxgp.dts
@@ -50,6 +50,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;                    // from bootloader
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index ba586cb..783241c 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -57,6 +57,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc836x_mds.dts b/arch/powerpc/boot/dts/mpc836x_mds.dts
index 3701dae..a3b76a7 100644
--- a/arch/powerpc/boot/dts/mpc836x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc836x_mds.dts
@@ -61,6 +61,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <264000000>;
diff --git a/arch/powerpc/boot/dts/mpc836x_rdk.dts b/arch/powerpc/boot/dts/mpc836x_rdk.dts
index 8acd1d6..89c9202 100644
--- a/arch/powerpc/boot/dts/mpc836x_rdk.dts
+++ b/arch/powerpc/boot/dts/mpc836x_rdk.dts
@@ -149,18 +149,14 @@
 		};
 
 		crypto@30000 {
-			compatible = "fsl,sec2-crypto";
+			compatible = "fsl,sec2.0";
 			reg = <0x30000 0x10000>;
-			interrupts = <11 8>;
+			interrupts = <11 0x8>;
 			interrupt-parent = <&ipic>;
-			num-channels = <4>;
-			channel-fifo-len = <24>;
-			exec-units-mask = <0x7e>;
-			/*
-			 * desc mask is for rev1.x, we need runtime fixup
-			 * for >=2.x
-			 */
-			descriptor-types-mask = <0x1010ebf>;
+			fsl,num-channels = <4>;
+			fsl,channel-fifo-len = <24>;
+			fsl,exec-units-mask = <0x7e>;
+			fsl,descriptor-types-mask = <0x01010ebf>;
 		};
 
 		ipic: interrupt-controller@700 {
diff --git a/arch/powerpc/boot/dts/mpc8377_mds.dts b/arch/powerpc/boot/dts/mpc8377_mds.dts
index 0a700cb..432782b 100644
--- a/arch/powerpc/boot/dts/mpc8377_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8377_mds.dts
@@ -117,6 +117,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8378_mds.dts b/arch/powerpc/boot/dts/mpc8378_mds.dts
index 29c8c76..ed32c8d 100644
--- a/arch/powerpc/boot/dts/mpc8378_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8378_mds.dts
@@ -117,6 +117,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8379_mds.dts b/arch/powerpc/boot/dts/mpc8379_mds.dts
index d641a89..f4db9ed 100644
--- a/arch/powerpc/boot/dts/mpc8379_mds.dts
+++ b/arch/powerpc/boot/dts/mpc8379_mds.dts
@@ -117,6 +117,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x00100000>;
 		reg = <0xe0000000 0x00000200>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8536ds.dts b/arch/powerpc/boot/dts/mpc8536ds.dts
index 02cfa24..1505d68 100644
--- a/arch/powerpc/boot/dts/mpc8536ds.dts
+++ b/arch/powerpc/boot/dts/mpc8536ds.dts
@@ -49,6 +49,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xffe00000 0x100000>;
 		reg = <0xffe00000 0x1000>;
 		bus-frequency = <0>;		// Filled out by uboot.
diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts b/arch/powerpc/boot/dts/mpc8540ads.dts
index f2273a8..9568bfa 100644
--- a/arch/powerpc/boot/dts/mpc8540ads.dts
+++ b/arch/powerpc/boot/dts/mpc8540ads.dts
@@ -53,6 +53,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x100000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8541cds.dts b/arch/powerpc/boot/dts/mpc8541cds.dts
index c4469f1..6480f4f 100644
--- a/arch/powerpc/boot/dts/mpc8541cds.dts
+++ b/arch/powerpc/boot/dts/mpc8541cds.dts
@@ -53,6 +53,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8544ds.dts b/arch/powerpc/boot/dts/mpc8544ds.dts
index 7d3829d..f1fb207 100644
--- a/arch/powerpc/boot/dts/mpc8544ds.dts
+++ b/arch/powerpc/boot/dts/mpc8544ds.dts
@@ -54,6 +54,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
diff --git a/arch/powerpc/boot/dts/mpc8548cds.dts b/arch/powerpc/boot/dts/mpc8548cds.dts
index d84466b..431b496 100644
--- a/arch/powerpc/boot/dts/mpc8548cds.dts
+++ b/arch/powerpc/boot/dts/mpc8548cds.dts
@@ -58,6 +58,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;	// CCSRBAR
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8555cds.dts b/arch/powerpc/boot/dts/mpc8555cds.dts
index e03a780..d833a5c 100644
--- a/arch/powerpc/boot/dts/mpc8555cds.dts
+++ b/arch/powerpc/boot/dts/mpc8555cds.dts
@@ -53,6 +53,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;	// CCSRBAR 1M
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8560ads.dts b/arch/powerpc/boot/dts/mpc8560ads.dts
index ba8159d..4d1f2f2 100644
--- a/arch/powerpc/boot/dts/mpc8560ads.dts
+++ b/arch/powerpc/boot/dts/mpc8560ads.dts
@@ -53,6 +53,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x200>;
 		bus-frequency = <330000000>;
diff --git a/arch/powerpc/boot/dts/mpc8568mds.dts b/arch/powerpc/boot/dts/mpc8568mds.dts
index 9c30a34..a15f103 100644
--- a/arch/powerpc/boot/dts/mpc8568mds.dts
+++ b/arch/powerpc/boot/dts/mpc8568mds.dts
@@ -60,6 +60,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xe0000000 0x100000>;
 		reg = <0xe0000000 0x1000>;
 		bus-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc8572ds.dts b/arch/powerpc/boot/dts/mpc8572ds.dts
index 08c61e3..e124dd1 100644
--- a/arch/powerpc/boot/dts/mpc8572ds.dts
+++ b/arch/powerpc/boot/dts/mpc8572ds.dts
@@ -68,6 +68,7 @@
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
+		compatible = "simple-bus";
 		ranges = <0x0 0xffe00000 0x100000>;
 		reg = <0xffe00000 0x1000>;	// CCSRBAR & soc regs, remove once parse code for immrbase fixed
 		bus-frequency = <0>;		// Filled out by uboot.
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index dd4be4a..ec43477 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -105,6 +105,7 @@ static void __init mpc832x_sys_setup_arch(void)
 static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
 	{},
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index f049d69..0300268 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -115,6 +115,7 @@ static void __init mpc832x_rdb_setup_arch(void)
 static struct of_device_id mpc832x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
 	{},
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 7301d77..76092d3 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -41,6 +41,7 @@
 
 static struct of_device_id __initdata mpc834x_itx_ids[] = {
 	{ .compatible = "fsl,pq2pro-localbus", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 30d509a..fc3f2ed 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -111,6 +111,7 @@ static void __init mpc834x_mds_init_IRQ(void)
 static struct of_device_id mpc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 75b80e8..9d46e5b 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -136,6 +136,7 @@ static void __init mpc836x_mds_setup_arch(void)
 static struct of_device_id mpc836x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
 	{},
diff --git a/arch/powerpc/platforms/83xx/sbc834x.c b/arch/powerpc/platforms/83xx/sbc834x.c
index fc21f5c..156c4e2 100644
--- a/arch/powerpc/platforms/83xx/sbc834x.c
+++ b/arch/powerpc/platforms/83xx/sbc834x.c
@@ -83,6 +83,7 @@ static void __init sbc834x_init_IRQ(void)
 static struct __initdata of_device_id sbc834x_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index 2145ade..8a3b117 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -222,6 +222,7 @@ static void ksi8560_show_cpuinfo(struct seq_file *m)
 
 static struct of_device_id __initdata of_bus_ids[] = {
 	{ .type = "soc", },
+	{ .type = "simple-bus", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
 	{},
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index 6b846aa..1bf5aef 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -91,6 +91,7 @@ static void __init mpc8536_ds_setup_arch(void)
 static struct of_device_id __initdata mpc8536_ds_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index ba498d6..d17807a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -230,6 +230,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .type = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index 00c5358..483b65c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -186,6 +186,7 @@ static int __init mpc8544_ds_probe(void)
 static struct of_device_id __initdata mpc85xxds_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 43a459f..2494c51 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -260,6 +260,7 @@ machine_arch_initcall(mpc85xx_mds, board_fixups);
 static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
+	{ .compatible = "simple-bus", },
 	{ .type = "qe", },
 	{ .compatible = "fsl,qe", },
 	{},
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index 2c580cd..6509ade 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -217,6 +217,7 @@ static struct of_device_id __initdata of_bus_ids[] = {
 	{ .type = "soc", },
 	{ .name = "cpm", },
 	{ .name = "localbus", },
+	{ .compatible = "simple-bus", },
 	{},
 };
 
-- 
1.5.6
