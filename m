Return-Path: <brking@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BBB56DDE38
	for <linuxppc-dev@ozlabs.org>; Fri,  2 Feb 2007 04:30:33 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l11HUUJt007961
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 12:30:30 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l11HUU4i240982
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 12:30:30 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l11HUTD7022121
	for <linuxppc-dev@ozlabs.org>; Thu, 1 Feb 2007 12:30:30 -0500
Message-Id: <200702011730.l11HUTSJ022072@d01av02.pok.ibm.com>
Subject: [PATCH 2/3] powerpc: Add powerpc PCI-E reset API implementation
To: gregkh@suse.de
From: Brian King <brking@linux.vnet.ibm.com>
Date: Thu, 01 Feb 2007 11:30:28 -0600
In-Reply-To: <11703510202911-patch-mail.ibm.com>
References: <11703510202911-patch-mail.ibm.com>
Cc: James.Bottomley@steeleye.com, linux-scsi@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org,
	brking@linux.vnet.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Adds the pSeries platform implementation for a new PCI API
which can be used to issue various types of PCI-E reset,
including PCI-E warm reset and PCI-E hot reset. This is needed
for an ipr PCI-E adapter which does not properly implement BIST.
Running BIST on this adapter results in PCI-E errors. The only
reliable reset mechanism that exists on this hardware is PCI
Fundamental reset (warm reset). 

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c |   30 +++++++++++++++++
 1 files changed, 30 insertions(+)

diff -puN arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3 arch/powerpc/platforms/pseries/eeh.c
--- linux-2.6/arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3	2007-02-01 10:29:21.000000000 -0600
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c	2007-02-01 10:30:59.000000000 -0600
@@ -561,6 +561,36 @@ rtas_pci_slot_reset(struct pci_dn *pdn, 
 }
 
 /**
+ * pcibios_set_pcie_slot_reset - Set PCI-E reset state
+ * @dev:	pci device struct
+ * @state:	reset state to enter
+ *
+ * Return value:
+ * 	0 if success
+ **/
+int pcibios_set_pcie_reset_state(struct pci_dev *dev, enum pcie_reset_state state)
+{
+	struct device_node *dn = pci_device_to_OF_node(dev);
+	struct pci_dn *pdn = PCI_DN(dn);
+
+	switch (state) {
+	case pci_reset_normal:
+		rtas_pci_slot_reset(pdn, 0);
+		break;
+	case pci_reset_pcie_hot_reset:
+		rtas_pci_slot_reset(pdn, 1);
+		break;
+	case pci_reset_pcie_warm_reset:
+		rtas_pci_slot_reset(pdn, 3);
+		break;
+	default:
+		return -EINVAL;
+	};
+
+	return 0;
+}
+
+/**
  * rtas_set_slot_reset -- assert the pci #RST line for 1/4 second
  * @pdn: pci device node to be reset.
  *
_
