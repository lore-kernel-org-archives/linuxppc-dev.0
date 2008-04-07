Return-Path: <dale@farnsworth.org>
Received: from xyzzy.farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4B38CDDE25
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 04:52:17 +1000 (EST)
Date: Mon, 7 Apr 2008 11:51:55 -0700
From: Dale Farnsworth <dale@farnsworth.org>
To: paulus@samba.org
Message-ID: <20080407185155.GG7438@farnsworth.org>
References: <20080407183228.GA7438@farnsworth.org>
MIME-Version: 1.0
In-Reply-To: <20080407183228.GA7438@farnsworth.org>
Subject: [PATCH 6/9 v2] powerpc: prpmc2800: clean up dts properties
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

Remove several unused (or software config only) properties.
Rename marvel node to "system-controller".  Also, rename the
"block-index" property to "cell-index" to conform to current
practice.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---
 arch/powerpc/boot/dts/prpmc2800.dts |   27 ++------------------------
 arch/powerpc/boot/mpsc.c            |    2 -
 arch/powerpc/sysdev/mv64x60_dev.c   |   18 ++++++-----------
 3 files changed, 11 insertions(+), 36 deletions(-)

Index: linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/dts/prpmc2800.dts
+++ linux-2.6/arch/powerpc/boot/dts/prpmc2800.dts
@@ -42,7 +42,7 @@
 		reg = <0x0 0x20000000>;			/* Default (512MB) */
 	};
 
-	mv64x60@f1000000 { /* Marvell Discovery */
+	system-controller@f1000000 { /* Marvell Discovery mv64360 */
 		#address-cells = <1>;
 		#size-cells = <1>;
 		model = "mv64360";			/* Default */
@@ -114,21 +114,17 @@
 		};
 
 		SDMA0: sdma@4000 {
-			device_type = "dma";
 			compatible = "mrvl,mv64360-sdma";
 			reg = <0x4000 0xc18>;
 			virtual-reg = <0xf1004000>;
-			interrupt-base = <0>;
 			interrupts = <36>;
 			interrupt-parent = <&PIC>;
 		};
 
 		SDMA1: sdma@6000 {
-			device_type = "dma";
 			compatible = "mrvl,mv64360-sdma";
 			reg = <0x6000 0xc18>;
 			virtual-reg = <0xf1006000>;
-			interrupt-base = <0>;
 			interrupts = <38>;
 			interrupt-parent = <&PIC>;
 		};
@@ -139,7 +135,6 @@
 			clock-src = <8>;
 			clock-frequency = <133333333>;
 			current-speed = <9600>;
-			bcr = <0>;
 		};
 
 		BRG1: brg@b208 {
@@ -148,7 +143,6 @@
 			clock-src = <8>;
 			clock-frequency = <133333333>;
 			current-speed = <9600>;
-			bcr = <0>;
 		};
 
 		CUNIT: cunit@f200 {
@@ -174,12 +168,7 @@
 			cunit = <&CUNIT>;
 			mpscrouting = <&MPSCROUTING>;
 			mpscintr = <&MPSCINTR>;
-			block-index = <0>;
-			max_idle = <40>;
-			chr_1 = <0>;
-			chr_2 = <0>;
-			chr_10 = <3>;
-			mpcr = <0>;
+			cell-index = <0>;
 			interrupts = <40>;
 			interrupt-parent = <&PIC>;
 		};
@@ -194,12 +183,7 @@
 			cunit = <&CUNIT>;
 			mpscrouting = <&MPSCROUTING>;
 			mpscintr = <&MPSCINTR>;
-			block-index = <1>;
-			max_idle = <40>;
-			chr_1 = <0>;
-			chr_2 = <0>;
-			chr_10 = <3>;
-			mpcr = <0>;
+			cell-index = <1>;
 			interrupts = <42>;
 			interrupt-parent = <&PIC>;
 		};
@@ -207,7 +191,6 @@
 		wdt@b410 {			/* watchdog timer */
 			compatible = "mrvl,mv64360-wdt";
 			reg = <0xb410 0x8>;
-			timeout = <10>;		/* wdt timeout in seconds */
 		};
 
 		i2c@c000 {
@@ -215,10 +198,6 @@
 			compatible = "mrvl,mv64360-i2c";
 			reg = <0xc000 0x20>;
 			virtual-reg = <0xf100c000>;
-			freq_m = <8>;
-			freq_n = <3>;
-			timeout = <1000>;		/* 1000 = 1 second */
-			retries = <1>;
 			interrupts = <37>;
 			interrupt-parent = <&PIC>;
 		};
Index: linux-2.6/arch/powerpc/boot/mpsc.c
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/mpsc.c
+++ linux-2.6/arch/powerpc/boot/mpsc.c
@@ -141,7 +141,7 @@ int mpsc_console_init(void *devp, struct
 	if (mpscintr_base == NULL)
 		goto err_out;
 
-	n = getprop(devp, "block-index", &v, sizeof(v));
+	n = getprop(devp, "cell-index", &v, sizeof(v));
 	if (n != sizeof(v))
 		goto err_out;
 	reg_set = (int)v;
Index: linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
===================================================================
--- linux-2.6.orig/arch/powerpc/sysdev/mv64x60_dev.c
+++ linux-2.6/arch/powerpc/sysdev/mv64x60_dev.c
@@ -127,7 +127,7 @@ static int __init mv64x60_mpsc_device_se
 	if (err)
 		return err;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		return -ENODEV;
 	port_number = *(int *)prop;
@@ -136,6 +136,7 @@ static int __init mv64x60_mpsc_device_se
 
 	pdata.cache_mgmt = 1; /* All current revs need this set */
 
+	pdata.max_idle = 40; /* default */
 	prop = of_get_property(np, "max_idle", NULL);
 	if (prop)
 		pdata.max_idle = *prop;
@@ -345,21 +346,19 @@ static int __init mv64x60_i2c_device_set
 
 	memset(&pdata, 0, sizeof(pdata));
 
+	pdata.freq_m = 8;	/* default */
 	prop = of_get_property(np, "freq_m", NULL);
 	if (!prop)
 		return -ENODEV;
 	pdata.freq_m = *prop;
 
+	pdata.freq_m = 3;	/* default */
 	prop = of_get_property(np, "freq_n", NULL);
 	if (!prop)
 		return -ENODEV;
 	pdata.freq_n = *prop;
 
-	prop = of_get_property(np, "timeout", NULL);
-	if (prop)
-		pdata.timeout = *prop;
-	else
-		pdata.timeout = 1000;	/* 1 second */
+	pdata.timeout = 1000;				/* default: 1 second */
 
 	pdev = platform_device_alloc(MV64XXX_I2C_CTLR_NAME, id);
 	if (!pdev)
@@ -401,10 +400,7 @@ static int __init mv64x60_wdt_device_set
 
 	memset(&pdata, 0, sizeof(pdata));
 
-	prop = of_get_property(np, "timeout", NULL);
-	if (!prop)
-		return -ENODEV;
-	pdata.timeout = *prop;
+	pdata.timeout = 10;			/* Default: 10 seconds */
 
 	np = of_get_parent(np);
 	if (!np)
@@ -492,7 +488,7 @@ static int __init mv64x60_add_mpsc_conso
 	if (!of_device_is_compatible(np, "mrvl,mv64360-mpsc"))
 		goto not_mpsc;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		goto not_mpsc;
 
