Return-Path: <arbab@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lc582PC7zDq6t
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 13:17:31 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w783ESRr118841
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Aug 2018 23:17:29 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2kqnw84pk2-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 23:17:28 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <arbab@linux.ibm.com>;
 Tue, 7 Aug 2018 23:17:28 -0400
From: Reza Arbab <arbab@linux.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alistair Popple <alistair@popple.id.au>
Subject: [PATCH] powerpc/powernv: Add support for NPU2 relaxed-ordering mode
Date: Tue,  7 Aug 2018 22:17:23 -0500
Message-Id: <1533698243-25972-1-git-send-email-arbab@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alistair Popple <alistair@popple.id.au>

Some device drivers support out of order access to GPU memory. This does
not affect the CPU view of memory but it does affect the GPU view, so it
should only be enabled once the GPU driver has requested it. Add APIs
allowing a driver to do so.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
[arbab@linux.ibm.com: Rebase, add commit log]
Signed-off-by: Reza Arbab <arbab@linux.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            |  4 ++-
 arch/powerpc/include/asm/opal.h                |  3 ++
 arch/powerpc/include/asm/powernv.h             | 12 ++++++++
 arch/powerpc/platforms/powernv/npu-dma.c       | 39 ++++++++++++++++++++++++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  2 ++
 5 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3bab299..be6fe23e 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -208,7 +208,9 @@
 #define OPAL_SENSOR_READ_U64			162
 #define OPAL_PCI_GET_PBCQ_TUNNEL_BAR		164
 #define OPAL_PCI_SET_PBCQ_TUNNEL_BAR		165
-#define OPAL_LAST				165
+#define OPAL_NPU_SET_RELAXED_ORDER		168
+#define OPAL_NPU_GET_RELAXED_ORDER		169
+#define OPAL_LAST				169
 
 #define QUIESCE_HOLD			1 /* Spin all calls at entry */
 #define QUIESCE_REJECT			2 /* Fail all calls with OPAL_BUSY */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index e1b2910..48bea30 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -43,6 +43,9 @@ int64_t opal_npu_spa_clear_cache(uint64_t phb_id, uint32_t bdfn,
 				uint64_t PE_handle);
 int64_t opal_npu_tl_set(uint64_t phb_id, uint32_t bdfn, long cap,
 			uint64_t rate_phys, uint32_t size);
+int64_t opal_npu_set_relaxed_order(uint64_t phb_id, uint16_t bdfn,
+				   bool request_enabled);
+int64_t opal_npu_get_relaxed_order(uint64_t phb_id, uint16_t bdfn);
 int64_t opal_console_write(int64_t term_number, __be64 *length,
 			   const uint8_t *buffer);
 int64_t opal_console_read(int64_t term_number, __be64 *length,
diff --git a/arch/powerpc/include/asm/powernv.h b/arch/powerpc/include/asm/powernv.h
index 2f3ff7a..874ec6d 100644
--- a/arch/powerpc/include/asm/powernv.h
+++ b/arch/powerpc/include/asm/powernv.h
@@ -22,6 +22,8 @@ extern void pnv_npu2_destroy_context(struct npu_context *context,
 extern int pnv_npu2_handle_fault(struct npu_context *context, uintptr_t *ea,
 				unsigned long *flags, unsigned long *status,
 				int count);
+int pnv_npu2_request_relaxed_ordering(struct pci_dev *pdev, bool enable);
+int pnv_npu2_get_relaxed_ordering(struct pci_dev *pdev);
 
 void pnv_tm_init(void);
 #else
@@ -39,6 +41,16 @@ static inline int pnv_npu2_handle_fault(struct npu_context *context,
 	return -ENODEV;
 }
 
+static int pnv_npu2_request_relaxed_ordering(struct pci_dev *pdev, bool enable)
+{
+	return -ENODEV;
+}
+
+static int pnv_npu2_get_relaxed_ordering(struct pci_dev *pdev)
+{
+	return -ENODEV;
+}
+
 static inline void pnv_tm_init(void) { }
 static inline void pnv_power9_force_smt4(void) { }
 #endif
diff --git a/arch/powerpc/platforms/powernv/npu-dma.c b/arch/powerpc/platforms/powernv/npu-dma.c
index 8cdf91f..038dc1e 100644
--- a/arch/powerpc/platforms/powernv/npu-dma.c
+++ b/arch/powerpc/platforms/powernv/npu-dma.c
@@ -27,6 +27,7 @@
 #include <asm/pnv-pci.h>
 #include <asm/msi_bitmap.h>
 #include <asm/opal.h>
+#include <asm/ppc-pci.h>
 
 #include "powernv.h"
 #include "pci.h"
@@ -988,3 +989,41 @@ int pnv_npu2_init(struct pnv_phb *phb)
 
 	return 0;
 }
+
+/*
+ * Request relaxed ordering be enabled or disabled for the given PCI device.
+ * This function may or may not actually enable relaxed ordering depending on
+ * the exact system configuration. Use pnv_npu2_get_relaxed_ordering() below to
+ * determine the current state of relaxed ordering.
+ */
+int pnv_npu2_request_relaxed_ordering(struct pci_dev *pdev, bool enable)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+	int rc;
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+
+	rc = opal_npu_set_relaxed_order(phb->opal_id,
+				PCI_DEVID(pdev->bus->number, pdev->devfn),
+				enable);
+	if (rc != OPAL_SUCCESS && rc != OPAL_CONSTRAINED)
+		return -EPERM;
+
+	return 0;
+}
+EXPORT_SYMBOL(pnv_npu2_request_relaxed_ordering);
+
+int pnv_npu2_get_relaxed_ordering(struct pci_dev *pdev)
+{
+	struct pci_controller *hose;
+	struct pnv_phb *phb;
+
+	hose = pci_bus_to_host(pdev->bus);
+	phb = hose->private_data;
+
+	return opal_npu_get_relaxed_order(phb->opal_id,
+				PCI_DEVID(pdev->bus->number, pdev->devfn));
+}
+EXPORT_SYMBOL(pnv_npu2_get_relaxed_ordering);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index a8d9b40..3c72faf 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -327,3 +327,5 @@ OPAL_CALL(opal_npu_tl_set,			OPAL_NPU_TL_SET);
 OPAL_CALL(opal_pci_get_pbcq_tunnel_bar,		OPAL_PCI_GET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_pci_set_pbcq_tunnel_bar,		OPAL_PCI_SET_PBCQ_TUNNEL_BAR);
 OPAL_CALL(opal_sensor_read_u64,			OPAL_SENSOR_READ_U64);
+OPAL_CALL(opal_npu_set_relaxed_order,		OPAL_NPU_SET_RELAXED_ORDER);
+OPAL_CALL(opal_npu_get_relaxed_order,		OPAL_NPU_GET_RELAXED_ORDER);
-- 
1.8.3.1
