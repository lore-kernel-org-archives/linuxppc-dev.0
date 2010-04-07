Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 61DDCB7D4F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  7 Apr 2010 11:03:46 +1000 (EST)
Received: from [IPv6:::1] (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.14.1/8.13.8) with ESMTP id o3713eeW031532
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Apr 2010 20:03:42 -0500
Subject: [PATCH] powerpc/pseries: Flush lazy kernel mappings after unplug
	operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 07 Apr 2010 11:03:40 +1000
Message-ID: <1270602220.13812.99.camel@pasglop>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This ensures that the translations for unmapped IO mappings or
unmapped memory are properly removed from the MMU hash table
before such an unplug. Without this, the hypervisor refuses the
unplug operations due to those resources still being mapped by
the partition.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/pseries/hotplug-memory.c |    7 +++++++
 drivers/pci/hotplug/rpadlpar_core.c             |    3 +++
 drivers/pci/hotplug/rpaphp_core.c               |    3 +++
 3 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/hotplug-memory.c b/arch/powerpc/platforms/pseries/hotplug-memory.c
index 9b21ee6..01e7b5b 100644
--- a/arch/powerpc/platforms/pseries/hotplug-memory.c
+++ b/arch/powerpc/platforms/pseries/hotplug-memory.c
@@ -11,6 +11,7 @@
 
 #include <linux/of.h>
 #include <linux/lmb.h>
+#include <linux/vmalloc.h>
 #include <asm/firmware.h>
 #include <asm/machdep.h>
 #include <asm/pSeries_reconfig.h>
@@ -54,6 +55,12 @@ static int pseries_remove_lmb(unsigned long base, unsigned int lmb_size)
 	 */
 	start = (unsigned long)__va(base);
 	ret = remove_section_mapping(start, start + lmb_size);
+
+	/* Ensure all vmalloc mappings are flushed in case they also
+	 * hit that section of memory
+	 */
+	vm_unmap_aliases();
+
 	return ret;
 }
 
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 4e3e038..0830347 100644
--- a/drivers/pci/hotplug/rpadlpar_core.c
+++ b/drivers/pci/hotplug/rpadlpar_core.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/string.h>
+#include <linux/vmalloc.h>
 
 #include <asm/pci-bridge.h>
 #include <linux/mutex.h>
@@ -430,6 +431,8 @@ int dlpar_remove_slot(char *drc_name)
 			rc = dlpar_remove_pci_slot(drc_name, dn);
 			break;
 	}
+	vm_unmap_aliases();
+
 	printk(KERN_INFO "%s: slot %s removed\n", DLPAR_MODULE_NAME, drc_name);
 exit:
 	mutex_unlock(&rpadlpar_mutex);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index dcaae72..0aefc96 100644
--- a/drivers/pci/hotplug/rpaphp_core.c
+++ b/drivers/pci/hotplug/rpaphp_core.c
@@ -30,6 +30,7 @@
 #include <linux/slab.h>
 #include <linux/smp.h>
 #include <linux/init.h>
+#include <linux/vmalloc.h>
 #include <asm/eeh.h>       /* for eeh_add_device() */
 #include <asm/rtas.h>		/* rtas_call */
 #include <asm/pci-bridge.h>	/* for pci_controller */
@@ -419,6 +420,8 @@ static int disable_slot(struct hotplug_slot *hotplug_slot)
 		return -EINVAL;
 
 	pcibios_remove_pci_devices(slot->bus);
+	vm_unmap_aliases();
+
 	slot->state = NOT_CONFIGURED;
 	return 0;
 }
