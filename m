Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (unknown
 [IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 280AAB6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 Mar 2012 08:13:17 +1100 (EST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 11/17] powerpc: mark const init data with __initconst instead
 of __initdata
Date: Thu, 29 Mar 2012 23:12:28 +0200
Message-Id: <1333055554-31300-11-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20120329211131.GA31250@pengutronix.de>
References: <20120329211131.GA31250@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: cbe-oss-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
 Paul Mackerras <paulus@samba.org>, kernel@pengutronix.de,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As long as there is no other non-const variable marked __initdata in the
same compilation unit it doesn't hurt. If there were one however
compilation would fail with

	error: $variablename causes a section type conflict

because a section containing const variables is marked read only and so
cannot contain non-const variables.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Cc: Josh Boyer <jwboyer@gmail.com>
Cc: Matt Porter <mporter@kernel.crashing.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: cbe-oss-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/40x/ppc40x_simple.c    |    2 +-
 arch/powerpc/platforms/512x/mpc5121_generic.c |    2 +-
 arch/powerpc/platforms/52xx/lite5200.c        |    2 +-
 arch/powerpc/platforms/52xx/media5200.c       |    2 +-
 arch/powerpc/platforms/52xx/mpc5200_simple.c  |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c     |    2 +-
 arch/powerpc/platforms/83xx/mpc830x_rdb.c     |    2 +-
 arch/powerpc/platforms/83xx/mpc831x_rdb.c     |    2 +-
 arch/powerpc/platforms/83xx/mpc837x_rdb.c     |    2 +-
 arch/powerpc/platforms/85xx/tqm85xx.c         |    2 +-
 arch/powerpc/platforms/cell/qpace_setup.c     |    2 +-
 arch/powerpc/platforms/cell/setup.c           |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 9761206..2efba25 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -50,7 +50,7 @@ machine_device_initcall(ppc40x_simple, ppc40x_device_probe);
  * Again, if your board needs to do things differently then create a
  * board.c file for it rather than adding it to this list.
  */
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"amcc,acadia",
 	"amcc,haleakala",
 	"amcc,kilauea",
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index 926731f..b1b558c 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -26,7 +26,7 @@
 /*
  * list of supported boards
  */
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"prt,prtlvt",
 	NULL
 };
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index 01ffa64..86bd6f2 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -172,7 +172,7 @@ static void __init lite5200_setup_arch(void)
 	mpc52xx_setup_pci();
 }
 
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"fsl,lite5200",
 	"fsl,lite5200b",
 	NULL,
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 17d91b7..df4d53a 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -232,7 +232,7 @@ static void __init media5200_setup_arch(void)
 }
 
 /* list of the supported boards */
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"fsl,media5200",
 	NULL
 };
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index c0aa040..2622361 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -49,7 +49,7 @@ static void __init mpc5200_simple_setup_arch(void)
 }
 
 /* list of the supported boards */
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"anonymous,a4m072",
 	"anon,charon",
 	"intercontrol,digsy-mtc",
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index bfb11e0..e2d401a 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -93,7 +93,7 @@ struct mpc52xx_pci {
 };
 
 /* MPC5200 device tree match tables */
-const struct of_device_id mpc52xx_pci_ids[] __initdata = {
+const struct of_device_id mpc52xx_pci_ids[] __initconst = {
 	{ .type = "pci", .compatible = "fsl,mpc5200-pci", },
 	{ .type = "pci", .compatible = "mpc5200-pci", },
 	{}
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 4f2d9fe..3327ab9 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -34,7 +34,7 @@ static void __init mpc830x_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"MPC8308RDB",
 	"fsl,mpc8308rdb",
 	"denx,mpc8308_p1m",
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index fa25977..067d3f0 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -35,7 +35,7 @@ static void __init mpc831x_rdb_setup_arch(void)
 	mpc831x_usb_cfg();
 }
 
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"MPC8313ERDB",
 	"fsl,mpc8315erdb",
 	NULL
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 16c9c9c..a9a15bb 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -60,7 +60,7 @@ static void __init mpc837x_rdb_setup_arch(void)
 
 machine_device_initcall(mpc837x_rdb, mpc83xx_declare_of_platform_devices);
 
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"fsl,mpc8377rdb",
 	"fsl,mpc8378rdb",
 	"fsl,mpc8379rdb",
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 4d786c2..c182de0 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -125,7 +125,7 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_1520,
 
 machine_device_initcall(tqm85xx, mpc85xx_common_publish_devices);
 
-static const char *board[] __initdata = {
+static const char *board[] __initconst = {
 	"tqc,tqm8540",
 	"tqc,tqm8541",
 	"tqc,tqm8548",
diff --git a/arch/powerpc/platforms/cell/qpace_setup.c b/arch/powerpc/platforms/cell/qpace_setup.c
index 7f9b674..6e3409d 100644
--- a/arch/powerpc/platforms/cell/qpace_setup.c
+++ b/arch/powerpc/platforms/cell/qpace_setup.c
@@ -61,7 +61,7 @@ static void qpace_progress(char *s, unsigned short hex)
 	printk("*** %04x : %s\n", hex, s ? s : "");
 }
 
-static const struct of_device_id qpace_bus_ids[] __initdata = {
+static const struct of_device_id qpace_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index fa3e294..4ab0876 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -140,7 +140,7 @@ static int __devinit cell_setup_phb(struct pci_controller *phb)
 	return 0;
 }
 
-static const struct of_device_id cell_bus_ids[] __initdata = {
+static const struct of_device_id cell_bus_ids[] __initconst = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .type = "spider", },
-- 
1.7.9.1
