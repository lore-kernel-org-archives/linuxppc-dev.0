Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BA20D1A0688
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 16:43:25 +1100 (AEDT)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 895551400DD
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:25 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 26 Mar 2015 15:43:25 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 1D13F2BB0047
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:22 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2Q5hDcV47054892
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:43:22 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2Q5gmWw014619
 for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2015 16:42:48 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH v5 3/3] drivers/vfio: Support EEH error injection
Date: Thu, 26 Mar 2015 16:42:09 +1100
Message-Id: <1427348529-7060-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1427348529-7060-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, alex.williamson@redhat.com,
 agraf@suse.de, kvm@vger.kernel.org, david@gibson.dropbear.id.au
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 Documentation/vfio.txt        | 12 ++++++++++++
 drivers/vfio/vfio_spapr_eeh.c | 10 ++++++++++
 include/uapi/linux/vfio.h     | 14 +++++++++++++-
 3 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/Documentation/vfio.txt b/Documentation/vfio.txt
index 96978ec..4c746a7 100644
--- a/Documentation/vfio.txt
+++ b/Documentation/vfio.txt
@@ -385,6 +385,18 @@ The code flow from the example above should be slightly changed:
 
 	....
 
+	/* Inject EEH error, which is expected to be caused by 32-bits
+	 * config load.
+	 */
+	pe_op.op = VFIO_EEH_PE_INJECT_ERR;
+	pe_op.err.type = EEH_ERR_TYPE_32;
+	pe_op.err.func = EEH_ERR_FUNC_LD_CFG_ADDR;
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
index 82889c3..d81c17f 100644
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
@@ -490,6 +501,7 @@ struct vfio_eeh_pe_op {
 #define VFIO_EEH_PE_RESET_HOT		6	/* Assert hot reset          */
 #define VFIO_EEH_PE_RESET_FUNDAMENTAL	7	/* Assert fundamental reset  */
 #define VFIO_EEH_PE_CONFIGURE		8	/* PE configuration          */
+#define VFIO_EEH_PE_INJECT_ERR		9	/* Inject EEH error          */
 
 #define VFIO_EEH_PE_OP			_IO(VFIO_TYPE, VFIO_BASE + 21)
 
-- 
1.8.3.2
