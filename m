Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yVdH24cz1zDr8P
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 14:25:18 +1100 (AEDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Michael Neuling <mikey@neuling.org>
Subject: [RFC PATCH kernel] powerpc/pci: Get rid of unused @parent pointer in
 pci_controller
Date: Mon,  6 Nov 2017 14:24:41 +1100
Message-Id: <20171106032441.10031-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The @parent pointer is supposed to point to a device which represents
a PCI controller, however it is never set to anything and remains NULL;
it is also quite common to pass NULL to pci_create_root_bus().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

This @parent is NULL for every PHB in garrison machines, for example.
Where would this pointer be really used?

I wonder how does setting it make any difference in sysfs for CXL vphb?

In general, I'd think that @parent makes sense and every PHB
has a parent device struct like any other device and the platform
code binds a correct device driver to a PHB and we can avoid
having PNV_PHB_IODA2&co switches but for some reason PHBs are
hardcoded in the platform code.

---
 arch/powerpc/include/asm/pci-bridge.h | 1 -
 arch/powerpc/kernel/pci-common.c      | 2 +-
 drivers/misc/cxl/vphb.c               | 3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 752718a2949d..ad88ddeaa6b7 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -60,7 +60,6 @@ struct pci_controller {
 #endif
 	struct device_node *dn;
 	struct list_head list_node;
-	struct device *parent;
 
 	int first_busno;
 	int last_busno;
diff --git a/arch/powerpc/kernel/pci-common.c b/arch/powerpc/kernel/pci-common.c
index 02831a396419..597576777c34 100644
--- a/arch/powerpc/kernel/pci-common.c
+++ b/arch/powerpc/kernel/pci-common.c
@@ -1681,7 +1681,7 @@ void pcibios_scan_phb(struct pci_controller *hose)
 	pci_add_resource(&resources, &hose->busn);
 
 	/* Create an empty bus for the toplevel */
-	bus = pci_create_root_bus(hose->parent, hose->first_busno,
+	bus = pci_create_root_bus(NULL, hose->first_busno,
 				  hose->ops, hose, &resources);
 	if (bus == NULL) {
 		pr_err("Failed to create bus for PCI domain %04x\n",
diff --git a/drivers/misc/cxl/vphb.c b/drivers/misc/cxl/vphb.c
index 512a4897dbf6..ae3fe1563812 100644
--- a/drivers/misc/cxl/vphb.c
+++ b/drivers/misc/cxl/vphb.c
@@ -232,9 +232,6 @@ int cxl_pci_vphb_add(struct cxl_afu *afu)
 	if (!phb)
 		return -ENODEV;
 
-	/* Setup parent in sysfs */
-	phb->parent = parent;
-
 	/* Setup the PHB using arch provided callback */
 	phb->ops = &cxl_pcie_pci_ops;
 	phb->cfg_addr = NULL;
-- 
2.11.0
