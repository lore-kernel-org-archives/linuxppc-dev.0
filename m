Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Oct 2008 14:51:46 +1100
Subject: [PATCH] powerpc: Fix link errors on 32-bit machines using legacy DMA
Message-Id: <20081014035221.76042DDE0D@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The new merged DMA code will try to access isa_bridge_pcidev when
trying to DMA to/from legacy devices. This is however only defined
on 64-bit. Fixes this for now by adding the variable, even if it
stays NULL. In the long run, we'll make isa-bridge.c common to
32 and 64-bit.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/pci_32.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- linux-work.orig/arch/powerpc/kernel/pci_32.c	2008-10-14 13:41:14.000000000 +1100
+++ linux-work/arch/powerpc/kernel/pci_32.c	2008-10-14 13:41:40.000000000 +1100
@@ -53,6 +53,12 @@ LIST_HEAD(hose_list);
 
 static int pci_bus_count;
 
+/* This will remain NULL for now, until isa-bridge.c is made common
+ * to both 32-bit and 64-bit.
+ */
+struct pci_dev *isa_bridge_pcidev;
+EXPORT_SYMBOL_GPL(isa_bridge_pcidev);
+
 static void
 fixup_hide_host_resource_fsl(struct pci_dev *dev)
 {
