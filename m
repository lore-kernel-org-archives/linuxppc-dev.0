Return-Path: <aik@ozlabs.ru>
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 3wpCHq01KmzDqLl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 15:49:26 +1000 (AEST)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Yongji Xie <elohimes@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Yongji Xie <xyjxie@linux.vnet.ibm.com>
Subject: [PATCH kernel 2/3] pci-ioda: Set PCI_BUS_FLAGS_MSI_REMAP for IODA
 host bridge
Date: Thu, 15 Jun 2017 15:48:44 +1000
Message-Id: <20170615054845.8428-3-aik@ozlabs.ru>
In-Reply-To: <20170615054845.8428-1-aik@ozlabs.ru>
References: <20170615054845.8428-1-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Yongji Xie <elohimes@gmail.com>

Any IODA host bridge have the capability of IRQ remapping.
So we set PCI_BUS_FLAGS_MSI_REMAP when this kind of host birdge
is detected.

Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 283caf1070c9..b6bda1918273 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -3177,6 +3177,12 @@ static void pnv_pci_ioda_fixup(void)
 #endif
 }
 
+int pnv_pci_ioda_root_bridge_prepare(struct pci_host_bridge *bridge)
+{
+	bridge->bus->bus_flags |= PCI_BUS_FLAGS_MSI_REMAP;
+	return 0;
+}
+
 /*
  * Returns the alignment for I/O or memory windows for P2P
  * bridges. That actually depends on how PEs are segmented.
@@ -3861,6 +3867,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	 */
 	ppc_md.pcibios_fixup = pnv_pci_ioda_fixup;
 
+	ppc_md.pcibios_root_bridge_prepare = pnv_pci_ioda_root_bridge_prepare;
+
 	if (phb->type == PNV_PHB_NPU) {
 		hose->controller_ops = pnv_npu_ioda_controller_ops;
 	} else {
-- 
2.11.0
