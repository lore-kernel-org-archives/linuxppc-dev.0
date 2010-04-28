Return-Path: <sr@denx.de>
Received: from mo-p05-ob.rzone.de (mo-p05-ob.rzone.de [81.169.146.180])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A2891B7D54
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 18:13:58 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v2] powerpc/4xx: Add optional "reset_type" property to control
	reboot via dts
Date: Wed, 28 Apr 2010 10:13:34 +0200
Message-Id: <1272442414-8018-1-git-send-email-sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

By setting "reset_type" to one of the following values, the default
software reset mechanism may be overidden. Here the possible values of
"reset_type":

  1 - PPC4xx core reset
  2 - PPC4xx chip reset
  3 - PPC4xx system reset (default)

This will be used by a new PPC440SPe board port, which needs a "chip
reset" instead of the default "system reset" to be asserted.

Signed-off-by: Stefan Roese <sr@denx.de>
Cc: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
v2:
- Add small property description to Documentation
- Add sanity check for property value

 Documentation/powerpc/dts-bindings/4xx/reboot.txt |   18 +++++++++++++++
 arch/powerpc/sysdev/ppc4xx_soc.c                  |   24 +++++++++++++++++++-
 2 files changed, 40 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/powerpc/dts-bindings/4xx/reboot.txt

diff --git a/Documentation/powerpc/dts-bindings/4xx/reboot.txt b/Documentation/powerpc/dts-bindings/4xx/reboot.txt
new file mode 100644
index 0000000..d721726
--- /dev/null
+++ b/Documentation/powerpc/dts-bindings/4xx/reboot.txt
@@ -0,0 +1,18 @@
+Reboot property to control system reboot on PPC4xx systems:
+
+By setting "reset_type" to one of the following values, the default
+software reset mechanism may be overidden. Here the possible values of
+"reset_type":
+
+      1 - PPC4xx core reset
+      2 - PPC4xx chip reset
+      3 - PPC4xx system reset (default)
+
+Example:
+
+		cpu@0 {
+			device_type = "cpu";
+			model = "PowerPC,440SPe";
+			...
+			reset-type = <2>;	/* Use chip-reset */
+		};
diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/sysdev/ppc4xx_soc.c
index 5c01435..d3d6ce3 100644
--- a/arch/powerpc/sysdev/ppc4xx_soc.c
+++ b/arch/powerpc/sysdev/ppc4xx_soc.c
@@ -191,11 +191,31 @@ static int __init ppc4xx_l2c_probe(void)
 arch_initcall(ppc4xx_l2c_probe);
 
 /*
- * At present, this routine just applies a system reset.
+ * Apply a system reset. Alternatively a board specific value may be
+ * provided via the "reset-type" property in the cpu node.
  */
 void ppc4xx_reset_system(char *cmd)
 {
-	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_RST_SYSTEM);
+	struct device_node *np;
+	u32 reset_type = DBCR0_RST_SYSTEM;
+	const u32 *prop;
+
+	np = of_find_node_by_type(NULL, "cpu");
+	if (np) {
+		prop = of_get_property(np, "reset-type", NULL);
+
+		/*
+		 * Check if property exists and if it is in range:
+		 * 1 - PPC4xx core reset
+		 * 2 - PPC4xx chip reset
+		 * 3 - PPC4xx system reset (default)
+		 */
+		if ((prop) && ((prop[0] >= 1) && (prop[0] <= 3)))
+			reset_type = prop[0] << 28;
+	}
+
+	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | reset_type);
+
 	while (1)
 		;	/* Just in case the reset doesn't work */
 }
-- 
1.7.1
