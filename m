Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Subject: [PATCH] of/flattree: Add of_flat_dt_match() helper function
To: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 31 Dec 2010 02:15:55 -0700
Message-ID: <20101231091500.7355.2314.stgit@localhost6.localdomain6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds of_flat_dt_match() which tests a node for
compatibility with a list of values and converts the relevant powerpc
platform code to use it.  This approach simplifies the board support
code a bit.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/40x/ppc40x_simple.c    |   13 +++-------
 arch/powerpc/platforms/512x/mpc5121_generic.c |   13 +---------
 arch/powerpc/platforms/52xx/lite5200.c        |   16 +++++-------
 arch/powerpc/platforms/52xx/media5200.c       |   13 +---------
 arch/powerpc/platforms/52xx/mpc5200_simple.c  |   13 +---------
 arch/powerpc/platforms/83xx/mpc830x_rdb.c     |   13 ++++++----
 arch/powerpc/platforms/83xx/mpc831x_rdb.c     |   11 +++++---
 arch/powerpc/platforms/83xx/mpc837x_rdb.c     |   15 +++++++----
 arch/powerpc/platforms/85xx/tqm85xx.c         |   20 +++++++--------
 drivers/of/fdt.c                              |   34 ++++++++++++++++++++++++-
 include/linux/of_fdt.h                        |    1 +
 11 files changed, 84 insertions(+), 78 deletions(-)

diff --git a/arch/powerpc/platforms/40x/ppc40x_simple.c b/arch/powerpc/platforms/40x/ppc40x_simple.c
index 546bbc2..2521d93 100644
--- a/arch/powerpc/platforms/40x/ppc40x_simple.c
+++ b/arch/powerpc/platforms/40x/ppc40x_simple.c
@@ -50,7 +50,7 @@ machine_device_initcall(ppc40x_simple, ppc40x_device_probe);
  * Again, if your board needs to do things differently then create a
  * board.c file for it rather than adding it to this list.
  */
-static char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"amcc,acadia",
 	"amcc,haleakala",
 	"amcc,kilauea",
@@ -60,14 +60,9 @@ static char *board[] __initdata = {
 
 static int __init ppc40x_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-	int i = 0;
-
-	for (i = 0; i < ARRAY_SIZE(board); i++) {
-		if (of_flat_dt_is_compatible(root, board[i])) {
-			ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
-			return 1;
-		}
+	if (of_flat_dt_match(of_get_flat_dt_root(), board)) {
+		ppc_pci_set_flags(PPC_PCI_REASSIGN_ALL_RSRC);
+		return 1;
 	}
 
 	return 0;
diff --git a/arch/powerpc/platforms/512x/mpc5121_generic.c b/arch/powerpc/platforms/512x/mpc5121_generic.c
index e487eb0..926731f 100644
--- a/arch/powerpc/platforms/512x/mpc5121_generic.c
+++ b/arch/powerpc/platforms/512x/mpc5121_generic.c
@@ -26,7 +26,7 @@
 /*
  * list of supported boards
  */
-static char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"prt,prtlvt",
 	NULL
 };
@@ -36,16 +36,7 @@ static char *board[] __initdata = {
  */
 static int __init mpc5121_generic_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
-	int i = 0;
-
-	while (board[i]) {
-		if (of_flat_dt_is_compatible(node, board[i]))
-			break;
-		i++;
-	}
-
-	return board[i] != NULL;
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(mpc5121_generic) {
diff --git a/arch/powerpc/platforms/52xx/lite5200.c b/arch/powerpc/platforms/52xx/lite5200.c
index de55bc0..01ffa64 100644
--- a/arch/powerpc/platforms/52xx/lite5200.c
+++ b/arch/powerpc/platforms/52xx/lite5200.c
@@ -172,20 +172,18 @@ static void __init lite5200_setup_arch(void)
 	mpc52xx_setup_pci();
 }
 
+static const char *board[] __initdata = {
+	"fsl,lite5200",
+	"fsl,lite5200b",
+	NULL,
+};
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init lite5200_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
-	const char *model = of_get_flat_dt_prop(node, "model", NULL);
-
-	if (!of_flat_dt_is_compatible(node, "fsl,lite5200") &&
-	    !of_flat_dt_is_compatible(node, "fsl,lite5200b"))
-		return 0;
-	pr_debug("%s board found\n", model ? model : "unknown");
-
-	return 1;
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(lite5200) {
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 0bac3a3..2c7780c 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -239,7 +239,7 @@ static void __init media5200_setup_arch(void)
 }
 
 /* list of the supported boards */
-static char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"fsl,media5200",
 	NULL
 };
@@ -249,16 +249,7 @@ static char *board[] __initdata = {
  */
 static int __init media5200_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
-	int i = 0;
-
-	while (board[i]) {
-		if (of_flat_dt_is_compatible(node, board[i]))
-			break;
-		i++;
-	}
-
-	return (board[i] != NULL);
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(media5200_platform) {
diff --git a/arch/powerpc/platforms/52xx/mpc5200_simple.c b/arch/powerpc/platforms/52xx/mpc5200_simple.c
index d45be5b..e36d6e2 100644
--- a/arch/powerpc/platforms/52xx/mpc5200_simple.c
+++ b/arch/powerpc/platforms/52xx/mpc5200_simple.c
@@ -49,7 +49,7 @@ static void __init mpc5200_simple_setup_arch(void)
 }
 
 /* list of the supported boards */
-static char *board[] __initdata = {
+static const char *board[] __initdata = {
 	"intercontrol,digsy-mtc",
 	"manroland,mucmc52",
 	"manroland,uc101",
@@ -66,16 +66,7 @@ static char *board[] __initdata = {
  */
 static int __init mpc5200_simple_probe(void)
 {
-	unsigned long node = of_get_flat_dt_root();
-	int i = 0;
-
-	while (board[i]) {
-		if (of_flat_dt_is_compatible(node, board[i]))
-			break;
-		i++;
-	}
-	
-	return (board[i] != NULL);
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(mpc5200_simple_platform) {
diff --git a/arch/powerpc/platforms/83xx/mpc830x_rdb.c b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
index 846831d..661d354 100644
--- a/arch/powerpc/platforms/83xx/mpc830x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc830x_rdb.c
@@ -57,16 +57,19 @@ static void __init mpc830x_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+struct const char *board[] __initdata = {
+	"MPC8308RDB",
+	"fsl,mpc8308rdb",
+	"denx,mpc8308_p1m",
+	NULL
+}
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc830x_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MPC8308RDB") ||
-	       of_flat_dt_is_compatible(root, "fsl,mpc8308rdb") ||
-	       of_flat_dt_is_compatible(root, "denx,mpc8308_p1m");
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/83xx/mpc831x_rdb.c b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
index ae525e4..b54cd73 100644
--- a/arch/powerpc/platforms/83xx/mpc831x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc831x_rdb.c
@@ -60,15 +60,18 @@ static void __init mpc831x_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+struct const char *board[] __initdata = {
+	"MPC8313ERDB",
+	"fsl,mpc8315erdb",
+	NULL
+}
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc831x_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "MPC8313ERDB") ||
-	       of_flat_dt_is_compatible(root, "fsl,mpc8315erdb");
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 static struct of_device_id __initdata of_bus_ids[] = {
diff --git a/arch/powerpc/platforms/83xx/mpc837x_rdb.c b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
index 910caa6..7bafbf2 100644
--- a/arch/powerpc/platforms/83xx/mpc837x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc837x_rdb.c
@@ -101,17 +101,20 @@ static void __init mpc837x_rdb_init_IRQ(void)
 	ipic_set_default_priority();
 }
 
+static const char *board[] __initdata = {
+	"fsl,mpc8377rdb",
+	"fsl,mpc8378rdb",
+	"fsl,mpc8379rdb",
+	"fsl,mpc8377wlan",
+	NULL
+};
+
 /*
  * Called very early, MMU is off, device-tree isn't unflattened
  */
 static int __init mpc837x_rdb_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	return of_flat_dt_is_compatible(root, "fsl,mpc8377rdb") ||
-	       of_flat_dt_is_compatible(root, "fsl,mpc8378rdb") ||
-	       of_flat_dt_is_compatible(root, "fsl,mpc8379rdb") ||
-	       of_flat_dt_is_compatible(root, "fsl,mpc8377wlan");
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(mpc837x_rdb) {
diff --git a/arch/powerpc/platforms/85xx/tqm85xx.c b/arch/powerpc/platforms/85xx/tqm85xx.c
index 8f29bbc..5e847d0 100644
--- a/arch/powerpc/platforms/85xx/tqm85xx.c
+++ b/arch/powerpc/platforms/85xx/tqm85xx.c
@@ -186,21 +186,21 @@ static int __init declare_of_platform_devices(void)
 }
 machine_device_initcall(tqm85xx, declare_of_platform_devices);
 
+static const char *board[] __initdata = {
+	"tqc,tqm8540",
+	"tqc,tqm8541",
+	"tqc,tqm8548",
+	"tqc,tqm8555",
+	"tqc,tqm8560",
+	NULL
+};
+
 /*
  * Called very early, device-tree isn't unflattened
  */
 static int __init tqm85xx_probe(void)
 {
-	unsigned long root = of_get_flat_dt_root();
-
-	if ((of_flat_dt_is_compatible(root, "tqc,tqm8540")) ||
-	    (of_flat_dt_is_compatible(root, "tqc,tqm8541")) ||
-	    (of_flat_dt_is_compatible(root, "tqc,tqm8548")) ||
-	    (of_flat_dt_is_compatible(root, "tqc,tqm8555")) ||
-	    (of_flat_dt_is_compatible(root, "tqc,tqm8560")))
-		return 1;
-
-	return 0;
+	return of_flat_dt_match(of_get_flat_dt_root(), board);
 }
 
 define_machine(tqm85xx) {
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index 8a90ee4..5a3db04 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -78,19 +78,23 @@ void *of_fdt_get_property(struct boot_param_header *blob,
  * @blob: A device tree blob
  * @node: node to test
  * @compat: compatible string to compare with compatible list.
+ *
+ * On match, returns a non-zero value with smaller values returned for more
+ * specific compatible values.
  */
 int of_fdt_is_compatible(struct boot_param_header *blob,
 		      unsigned long node, const char *compat)
 {
 	const char *cp;
-	unsigned long cplen, l;
+	unsigned long cplen, l, score = 0;
 
 	cp = of_fdt_get_property(blob, node, "compatible", &cplen);
 	if (cp == NULL)
 		return 0;
 	while (cplen > 0) {
+		score++;
 		if (of_compat_cmp(cp, compat, strlen(compat)) == 0)
-			return 1;
+			return score;
 		l = strlen(cp) + 1;
 		cp += l;
 		cplen -= l;
@@ -99,6 +103,24 @@ int of_fdt_is_compatible(struct boot_param_header *blob,
 	return 0;
 }
 
+/**
+ * of_flat_dt_match - Return true if node matches a list of compatible values
+ */
+int of_fdt_match(struct boot_param_header *blob, unsigned long node,
+                 const char **compat)
+{
+	unsigned int tmp, score = 0;
+
+	while (*compat) {
+		tmp = of_fdt_is_compatible(blob, node, *compat);
+		if (tmp && (score == 0 || (tmp < score)))
+			score = tmp;
+		compat++;
+	}
+
+	return score;
+}
+
 static void *unflatten_dt_alloc(unsigned long *mem, unsigned long size,
 				       unsigned long align)
 {
@@ -511,6 +533,14 @@ int __init of_flat_dt_is_compatible(unsigned long node, const char *compat)
 	return of_fdt_is_compatible(initial_boot_params, node, compat);
 }
 
+/**
+ * of_flat_dt_match - Return true if node matches a list of compatible values
+ */
+int __init of_flat_dt_match(unsigned long node, const char **compat)
+{
+	return of_fdt_match(initial_boot_params, node, compat);
+}
+
 #ifdef CONFIG_BLK_DEV_INITRD
 /**
  * early_init_dt_check_for_initrd - Decode initrd location from flat tree
diff --git a/include/linux/of_fdt.h b/include/linux/of_fdt.h
index 9ce5dfd..fb327f3 100644
--- a/include/linux/of_fdt.h
+++ b/include/linux/of_fdt.h
@@ -84,6 +84,7 @@ extern int of_scan_flat_dt(int (*it)(unsigned long node, const char *uname,
 extern void *of_get_flat_dt_prop(unsigned long node, const char *name,
 				 unsigned long *size);
 extern int of_flat_dt_is_compatible(unsigned long node, const char *name);
+extern int of_flat_dt_match(unsigned long node, const char **matches);
 extern unsigned long of_get_flat_dt_root(void);
 
 extern int early_init_dt_scan_chosen(unsigned long node, const char *uname,
