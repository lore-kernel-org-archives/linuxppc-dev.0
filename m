Return-Path: <rlary@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F8B9100B22
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 23 Apr 2011 06:00:04 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3MJmlbA018245
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:48:47 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	p3MJxqrN125340
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:59:52 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3MJxpGj009069
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Apr 2011 13:59:51 -0600
Message-ID: <4DB1DE33.5030206@linux.vnet.ibm.com>
Date: Fri, 22 Apr 2011 12:59:47 -0700
From: Richard A Lary <rlary@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3]  [PATCH 1/3]powerpc/eeh: Propagate needs_freset flag
	to device at PE
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: antonb@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Richard A Lary <rlary@linux.vnet.ibm.com>

  For multifunction adapters with a PCI bridge or switch as the device
  at the Partitionable Endpoint(PE), if one or more devices below PE
  sets dev->needs_freset, that value will be set for the PE device.

  In other words, if any device below PE requires a fundamental reset
  the PE will request a fundamental reset.

Signed-off-by: Richard A Lary <rlary@linux.vnet.ibm.com>
---
  arch/powerpc/platforms/pseries/eeh.c |   48 	42 +	6 -	0 !
  1 file changed, 42 insertions(+), 6 deletions(-)

Index: b/arch/powerpc/platforms/pseries/eeh.c
===================================================================
--- a/arch/powerpc/platforms/pseries/eeh.c
+++ b/arch/powerpc/platforms/pseries/eeh.c
@@ -448,6 +448,39 @@ void eeh_clear_slot (struct device_node
  	raw_spin_unlock_irqrestore(&confirm_error_lock, flags);
  }

+void __eeh_set_pe_freset(struct device_node *parent, unsigned int *freset)
+{
+	struct device_node *dn;
+
+	for_each_child_of_node(parent, dn) {
+		if (PCI_DN(dn)) {
+
+			struct pci_dev *dev = PCI_DN(dn)->pcidev;
+
+			if (dev && dev->driver)
+				*freset |= dev->needs_freset;
+
+			__eeh_set_pe_freset(dn, freset);
+		}
+	}
+}
+
+void eeh_set_pe_freset(struct device_node *dn, unsigned int *freset)
+{
+	struct pci_dev *dev;
+	dn = find_device_pe(dn);
+
+	/* Back up one, since config addrs might be shared */
+	if (!pcibios_find_pci_bus(dn) && PCI_DN(dn->parent))
+		dn = dn->parent;
+
+	dev = PCI_DN(dn)->pcidev;
+	if (dev)
+		*freset |= dev->needs_freset;
+
+	__eeh_set_pe_freset(dn, freset);
+}
+
  /**
   * eeh_dn_check_failure - check if all 1's data is due to EEH slot freeze
   * @dn device node
@@ -736,18 +769,21 @@ int pcibios_set_pcie_reset_state(struct
  /**
   * rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
   * @pdn: pci device node to be reset.
- *
- *  Return 0 if success, else a non-zero value.
   */

  static void __rtas_set_slot_reset(struct pci_dn *pdn)
  {
-	struct pci_dev *dev = pdn->pcidev;
+	unsigned int freset = 0;

-	/* Determine type of EEH reset required by device,
-	 * default hot reset or fundamental reset
+	/* Determine type of EEH reset required for
+	 * Partitionable Endpoint, a hot-reset (1)
+	 * or a fundamental reset (3).
+	 * A fundamental reset required by any device under
+	 * Partitionable Endpoint trumps hot-reset.
  	 */
-	if (dev && dev->needs_freset)
+	eeh_set_pe_freset(pdn->node, &freset);
+
+	if (freset)
  		rtas_pci_slot_reset(pdn, 3);
  	else
  		rtas_pci_slot_reset(pdn, 1);
