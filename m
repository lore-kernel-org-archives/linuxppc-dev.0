Return-Path: <mgreer@mvista.com>
Date: Mon, 10 Dec 2007 17:38:56 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: [PATCH 5/8] powerpc: MPSC - Update DTS entries
Message-ID: <20071211003856.GF4995@mag.az.mvista.com>
References: <20071211003108.GA4995@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071211003108.GA4995@mag.az.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark A. Greer <mgreer@mvista.com>

MPSC DTS nodes should use 'cell-index' to distinguish between MPSC
controllers (just like all the other DTS files).  Also, rename the
compatible property from 'marvell,mpsc' to 'marvell,mv64360-mpsc'
for consistency.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
---
 arch/powerpc/boot/dts/prpmc2800.dts |    8 ++++----
 arch/powerpc/boot/mpsc.c            |    2 +-
 arch/powerpc/boot/serial.c          |    2 +-
 arch/powerpc/sysdev/mv64x60_dev.c   |    8 ++++----
 arch/powerpc/sysdev/mv64x60_udbg.c  |    4 ++--
 5 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/prpmc2800.dts b/arch/powerpc/boot/dts/prpmc2800.dts
index 1447faa..e670e3f 100644
--- a/arch/powerpc/boot/dts/prpmc2800.dts
+++ b/arch/powerpc/boot/dts/prpmc2800.dts
@@ -185,7 +185,7 @@
 
 		mpsc@8000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
+			compatible = "marvell,mv64360-mpsc";
 			reg = <0x8000 0x38>;
 			virtual-reg = <0xf1008000>;
 			sdma = <&SDMA0>;
@@ -193,7 +193,7 @@
 			cunit = <&CUNIT>;
 			mpscrouting = <&MPSCROUTING>;
 			mpscintr = <&MPSCINTR>;
-			block-index = <0>;
+			cell-index = <0>;
 			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
@@ -205,7 +205,7 @@
 
 		mpsc@9000 {
 			device_type = "serial";
-			compatible = "marvell,mpsc";
+			compatible = "marvell,mv64360-mpsc";
 			reg = <0x9000 0x38>;
 			virtual-reg = <0xf1009000>;
 			sdma = <&SDMA1>;
@@ -213,7 +213,7 @@
 			cunit = <&CUNIT>;
 			mpscrouting = <&MPSCROUTING>;
 			mpscintr = <&MPSCINTR>;
-			block-index = <1>;
+			cell-index = <1>;
 			max_idle = <40>;
 			chr_1 = <0>;
 			chr_2 = <0>;
diff --git a/arch/powerpc/boot/mpsc.c b/arch/powerpc/boot/mpsc.c
index 802ea53..425ad88 100644
--- a/arch/powerpc/boot/mpsc.c
+++ b/arch/powerpc/boot/mpsc.c
@@ -141,7 +141,7 @@ int mpsc_console_init(void *devp, struct serial_console_data *scdp)
 	if (mpscintr_base == NULL)
 		goto err_out;
 
-	n = getprop(devp, "block-index", &v, sizeof(v));
+	n = getprop(devp, "cell-index", &v, sizeof(v));
 	if (n != sizeof(v))
 		goto err_out;
 	reg_set = (int)v;
diff --git a/arch/powerpc/boot/serial.c b/arch/powerpc/boot/serial.c
index cafeece..cbcbb20 100644
--- a/arch/powerpc/boot/serial.c
+++ b/arch/powerpc/boot/serial.c
@@ -119,7 +119,7 @@ int serial_console_init(void)
 
 	if (dt_is_compatible(devp, "ns16550"))
 		rc = ns16550_console_init(devp, &serial_cd);
-	else if (dt_is_compatible(devp, "marvell,mpsc"))
+	else if (dt_is_compatible(devp, "marvell,mv64360-mpsc"))
 		rc = mpsc_console_init(devp, &serial_cd);
 	else if (dt_is_compatible(devp, "fsl,cpm1-scc-uart") ||
 	         dt_is_compatible(devp, "fsl,cpm1-smc-uart") ||
diff --git a/arch/powerpc/sysdev/mv64x60_dev.c b/arch/powerpc/sysdev/mv64x60_dev.c
index 20cd5e3..587c40f 100644
--- a/arch/powerpc/sysdev/mv64x60_dev.c
+++ b/arch/powerpc/sysdev/mv64x60_dev.c
@@ -127,7 +127,7 @@ static int __init mv64x60_mpsc_device_setup(struct device_node *np, int id)
 	if (err)
 		return err;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		return -ENODEV;
 	port_number = *(int *)prop;
@@ -452,7 +452,7 @@ static int __init mv64x60_device_setup(void)
 	int err;
 
 	id = 0;
-	for_each_compatible_node(np, "serial", "marvell,mpsc")
+	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc")
 		if ((err = mv64x60_mpsc_device_setup(np, id++)))
 			goto error;
 
@@ -495,10 +495,10 @@ static int __init mv64x60_add_mpsc_console(void)
 	if (!np)
 		goto not_mpsc;
 
-	if (!of_device_is_compatible(np, "marvell,mpsc"))
+	if (!of_device_is_compatible(np, "marvell,mv64360-mpsc"))
 		goto not_mpsc;
 
-	prop = of_get_property(np, "block-index", NULL);
+	prop = of_get_property(np, "cell-index", NULL);
 	if (!prop)
 		goto not_mpsc;
 
diff --git a/arch/powerpc/sysdev/mv64x60_udbg.c b/arch/powerpc/sysdev/mv64x60_udbg.c
index 35c77c7..2792dc8 100644
--- a/arch/powerpc/sysdev/mv64x60_udbg.c
+++ b/arch/powerpc/sysdev/mv64x60_udbg.c
@@ -85,7 +85,7 @@ static void mv64x60_udbg_init(void)
 	if (!stdout)
 		return;
 
-	for_each_compatible_node(np, "serial", "marvell,mpsc") {
+	for_each_compatible_node(np, "serial", "marvell,mv64360-mpsc") {
 		if (np == stdout)
 			break;
 	}
@@ -94,7 +94,7 @@ static void mv64x60_udbg_init(void)
 	if (!np)
 		return;
 
-	block_index = of_get_property(np, "block-index", NULL);
+	block_index = of_get_property(np, "cell-index", NULL);
 	if (!block_index)
 		goto error;
 
