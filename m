Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id D2F62DE1C3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Mar 2008 06:52:32 +1100 (EST)
Date: Thu, 13 Mar 2008 14:52:10 -0500
From: Nathan Lynch <ntl@pobox.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] convert pci and eeh code to of_device_is_available
Message-ID: <20080313195210.GO4712@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

A couple of places are duplicating the function of
of_device_is_available; convert them to use it.

Signed-off-by: Nathan Lynch <ntl@pobox.com>
---

This depends on Josh Boyer's patch "[OF] Add of_device_is_available
function":

http://patchwork.ozlabs.org/linuxppc/patch?id=17100

 arch/powerpc/kernel/rtas_pci.c       |   19 ++-----------------
 arch/powerpc/platforms/pseries/eeh.c |    5 ++---
 2 files changed, 4 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/rtas_pci.c b/arch/powerpc/kernel/rtas_pci.c
index 433a0a0..39a752b 100644
--- a/arch/powerpc/kernel/rtas_pci.c
+++ b/arch/powerpc/kernel/rtas_pci.c
@@ -56,21 +56,6 @@ static inline int config_access_valid(struct pci_dn *dn, int where)
 	return 0;
 }
 
-static int of_device_available(struct device_node * dn)
-{
-        const char *status;
-
-        status = of_get_property(dn, "status", NULL);
-
-        if (!status)
-                return 1;
-
-        if (!strcmp(status, "okay"))
-                return 1;
-
-        return 0;
-}
-
 int rtas_read_config(struct pci_dn *pdn, int where, int size, u32 *val)
 {
 	int returnval = -1;
@@ -117,7 +102,7 @@ static int rtas_pci_read_config(struct pci_bus *bus,
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		struct pci_dn *pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_available(dn))
+		    && of_device_is_available(dn))
 			return rtas_read_config(pdn, where, size, val);
 	}
 
@@ -164,7 +149,7 @@ static int rtas_pci_write_config(struct pci_bus *bus,
 	for (dn = busdn->child; dn; dn = dn->sibling) {
 		struct pci_dn *pdn = PCI_DN(dn);
 		if (pdn && pdn->devfn == devfn
-		    && of_device_available(dn))
+		    && of_device_is_available(dn))
 			return rtas_write_config(pdn, where, size, val);
 	}
 	return PCIBIOS_DEVICE_NOT_FOUND;
diff --git a/arch/powerpc/platforms/pseries/eeh.c b/arch/powerpc/platforms/pseries/eeh.c
index 9eb539e..550b2f7 100644
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -945,7 +945,6 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	unsigned int rets[3];
 	struct eeh_early_enable_info *info = data;
 	int ret;
-	const char *status = of_get_property(dn, "status", NULL);
 	const u32 *class_code = of_get_property(dn, "class-code", NULL);
 	const u32 *vendor_id = of_get_property(dn, "vendor-id", NULL);
 	const u32 *device_id = of_get_property(dn, "device-id", NULL);
@@ -959,8 +958,8 @@ static void *early_enable_eeh(struct device_node *dn, void *data)
 	pdn->eeh_freeze_count = 0;
 	pdn->eeh_false_positives = 0;
 
-	if (status && strncmp(status, "ok", 2) != 0)
-		return NULL;	/* ignore devices with bad status */
+	if (!of_device_is_available(dn))
+		return NULL;
 
 	/* Ignore bad nodes. */
 	if (!class_code || !vendor_id || !device_id)
-- 
1.5.4.rc5
