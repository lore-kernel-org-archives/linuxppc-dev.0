Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 567C7DDF6F
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Feb 2007 04:54:23 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org, galak@kernel.crashing.org,
	benh@kernel.crashing.org
Subject: [PATCH v3] powerpc: add of_get_mac_address() and update fsl_soc.c to
	use it
Date: Wed, 14 Feb 2007 11:54:07 -0600
Message-Id: <11714756473819-git-send-email-timur@freescale.com>
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
'mac-address', then 'local-mac-address', then 'address'.  It skips properties 
that contain invalid MAC addresses, which were probably not initialized
by U-Boot.
 
Update gfar_of_init() and fs_enet_of_init() in fsl_soc.c to call
of_get_mac_address().

Signed-off-by: Timur Tabi <timur@freescale.com>
---

After this patch is applied, the next step is to update the various
OF-enabled Ethernet drivers to use of_get_mac_address().

 arch/powerpc/kernel/prom.c    |   40 ++++++++++++++++++++++++++++++++++++++++
 arch/powerpc/sysdev/fsl_soc.c |   19 +++++++------------
 include/asm-powerpc/prom.h    |    2 ++
 3 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
index 3e86e6e..b36dacc 100644
--- a/arch/powerpc/kernel/prom.c
+++ b/arch/powerpc/kernel/prom.c
@@ -31,6 +31,7 @@
 #include <linux/kexec.h>
 #include <linux/debugfs.h>
 #include <linux/irq.h>
+#include <linux/etherdevice.h>
 
 #include <asm/prom.h>
 #include <asm/rtas.h>
@@ -1612,6 +1613,45 @@ const void *get_property(const struct device_node *np, const char *name,
 }
 EXPORT_SYMBOL(get_property);
 
+/**
+ * Search the device tree for the best MAC address to use.  'mac-address' is
+ * checked first, because that is supposed to contain to "most recent" MAC
+ * address. If that isn't set, then 'local-mac-address' is checked next,
+ * because that is the default address.  If that isn't set, then the obsolete
+ * 'address' is checked, just in case we're using an old device tree.
+ *
+ * Note that the 'address' property is supposed to contain a virtual address of
+ * the register set, but some DTS files have redefined that property to be the
+ * MAC address.
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
+	struct property *pp;
+	const char *mac_addr;
+
+	pp = of_find_property(np, "mac-address", NULL);
+	if (pp && (pp->length == 6) && is_valid_ether_addr(pp->value))
+		return pp->value;
+
+	pp = of_find_property(np, "local-mac-address", NULL);
+	if (pp && (pp->length == 6) && is_valid_ether_addr(pp->value))
+		return pp->value;
+
+	pp = of_find_property(np, "address", NULL);
+	if (pp && (pp->length == 6) && is_valid_ether_addr(pp->value))
+		return pp->value;
+
+	return NULL;
+}
+EXPORT_SYMBOL(of_get_mac_address);
+
 /*
  * Add a property to a node
  */
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
@@ -255,6 +255,8 @@ extern void kdump_move_device_tree(void);
 /* CPU OF node matching */
 struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 
+/* Get the MAC address */
+extern const void *of_get_mac_address(struct device_node *np);
 
 /*
  * OF interrupt mapping
-- 
1.5.0
