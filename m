Return-Path: <aik@ozlabs.ru>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 857481A0D59
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:54 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:54 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3062E2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9dZFt262616
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:35 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9douS009069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:51 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 08/12] spapr_pci_vfio: Enable DDW
Date: Tue, 15 Jul 2014 19:39:40 +1000
Message-Id: <1405417184-14333-9-git-send-email-aik@ozlabs.ru>
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
 hw/ppc/spapr_pci_vfio.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index d3bddf2..b72aff0 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -71,6 +71,75 @@ static void spapr_phb_vfio_finish_realize(sPAPRPHBState *sphb, Error **errp)
                                 spapr_tce_get_iommu(tcet));
 }
 
+static int spapr_pci_vfio_ddw_query(sPAPRPHBState *sphb,
+                                    uint32_t *windows_available,
+                                    uint32_t *page_size_mask)
+{
+    sPAPRPHBVFIOState *svphb = SPAPR_PCI_VFIO_HOST_BRIDGE(sphb);
+    struct vfio_iommu_spapr_tce_query query = { .argsz = sizeof(query) };
+    int ret;
+
+    ret = vfio_container_ioctl(&sphb->iommu_as, svphb->iommugroupid,
+                               VFIO_IOMMU_SPAPR_TCE_QUERY, &query);
+    if (ret) {
+        return ret;
+    }
+
+    *windows_available = query.windows_available;
+    *page_size_mask = query.page_size_mask;
+
+    return ret;
+}
+
+static int spapr_pci_vfio_ddw_create(sPAPRPHBState *sphb, uint32_t page_shift,
+                                     uint32_t window_shift, uint32_t liobn,
+                                     sPAPRTCETable **ptcet)
+{
+    sPAPRPHBVFIOState *svphb = SPAPR_PCI_VFIO_HOST_BRIDGE(sphb);
+    struct vfio_iommu_spapr_tce_create create = {
+        .argsz = sizeof(create),
+        .page_shift = page_shift,
+        .window_shift = window_shift,
+        .start_addr = 0
+    };
+    int ret;
+
+    ret = vfio_container_ioctl(&sphb->iommu_as, svphb->iommugroupid,
+                               VFIO_IOMMU_SPAPR_TCE_CREATE, &create);
+    if (ret) {
+        return ret;
+    }
+
+    *ptcet = spapr_tce_new_table(DEVICE(sphb), liobn, create.start_addr,
+                                 page_shift, 1 << (window_shift - page_shift),
+                                 true);
+    memory_region_add_subregion(&sphb->iommu_root, (*ptcet)->bus_offset,
+                                spapr_tce_get_iommu(*ptcet));
+
+    return ret;
+}
+
+static int spapr_pci_vfio_ddw_remove(sPAPRPHBState *sphb, sPAPRTCETable *tcet)
+{
+    sPAPRPHBVFIOState *svphb = SPAPR_PCI_VFIO_HOST_BRIDGE(sphb);
+    struct vfio_iommu_spapr_tce_remove remove = {
+        .argsz = sizeof(remove),
+        .start_addr = tcet->bus_offset
+    };
+
+    return vfio_container_ioctl(&sphb->iommu_as, svphb->iommugroupid,
+                                VFIO_IOMMU_SPAPR_TCE_REMOVE, &remove);
+}
+
+static int spapr_pci_vfio_ddw_reset(sPAPRPHBState *sphb)
+{
+    sPAPRPHBVFIOState *svphb = SPAPR_PCI_VFIO_HOST_BRIDGE(sphb);
+    struct vfio_iommu_spapr_tce_reset reset = { .argsz = sizeof(reset) };
+
+    return vfio_container_ioctl(&sphb->iommu_as, svphb->iommugroupid,
+                                VFIO_IOMMU_SPAPR_TCE_RESET, &reset);
+}
+
 static void spapr_phb_vfio_reset(DeviceState *qdev)
 {
     /* Do nothing */
@@ -84,6 +153,10 @@ static void spapr_phb_vfio_class_init(ObjectClass *klass, void *data)
     dc->props = spapr_phb_vfio_properties;
     dc->reset = spapr_phb_vfio_reset;
     spc->finish_realize = spapr_phb_vfio_finish_realize;
+    spc->ddw_query = spapr_pci_vfio_ddw_query;
+    spc->ddw_create = spapr_pci_vfio_ddw_create;
+    spc->ddw_remove = spapr_pci_vfio_ddw_remove;
+    spc->ddw_reset = spapr_pci_vfio_ddw_reset;
 }
 
 static const TypeInfo spapr_phb_vfio_info = {
-- 
2.0.0
