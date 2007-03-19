Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4984BDE01B
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 07:01:35 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2JK1Wmr000511
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 16:01:32 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2JK1WYp064230
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 14:01:32 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2JK1Wk0018207
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Mar 2007 14:01:32 -0600
Date: Mon, 19 Mar 2007 15:01:31 -0500
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 11/11] ppc64: EEH: restructure multi-function support
Message-ID: <20070319200131.GK11532@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070319194349.GT5151@austin.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Rework how multi-function PCI devices are identified and traversed.
This fixes a bug with multi-function recovery on Power4 that was
introduced by a recent Power4 EEH patch.

Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

----
 arch/powerpc/platforms/pseries/eeh.c        |    4 +--
 arch/powerpc/platforms/pseries/eeh_driver.c |   30 +++++++++++++---------------
 2 files changed, 16 insertions(+), 18 deletions(-)

Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:21:53.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh_driver.c	2007-03-19 13:48:58.000000000 -0500
@@ -249,6 +249,7 @@ static void eeh_report_failure(struct pc
 
 static int eeh_reset_device (struct pci_dn *pe_dn, struct pci_bus *bus)
 {
+	struct device_node *dn;
 	int cnt, rc;
 
 	/* pcibios will clear the counter; save the value */
@@ -264,23 +265,20 @@ static int eeh_reset_device (struct pci_
 	if (rc)
 		return rc;
 
- 	/* New-style config addrs might be shared across multiple devices,
- 	 * Walk over all functions on this device */
- 	if (pe_dn->eeh_pe_config_addr) {
- 		struct device_node *pe = pe_dn->node;
- 		pe = pe->parent->child;
- 		while (pe) {
- 			struct pci_dn *ppe = PCI_DN(pe);
- 			if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
- 				rtas_configure_bridge(ppe);
- 				eeh_restore_bars(ppe);
- 			}
- 			pe = pe->sibling;
+ 	/* Walk over all functions on this device.  */
+	dn = pe_dn->node;
+	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+		dn = dn->parent->child;
+
+	while (dn) {
+ 		struct pci_dn *ppe = PCI_DN(dn);
+		/* On Power4, always true because eeh_pe_config_addr=0 */
+ 		if (pe_dn->eeh_pe_config_addr == ppe->eeh_pe_config_addr) {
+ 			rtas_configure_bridge(ppe);
+ 			eeh_restore_bars(ppe);
  		}
- 	} else {
- 		rtas_configure_bridge(pe_dn);
- 		eeh_restore_bars(pe_dn);
- 	}
+ 		dn = dn->sibling;
+	}
 
 	/* Give the system 5 seconds to finish running the user-space
 	 * hotplug shutdown scripts, e.g. ifdown for ethernet.  Yes, 
Index: linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- linux-2.6.21-rc4-git4.orig/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:21:53.000000000 -0500
+++ linux-2.6.21-rc4-git4/arch/powerpc/platforms/pseries/eeh.c	2007-03-19 13:48:44.000000000 -0500
@@ -282,7 +282,7 @@ void eeh_mark_slot (struct device_node *
 	dn = find_device_pe (dn);
 
 	/* Back up one, since config addrs might be shared */
-	if (PCI_DN(dn) && PCI_DN(dn)->eeh_pe_config_addr)
+	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
 		dn = dn->parent;
 
 	PCI_DN(dn)->eeh_mode |= mode_flag;
@@ -316,7 +316,7 @@ void eeh_clear_slot (struct device_node 
 	dn = find_device_pe (dn);
 	
 	/* Back up one, since config addrs might be shared */
-	if (PCI_DN(dn) && PCI_DN(dn)->eeh_pe_config_addr)
+	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
 		dn = dn->parent;
 
 	PCI_DN(dn)->eeh_mode &= ~mode_flag;
