Return-Path: <Bharat.Bhushan@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 559621A0244
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Mar 2015 16:42:22 +1100 (AEDT)
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0138.outbound.protection.outlook.com [157.56.110.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EDFD1140146
 for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2015 16:42:20 +1100 (AEDT)
From: Bharat Bhushan <Bharat.Bhushan@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH 3/4 RFC] fsl/msi: Add MSI bank allocation for kernel owned
 devices
Date: Tue, 3 Mar 2015 10:47:45 +0530
Message-ID: <1425359866-31049-3-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1425359866-31049-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <Bharat.Bhushan@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With this patch a "context" can allocate a MSI bank and use the
allocated MSI-bank for the devices in that "context".

kernel/host "context" is "NULL", So all devices owned by kernel
will share a MSI bank allocated with "context = NULL.

This patch is in direction to have separate MSI bank for kernel
context and userspace/VM context. We do not want two software
context (kernel and VMs) to share a MSI bank for safe/reliable
interrupts with full isolation. Follow up patch will add interface
to allocate a MSI bank for userspace/VM context.

NOTE: This RFC patch allows only one MSI bank to be allocated for
kernel context. Which seems to be sufficient to me. But if we see this
is limiting some real usecase scanerio then this limitation can be
removed

One issue which still need to addressed is when to free kernel
context allocated MSI bank? Say all MSI capable devices are assigned
to VM/userspace then there is no need to have any MSI bank reserved
for kernel context.

Signed-off-by: Bharat Bhushan <Bharat.Bhushan@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 88 ++++++++++++++++++++++++++++++++++++++-----
 arch/powerpc/sysdev/fsl_msi.h |  4 ++
 2 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 32ba1e3..027aeeb 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -142,6 +142,79 @@ static void fsl_teardown_msi_irqs(struct pci_dev *pdev)
 	return;
 }
 
+/*
+ * Allocate a MSI Bank for the requested "context".
+ * NULL "context" means that this request is to allocate
+ * MSI bank for kernel owned devices. And currently we
+ * assume that one MSI bank is sufficient for kernel.
+ */
+static struct fsl_msi *fsl_msi_allocate_msi_bank(void *context)
+{
+	struct fsl_msi *msi_data;
+
+	/* Kernel context (NULL) can reserve only one msi bank */
+	if (!context) {
+		list_for_each_entry(msi_data, &msi_head, list) {
+			if ((msi_data->reserved == MSI_RESERVED) &&
+			    (msi_data->context == NULL))
+				return NULL;
+		}
+	}
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if (msi_data->reserved == MSI_FREE) {
+			msi_data->reserved = MSI_RESERVED;
+			msi_data->context = context;
+			return msi_data;
+		}
+	}
+
+	return NULL;
+}
+
+/* FIXME: Assumption that host kernel will allocate only one MSI bank */
+ __attribute__ ((unused)) static int fsl_msi_free_msi_bank(void *context)
+{
+	struct fsl_msi *msi_data;
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if ((msi_data->reserved == MSI_RESERVED) &&
+		     (msi_data->context == context)) {
+			msi_data->reserved = MSI_FREE;
+			msi_data->context = NULL;
+			return 0;
+		}
+	}
+	return -ENODEV;
+}
+
+/*  This API returns the allocated MSI bank of "context"
+ *  to which "pdev" device belongs.
+ *  All kernel owned devices have NULL context. All devices
+ *  in same "context" will share the allocated MSI bank.
+ *
+ *  Note: If no MSI bank allocated to kernel context then
+ *  we allocate a MSI bank here.
+ */
+static struct fsl_msi *fsl_msi_get_reserved_msi_bank(struct pci_dev *pdev)
+{
+	struct fsl_msi *msi_data = NULL;
+	void *context = NULL;
+
+	list_for_each_entry(msi_data, &msi_head, list) {
+		if ((msi_data->reserved == MSI_RESERVED) &&
+		    (msi_data->context == context))
+			return msi_data;
+	}
+
+	/* If no MSI bank allocated for kernel owned device, allocate one */
+	msi_data = fsl_msi_allocate_msi_bank(NULL);
+	if (msi_data)
+		return msi_data;
+
+	return NULL;
+}
+
 static void fsl_compose_msi_msg(struct pci_dev *pdev, int hwirq,
 				struct msi_msg *msg,
 				struct fsl_msi *fsl_msi_data)
@@ -174,7 +247,7 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 	struct pci_controller *hose = pci_bus_to_host(pdev->bus);
 	struct device_node *np;
 	phandle phandle = 0;
-	int rc, hwirq = -ENOMEM;
+	int rc = -ENODEV, hwirq = -ENOMEM;
 	unsigned int virq;
 	struct msi_desc *entry;
 	struct msi_msg msg;
@@ -231,15 +304,12 @@ static int fsl_setup_msi_irqs(struct pci_dev *pdev, int nvec, int type)
 		if (specific_msi_bank) {
 			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		} else {
-			/*
-			 * Loop over all the MSI devices until we find one that has an
-			 * available interrupt.
-			 */
-			list_for_each_entry(msi_data, &msi_head, list) {
-				hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
-				if (hwirq >= 0)
-					break;
+			msi_data = fsl_msi_get_reserved_msi_bank(pdev);
+			if (!msi_data) {
+				dev_err(&pdev->dev, "No MSI Bank allocated\n");
+				goto out_free;
 			}
+			hwirq = msi_bitmap_alloc_hwirqs(&msi_data->bitmap, 1);
 		}
 
 		if (hwirq < 0) {
diff --git a/arch/powerpc/sysdev/fsl_msi.h b/arch/powerpc/sysdev/fsl_msi.h
index 9b0ab84..c69702b 100644
--- a/arch/powerpc/sysdev/fsl_msi.h
+++ b/arch/powerpc/sysdev/fsl_msi.h
@@ -46,6 +46,10 @@ struct fsl_msi {
 	struct list_head list;          /* support multiple MSI banks */
 
 	phandle phandle;
+#define MSI_FREE		0
+#define MSI_RESERVED		1
+        int reserved;
+        void *context;
 };
 
 #endif /* _POWERPC_SYSDEV_FSL_MSI_H */
-- 
1.9.3
