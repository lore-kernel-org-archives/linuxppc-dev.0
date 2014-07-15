Return-Path: <aik@ozlabs.ru>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C4251A0A36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:50 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 46BCC357805A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:49 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9dX7C5964214
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:33 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9dmqu026406
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:49 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 05/12] spapr_rtas: Add Dynamic DMA windows (DDW) RTAS
 calls support
Date: Tue, 15 Jul 2014 19:39:37 +1000
Message-Id: <1405417184-14333-6-git-send-email-aik@ozlabs.ru>
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

spapr_pci_vfio: Support dynamic DMA window

This adds support for Dynamic DMA Windows (DDW) option defined by
the SPAPR specification which allows to have additional DMA windows besides
the default and small one which can only handle 4K pages and which
should completely fit into first 32bit of PCI address space what makes it
less than perfect solution for high-speed PCI devices.

The existing implementation of DDW in the guest tries to create one huge
DMA window with 64K or 16MB pages and map the entire guest RAM to. If this
operation suceedes, the guest switches to dma_direct_ops and never calls
TCE hypercalls (H_PUT_TCE,...). This enables VFIO devices to use the entire
RAM and not spend time on mapping/unmapping.

This adds 4 RTAS handlers:
* ibm,query-pe-dma-window
* ibm,create-pe-dma-window
* ibm,remove-pe-dma-window
* ibm,reset-pe-dma-window
These are registered from qapi_init callback.

This adds @ddw_supported property to sPAPRPHBState to enable DDW
feature.

This adds @ddw_reset_supported property to sPAPRPHBState to enable DDW
"reset" extention (TODO: debug).

This bumps migration descriptor version as there are 2 new properties.

This adds a notifier for VFIO to provide path for calling DDW-related
ioctls via VFIO container fd.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

"Reset" is not implemented yet and it is questionable if we really want it.
---
 hw/ppc/Makefile.objs        |   3 +
 hw/ppc/spapr_rtas_ddw.c     | 296 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci-host/spapr.h |  18 +++
 include/hw/ppc/spapr.h      |   7 +-
 trace-events                |   4 +
 5 files changed, 326 insertions(+), 2 deletions(-)
 create mode 100644 hw/ppc/spapr_rtas_ddw.c

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index edd44d0..9773294 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -7,6 +7,9 @@ obj-$(CONFIG_PSERIES) += spapr_pci.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y += spapr_pci_vfio.o
 endif
+ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES), yy)
+obj-y += spapr_rtas_ddw.o
+endif
 # PowerPC 4xx boards
 obj-y += ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
 obj-y += ppc4xx_pci.o
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
new file mode 100644
index 0000000..943af2c
--- /dev/null
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -0,0 +1,296 @@
+/*
+ * QEMU sPAPR Dynamic DMA windows support
+ *
+ * Copyright (c) 2014 Alexey Kardashevskiy, IBM Corporation.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "hw/ppc/spapr.h"
+#include "hw/pci-host/spapr.h"
+#include "trace.h"
+
+static inline uint32_t spapr_iommu_fixmask(uint32_t cur_mask,
+                                           struct ppc_one_seg_page_size *sps,
+                                           uint32_t query_mask,
+                                           int shift,
+                                           uint32_t add_mask)
+{
+    if ((sps->page_shift == shift) && (query_mask & add_mask)) {
+        cur_mask |= add_mask;
+    }
+    return cur_mask;
+}
+
+static void rtas_ibm_query_pe_dma_window(PowerPCCPU *cpu,
+                                         sPAPREnvironment *spapr,
+                                         uint32_t token, uint32_t nargs,
+                                         target_ulong args,
+                                         uint32_t nret, target_ulong rets)
+{
+    CPUPPCState *env = &cpu->env;
+    sPAPRPHBState *sphb;
+    sPAPRPHBClass *spc;
+    uint64_t buid;
+    uint32_t addr, pgmask = 0;
+    uint32_t windows_available = 0, page_size_mask = 0;
+    long ret, i;
+
+    if ((nargs != 3) || (nret != 5)) {
+        goto param_error_exit;
+    }
+
+    buid = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 2);
+    addr = rtas_ld(args, 0);
+    sphb = spapr_pci_find_phb(spapr, buid);
+    if (!sphb) {
+        goto param_error_exit;
+    }
+
+    spc = SPAPR_PCI_HOST_BRIDGE_GET_CLASS(sphb);
+    if (!spc->ddw_query) {
+        goto hw_error_exit;
+    }
+
+    ret = spc->ddw_query(sphb, &windows_available, &page_size_mask);
+    trace_spapr_iommu_ddw_query(buid, addr, windows_available,
+                                page_size_mask, pgmask, ret);
+    if (ret) {
+        goto hw_error_exit;
+    }
+
+    /* DBG! */
+    if (!(page_size_mask & DDW_PGSIZE_16M)) {
+        goto hw_error_exit;
+    }
+
+    /* Work out biggest possible page size */
+    for (i = 0; i < PPC_PAGE_SIZES_MAX_SZ; i++) {
+        int j;
+        struct ppc_one_seg_page_size *sps = &env->sps.sps[i];
+        const struct { int shift; uint32_t mask; } masks[] = {
+            { 12, DDW_PGSIZE_4K },
+            { 16, DDW_PGSIZE_64K },
+            { 24, DDW_PGSIZE_16M },
+            { 25, DDW_PGSIZE_32M },
+            { 26, DDW_PGSIZE_64M },
+            { 27, DDW_PGSIZE_128M },
+            { 28, DDW_PGSIZE_256M },
+            { 34, DDW_PGSIZE_16G },
+        };
+        for (j = 0; j < ARRAY_SIZE(masks); ++j) {
+            pgmask = spapr_iommu_fixmask(pgmask, sps, page_size_mask,
+                                         masks[j].shift, masks[j].mask);
+        }
+    }
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    rtas_st(rets, 1, windows_available);
+    /* Return maximum number as all RAM was 4K pages */
+    rtas_st(rets, 2, ram_size >> SPAPR_TCE_PAGE_SHIFT);
+    rtas_st(rets, 3, pgmask);
+    rtas_st(rets, 4, pgmask); /* DMA migration mask */
+    return;
+
+hw_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
+static void rtas_ibm_create_pe_dma_window(PowerPCCPU *cpu,
+                                          sPAPREnvironment *spapr,
+                                          uint32_t token, uint32_t nargs,
+                                          target_ulong args,
+                                          uint32_t nret, target_ulong rets)
+{
+    sPAPRPHBState *sphb;
+    sPAPRPHBClass *spc;
+    sPAPRTCETable *tcet = NULL;
+    uint32_t addr, page_shift, window_shift, liobn;
+    uint64_t buid;
+    long ret;
+
+    if ((nargs != 5) || (nret != 4)) {
+        goto param_error_exit;
+    }
+
+    buid = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 2);
+    addr = rtas_ld(args, 0);
+    sphb = spapr_pci_find_phb(spapr, buid);
+    if (!sphb) {
+        goto param_error_exit;
+    }
+
+    spc = SPAPR_PCI_HOST_BRIDGE_GET_CLASS(sphb);
+    if (!spc->ddw_create) {
+        goto hw_error_exit;
+    }
+
+    page_shift = rtas_ld(args, 3);
+    window_shift = rtas_ld(args, 4);
+    liobn = sphb->dma_liobn + 0x10000;
+
+    ret = spc->ddw_create(sphb, page_shift, window_shift, liobn, &tcet);
+    trace_spapr_iommu_ddw_create(buid, addr, 1 << page_shift,
+                                 1 << window_shift,
+                                 tcet ? tcet->bus_offset : 0xbaadf00d,
+                                 liobn, ret);
+    if (ret || !tcet) {
+        goto hw_error_exit;
+    }
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    rtas_st(rets, 1, liobn);
+    rtas_st(rets, 2, tcet->bus_offset >> 32);
+    rtas_st(rets, 3, tcet->bus_offset & ((uint32_t) -1));
+    return;
+
+hw_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
+static void rtas_ibm_remove_pe_dma_window(PowerPCCPU *cpu,
+                                          sPAPREnvironment *spapr,
+                                          uint32_t token, uint32_t nargs,
+                                          target_ulong args,
+                                          uint32_t nret, target_ulong rets)
+{
+    sPAPRPHBState *sphb;
+    sPAPRPHBClass *spc;
+    sPAPRTCETable *tcet;
+    uint32_t liobn;
+    long ret;
+
+    if ((nargs != 1) || (nret != 1)) {
+        goto param_error_exit;
+    }
+
+    liobn = rtas_ld(args, 0);
+    tcet = spapr_tce_find_by_liobn(liobn);
+    if (!tcet) {
+        goto param_error_exit;
+    }
+
+    sphb = SPAPR_PCI_HOST_BRIDGE(OBJECT(tcet)->parent);
+    if (!sphb) {
+        goto param_error_exit;
+    }
+
+    spc = SPAPR_PCI_HOST_BRIDGE_GET_CLASS(sphb);
+    if (!spc->ddw_remove) {
+        goto hw_error_exit;
+    }
+
+    ret = spc->ddw_remove(sphb, tcet);
+    trace_spapr_iommu_ddw_remove(liobn, ret);
+    if (ret) {
+        goto hw_error_exit;
+    }
+
+    object_unparent(OBJECT(tcet));
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    return;
+
+hw_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
+static int ddw_remove_tce_table_cb(Object *child, void *opaque)
+{
+    sPAPRTCETable *tcet;
+
+    tcet = (sPAPRTCETable *) object_dynamic_cast(child, TYPE_SPAPR_TCE_TABLE);
+    if (tcet && tcet->bus_offset) {
+        object_unparent(child);
+    }
+
+    return 0;
+}
+
+static void rtas_ibm_reset_pe_dma_window(PowerPCCPU *cpu,
+                                         sPAPREnvironment *spapr,
+                                         uint32_t token, uint32_t nargs,
+                                         target_ulong args,
+                                         uint32_t nret, target_ulong rets)
+{
+    sPAPRPHBState *sphb;
+    sPAPRPHBClass *spc;
+    uint64_t buid;
+    uint32_t addr;
+    long ret;
+
+    if ((nargs != 3) || (nret != 1)) {
+        goto param_error_exit;
+    }
+
+    buid = ((uint64_t)rtas_ld(args, 1) << 32) | rtas_ld(args, 2);
+    addr = rtas_ld(args, 0);
+    sphb = spapr_pci_find_phb(spapr, buid);
+    if (!sphb) {
+        goto param_error_exit;
+    }
+
+    spc = SPAPR_PCI_HOST_BRIDGE_GET_CLASS(sphb);
+    if (!spc->ddw_reset) {
+        goto hw_error_exit;
+    }
+
+    ret = spc->ddw_reset(sphb);
+    trace_spapr_iommu_ddw_reset(buid, addr, ret);
+    if (ret) {
+        goto hw_error_exit;
+    }
+
+    object_child_foreach(OBJECT(sphb), ddw_remove_tce_table_cb, NULL);
+
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    return;
+
+hw_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_HW_ERROR);
+    return;
+
+param_error_exit:
+    rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+}
+
+static void spapr_rtas_ddw_init(void)
+{
+    spapr_rtas_register(RTAS_IBM_QUERY_PE_DMA_WINDOW,
+                        "ibm,query-pe-dma-window",
+                        rtas_ibm_query_pe_dma_window);
+    spapr_rtas_register(RTAS_IBM_CREATE_PE_DMA_WINDOW,
+                        "ibm,create-pe-dma-window",
+                        rtas_ibm_create_pe_dma_window);
+    spapr_rtas_register(RTAS_IBM_REMOVE_PE_DMA_WINDOW,
+                        "ibm,remove-pe-dma-window",
+                        rtas_ibm_remove_pe_dma_window);
+    spapr_rtas_register(RTAS_IBM_RESET_PE_DMA_WINDOW,
+                        "ibm,reset-pe-dma-window",
+                        rtas_ibm_reset_pe_dma_window);
+}
+
+type_init(spapr_rtas_ddw_init)
diff --git a/include/hw/pci-host/spapr.h b/include/hw/pci-host/spapr.h
index 14c2ab0..119d326 100644
--- a/include/hw/pci-host/spapr.h
+++ b/include/hw/pci-host/spapr.h
@@ -49,6 +49,24 @@ struct sPAPRPHBClass {
     PCIHostBridgeClass parent_class;
 
     void (*finish_realize)(sPAPRPHBState *sphb, Error **errp);
+
+/* sPAPR spec defined pagesize mask values */
+#define DDW_PGSIZE_4K       0x01
+#define DDW_PGSIZE_64K      0x02
+#define DDW_PGSIZE_16M      0x04
+#define DDW_PGSIZE_32M      0x08
+#define DDW_PGSIZE_64M      0x10
+#define DDW_PGSIZE_128M     0x20
+#define DDW_PGSIZE_256M     0x40
+#define DDW_PGSIZE_16G      0x80
+
+    int (*ddw_query)(sPAPRPHBState *sphb, uint32_t *windows_available,
+                     uint32_t *page_size_mask);
+    int (*ddw_create)(sPAPRPHBState *sphb, uint32_t page_shift,
+                      uint32_t window_shift, uint32_t liobn,
+                      sPAPRTCETable **ptcet);
+    int (*ddw_remove)(sPAPRPHBState *sphb, sPAPRTCETable *tcet);
+    int (*ddw_reset)(sPAPRPHBState *sphb);
 };
 
 typedef struct spapr_pci_msi {
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9c5686e..afda68f 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -382,9 +382,12 @@ int spapr_allocate_irq_block(int num, bool lsi, bool msi);
 #define RTAS_GET_SENSOR_STATE                   (RTAS_TOKEN_BASE + 0x1D)
 #define RTAS_IBM_CONFIGURE_CONNECTOR            (RTAS_TOKEN_BASE + 0x1E)
 #define RTAS_IBM_OS_TERM                        (RTAS_TOKEN_BASE + 0x1F)
-#define RTAS_IBM_EXTENDED_OS_TERM               (RTAS_TOKEN_BASE + 0x20)
+#define RTAS_IBM_QUERY_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x20)
+#define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x21)
+#define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x22)
+#define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x23)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x21)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x24)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
diff --git a/trace-events b/trace-events
index 11a17a8..5b54fbd 100644
--- a/trace-events
+++ b/trace-events
@@ -1213,6 +1213,10 @@ spapr_iommu_indirect(uint64_t liobn, uint64_t ioba, uint64_t tce, uint64_t iobaN
 spapr_iommu_stuff(uint64_t liobn, uint64_t ioba, uint64_t tce_value, uint64_t npages, uint64_t ret) "liobn=%"PRIx64" ioba=0x%"PRIx64" tcevalue=0x%"PRIx64" npages=%"PRId64" ret=%"PRId64
 spapr_iommu_xlate(uint64_t liobn, uint64_t ioba, uint64_t tce, unsigned perm, unsigned pgsize) "liobn=%"PRIx64" 0x%"PRIx64" -> 0x%"PRIx64" perm=%u mask=%x"
 spapr_iommu_new_table(uint64_t liobn, void *tcet, void *table, int fd) "liobn=%"PRIx64" tcet=%p table=%p fd=%d"
+spapr_iommu_ddw_query(uint64_t buid, uint32_t cfgaddr, uint32_t wa, uint32_t pgz, uint32_t pgz_fixed, long ret) "buid=%"PRIx64" addr=%"PRIx32", %u windows available, sizes %"PRIx32", fixed %"PRIx32", ret = %ld"
+spapr_iommu_ddw_create(uint64_t buid, uint32_t cfgaddr, unsigned long long pg_size, unsigned long long req_size, uint64_t start, uint32_t liobn, long ret) "buid=%"PRIx64" addr=%"PRIx32", page size=0x%llx, requested=0x%llx, start addr=%"PRIx64", liobn=%"PRIx32", ret = %ld"
+spapr_iommu_ddw_remove(uint32_t liobn, long ret) "liobn=%"PRIx32", ret = %ld"
+spapr_iommu_ddw_reset(uint64_t buid, uint32_t cfgaddr, long ret) "buid=%"PRIx64" addr=%"PRIx32", ret = %ld"
 
 # hw/ppc/ppc.c
 ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64" (%"PRId64"s)"
-- 
2.0.0
