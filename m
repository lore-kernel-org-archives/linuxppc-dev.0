Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdRZh4C6JzDqnV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 21:30:52 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 24/38] powerpc: Move 64-bit probe_machine() to later in the
 boot process
Date: Mon, 27 Jun 2016 21:29:22 +1000
Message-Id: <1467026976-7974-25-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
References: <1467026976-7974-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We no long need the machine type that early, so we can move probe_machine()
to after the device-tree has been expanded. This will allow further
consolidation.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/kernel/setup_64.c          | 6 +++---
 arch/powerpc/platforms/cell/setup.c     | 6 ++----
 arch/powerpc/platforms/maple/setup.c    | 6 ++----
 arch/powerpc/platforms/pasemi/setup.c   | 6 ++----
 arch/powerpc/platforms/powermac/setup.c | 6 ++++++
 arch/powerpc/platforms/powernv/setup.c  | 4 +---
 arch/powerpc/platforms/ps3/setup.c      | 6 ++----
 arch/powerpc/platforms/pseries/setup.c  | 7 +++----
 8 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 47a2706..1f20f99 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -313,9 +313,6 @@ void __init early_setup(unsigned long dt_ptr)
 	setup_paca(&paca[boot_cpuid]);
 	fixup_boot_paca();
 
-	/* Probe the machine type */
-	probe_machine();
-
 	/* Configure exception handlers. This include setting up trampolines
 	 * if needed, setting exception endian mode, etc...
 	 */
@@ -522,6 +519,9 @@ void __init setup_system(void)
 	 */
 	check_for_initrd();
 
+	/* Probe the machine type */
+	probe_machine();
+
 	/*
 	 * Do some platform specific early initializations, that includes
 	 * setting up the hash table pointers. It also sets up some interrupt-mapping
diff --git a/arch/powerpc/platforms/cell/setup.c b/arch/powerpc/platforms/cell/setup.c
index e342f78..d3543e6 100644
--- a/arch/powerpc/platforms/cell/setup.c
+++ b/arch/powerpc/platforms/cell/setup.c
@@ -255,10 +255,8 @@ static void __init cell_setup_arch(void)
 
 static int __init cell_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "IBM,CBEA") &&
-	    !of_flat_dt_is_compatible(root, "IBM,CPBW-1.0"))
+	if (!of_machine_is_compatible("IBM,CBEA") &&
+	    !of_machine_is_compatible("IBM,CPBW-1.0"))
 		return 0;
 
 	pm_power_off = rtas_power_off;
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index a56828c..a1ecbc9 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -298,10 +298,8 @@ static void __init maple_progress(char *s, unsigned short hex)
  */
 static int __init maple_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "Momentum,Maple") &&
-	    !of_flat_dt_is_compatible(root, "Momentum,Apache"))
+	if (!of_machine_is_compatible("Momentum,Maple") &&
+	    !of_machine_is_compatible("Momentum,Apache"))
 		return 0;
 
 	pm_power_off = maple_power_off;
diff --git a/arch/powerpc/platforms/pasemi/setup.c b/arch/powerpc/platforms/pasemi/setup.c
index 9a881be..8f5e291 100644
--- a/arch/powerpc/platforms/pasemi/setup.c
+++ b/arch/powerpc/platforms/pasemi/setup.c
@@ -420,10 +420,8 @@ machine_device_initcall(pasemi, pasemi_publish_devices);
  */
 static int __init pas_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "PA6T-1682M") &&
-	    !of_flat_dt_is_compatible(root, "pasemi,pwrficient"))
+	if (!of_machine_is_compatible("PA6T-1682M") &&
+	    !of_machine_is_compatible("pasemi,pwrficient"))
 		return 0;
 
 	return 1;
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 1e42104..128ce76 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -588,11 +588,17 @@ console_initcall(check_pmac_serial_console);
  */
 static int __init pmac_probe(void)
 {
+#ifdef CONFIG_PPC32
 	unsigned long root = of_get_flat_dt_root();
 
 	if (!of_flat_dt_is_compatible(root, "Power Macintosh") &&
 	    !of_flat_dt_is_compatible(root, "MacRISC"))
 		return 0;
+#else
+	if (!of_machine_is_compatible("Power Macintosh") &&
+	    !of_machine_is_compatible("MacRISC"))
+		return 0;
+#endif
 
 #ifdef CONFIG_PPC32
 	/* isa_io_base gets set in pmac_pci_init */
diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index 15e3b8b..ed99177 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -268,9 +268,7 @@ static void __init pnv_setup_machdep_opal(void)
 
 static int __init pnv_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if (!of_flat_dt_is_compatible(root, "ibm,powernv"))
+	if (!of_machine_is_compatible("ibm,powernv"))
 		return 0;
 
 	if (firmware_has_feature(FW_FEATURE_OPAL))
diff --git a/arch/powerpc/platforms/ps3/setup.c b/arch/powerpc/platforms/ps3/setup.c
index e5ee80d..af18deb 100644
--- a/arch/powerpc/platforms/ps3/setup.c
+++ b/arch/powerpc/platforms/ps3/setup.c
@@ -237,15 +237,13 @@ void __init ps3_early_mm_init(void)
 
 static int __init ps3_probe(void)
 {
-	unsigned long dt_root;
-
 	DBG(" -> %s:%d\n", __func__, __LINE__);
 
-	dt_root = of_get_flat_dt_root();
-	if (!of_flat_dt_is_compatible(dt_root, "sony,ps3"))
+	if (!of_machine_is_compatible("sony,ps3"))
 		return 0;
 
 	ps3_os_area_save_params();
+
 	pm_power_off = ps3_power_off;
 
 	DBG(" <- %s:%d\n", __func__, __LINE__);
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index a8e33424..eacfba7 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -722,8 +722,7 @@ static void pseries_power_off(void)
 
 static int __init pSeries_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	const char *dtype = of_get_flat_dt_prop(root, "device_type", NULL);
+	const char *dtype = of_get_property(of_root, "device_type", NULL);
 
  	if (dtype == NULL)
  		return 0;
@@ -733,8 +732,8 @@ static int __init pSeries_probe(void)
 	/* Cell blades firmware claims to be chrp while it's not. Until this
 	 * is fixed, we need to avoid those here.
 	 */
-	if (of_flat_dt_is_compatible(root, "IBM,CPBW-1.0") ||
-	    of_flat_dt_is_compatible(root, "IBM,CBEA"))
+	if (of_machine_is_compatible("IBM,CPBW-1.0") ||
+	    of_machine_is_compatible("IBM,CBEA"))
 		return 0;
 
 	pm_power_off = pseries_power_off;
-- 
2.7.4
