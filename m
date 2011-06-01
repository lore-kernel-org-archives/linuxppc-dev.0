Return-Path: <dbaryshkov@gmail.com>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8103FB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 02:08:15 +1000 (EST)
Received: by wwi18 with SMTP id 18so3543804wwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 01 Jun 2011 09:08:09 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: bluesmoke-devel@lists.sourceforge.net, linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Subject: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Date: Wed,  1 Jun 2011 20:08:12 +0400
Message-Id: <1306944492-13054-1-git-send-email-dbaryshkov@gmail.com>
In-Reply-To: <20110601145911.GA30312@oksana.dev.rtsoft.ru>
References: <20110601145911.GA30312@oksana.dev.rtsoft.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As a device for pci node isn't created, create a special platform_device
for PCI EDAC device on MPC85xx.

Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
---
 arch/powerpc/platforms/85xx/ksi8560.c     |    2 +
 arch/powerpc/platforms/85xx/mpc8536_ds.c  |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ads.c |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_cds.c |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_ds.c  |    2 +
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    4 +++
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |    2 +
 arch/powerpc/platforms/85xx/p1022_ds.c    |    2 +
 arch/powerpc/platforms/85xx/sbc8548.c     |    2 +
 arch/powerpc/platforms/85xx/sbc8560.c     |    2 +
 arch/powerpc/platforms/85xx/socrates.c    |    2 +
 arch/powerpc/platforms/85xx/stx_gp3.c     |    2 +
 arch/powerpc/platforms/85xx/tqm85xx.c     |    2 +
 arch/powerpc/platforms/85xx/xes_mpc85xx.c |    2 +
 arch/powerpc/sysdev/fsl_pci.c             |   30 +++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_pci.h             |    5 ++++
 16 files changed, 65 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/ksi8560.c b/arch/powerpc/platforms/85xx/ksi8560.c
index c46f935..288fc4686 100644
--- a/arch/powerpc/platforms/85xx/ksi8560.c
+++ b/arch/powerpc/platforms/85xx/ksi8560.c
@@ -228,6 +228,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(ksi8560, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc8536_ds.c b/arch/powerpc/platforms/85xx/mpc8536_ds.c
index f79f2f1..cfcbd88 100644
--- a/arch/powerpc/platforms/85xx/mpc8536_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc8536_ds.c
@@ -114,6 +114,8 @@ static struct of_device_id __initdata mpc8536_ds_ids[] = {
 
 static int __init mpc8536_ds_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, mpc8536_ds_ids, NULL);
 }
 machine_device_initcall(mpc8536_ds, mpc8536_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ads.c b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
index 3b2c9bb..6af50d4 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ads.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ads.c
@@ -235,6 +235,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(mpc85xx_ads, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_cds.c b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
index 6299a2a..2785c75 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_cds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_cds.c
@@ -341,6 +341,8 @@ static struct of_device_id __initdata of_bus_ids[] = {
 
 static int __init declare_of_platform_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, of_bus_ids, NULL);
 }
 machine_device_initcall(mpc85xx_cds, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
index c7b97f7..2d0a138 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
@@ -228,6 +228,8 @@ static struct of_device_id __initdata mpc85xxds_ids[] = {
 
 static int __init mpc85xxds_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, mpc85xxds_ids, NULL);
 }
 machine_device_initcall(mpc8544_ds, mpc85xxds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index 747d1ee..2ff879a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -455,6 +455,8 @@ static int __init mpc85xx_publish_devices(void)
 	if (machine_is(mpc8569_mds))
 		simple_gpiochip_init("fsl,mpc8569mds-bcsr-gpio");
 
+	fsl_add_pci_err();
+
 	of_platform_bus_probe(NULL, mpc85xx_ids, NULL);
 	mpc85xx_publish_qe_devices();
 
@@ -463,6 +465,8 @@ static int __init mpc85xx_publish_devices(void)
 
 static int __init p1021_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	of_platform_bus_probe(NULL, p1021_ids, NULL);
 	mpc85xx_publish_qe_devices();
 
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 088f30b..511a86c 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -118,6 +118,8 @@ static struct of_device_id __initdata mpc85xxrdb_ids[] = {
 
 static int __init mpc85xxrdb_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, mpc85xxrdb_ids, NULL);
 }
 machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 7eb5c40..249f302 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -326,6 +326,8 @@ static struct of_device_id __initdata p1022_ds_ids[] = {
 
 static int __init p1022_ds_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, p1022_ds_ids, NULL);
 }
 machine_device_initcall(p1022_ds, p1022_ds_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/sbc8548.c b/arch/powerpc/platforms/85xx/sbc8548.c
index ecdd8c0..f3dcd88 100644
--- a/arch/powerpc/platforms/85xx/sbc8548.c
+++ b/arch/powerpc/platforms/85xx/sbc8548.c
@@ -162,6 +162,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(sbc8548, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/sbc8560.c b/arch/powerpc/platforms/85xx/sbc8560.c
index d2dfd46..6abdda7 100644
--- a/arch/powerpc/platforms/85xx/sbc8560.c
+++ b/arch/powerpc/platforms/85xx/sbc8560.c
@@ -222,6 +222,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(sbc8560, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/socrates.c b/arch/powerpc/platforms/85xx/socrates.c
index 747d8fb..d1546a3 100644
--- a/arch/powerpc/platforms/85xx/socrates.c
+++ b/arch/powerpc/platforms/85xx/socrates.c
@@ -104,6 +104,8 @@ static struct of_device_id __initdata socrates_of_bus_ids[] = {
 
 static int __init socrates_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, socrates_of_bus_ids, NULL);
 }
 machine_device_initcall(socrates, socrates_publish_devices);
diff --git a/arch/powerpc/platforms/85xx/stx_gp3.c b/arch/powerpc/platforms/85xx/stx_gp3.c
index 5387e9f..b5bf6b0 100644
--- a/arch/powerpc/platforms/85xx/stx_gp3.c
+++ b/arch/powerpc/platforms/85xx/stx_gp3.c
@@ -154,6 +154,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(stx_gp3, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 325de77..88d8bb8 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -183,6 +183,8 @@ static int __init declare_of_platform_devices(void)
 {
 	of_platform_bus_probe(NULL, of_bus_ids, NULL);
 
+	fsl_add_pci_err();
+
 	return 0;
 }
 machine_device_initcall(tqm85xx, declare_of_platform_devices);
diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 0125604..3771a2c 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -187,6 +187,8 @@ static struct of_device_id __initdata xes_mpc85xx_ids[] = {
 
 static int __init xes_mpc85xx_publish_devices(void)
 {
+	fsl_add_pci_err();
+
 	return of_platform_bus_probe(NULL, xes_mpc85xx_ids, NULL);
 }
 machine_device_initcall(xes_mpc8572, xes_mpc85xx_publish_devices);
diff --git a/arch/powerpc/sysdev/fsl_pci.c b/arch/powerpc/sysdev/fsl_pci.c
index 68ca929..8c64b91 100644
--- a/arch/powerpc/sysdev/fsl_pci.c
+++ b/arch/powerpc/sysdev/fsl_pci.c
@@ -381,6 +381,36 @@ int __init fsl_add_bridge(struct device_node *dev, int is_primary)
 	return 0;
 }
 
+void __init fsl_add_pci_err(void)
+{
+	struct device_node *np;
+
+	for_each_node_by_type(np, "pci") {
+		/* Only PCI, not PCI Express! */
+		if (of_device_is_compatible(np, "fsl,mpc8540-pci")) {
+			struct resource r[2];
+
+			r[0].parent = NULL;
+			r[1].parent = NULL;
+
+			if (of_address_to_resource(np, 0, &r[0])) {
+				printk(KERN_WARNING
+						"Can't get register base for PCI EDAC!\n");
+				continue;
+			}
+			r[0].start += 0xe00;
+
+			if (of_irq_to_resource(np, 0, &r[1]) == NO_IRQ) {
+				printk(KERN_WARNING
+						"Can't get irq for PCI EDAC!\n");
+				continue;
+			}
+			platform_device_register_simple("mpc85xx_pci_err", -1,
+					r, ARRAY_SIZE(r));
+		}
+	}
+}
+
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548E, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8548, quirk_fsl_pcie_header);
 DECLARE_PCI_FIXUP_HEADER(0x1957, PCI_DEVICE_ID_MPC8543E, quirk_fsl_pcie_header);
diff --git a/arch/powerpc/sysdev/fsl_pci.h b/arch/powerpc/sysdev/fsl_pci.h
index a39ed5c..e7abc37 100644
--- a/arch/powerpc/sysdev/fsl_pci.h
+++ b/arch/powerpc/sysdev/fsl_pci.h
@@ -92,6 +92,11 @@ extern int fsl_add_bridge(struct device_node *dev, int is_primary);
 extern void fsl_pcibios_fixup_bus(struct pci_bus *bus);
 extern int mpc83xx_add_bridge(struct device_node *dev);
 u64 fsl_pci_immrbar_base(struct pci_controller *hose);
+#ifdef CONFIG_PCI
+void fsl_add_pci_err(void);
+#else
+static inline void fsl_add_pci_err(void) {}
+#endif
 
 #endif /* __POWERPC_FSL_PCI_H */
 #endif /* __KERNEL__ */
-- 
1.7.4.4
