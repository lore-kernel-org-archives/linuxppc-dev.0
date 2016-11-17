Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tKKG30zpNzDvrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2016 22:51:06 +1100 (AEDT)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-mips@linux-mips.org,
 linux-sh@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-renesas-soc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [RFC PATCH] of: base: add support to get machine model name
Date: Thu, 17 Nov 2016 11:50:50 +0000
Message-Id: <1479383450-19183-1-git-send-email-sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently platforms/drivers needing to get the machine model name are
replicating the same snippet of code. In some case, the OF reference
counting is either missing or incorrect.

This patch adds support to read the machine model name either using
the "model" or the "compatible" property in the device tree root node.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/mach-imx/cpu.c           |  4 +---
 arch/arm/mach-mxs/mach-mxs.c      |  3 +--
 arch/mips/cavium-octeon/setup.c   | 12 ++----------
 arch/mips/generic/proc.c          | 15 +++------------
 arch/sh/boards/of-generic.c       |  6 +-----
 drivers/of/base.c                 | 34 ++++++++++++++++++++++++++++++++++
 drivers/soc/fsl/guts.c            |  3 +--
 drivers/soc/renesas/renesas-soc.c |  4 +---
 include/linux/of.h                |  6 ++++++
 9 files changed, 50 insertions(+), 37 deletions(-)

Hi,

While trying to fix a simple build warning(as below) in -next for fsl/guts.c,
I came across this code duplication in multiple places.

WARNING: modpost: Found 1 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'

With CONFIG_DEBUG_SECTION_MISMATCH enabled, the details are reported:

WARNING: vmlinux.o(.text+0x55d014): Section mismatch in reference from the
function fsl_guts_probe() to the function
.init.text:of_flat_dt_get_machine_name()
The function fsl_guts_probe() references
the function __init of_flat_dt_get_machine_name().
This is often because fsl_guts_probe lacks a __init
annotation or the annotation of of_flat_dt_get_machine_name is wrong.

I can split the patch if needed if people are OK with the idea.

Regards,
Sudeep

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index b3347d32349f..846f40008752 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -85,9 +85,7 @@ struct device * __init imx_soc_device_init(void)

 	soc_dev_attr->family = "Freescale i.MX";

-	root = of_find_node_by_path("/");
-	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
-	of_node_put(root);
+	ret = of_machine_get_model_name(&soc_dev_attr->machine);
 	if (ret)
 		goto free_soc;

diff --git a/arch/arm/mach-mxs/mach-mxs.c b/arch/arm/mach-mxs/mach-mxs.c
index e4f21086b42b..ed9af3a894f0 100644
--- a/arch/arm/mach-mxs/mach-mxs.c
+++ b/arch/arm/mach-mxs/mach-mxs.c
@@ -391,8 +391,7 @@ static void __init mxs_machine_init(void)
 	if (!soc_dev_attr)
 		return;

-	root = of_find_node_by_path("/");
-	ret = of_property_read_string(root, "model", &soc_dev_attr->machine);
+	ret = of_machine_get_model_name(&soc_dev_attr->machine);
 	if (ret)
 		return;

diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
index 9a2db1c013d9..2e2b1b5befa4 100644
--- a/arch/mips/cavium-octeon/setup.c
+++ b/arch/mips/cavium-octeon/setup.c
@@ -498,16 +498,8 @@ static void __init init_octeon_system_type(void)
 	char const *board_type;

 	board_type = cvmx_board_type_to_string(octeon_bootinfo->board_type);
-	if (board_type == NULL) {
-		struct device_node *root;
-		int ret;
-
-		root = of_find_node_by_path("/");
-		ret = of_property_read_string(root, "model", &board_type);
-		of_node_put(root);
-		if (ret)
-			board_type = "Unsupported Board";
-	}
+	if (!board_type && of_machine_get_model_name(&board_type))
+		board_type = "Unsupported Board";

 	snprintf(octeon_system_type, sizeof(octeon_system_type), "%s (%s)",
 		 board_type, octeon_model_get_string(read_c0_prid()));
diff --git a/arch/mips/generic/proc.c b/arch/mips/generic/proc.c
index 42b33250a4a2..f7fc067bf908 100644
--- a/arch/mips/generic/proc.c
+++ b/arch/mips/generic/proc.c
@@ -10,20 +10,11 @@

 #include <linux/of.h>

-#include <asm/bootinfo.h>
-
 const char *get_system_type(void)
 {
 	const char *str;
-	int err;
-
-	err = of_property_read_string(of_root, "model", &str);
-	if (!err)
-		return str;
-
-	err = of_property_read_string_index(of_root, "compatible", 0, &str);
-	if (!err)
-		return str;

-	return "Unknown";
+	if (of_machine_get_model_name(&str))
+		return "Unknown";
+	return str;
 }
diff --git a/arch/sh/boards/of-generic.c b/arch/sh/boards/of-generic.c
index 1fb6d5714bae..938a14499298 100644
--- a/arch/sh/boards/of-generic.c
+++ b/arch/sh/boards/of-generic.c
@@ -135,11 +135,7 @@ static void __init sh_of_setup(char **cmdline_p)
 	board_time_init = sh_of_time_init;

 	sh_mv.mv_name = "Unknown SH model";
-	root = of_find_node_by_path("/");
-	if (root) {
-		of_property_read_string(root, "model", &sh_mv.mv_name);
-		of_node_put(root);
-	}
+	of_machine_get_model_name(&sh_mv.mv_name);

 	sh_of_smp_probe();
 }
diff --git a/drivers/of/base.c b/drivers/of/base.c
index a0bccb54a9bd..752cb8eefd6e 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -546,6 +546,40 @@ int of_machine_is_compatible(const char *compat)
 EXPORT_SYMBOL(of_machine_is_compatible);

 /**
+ * of_machine_get_model_name - Find and read the model name or the compatible
+ *		value for the machine.
+ * @model:	pointer to null terminated return string, modified only if
+ *		return value is 0.
+ *
+ * Returns a string containing either the model name or the compatible value
+ * of the machine if found, else return error.
+ *
+ * Search for a machine model name or the compatible if model name is missing
+ * in a device tree node and retrieve a null terminated string value (pointer
+ * to data, not a copy). Returns 0 on success, -EINVAL if root of the device
+ * tree is not found and other error returned by of_property_read_string on
+ * failure.
+ */
+int of_machine_get_model_name(const char **model)
+{
+	int error;
+	struct device_node *root;
+
+	root = of_find_node_by_path("/");
+	if (!root)
+		return -EINVAL;
+
+	error = of_property_read_string(root, "model", model);
+	if (error)
+		error = of_property_read_string_index(root, "compatible",
+						      0, model);
+	of_node_put(root);
+
+	return error;
+}
+EXPORT_SYMBOL(of_machine_get_model_name);
+
+/**
  *  __of_device_is_available - check if a device is available for use
  *
  *  @device: Node to check for availability, with locks already held
diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 0ac88263c2d7..94aef0465451 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -152,8 +152,7 @@ static int fsl_guts_probe(struct platform_device *pdev)
 		return PTR_ERR(guts->regs);

 	/* Register soc device */
-	machine = of_flat_dt_get_machine_name();
-	if (machine)
+	if (!of_machine_get_model_name(&machine))
 		soc_dev_attr.machine = devm_kstrdup(dev, machine, GFP_KERNEL);

 	svr = fsl_guts_get_svr();
diff --git a/drivers/soc/renesas/renesas-soc.c b/drivers/soc/renesas/renesas-soc.c
index 330960312296..d9a119073de5 100644
--- a/drivers/soc/renesas/renesas-soc.c
+++ b/drivers/soc/renesas/renesas-soc.c
@@ -228,9 +228,7 @@ static int __init renesas_soc_init(void)
 	if (!soc_dev_attr)
 		return -ENOMEM;

-	np = of_find_node_by_path("/");
-	of_property_read_string(np, "model", &soc_dev_attr->machine);
-	of_node_put(np);
+	of_machine_get_model_name(&soc_dev_attr->machine);

 	soc_dev_attr->family = kstrdup_const(family->name, GFP_KERNEL);
 	soc_dev_attr->soc_id = kstrdup_const(strchr(match->compatible, ',') + 1,
diff --git a/include/linux/of.h b/include/linux/of.h
index d72f01009297..13fc66531f1b 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -367,6 +367,7 @@ extern int of_alias_get_id(struct device_node *np, const char *stem);
 extern int of_alias_get_highest_id(const char *stem);

 extern int of_machine_is_compatible(const char *compat);
+extern int of_machine_get_model_name(const char **model);

 extern int of_add_property(struct device_node *np, struct property *prop);
 extern int of_remove_property(struct device_node *np, struct property *prop);
@@ -788,6 +789,11 @@ static inline int of_machine_is_compatible(const char *compat)
 	return 0;
 }

+static inline int of_machine_get_model_name(const char **model)
+{
+	return -EINVAL;
+}
+
 static inline bool of_console_check(const struct device_node *dn, const char *name, int index)
 {
 	return false;
--
2.7.4
