Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B2CB3DE0CF
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:14 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id m0PGg1dp004832
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 10:42:02 -0600
Date: Fri, 25 Jan 2008 10:39:38 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] [POWERPC] 85xx: some minor cleanups for stx_gp3 and tqm85xx
Message-ID: <Pine.LNX.4.64.0801251039220.17501@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* "simple-bus" covers all our needs for of_platform_bus_probe()
* make device tree name just 'soc' not 'soc85..'

---
 arch/powerpc/boot/dts/stx_gp3_8560.dts |    2 +-
 arch/powerpc/boot/dts/tqm8540.dts      |    2 +-
 arch/powerpc/boot/dts/tqm8541.dts      |    2 +-
 arch/powerpc/boot/dts/tqm8555.dts      |    2 +-
 arch/powerpc/boot/dts/tqm8560.dts      |    2 +-
 arch/powerpc/platforms/85xx/stx_gp3.c  |    4 ----
 arch/powerpc/platforms/85xx/tqm85xx.c  |    4 ----
 7 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/dts/stx_gp3_8560.dts b/arch/powerpc/boot/dts/stx_gp3_8560.dts
index 2e97236..f81fd7f 100644
--- a/arch/powerpc/boot/dts/stx_gp3_8560.dts
+++ b/arch/powerpc/boot/dts/stx_gp3_8560.dts
@@ -46,7 +46,7 @@
 		reg = <0x00000000 0x10000000>;
 	};

-	soc8560@fdf00000 {
+	soc@fdf00000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8540.dts b/arch/powerpc/boot/dts/tqm8540.dts
index a6e3989..1addb3a 100644
--- a/arch/powerpc/boot/dts/tqm8540.dts
+++ b/arch/powerpc/boot/dts/tqm8540.dts
@@ -48,7 +48,7 @@
 		reg = <0x00000000 0x10000000>;
 	};

-	soc8540@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8541.dts b/arch/powerpc/boot/dts/tqm8541.dts
index 11bdb0f..9e01093 100644
--- a/arch/powerpc/boot/dts/tqm8541.dts
+++ b/arch/powerpc/boot/dts/tqm8541.dts
@@ -47,7 +47,7 @@
 		reg = <0x00000000 0x10000000>;
 	};

-	soc8541@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8555.dts b/arch/powerpc/boot/dts/tqm8555.dts
index eef9a6b..a20eb06 100644
--- a/arch/powerpc/boot/dts/tqm8555.dts
+++ b/arch/powerpc/boot/dts/tqm8555.dts
@@ -47,7 +47,7 @@
 		reg = <0x00000000 0x10000000>;
 	};

-	soc8555@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/boot/dts/tqm8560.dts b/arch/powerpc/boot/dts/tqm8560.dts
index 8ca7fdd..b9ac6c9 100644
--- a/arch/powerpc/boot/dts/tqm8560.dts
+++ b/arch/powerpc/boot/dts/tqm8560.dts
@@ -48,7 +48,7 @@
 		reg = <0x00000000 0x10000000>;
 	};

-	soc8560@e0000000 {
+	soc@e0000000 {
 		#address-cells = <1>;
 		#size-cells = <1>;
 		device_type = "soc";
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 0b20c17..18499d7 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -148,10 +148,6 @@ static void stx_gp3_show_cpuinfo(struct seq_file *m)
 }

 static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .type = "soc", },
-	{ .name = "cpm", },
-	{ .name = "localbus", },
 	{ .compatible = "simple-bus", },
 	{},
 };
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 2a08b31..77681ac 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -146,10 +146,6 @@ static void tqm85xx_show_cpuinfo(struct seq_file *m)
 }

 static struct of_device_id __initdata of_bus_ids[] = {
-	{ .name = "soc", },
-	{ .type = "soc", },
-	{ .name = "cpm", },
-	{ .name = "localbus", },
 	{ .compatible = "simple-bus", },
 	{},
 };
-- 
1.5.3.7
