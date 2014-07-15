Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C18CE1A15FA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:53 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:53 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 1DF58357805B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9N4uH36110360
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:23:04 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9doa5012970
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 07/12] spapr_pci: Enable DDW
Date: Tue, 15 Jul 2014 19:39:39 +1000
Message-Id: <1405417184-14333-8-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
References: <1405417184-14333-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/ppc/spapr_pci.c          | 62 +++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h |  3 +++
 2 files changed, 65 insertions(+)

diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 230b59c..038a485 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -22,6 +22,7 @@
  * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
  * THE SOFTWARE.
  */
+#include "sysemu/sysemu.h"
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
@@ -781,6 +782,42 @@ static const char *spapr_phb_root_bus_path(PCIHostState *host_bridge,
     return sphb->dtbusname;
 }
 
+static int spapr_pci_ddw_query(sPAPRPHBState *sphb,
+                               uint32_t *windows_available,
+                               uint32_t *page_size_mask)
+{
+    *windows_available = 1;
+    *page_size_mask = DDW_PGSIZE_16M;
+
+    return 0;
+}
+
+static int spapr_pci_ddw_create(sPAPRPHBState *sphb, uint32_t page_shift,
+                                uint32_t window_shift, uint32_t liobn,
+                                sPAPRTCETable **ptcet)
+{
+    *ptcet = spapr_tce_new_table(DEVICE(sphb), liobn, SPAPR_PCI_TCE64_START,
+                                 page_shift, 1 << (window_shift - page_shift),
+                                 true);
+    if (!*ptcet) {
+        return -1;
+    }
+    memory_region_add_subregion(&sphb->iommu_root, (*ptcet)->bus_offset,
+                                spapr_tce_get_iommu(*ptcet));
+
+    return 0;
+}
+
+static int spapr_pci_ddw_remove(sPAPRPHBState *sphb, sPAPRTCETable *tcet)
+{
+    return 0;
+}
+
+static int spapr_pci_ddw_reset(sPAPRPHBState *sphb)
+{
+    return 0;
+}
+
 static void spapr_phb_class_init(ObjectClass *klass, void *data)
 {
     PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(klass);
@@ -795,6 +832,10 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->cannot_instantiate_with_device_add_yet = false;
     spc->finish_realize = spapr_phb_finish_realize;
+    spc->ddw_query = spapr_pci_ddw_query;
+    spc->ddw_create = spapr_pci_ddw_create;
+    spc->ddw_remove = spapr_pci_ddw_remove;
+    spc->ddw_reset = spapr_pci_ddw_reset;
 }
 
 static const TypeInfo spapr_phb_info = {
@@ -878,6 +919,14 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     uint32_t interrupt_map_mask[] = {
         cpu_to_be32(b_ddddd(-1)|b_fff(0)), 0x0, 0x0, cpu_to_be32(-1)};
     uint32_t interrupt_map[PCI_SLOT_MAX * PCI_NUM_PINS][7];
+    uint32_t ddw_applicable[] = {
+        RTAS_IBM_QUERY_PE_DMA_WINDOW,
+        RTAS_IBM_CREATE_PE_DMA_WINDOW,
+        RTAS_IBM_REMOVE_PE_DMA_WINDOW
+    };
+    uint32_t ddw_extensions[] = { 1, RTAS_IBM_RESET_PE_DMA_WINDOW };
+    sPAPRPHBClass *spc = SPAPR_PCI_HOST_BRIDGE_GET_CLASS(phb);
+    QemuOpts *machine_opts = qemu_get_machine_opts();
 
     /* Start populating the FDT */
     sprintf(nodename, "pci@%" PRIx64, phb->buid);
@@ -907,6 +956,19 @@ int spapr_populate_pci_dt(sPAPRPHBState *phb,
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pci-config-space-type", 0x1));
     _FDT(fdt_setprop_cell(fdt, bus_off, "ibm,pe-total-#msi", XICS_IRQS));
 
+    /* Dynamic DMA window */
+    if (qemu_opt_get_bool(machine_opts, "ddw", true) &&
+        spc->ddw_query && spc->ddw_create && spc->ddw_remove) {
+        _FDT(fdt_setprop(fdt, bus_off, "ibm,ddw-applicable", &ddw_applicable,
+                         sizeof(ddw_applicable)));
+
+        if (spc->ddw_reset) {
+            /* When enabled, the guest will remove the default 32bit window */
+            _FDT(fdt_setprop(fdt, bus_off, "ibm,ddw-extensions",
+                             &ddw_extensions, sizeof(ddw_extensions)));
+        }
+    }
+
     /* Build the interrupt-map, this must matches what is done
      * in pci_spapr_map_irq
      */
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 119d326..f494cbb 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -125,6 +125,9 @@ struct sPAPRPHBVFIOState {
 
 #define SPAPR_PCI_MEM_WIN_BUS_OFFSET 0x80000000ULL
 
+/* Default 64bit dynamic window offset */
+#define SPAPR_PCI_TCE64_START        0x8000000000000000ULL
+
 static inline qemu_irq spapr_phb_lsi_qirq(struct sPAPRPHBState *phb, int pin)
 {
     return xics_get_qirq(spapr->icp, phb->lsi_table[pin].irq);
-- 
2.0.0
