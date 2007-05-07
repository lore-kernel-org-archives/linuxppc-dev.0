Return-Path: <brking@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 773E3DDEF6
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 08:04:10 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e35.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l47M472s029944
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 18:04:07 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l47M47RJ123172
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 16:04:07 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l47M46vn030747
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 16:04:07 -0600
Subject: [PATCH 1/1] powerpc: Add powerpc PCI-E reset API implementation
To: paulus@samba.org
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 07 May 2007 17:04:05 -0500
Message-Id: <11785754441145-patch-mail.ibm.com>
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

Acked-by: Linas Vepstas <linas@austin.ibm.com>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

Paul,

The generic PCI layer patch that this patch depends on is now
in. This patch can now be merged. Hopefully it can still make
2.6.22.

Thanks,

Brian
---

 linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c |   30 +++++++++++++++++
 1 file changed, 30 insertions(+)

diff -puN arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3 arch/powerpc/platforms/pseries/eeh.c
--- linux-2.6/arch/powerpc/platforms/pseries/eeh.c~powerpc_slot_reset_api3	2007-05-07 16:52:33.000000000 -0500
+++ linux-2.6-bjking1/arch/powerpc/platforms/pseries/eeh.c	2007-05-07 16:52:33.000000000 -0500
@@ -580,6 +580,36 @@ rtas_pci_slot_reset(struct pci_dn *pdn, 
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
+	case pcie_deassert_reset:
+		rtas_pci_slot_reset(pdn, 0);
+		break;
+	case pcie_hot_reset:
+		rtas_pci_slot_reset(pdn, 1);
+		break;
+	case pcie_warm_reset:
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
