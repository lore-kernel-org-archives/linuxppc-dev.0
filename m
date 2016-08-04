Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4d7y2nVDzDqTg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 15:01:34 +1000 (AEST)
From: Russell Currey <ruscur@russell.cc>
To: linuxppc-dev@lists.ozlabs.org
Cc: gwshan@linux.vnet.ibm.com,
	Russell Currey <ruscur@russell.cc>
Subject: [PATCH] powerpc/eeh: Fix slot locations on NPU and legacy platforms
Date: Thu,  4 Aug 2016 15:01:15 +1000
Message-Id: <20160804050115.9937-1-ruscur@russell.cc>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The slot location code as part of EEH has never functioned perfectly on
every powerpc system.  The device node properties "ibm,slot-loc",
"ibm,slot-location-code" and "ibm,io-base-loc-code" have all been
presented in different cases, and in some situations, there are legacy
platforms not conforming to the conventions of populating root buses with
"ibm,io-base-loc-code" and child nodes with "ibm,slot-location-code".

Specifically, some legacy platforms use "ibm,loc-code" instead, which
stopped working with 7e56f627768.  In addition, EEH PEs for NPU devices
have slot locations specified on the devices instead of buses due to their
architecture, and these were not printed.  This has been fixed by looking
at the top device of a PE for a slot location before checking its bus.

Fixes: 7e56f627768 "powerpc/eeh: Fix PE location code"
Cc: <stable@vger.kernel.org> #4.4+
Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/eeh_pe.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/eeh_pe.c b/arch/powerpc/kernel/eeh_pe.c
index f0520da..034538c 100644
--- a/arch/powerpc/kernel/eeh_pe.c
+++ b/arch/powerpc/kernel/eeh_pe.c
@@ -881,17 +881,34 @@ void eeh_pe_restore_bars(struct eeh_pe *pe)
  * eeh_pe_loc_get - Retrieve location code binding to the given PE
  * @pe: EEH PE
  *
- * Retrieve the location code of the given PE. If the primary PE bus
- * is root bus, we will grab location code from PHB device tree node
- * or root port. Otherwise, the upstream bridge's device tree node
- * of the primary PE bus will be checked for the location code.
+ * Retrieve the location code of the given PE. The first device associated
+ * with the PE is checked for a slot location.  If missing, the bus of the
+ * device is checked instead.  If this is a root bus, the location code is
+ * taken from the PHB device tree node or root port.  If not, the upstream
+ * bridge's device tree node of the primary PE bus will be checked instead.
+ * If a slot location isn't found on the bus, walk through parent buses
+ * until a location is found.
  */
 const char *eeh_pe_loc_get(struct eeh_pe *pe)
 {
-	struct pci_bus *bus = eeh_pe_bus_get(pe);
+	struct pci_bus *bus;
 	struct device_node *dn;
 	const char *loc = NULL;
 
+	/* Check the slot location of the first (top) PCI device */
+	struct eeh_dev *edev =
+		list_first_entry_or_null(&pe->edevs, struct eeh_dev, list);
+
+	if (edev) {
+		loc = of_get_property(edev->pdn->node,
+				      "ibm,slot-location-code", NULL);
+		if (loc)
+			return loc;
+	}
+
+	/* If there's nothing on the device, look at the bus */
+	bus = eeh_pe_bus_get(pe);
+
 	while (bus) {
 		dn = pci_bus_to_OF_node(bus);
 		if (!dn) {
@@ -905,6 +922,10 @@ const char *eeh_pe_loc_get(struct eeh_pe *pe)
 			loc = of_get_property(dn, "ibm,slot-location-code",
 					      NULL);
 
+		/* Fall back to ibm,loc-code if nothing else is found */
+		if (!loc)
+			loc = of_get_property(dn, "ibm,loc-code", NULL);
+
 		if (loc)
 			return loc;
 
-- 
2.9.2
