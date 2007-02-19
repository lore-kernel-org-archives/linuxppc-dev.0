Return-Path: <brking@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45808DDF11
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2007 01:47:29 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1JElOXo001667
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 09:47:24 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1JElO9O521278
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 07:47:24 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1JElNfY027135
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Feb 2007 07:47:24 -0700
Message-Id: <200702191447.l1JElNTw027077@d03av04.boulder.ibm.com>
Subject: [PATCH 2/3] powerpc: Add powerpc PCI-E reset API implementation
To: greg@kroah.com
From: Brian King <brking@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2007 08:47:21 -0600
In-Reply-To: <11718964333825-patch-mail.ibm.com>
References: <11718964333825-patch-mail.ibm.com>
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
