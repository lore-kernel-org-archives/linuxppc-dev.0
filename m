Return-Path: <mauricfo@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s9KKD5ZStzDr0d
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Aug 2016 06:25:52 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7BKNjwX009255
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:25:50 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0a-001b2d01.pphosted.com with ESMTP id 24rtx3f41a-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:25:50 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mauricfo@linux.vnet.ibm.com>;
 Thu, 11 Aug 2016 17:25:48 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 7E466352005F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 16:25:24 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u7BKPigt4690002
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 17:25:45 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u7BKPi7Z028583
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Aug 2016 17:25:44 -0300
From: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 gwshan@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH v4] powerpc/pseries: use pci_host_bridge.release_fn() to
 kfree(phb)
Date: Thu, 11 Aug 2016 17:25:40 -0300
Message-Id: <1470947140-16366-1-git-send-email-mauricfo@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch leverages 'struct pci_host_bridge' from the PCI subsystem
in order to free the pci_controller only after the last reference to
its devices is dropped (avoiding an oops in pcibios_release_device()
if the last reference is dropped after pcibios_free_controller()).

The patch relies on pci_host_bridge.release_fn() (and .release_data),
which is called automatically by the PCI subsystem when the root bus
is released (i.e., the last reference is dropped).  Those fields are
set via pci_set_host_bridge_release() (e.g. in the platform-specific
implementation of pcibios_root_bridge_prepare()).

It introduces the 'pcibios_free_controller_deferred()' .release_fn()
and it expects .release_data to hold a pointer to the pci_controller.

The function implictly calls 'pcibios_free_controller()', so an user
must *NOT* explicitly call it if using the new _deferred() callback.

The functionality is enabled for pseries (although it isn't platform
specific, and may be used by cxl).

Details on not-so-elegant design choices:

 - Use 'pci_host_bridge.release_data' field as pointer to associated
   'struct pci_controller' so *not* to 'pci_bus_to_host(bridge->bus)'
   in pcibios_free_controller_deferred().

   That's because pci_remove_root_bus() sets 'host_bridge->bus = NULL'
   (so, if the last reference is released after pci_remove_root_bus()
   runs, which eventually reaches pcibios_free_controller_deferred(),
   that would hit a null pointer dereference).

   The cxl/vphb.c code calls pci_remove_root_bus(), and the cxl folks
   are interested in this fix.

Test-case #1 (hold references)

  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.0
  <...> /sys/block/sdaa -> ../devices/pci0021:01/0021:01:00.0/<...>

  # ls -ld /sys/block/sd* | grep -m1 0021:01:00.1
  <...> /sys/block/sdab -> ../devices/pci0021:01/0021:01:00.1/<...>

  # cat >/dev/sdaa & pid1=$!
  # cat >/dev/sdab & pid2=$!

  # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
  Validating PHB DLPAR capability...yes.
  [  594.306719] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
  [  594.306738] pci_hp_remove_devices:    Removing 0021:01:00.0...
  ...
  [  598.236381] pci_hp_remove_devices:    Removing 0021:01:00.1...
  ...
  [  611.972077] pci_bus 0021:01: busn_res: [bus 01-ff] is released
  [  611.972140] rpadlpar_io: slot PHB 33 removed

  # kill -9 $pid1
  # kill -9 $pid2
  [  632.918088] pcibios_free_controller_deferred: domain 33, dynamic 1

Test-case #2 (don't hold references)

  # drmgr -w 5 -d 1 -c phb -s 'PHB 33' -r
  Validating PHB DLPAR capability...yes.
  [  916.357363] pci_hp_remove_devices: PCI: Removing devices on bus 0021:01
  [  916.357386] pci_hp_remove_devices:    Removing 0021:01:00.0...
  ...
  [  920.566527] pci_hp_remove_devices:    Removing 0021:01:00.1...
  ...
  [  933.955873] pci_bus 0021:01: busn_res: [bus 01-ff] is released
  [  933.955977] pcibios_free_controller_deferred: domain 33, dynamic 1
  [  933.955999] rpadlpar_io: slot PHB 33 removed

Suggested-By: Gavin Shan <gwshan@linux.vnet.ibm.com>
Signed-off-by: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>
---
Changelog:
 - v4: improve usability/design/documentation:
       - rename function to pcibios_free_controller_deferred()
       - from function call pcibios_free_controller()
       - no more struct pci_controller.bridge field
       thanks: Gavin Shan, Andrew Donnellan
 - v3: different approach: struct pci_host_bridge.release_fn()
 - v2: different approach: struct pci_controller.refcount 

 arch/powerpc/include/asm/pci-bridge.h      |  1 +
 arch/powerpc/kernel/pci-common.c           | 36 ++++++++++++++++++++++++++++++
 arch/powerpc/platforms/pseries/pci.c       |  4 ++++
 arch/powerpc/platforms/pseries/pci_dlpar.c |  7 ++++--
 4 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index b5e88e4..c0309c5 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -301,6 +301,7 @@ extern void pci_process_bridge_OF_ranges(struct pci_controller *hose,
 /* Allocate & free a PCI host bridge structure */
 extern struct pci_controller *pcibios_alloc_controller(struct device_node *dev);
 extern void pcibios_free_controller(struct pci_controller *phb);
+extern void pcibios_free_controller_deferred(struct pci_host_bridge *bridge);
 
 #ifdef CONFIG_PCI
 extern int pcibios_vaddr_is_ioport(void __iomem *address);
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index a5c0153..8c48a78 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -151,6 +151,42 @@ void pcibios_free_controller(struct pci_controller *phb)
 EXPORT_SYMBOL_GPL(pcibios_free_controller);
 
 /*
+ * This function is used to call pcibios_free_controller()
+ * in a deferred manner: a callback from the PCI subsystem.
+ *
+ * _*DO NOT*_ call pcibios_free_controller() explicitly if
+ * this is used (or it may access an invalid *phb pointer).
+ *
+ * The callback occurs when all references to the root bus
+ * are dropped (e.g., child buses/devices and their users).
+ *
+ * It's called as .release_fn() of 'struct pci_host_bridge'
+ * which is associated with the 'struct pci_controller.bus'
+ * (root bus) - it expects .release_data to hold a pointer
+ * to 'struct pci_controller'.
+ *
+ * In order to use it, register .release_fn()/release_data
+ * like this:
+ *
+ * pci_set_host_bridge_release(bridge,
+ *                             pcibios_free_controller_deferred
+ *                             (void *) phb);
+ *
+ * e.g. in the pcibios_root_bridge_prepare() callback from
+ * pci_create_root_bus().
+ */
+void pcibios_free_controller_deferred(struct pci_host_bridge *bridge)
+{
+	struct pci_controller *phb = (struct pci_controller *)
+					 bridge->release_data;
+
+	pr_debug("domain %d, dynamic %d\n", phb->global_number, phb->is_dynamic);
+
+	pcibios_free_controller(phb);
+}
+EXPORT_SYMBOL_GPL(pcibios_free_controller_deferred);
+
+/*
  * The function is used to return the minimal alignment
  * for memory or I/O windows of the associated P2P bridge.
  * By default, 4KiB alignment for I/O windows and 1MiB for
diff --git a/arch/powerpc/platforms/pseries/pci.c b/arch/powerpc/platforms/pseries/pci.c
index fe16a50..09eba5a 100644
--- a/arch/powerpc/platforms/pseries/pci.c
+++ b/arch/powerpc/platforms/pseries/pci.c
@@ -119,6 +119,10 @@ int pseries_root_bridge_prepare(struct pci_host_bridge *bridge)
 
 	bus = bridge->bus;
 
+	/* Rely on the pcibios_free_controller_deferred() callback. */
+	pci_set_host_bridge_release(bridge, pcibios_free_controller_deferred,
+					(void *) pci_bus_to_host(bus));
+
 	dn = pcibios_get_phb_of_node(bus);
 	if (!dn)
 		return 0;
diff --git a/arch/powerpc/platforms/pseries/pci_dlpar.c b/arch/powerpc/platforms/pseries/pci_dlpar.c
index 906dbaa..547fd13 100644
--- a/arch/powerpc/platforms/pseries/pci_dlpar.c
+++ b/arch/powerpc/platforms/pseries/pci_dlpar.c
@@ -106,8 +106,11 @@ int remove_phb_dynamic(struct pci_controller *phb)
 		release_resource(res);
 	}
 
-	/* Free pci_controller data structure */
-	pcibios_free_controller(phb);
+	/*
+	 * The pci_controller data structure is freed by
+	 * the pcibios_free_controller_deferred() callback;
+	 * see pseries_root_bridge_prepare().
+	 */
 
 	return 0;
 }
-- 
1.8.3.1
