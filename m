Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 537FB1A0325
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Mar 2015 06:59:00 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7367214012F
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 06:58:58 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Sat, 21 Mar 2015 01:28:55 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 21B633940049
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 01:28:53 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2KJwq4A26804254
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 01:28:52 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2KJwqPY007943
 for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2015 01:28:52 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/2] drivers/vfio: Support EEH error injection
Date: Sat, 21 Mar 2015 06:58:45 +1100
Message-Id: <1426881525-11044-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1426881525-11044-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 Documentation/vfio.txt        | 12 ++++++++++++
 drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
 include/uapi/linux/vfio.h     | 36 +++++++++++++++++++++++++++++++++++-
 3 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..c6e11a3 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -385,6 +385,18 @@ The code flow from the example above should be slightly changed:
 
 	....
 
+	/* Inject EEH error, which is expected to be caused by 32-bits
+	 * config load.
+	 */
+	pe_op.op = VFIO_EEH_PE_INJECT_ERR;
+	pe_op.err.type = VFIO_EEH_ERR_TYPE_32;
+	pe_op.err.func = VFIO_EEH_ERR_FUNC_LD_CFG_ADDR;
+	pe_op.err.addr = 0ul;
+	pe_op.err.mask = 0ul;
+	ioctl(container, VFIO_EEH_PE_OP, &pe_op);
+
+	....
+
 	/* When 0xFF's returned from reading PCI config space or IO BARs
 	 * of the PCI device. Check the PE's state to see if that has been
 	 * frozen.
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index 5fa42db..38edeb4 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -85,6 +85,16 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 		case VFIO_EEH_PE_CONFIGURE:
 			ret = eeh_pe_configure(pe);
 			break;
+		case VFIO_EEH_PE_INJECT_ERR:
+			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
+			if (op.argsz < minsz)
+				return -EINVAL;
+			if (copy_from_user(&op, (void __user *)arg, minsz))
+				return -EFAULT;
+
+			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
+						op.err.addr, op.err.mask);
+			break;
 		default:
 			ret = -EINVAL;
 		}
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 82889c3..f68e962 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -468,12 +468,23 @@ struct vfio_iommu_spapr_tce_info {
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
+	union {
+		struct vfio_eeh_pe_err err;
+	};
 };
 
 #define VFIO_EEH_PE_DISABLE		0	/* Disable EEH functionality */
@@ -490,6 +501,29 @@ struct vfio_eeh_pe_op {
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
