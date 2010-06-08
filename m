Return-Path: <avorontsov@mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 45BE4B7DAF
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jun 2010 05:55:52 +1000 (EST)
Date: Tue, 8 Jun 2010 23:55:50 +0400
From: Anton Vorontsov <avorontsov@mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/85xx: Fix booting for P1021MDS boards
Message-ID: <20100608195550.GB11446@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

P1021 processors have no dedicated ROM to store the QE microcode,
so the fimrware is stored externally, and it is U-Boot responsibility
to load it. It might be that the board is booting without QE, e.g.
currently U-Boot doesn't support QE for P1021MDS boards, which means
that QE isn't initialized, and so the board hangs early at boot.

This patch fixes the issue by marking QE as disabled and checking the
state in the probing code. U-Boot should fixup the state if it
initialized the QE.

Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
---
 arch/powerpc/boot/dts/p1021mds.dts        |    1 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |   43 +++++++++++++++++++++++++----
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/boot/dts/p1021mds.dts b/arch/powerpc/boot/dts/p1021mds.dts
index 7fad2df..ad5b852 100644
--- a/arch/powerpc/boot/dts/p1021mds.dts
+++ b/arch/powerpc/boot/dts/p1021mds.dts
@@ -617,6 +617,7 @@
 		bus-frequency = <0>;
 		fsl,qe-num-riscs = <1>;
 		fsl,qe-num-snums = <28>;
+		status = "disabled"; /* no firmware loaded */
 
 		qeic: interrupt-controller@80 {
 			interrupt-controller;
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 35ab2b4..9dadcff 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -158,6 +158,29 @@ static int mpc8568_mds_phy_fixups(struct phy_device *phydev)
 extern void __init mpc85xx_smp_init(void);
 #endif
 
+#ifdef CONFIG_QUICC_ENGINE
+static struct of_device_id mpc85xx_qe_ids[] __initdata = {
+	{ .type = "qe", },
+	{ .compatible = "fsl,qe", },
+	{ },
+};
+
+static void __init mpc85xx_publish_qe_devices(void)
+{
+	struct device_node *np;
+
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return;
+	}
+
+	of_platform_bus_probe(NULL, mpc85xx_qe_ids, NULL);
+}
+#else
+static void __init mpc85xx_publish_qe_devices(void) { }
+#endif /* CONFIG_QUICC_ENGINE */
+
 static void __init mpc85xx_mds_setup_arch(void)
 {
 	struct device_node *np;
@@ -218,6 +241,11 @@ static void __init mpc85xx_mds_setup_arch(void)
 			return;
 	}
 
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return;
+	}
+
 	qe_reset();
 	of_node_put(np);
 
@@ -369,8 +397,6 @@ static struct of_device_id mpc85xx_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
 	{ .compatible = "gianfar", },
 	{ .compatible = "fsl,rapidio-delta", },
 	{ .compatible = "fsl,mpc8548-guts", },
@@ -382,8 +408,6 @@ static struct of_device_id p1021_ids[] = {
 	{ .type = "soc", },
 	{ .compatible = "soc", },
 	{ .compatible = "simple-bus", },
-	{ .type = "qe", },
-	{ .compatible = "fsl,qe", },
 	{ .compatible = "gianfar", },
 	{},
 };
@@ -395,16 +419,16 @@ static int __init mpc85xx_publish_devices(void)
 	if (machine_is(mpc8569_mds))
 		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
 
-	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
+	mpc85xx_publish_qe_devices();
 
 	return 0;
 }
 
 static int __init p1021_publish_devices(void)
 {
-	/* Publish the QE devices */
 	of_platform_bus_probe(NULL, p1021_ids, NULL);
+	mpc85xx_publish_qe_devices();
 
 	return 0;
 }
@@ -443,12 +467,19 @@ static void __init mpc85xx_mds_pic_init(void)
 	mpic_init(mpic);
 
 #ifdef CONFIG_QUICC_ENGINE
+	np = of_find_compatible_node(NULL, NULL, "fsl,qe");
+	if (!of_device_is_available(np)) {
+		of_node_put(np);
+		return;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "fsl,qe-ic");
 	if (!np) {
 		np = of_find_node_by_type(NULL, "qeic");
 		if (!np)
 			return;
 	}
+
 	if (machine_is(p1021_mds))
 		qe_ic_init(np, 0, qe_ic_cascade_low_mpic,
 				qe_ic_cascade_high_mpic);
-- 
1.7.0.5
