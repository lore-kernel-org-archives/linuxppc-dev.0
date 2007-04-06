Return-Path: <brking@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2C4E3DDE49
	for <linuxppc-dev@ozlabs.org>; Sat,  7 Apr 2007 00:07:13 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l36E79OH014951
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 10:07:09 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l36E75Xr224314
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 10:07:05 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l36E756h007556
	for <linuxppc-dev@ozlabs.org>; Fri, 6 Apr 2007 10:07:05 -0400
Subject: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Fri, 06 Apr 2007 09:07:04 -0500
Message-Id: <11758684222896-patch-mail.ibm.com>
Cc: brking@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	thlin@linux.vnet.ibm.com
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

Paul,

This patch requires a generic PCI layer patch, which is in Greg's
queue for 2.6.22, so do NOT apply this yet. Once the PCI change goes
in, I will resend this patch.

Thanks,

Brian
---

 linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c |   30 +++++++++++++++++
 1 files changed, 30 insertions(+)

diff -puN arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3 arch/powerpc/platforms/pseries/eeh.c
--- linux-2.6/arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3	2007-04-06 08:38:35.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c	2007-04-06 08:38:35.000000000 -0500
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
