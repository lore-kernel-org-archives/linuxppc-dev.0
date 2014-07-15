Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 607601A1605
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:56 +1000 (EST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 15 Jul 2014 19:39:56 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2680C2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:54 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F9HB9A63832184
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:17:11 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F9drKb009217
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 19:39:53 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH QEMU 12/12] vfio: Enable in-kernel acceleration via VFIO KVM
 device
Date: Tue, 15 Jul 2014 19:39:44 +1000
Message-Id: <1405417184-14333-13-git-send-email-aik@ozlabs.ru>
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

TCE hypercalls (H_PUT_TCE, H_PUT_TCE_INDIRECT, H_STUFF_TCE) use a logical bus
number (LIOBN) to identify which TCE table the request is addressed to.
However VFIO kernel driver operates with IOMMU group IDs and has no idea
about which LIOBN corresponds to which group. If the host kernel supports
in-kernel acceleration for TCE calls, we have to provide the LIOBN to IOMMU
mapping information.

This makes use of a VFIO KVM device's
KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN attribute to set the link
between LIOBN and IOMMU group.

The vfio_container_spapr_set_liobn() helper is implemented completely
in vfio.c because kvm_vfio_spapr_tce_liobn needs a group fd and
we do not want to share resources likes that outside vfio.c.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/misc/vfio.c          | 41 +++++++++++++++++++++++++++++++++++++++++
 hw/ppc/spapr_iommu.c    |  1 +
 hw/ppc/spapr_pci_vfio.c | 22 ++++++++++++++++++++++
 include/hw/misc/vfio.h  |  5 +++++
 4 files changed, 69 insertions(+)

diff --git a/hw/misc/vfio.c b/hw/misc/vfio.c
index e7b4d6e..6e9919a 100644
--- a/hw/misc/vfio.c
+++ b/hw/misc/vfio.c
@@ -4450,3 +4450,44 @@ int vfio_container_ioctl(AddressSpace *as, int32_t groupid,
 
     return vfio_container_do_ioctl(as, groupid, req, param);
 }
+
+int vfio_container_spapr_set_liobn(AddressSpace *as,
+                                   int32_t groupid,
+                                   uint64_t liobn,
+                                   uint64_t start_addr)
+{
+#ifdef CONFIG_KVM
+    VFIOGroup *group;
+    int ret;
+    struct kvm_vfio_spapr_tce_liobn param = {
+        .argsz = sizeof(param),
+        .liobn = liobn,
+        .start_addr = start_addr
+    };
+    struct kvm_device_attr attr = {
+        .group = KVM_DEV_VFIO_GROUP,
+        .attr = KVM_DEV_VFIO_GROUP_SET_SPAPR_TCE_LIOBN,
+        .addr = (uint64_t)(unsigned long)&param,
+    };
+
+    if (vfio_kvm_device_fd < 0) {
+        return 0;
+    }
+
+    group = vfio_get_group(groupid, as);
+    if (!group) {
+        return -1;
+    }
+
+    param.fd = group->fd;
+    ret = ioctl(vfio_kvm_device_fd, KVM_SET_DEVICE_ATTR, &attr);
+    if (ret) {
+        error_report("vfio: failed to setup liobn for a group: %s",
+                     strerror(errno));
+    }
+
+    return ret;
+#else
+    return 0;
+#endif
+}
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index 1710595..3c2a9c9 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -126,6 +126,7 @@ static int spapr_tce_table_realize(DeviceState *dev)
     if (!tcet->table) {
         size_t table_size = tcet->nb_table * sizeof(uint64_t);
         tcet->table = g_malloc0(table_size);
+        tcet->vfio_accel = false;
     }
 
     trace_spapr_iommu_new_table(tcet->liobn, tcet, tcet->table, tcet->fd);
diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index b72aff0..06b4e02 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -21,6 +21,7 @@
 #include "hw/pci-host/spapr.h"
 #include "linux/vfio.h"
 #include "hw/misc/vfio.h"
+#include "qemu/error-report.h"
 
 static Property spapr_phb_vfio_properties[] = {
     DEFINE_PROP_INT32("iommu", sPAPRPHBVFIOState, iommugroupid, -1),
@@ -69,6 +70,17 @@ static void spapr_phb_vfio_finish_realize(sPAPRPHBState *sphb, Error **errp)
     /* Register default 32bit DMA window */
     memory_region_add_subregion(&sphb->iommu_root, tcet->bus_offset,
                                 spapr_tce_get_iommu(tcet));
+
+    if (!tcet->vfio_accel) {
+        return;
+    }
+    ret = vfio_container_spapr_set_liobn(&svphb->phb.iommu_as,
+                                         svphb->iommugroupid,
+                                         tcet->liobn,
+                                         tcet->bus_offset);
+    if (ret) {
+        error_report("spapr-vfio: failed to create link to IOMMU");
+    }
 }
 
 static int spapr_pci_vfio_ddw_query(sPAPRPHBState *sphb,
@@ -116,6 +128,16 @@ static int spapr_pci_vfio_ddw_create(sPAPRPHBState *sphb, uint32_t page_shift,
     memory_region_add_subregion(&sphb->iommu_root, (*ptcet)->bus_offset,
                                 spapr_tce_get_iommu(*ptcet));
 
+    if (!(*ptcet)->vfio_accel) {
+        return 0;
+    }
+    ret = vfio_container_spapr_set_liobn(&sphb->iommu_as, svphb->iommugroupid,
+                                         liobn, (*ptcet)->bus_offset);
+    if (ret) {
+        error_report("spapr-vfio: failed to create link to IOMMU");
+        ret = 0;
+    }
+
     return ret;
 }
 
diff --git a/include/hw/misc/vfio.h b/include/hw/misc/vfio.h
index 0b26cd8..8f248e2 100644
--- a/include/hw/misc/vfio.h
+++ b/include/hw/misc/vfio.h
@@ -6,4 +6,9 @@
 extern int vfio_container_ioctl(AddressSpace *as, int32_t groupid,
                                 int req, void *param);
 
+extern int vfio_container_spapr_set_liobn(AddressSpace *as,
+                                          int32_t groupid,
+                                          uint64_t liobn,
+                                          uint64_t start_addr);
+
 #endif
-- 
2.0.0
