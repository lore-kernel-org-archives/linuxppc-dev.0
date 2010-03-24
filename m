Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1D5A7B7D17
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 24 Mar 2010 19:18:37 +1100 (EST)
Subject: [PATCH 2/2] powerpc/pseries: Flush lazy kernel mappings after
	unplug operations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 24 Mar 2010 18:56:35 +1100
Message-ID: <1269417395.8599.189.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Nick Piggin <npiggin@suse.de>
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
index 9b21ee6..8a0a32e 100644
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
+	purge_vmap_area_lazy();
+
 	return ret;
 }
 
diff --git a/drivers/pci/hotplug/rpadlpar_core.c b/drivers/pci/hotplug/rpadlpar_core.c
index 4e3e038..99cb3f9 100644
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
+	purge_vmap_area_lazy();
+
 	printk(KERN_INFO "%s: slot %s removed\n", DLPAR_MODULE_NAME, drc_name);
 exit:
 	mutex_unlock(&rpadlpar_mutex);
diff --git a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
index dcaae72..2394ec0 100644
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
+	purge_vmap_area_lazy();
+
 	slot->state = NOT_CONFIGURED;
 	return 0;
 }
