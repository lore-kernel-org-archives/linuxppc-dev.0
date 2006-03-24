Return-Path: <johnrose@austin.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78FCB67A5C
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 04:18:42 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2OHId0j013447
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 12:18:39 -0500
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by westrelay02.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2OHFZXl255976
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 10:15:35 -0700
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k2OHIdsU015481
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 10:18:39 -0700
Subject: [PATCH] powerpc: dynamic probe - use ppc_md.pci_probe_mode()
From: John Rose <johnrose@austin.ibm.com>
To: benh@kernel.crashing.org
Content-Type: text/plain
Message-Id: <1143220753.2567.22.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
Date: Fri, 24 Mar 2006 11:19:13 -0600
Cc: External List <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change the dynamic PCI probe function for pSeries to use
ppc_md.pci_probe_mode() when appropriate.

Signed-off-by: John Rose <johnrose@austin.ibm.com>

---

As suggested by BenH.  Tested on POWER5.

Thanks-
John

diff -puN arch/powerpc/platforms/pseries/pci_dlpar.c~use_probe_mode arch/powerpc/platforms/pseries/pci_dlpar.c
--- 2_6_cleanups/arch/powerpc/platforms/pseries/pci_dlpar.c~use_probe_mode	2006-03-24 09:57:08.000000000 -0600
+++ 2_6_cleanups-johnrose/arch/powerpc/platforms/pseries/pci_dlpar.c	2006-03-24 10:12:49.000000000 -0600
@@ -152,20 +152,26 @@ pcibios_pci_config_bridge(struct pci_dev
 void
 pcibios_add_pci_devices(struct pci_bus * bus)
 {
-	int slotno, num;
+	int slotno, num, mode;
 	struct pci_dev *dev;
 	struct device_node *dn = pci_bus_to_OF_node(bus);
 
 	eeh_add_device_tree_early(dn);
 
-	if (_machine == PLATFORM_PSERIES_LPAR) {
+	mode = PCI_PROBE_NORMAL;
+	if (ppc_md.pci_probe_mode)
+		mode = ppc_md.pci_probe_mode(bus);
+
+	if (mode == PCI_PROBE_DEVTREE) {
+		printk("%s: jhr: new probe\n", __FUNCTION__);
 		/* use ofdt-based probe */
 		of_scan_bus(dn, bus);
 		if (!list_empty(&bus->devices)) {
 			pcibios_fixup_new_pci_devices(bus, 0);
 			pci_bus_add_devices(bus);
 		}
-	} else {
+	} else if (mode == PCI_PROBE_NORMAL) {
+		printk("%s: jhr: old probe\n", __FUNCTION__);
 		/* use legacy probe */
 		slotno = PCI_SLOT(PCI_DN(dn->child)->devfn);
 		num = pci_scan_slot(bus, PCI_DEVFN(slotno, 0));

_
