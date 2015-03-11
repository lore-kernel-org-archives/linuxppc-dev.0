Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E78F1A0631
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Mar 2015 17:35:14 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2ADC914016A
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:14 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 11 Mar 2015 16:35:13 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 161853578048
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:11 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2B6Z27240370388
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:35:11 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2B6YbJL024887
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2015 17:34:37 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/2] drivers/vfio: Support EEH error injection
Date: Wed, 11 Mar 2015 17:34:11 +1100
Message-Id: <1426055651-22925-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426055651-22925-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, Gavin Shan <gwshan@linux.vnet.ibm.com>,
 agraf@suse.de, alex.williamson@redhat.com, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch adds one more EEH sub-command (VFIO_EEH_PE_INJECT_ERR)
to inject the specified EEH error, which is represented by
(struct vfio_eeh_pe_err), to the indicated PE for testing purpose.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 Documentation/vfio.txt        | 47 ++++++++++++++++++++++++++++++-------------
 drivers/vfio/vfio_spapr_eeh.c | 14 +++++++++++++
 include/uapi/linux/vfio.h     | 34 ++++++++++++++++++++++++++++++-
 3 files changed, 80 insertions(+), 15 deletions(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..2e7f736 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -328,7 +328,13 @@ So 4 additional ioctls have been added:
 
 The code flow from the example above should be slightly changed:
 
-	struct vfio_eeh_pe_op pe_op = { .argsz = sizeof(pe_op), .flags = 0 };
+	struct vfio_eeh_pe_op *pe_op;
+	struct vfio_eeh_pe_err *pe_err;
+
+	pe_op = malloc(sizeof(*pe_op) + sizeof(*pe_err));
+	pe_err = (void *)pe_op + sizeof(*pe_op);
+	pe_op->argsz = sizeof(*pe_op) + sizeof(*pe_err);
+	pe_op->flags = 0;
 
 	.....
 	/* Add the group to the container */
@@ -367,8 +373,8 @@ The code flow from the example above should be slightly changed:
 	ioctl(container, VFIO_CHECK_EXTENSION, VFIO_EEH);
 
 	/* Enable the EEH functionality on the device */
-	pe_op.op = VFIO_EEH_PE_ENABLE;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_ENABLE;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/* You're suggested to create additional data struct to represent
 	 * PE, and put child devices belonging to same IOMMU group to the
@@ -376,8 +382,8 @@ The code flow from the example above should be slightly changed:
 	 */
 
 	/* Check the PE's state and make sure it's in functional state */
-	pe_op.op = VFIO_EEH_PE_GET_STATE;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_GET_STATE;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/* Save device state using pci_save_state().
 	 * EEH should be enabled on the specified device.
@@ -385,11 +391,24 @@ The code flow from the example above should be slightly changed:
 
 	....
 
+	/* Inject EEH error, which is expected to be caused by 32-bits
+	 * config load.
+	 */
+	pe_err->type = VFIO_EEH_ERR_TYPE_32;
+	pe_err->func = VFIO_EEH_ERR_FUNC_LD_CFG_ADDR;
+	pe_err->addr = 0ul;
+	pe_err->mask = 0ul;
+	pe_op->op = VFIO_EEH_PE_INJECT_ERR;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
+
+	....
+
 	/* When 0xFF's returned from reading PCI config space or IO BARs
 	 * of the PCI device. Check the PE's state to see if that has been
 	 * frozen.
 	 */
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_GET_STATE;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/* Waiting for pending PCI transactions to be completed and don't
 	 * produce any more PCI traffic from/to the affected PE until
@@ -400,22 +419,22 @@ The code flow from the example above should be slightly changed:
 	 * standard part of PCI config space, AER registers are dumped
 	 * as logs for further analysis.
 	 */
-	pe_op.op = VFIO_EEH_PE_UNFREEZE_IO;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_UNFREEZE_IO;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/*
 	 * Issue PE reset: hot or fundamental reset. Usually, hot reset
 	 * is enough. However, the firmware of some PCI adapters would
 	 * require fundamental reset.
 	 */
-	pe_op.op = VFIO_EEH_PE_RESET_HOT;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
-	pe_op.op = VFIO_EEH_PE_RESET_DEACTIVATE;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_RESET_HOT;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
+	pe_op->op = VFIO_EEH_PE_RESET_DEACTIVATE;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/* Configure the PCI bridges for the affected PE */
-	pe_op.op = VFIO_EEH_PE_CONFIGURE;
-	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+	pe_op->op = VFIO_EEH_PE_CONFIGURE;
+	ioctl(container, VFIO_EEH_PE_OP, pe_op);
 
 	/* Restored state we saved at initialization time. pci_restore_state()
 	 * is good enough as an example.
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 5fa42db..4f1ebc1 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -85,6 +85,20 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 		case VFIO_EEH_PE_CONFIGURE:
 			ret = eeh_pe_configure(pe);
 			break;
+		case VFIO_EEH_PE_INJECT_ERR: {
+			struct vfio_eeh_pe_err err;
+
+			if (op.argsz < minsz + sizeof(err))
+				return -EINVAL;
+			if (copy_from_user(&err,
+					   (void __user *)(arg + minsz),
+					   sizeof(err)))
+				return -EFAULT;
+
+			ret = eeh_pe_inject_err(pe, err.type, err.func,
+						err.addr, err.mask);
+			break;
+		}
 		default:
 			ret = -EINVAL;
 		}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 82889c3..0b32422 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -468,12 +468,21 @@ struct vfio_iommu_spapr_tce_info {
  * - unfreeze IO/DMA for frozen PE;
  * - read PE state;
  * - reset PE;
- * - configure PE.
+ * - configure PE;
+ * - inject EEH error.
  */
+struct vfio_eeh_pe_err {
+	__u32 type;
+	__u32 func;
+	__u64 addr;
+	__u64 mask;
+};
+
 struct vfio_eeh_pe_op {
 	__u32 argsz;
 	__u32 flags;
 	__u32 op;
+	__u8  data[];
 };
 
 #define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
@@ -490,6 +499,29 @@ struct vfio_eeh_pe_op {
 #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
 #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
 #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
+#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
+#define  VFIO_EEH_ERR_TYPE_32		0	/* 32-bits EEH error type    */
+#define  VFIO_EEH_ERR_TYPE_64		1	/* 64-bits EEH error type    */
+#define  VFIO_EEH_ERR_FUNC_LD_MEM_ADDR		0	/* Memory load  */
+#define  VFIO_EEH_ERR_FUNC_LD_MEM_DATA		1
+#define  VFIO_EEH_ERR_FUNC_LD_IO_ADDR		2	/* IO load      */
+#define  VFIO_EEH_ERR_FUNC_LD_IO_DATA		3
+#define  VFIO_EEH_ERR_FUNC_LD_CFG_ADDR		4	/* Config load  */
+#define  VFIO_EEH_ERR_FUNC_LD_CFG_DATA		5
+#define  VFIO_EEH_ERR_FUNC_ST_MEM_ADDR		6	/* Memory store */
+#define  VFIO_EEH_ERR_FUNC_ST_MEM_DATA		7
+#define  VFIO_EEH_ERR_FUNC_ST_IO_ADDR		8	/* IO store     */
+#define  VFIO_EEH_ERR_FUNC_ST_IO_DATA		9
+#define  VFIO_EEH_ERR_FUNC_ST_CFG_ADDR		10	/* Config store */
+#define  VFIO_EEH_ERR_FUNC_ST_CFG_DATA		11
+#define  VFIO_EEH_ERR_FUNC_DMA_RD_ADDR		12	/* DMA read     */
+#define  VFIO_EEH_ERR_FUNC_DMA_RD_DATA		13
+#define  VFIO_EEH_ERR_FUNC_DMA_RD_MASTER	14
+#define  VFIO_EEH_ERR_FUNC_DMA_RD_TARGET	15
+#define  VFIO_EEH_ERR_FUNC_DMA_WR_ADDR		16	/* DMA write    */
+#define  VFIO_EEH_ERR_FUNC_DMA_WR_DATA		17
+#define  VFIO_EEH_ERR_FUNC_DMA_WR_MASTER	18
+#define  VFIO_EEH_ERR_FUNC_DMA_WR_TARGET	19
 
 #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
 
-- 
1.8.3.2
