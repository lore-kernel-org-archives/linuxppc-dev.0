Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 010FDDDEAB
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 10:11:01 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, paulus@samba.org, sshtylyov@ru.mvista.com,
	galak@kernel.crashing.org
Subject: [PATCH] powerpc: add of_get_mac_address() and update fsl_soc.c to use
	it
Date: Tue, 13 Feb 2007 17:10:47 -0600
Message-Id: <1171408247467-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Add function of_get_mac_address(), which obtains the best MAC address to use
from the device tree by checking various properties in order.  The order is: 
'mac-address', then 'local-mac-address', then 'address'.  It also skips
properties that were not initialized by U-Boot.

Update gfar_of_init() and fs_enet_of_init() in fsl_soc.c to call 
of_get_mac_address().

Signed-off-by: Timur Tabi <timur@freescale.com>
---

See the comment for function of_get_mac_address() for a detailed description
of what it does.

After this patch is applied, the next step is to update the various
OF-enabled Ethernet drivers to use of_get_mac_address().

 arch/powerpc/kernel/prom.c    |   45 ++++++++++++++++++++++++++++++++++------
 arch/powerpc/sysdev/fsl_soc.c |   19 ++++++-----------
 include/asm-powerpc/prom.h    |    2 +
 3 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 3e86e6e..4826f01 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -3,9 +3,9 @@
  *
  * Paul Mackerras	August 1996.
  * Copyright (C) 1996-2005 Paul Mackerras.
- * 
+ *
  *  Adapted for 64bit PowerPC by Dave Engebretsen and Peter Bergner.
- *    {engebret|bergner}@us.ibm.com 
+ *    {engebret|bergner}@us.ibm.com
  *
  *      This program is free software; you can redistribute it and/or
  *      modify it under the terms of the GNU General Public License
@@ -111,7 +111,7 @@ int __init of_scan_flat_dt(int (*it)(uns
 	do {
 		u32 tag = *((u32 *)p);
 		char *pathp;
-		
+
 		p += 4;
 		if (tag == OF_DT_END_NODE) {
 			depth --;
@@ -148,7 +148,7 @@ int __init of_scan_flat_dt(int (*it)(uns
 		}
 		rc = it(p, pathp, depth, data);
 		if (rc != 0)
-			break;		
+			break;
 	} while(1);
 
 	return rc;
@@ -791,7 +791,7 @@ static int __init early_init_dt_scan_roo
 	prop = of_get_flat_dt_prop(node, "#address-cells", NULL);
 	dt_root_addr_cells = (prop == NULL) ? 2 : *prop;
 	DBG("dt_root_addr_cells = %x\n", dt_root_addr_cells);
-	
+
 	/* break now */
 	return 1;
 }
@@ -927,7 +927,7 @@ static void __init early_reserve_mem(voi
 	lmb_reserve(self_base, self_size);
 
 #ifdef CONFIG_PPC32
-	/* 
+	/*
 	 * Handle the case where we might be booting from an old kexec
 	 * image that setup the mem_rsvmap as pairs of 32-bit values
 	 */
@@ -1613,13 +1613,44 @@ const void *get_property(const struct de
 EXPORT_SYMBOL(get_property);
 
 /*
+ * Search the device tree for the best MAC address to use.  'mac-address' is
+ * checked first, because that is supposed to contain to "most recent" MAC
+ * address. If that isn't set, then 'local-mac-address' is checked next,
+ * because that is the default address.  If that isn't set, then the obsolete
+ * 'address' is checked, just in case we're using an old device tree.
+ *
+ * All-zero MAC addresses are rejected, because those could be properties that
+ * exist in the device tree, but were not set by U-Boot.  For example, the
+ * DTS could define 'mac-address' and 'local-mac-address', with zero MAC
+ * addresses.  Some older U-Boots only initialized 'local-mac-address'.  In
+ * this case, the real MAC is in 'local-mac-address', and 'mac-address' exists
+ * but is all zeros.
+*/
+const void *of_get_mac_address(struct device_node *np)
+{
+	static const u8 null_mac_address[6] = { 0 };
+	const void *mac_addr;
+
+	mac_addr = get_property(np, "mac-address", NULL);
+	if (mac_addr && (memcmp(mac_addr, null_mac_address, 6) != 0))
+		return mac_addr;
+
+	mac_addr = get_property(np, "local-mac-address", NULL);
+	if (mac_addr && (memcmp(mac_addr, null_mac_address, 6) != 0))
+		return mac_addr;
+
+	return get_property(np, "address", NULL);
+}
+EXPORT_SYMBOL(of_get_mac_address);
+
+/*
  * Add a property to a node
  */
 int prom_add_property(struct device_node* np, struct property* prop)
 {
 	struct property **next;
 
-	prop->next = NULL;	
+	prop->next = NULL;
 	write_lock(&devtree_lock);
 	next = &np->properties;
 	while (*next) {
diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 34161bc..d20f029 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -233,14 +233,7 @@ static int __init gfar_of_init(void)
 			goto err;
 		}
 
-		mac_addr = get_property(np, "local-mac-address", NULL);
-		if (mac_addr == NULL)
-			mac_addr = get_property(np, "mac-address", NULL);
-		if (mac_addr == NULL) {
-			/* Obsolete */
-			mac_addr = get_property(np, "address", NULL);
-		}
-
+		mac_addr = of_get_mac_address(np);
 		if (mac_addr)
 			memcpy(gfar_data.mac_addr, mac_addr, 6);
 
@@ -646,8 +639,9 @@ static int __init fs_enet_of_init(void)
 			goto unreg;
 		}
 
-		mac_addr = get_property(np, "mac-address", NULL);
-		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
 		ph = get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
@@ -931,8 +925,9 @@ static int __init fs_enet_of_init(void)
 			goto err;
 		r[0].name = enet_regs;
 
-		mac_addr = (void *)get_property(np, "mac-address", NULL);
-		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+		mac_addr = of_get_mac_address(np);
+		if (mac_addr)
+			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
 		ph = (phandle *) get_property(np, "phy-handle", NULL);
 		if (ph != NULL)
diff --git a/include/asm-powerpc/prom.h b/include/asm-powerpc/prom.h
index 0afee17..020ed01 100644
--- a/include/asm-powerpc/prom.h
+++ b/include/asm-powerpc/prom.h
@@ -255,6 +255,8 @@ extern void kdump_move_device_tree(void)
 /* CPU OF node matching */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 
+/* Get the MAC address */
+extern const void *of_get_mac_address(struct device_node *np);
 
 /*
  * OF interrupt mapping
-- 
1.4.4
