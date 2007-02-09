Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D30B1DDE3A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 07:02:52 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: paulus@samba.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] Check mac-address first in fsl_soc.c
Date: Fri,  9 Feb 2007 14:02:47 -0600
Message-Id: <11710513671236-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The mac-address property in the device tree should be checked first,
before local-mac-address.  This is because mac-address contains the most
recent MAC address, whereas local-mac-address is the default address.
Depending on the platform and the version of U-Boot, U-Boot will set
one or the other, or both.

This patch updates gfar_of_init() and fs_enet_of_init() to conform to
this order.  It skips a property if it doesn't exist or if it contains
an all-zero MAC address.  This patch also adds some NULL-pointer checking
to make sure there are no panics if no MAC address has been passed.

Signed-off-by: Timur Tabi <timur@freescale.com>
---
 arch/powerpc/sysdev/fsl_soc.c |   39 +++++++++++++++++++++++++++++----------
 1 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index 9f2a9a4..a0586ea 100644
--- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -233,12 +233,13 @@ static int __init gfar_of_init(void)
 			goto err;
 		}
 
-		mac_addr = get_property(np, "local-mac-address", NULL);
-		if (mac_addr == NULL)
-			mac_addr = get_property(np, "mac-address", NULL);
-		if (mac_addr == NULL) {
-			/* Obsolete */
-			mac_addr = get_property(np, "address", NULL);
+		mac_addr = get_property(np, "mac-address", NULL);
+		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+			mac_addr = get_property(np, "local-mac-address", NULL);
+			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+				/* Obsolete */
+				mac_addr = get_property(np, "address", NULL);
+			}
 		}
 
 		if (mac_addr)
@@ -607,7 +608,16 @@ static int __init fs_enet_of_init(void)
 		}
 
 		mac_addr = get_property(np, "mac-address", NULL);
-		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+			mac_addr = get_property(np, "local-mac-address", NULL);
+			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+				/* Obsolete */
+				mac_addr = get_property(np, "address", NULL);
+			}
+		}
+
+		if (mac_addr)
+			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
 		ph = get_property(np, "phy-handle", NULL);
 		phy = of_find_node_by_phandle(*ph);
@@ -699,7 +709,7 @@ static int __init fs_enet_of_init(void)
 				if (ret)
 					goto unreg;
 			}
-			
+
 			of_node_put(phy);
 			of_node_put(mdio);
 
@@ -891,8 +901,17 @@ static int __init fs_enet_of_init(void)
 			goto err;
 		r[0].name = enet_regs;
 
-		mac_addr = (void *)get_property(np, "mac-address", NULL);
-		memcpy(fs_enet_data.macaddr, mac_addr, 6);
+		mac_addr = get_property(np, "mac-address", NULL);
+		if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+			mac_addr = get_property(np, "local-mac-address", NULL);
+			if (!mac_addr || (memcmp(mac_addr, "\0\0\0\0\0", 6) == 0)) {
+				/* Obsolete */
+				mac_addr = get_property(np, "address", NULL);
+			}
+		}
+
+		if (mac_addr)
+			memcpy(fs_enet_data.macaddr, mac_addr, 6);
 
 		ph = (phandle *) get_property(np, "phy-handle", NULL);
 		if (ph != NULL)
-- 
1.4.4
