Return-Path: <grant.likely@secretlab.ca>
Received: from pd3mo2so.prod.shaw.ca (idcmail-mo1so.shaw.ca [24.71.223.10])
	by ozlabs.org (Postfix) with ESMTP id 53244DE41D
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 04:06:49 +1100 (EST)
Received: from pd3mr4so.prod.shaw.ca
	(pd3mr4so-qfe3.prod.shaw.ca [10.0.141.180]) by l-daemon
	(Sun ONE Messaging Server 6.0 HotFix 1.01 (built Mar 15 2004))
	with ESMTP id <0JUU00LEJNHOE470@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:48 -0700 (MST)
Received: from pn2ml1so.prod.shaw.ca ([10.0.121.145])
	by pd3mr4so.prod.shaw.ca (Sun Java System Messaging Server 6.2-7.05
	(built Sep
	5 2006)) with ESMTP id <0JUU001ULNHGM830@pd3mr4so.prod.shaw.ca> for
	linuxppc-dev@ozlabs.org; Fri, 18 Jan 2008 10:05:49 -0700 (MST)
Received: from trillian.cg.shawcable.net ([68.147.67.118])
	by l-daemon (Sun Java System Messaging Server 6.2-7.05 (built Sep 5
	2006))
	with ESMTP id <0JUU00KEHNHBUF00@l-daemon> for linuxppc-dev@ozlabs.org;
	Fri, 18 Jan 2008 10:05:39 -0700 (MST)
Date: Fri, 18 Jan 2008 10:05:11 -0700
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC/PATCH 2/2] [POWERPC] Efika: prune fixups and make them more
	carefull
In-reply-to: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
To: linuxppc-dev@ozlabs.org, jrigby@freescale.com, matt@genesi-usa.com,
	tnt@246tnt.com
Message-id: <20080118170454.10592.21512.stgit@trillian.secretlab.ca>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
References: <20080118170324.10592.47360.stgit@trillian.secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

Prune back Efika fixups to only include changes that are actually required
to get a working system.  Most of the drivers can accept the compatible
properties, even if they don't match the what is recommented in the generic
names recommended practice document.

This patch also adds extra checks so that fixups are not performed blindly.
Instead, the code first verifies that the device tree is faulty before
making any changes.  This way, if the Efika firmware is updated to fix
these issues, then the fixups will no longer get applied.

At this point; here is the list of fixups needed for the efika:
1. If the device_type property on the root node is 'chrp', then Linux won't
   boot.  Change device_type to 'efika' to avoid this condition
2. Add full interrupt list to the bestcomm node.  In actual fact, the
   bestcomm interrupts property is technically correct, it just doesn't
   expose the same granularity as the device driver expects.  All other
   5200 device trees provide a separate irq number for each bestcomm
   channel.  Rather than hack the driver, it's simpler to fix it up
3. /builtin/sound node is missing an interrupts property
4. /builtin/ethernet node is missing a phy-handle property and the
   device driver doesn't know what to do without one.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/prom_init.c |  149 +++++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 70 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index 5d89a21..5ab4c84 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -2142,82 +2142,34 @@ static void __init fixup_device_tree_pmac(void)
 #endif
 
 #ifdef CONFIG_PPC_EFIKA
-/* The current fw of the Efika has a device tree needs quite a few
- * fixups to be compliant with the mpc52xx bindings. It's currently
- * unknown if it will ever be compliant (come on bPlan ...) so we do fixups.
- * NOTE that we (barely) tolerate it because the EFIKA was out before
- * the bindings were finished, for any new boards -> RTFM ! */
-
-struct subst_entry {
-	char *path;
-	char *property;
-	void *value;
-	int value_len;
-};
-
-static void __init fixup_device_tree_efika(void)
+/*
+ * The MPC5200 FEC driver requires an phy-handle property to tell it how
+ * to talk to the phy.  If the phy-handle property is missing, then this
+ * function is called to add the appropriate nodes and link it to the
+ * ethernet node.
+ */
+static void __init fixup_device_tree_efika_add_phy(void)
 {
-	/* Substitution table */
-	#define prop_cstr(x) x, sizeof(x)
-	int prop_sound_irq[3] = { 2, 2, 0 };
-	int prop_bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
-	                             3,4,0, 3,5,0, 3,6,0, 3,7,0,
-	                             3,8,0, 3,9,0, 3,10,0, 3,11,0,
-	                             3,12,0, 3,13,0, 3,14,0, 3,15,0 };
-	struct subst_entry efika_subst_table[] = {
-		{ "/",			"device_type",	prop_cstr("efika") },
-		{ "/builtin",		"device_type",	prop_cstr("soc") },
-		{ "/builtin/ata",	"compatible",	prop_cstr("mpc5200b-ata\0mpc5200-ata"), },
-		{ "/builtin/bestcomm",	"compatible",	prop_cstr("mpc5200b-bestcomm\0mpc5200-bestcomm") },
-		{ "/builtin/bestcomm",	"interrupts",	prop_bcomm_irq, sizeof(prop_bcomm_irq) },
-		{ "/builtin/ethernet",	"compatible",	prop_cstr("mpc5200b-fec\0mpc5200-fec") },
-		{ "/builtin/pic",	"compatible",	prop_cstr("mpc5200b-pic\0mpc5200-pic") },
-		{ "/builtin/serial",	"compatible",	prop_cstr("mpc5200b-psc-uart\0mpc5200-psc-uart") },
-		{ "/builtin/sound",	"compatible",	prop_cstr("mpc5200b-psc-ac97\0mpc5200-psc-ac97") },
-		{ "/builtin/sound",	"interrupts",	prop_sound_irq, sizeof(prop_sound_irq) },
-		{ "/builtin/sram",	"compatible",	prop_cstr("mpc5200b-sram\0mpc5200-sram") },
-		{ "/builtin/sram",	"device_type",	prop_cstr("sram") },
-		{}
-	};
-	#undef prop_cstr
-
-	/* Vars */
 	u32 node;
 	char prop[64];
-	int rv, i;
+	int rv;
 
-	/* Check if we're really running on a EFIKA */
-	node = call_prom("finddevice", 1, 1, ADDR("/"));
+	/* Check if /builtin/ethernet exists - bail if it doesn't */
+	node = call_prom("finddevice", 1, 1, ADDR("/builtin/ethernet"));
 	if (!PHANDLE_VALID(node))
 		return;
 
-	rv = prom_getprop(node, "model", prop, sizeof(prop));
-	if (rv == PROM_ERROR)
-		return;
-	if (strcmp(prop, "EFIKA5K2"))
+	/* Check if the phy-handle property exists - bail if it does */
+	rv = prom_getprop(node, "phy-handle", prop, sizeof(prop));
+	if (!rv)
 		return;
 
-	prom_printf("Applying EFIKA device tree fixups\n");
-
-	/* Process substitution table */
-	for (i=0; efika_subst_table[i].path; i++) {
-		struct subst_entry *se = &efika_subst_table[i];
-
-		node = call_prom("finddevice", 1, 1, ADDR(se->path));
-		if (!PHANDLE_VALID(node)) {
-			prom_printf("fixup_device_tree_efika: ",
-				"skipped entry %x - not found\n", i);
-			continue;
-		}
-
-		rv = prom_setprop(node, se->path, se->property,
-					se->value, se->value_len );
-		if (rv == PROM_ERROR)
-			prom_printf("fixup_device_tree_efika: ",
-				"skipped entry %x - setprop error\n", i);
-	}
+	/*
+	 * At this point the ethernet device doesn't have a phy described.
+	 * Now we need to add the missing phy node and linkage
+	 */
 
-	/* Make sure ethernet mdio bus node exists */
+	/* Check for an MDIO bus node - if missing then create one */
 	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio"));
 	if (!PHANDLE_VALID(node)) {
 		prom_printf("Adding Ethernet MDIO node\n");
@@ -2226,8 +2178,8 @@ static void __init fixup_device_tree_efika(void)
 			" new-device"
 				" 1 encode-int s\" #address-cells\" property"
 				" 0 encode-int s\" #size-cells\" property"
-				" s\" mdio\" 2dup device-name device-type"
-				" s\" mpc5200b-fec-phy\" encode-string"
+				" s\" mdio\" device-name"
+				" s\" fsl,mpc5200b-mdio\" encode-string"
 				" s\" compatible\" property"
 				" 0xf0003000 0x400 reg"
 				" 0x2 encode-int"
@@ -2237,8 +2189,10 @@ static void __init fixup_device_tree_efika(void)
 			" finish-device");
 	};
 
-	/* Make sure ethernet phy device node exist */
-	node = call_prom("finddevice", 1, 1, ADDR("/builtin/mdio/ethernet-phy"));
+	/* Check for a PHY device node - if missing then create one and
+	 * give it's phandle to the ethernet node */
+	node = call_prom("finddevice", 1, 1,
+			 ADDR("/builtin/mdio/ethernet-phy"));
 	if (!PHANDLE_VALID(node)) {
 		prom_printf("Adding Ethernet PHY node\n");
 		call_prom("interpret", 1, 1,
@@ -2254,7 +2208,62 @@ static void __init fixup_device_tree_efika(void)
 				" s\" phy-handle\" property"
 			" device-end");
 	}
+}
+
+static void __init fixup_device_tree_efika(void)
+{
+	int sound_irq[3] = { 2, 2, 0 };
+	int bcomm_irq[3*16] = { 3,0,0, 3,1,0, 3,2,0, 3,3,0,
+				3,4,0, 3,5,0, 3,6,0, 3,7,0,
+				3,8,0, 3,9,0, 3,10,0, 3,11,0,
+				3,12,0, 3,13,0, 3,14,0, 3,15,0 };
+	u32 node;
+	char prop[64];
+	int rv, len;
+
+	/* Check if we're really running on a EFIKA */
+	node = call_prom("finddevice", 1, 1, ADDR("/"));
+	if (!PHANDLE_VALID(node))
+		return;
+
+	rv = prom_getprop(node, "model", prop, sizeof(prop));
+	if (rv == PROM_ERROR)
+		return;
+	if (strcmp(prop, "EFIKA5K2"))
+		return;
+
+	prom_printf("Applying EFIKA device tree fixups\n");
+
+	/* Claiming to be 'chrp' is death */
+	node = call_prom("finddevice", 1, 1, ADDR("/"));
+	rv = prom_getprop(node, "device_type", prop, sizeof(prop));
+	if (rv != PROM_ERROR && (strcmp(prop, "chrp") == 0))
+		prom_setprop(node, "/", "device_type", "efika", sizeof("efika"));
+
+	/* Fixup bestcomm interrupts property */
+	node = call_prom("finddevice", 1, 1, ADDR("/builtin/bestcomm"));
+	if (PHANDLE_VALID(node)) {
+		len = prom_getproplen(node, "interrupts");
+		if (len == 12) {
+			prom_printf("Fixing bestcomm interrupts property\n");
+			prom_setprop(node, "/builtin/bestcom", "interrupts",
+				     bcomm_irq, sizeof(bcomm_irq));
+		}
+	}
+
+	/* Fixup sound interrupts property */
+	node = call_prom("finddevice", 1, 1, ADDR("/builtin/sound"));
+	if (PHANDLE_VALID(node)) {
+		rv = prom_getprop(node, "interrupts", prop, sizeof(prop));
+		if (rv == PROM_ERROR) {
+			prom_printf("Adding sound interrupts property\n");
+			prom_setprop(node, "/builtin/sound", "interrupts",
+				     sound_irq, sizeof(sound_irq));
+		}
+	}
 
+	/* Make sure ethernet phy-handle property exists */
+	fixup_device_tree_efika_add_phy();
 }
 #else
 #define fixup_device_tree_efika()
