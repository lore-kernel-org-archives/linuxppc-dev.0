Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D5701A2C01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:33 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Fri, 18 Sep 2015 16:25:31 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id DC171357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:27 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8I6PJDx45613060
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:27 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8I6OsX4021013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:24:55 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: kvm-ppc@vger.kernel.org, kvm@vger.kernel.org, david@gibson.dropbear.id.au,
 alex.williamson@redhat.com, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH 2/2] drivers/vfio: Support IOMMU group for EEH operations
Date: Fri, 18 Sep 2015 16:24:29 +1000
Message-Id: <1442557469-22185-3-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1442557469-22185-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, EEH module works based on the assumption that every
container has only one attached IOMMU group. It's not true any
more. So the userland has to specify the IOMMU group (PE) to
which the requested EEH operation is applied.

This exposes "v2" interface for the userland to specify IOMMU
group (PE) ID when requesting EEH operation.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 drivers/vfio/vfio_iommu_spapr_tce.c | 51 ++++++++++++++++++++++++++++++++-----
 drivers/vfio/vfio_spapr_eeh.c       | 39 ++++++++++++++++------------
 include/linux/vfio.h                |  7 ++---
 include/uapi/linux/vfio.h           |  3 +++
 4 files changed, 75 insertions(+), 25 deletions(-)

diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index 812b43b..f85bde7 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -724,7 +724,8 @@ static long tce_iommu_ioctl(void *iommu_data,
 			ret = 1;
 			break;
 		default:
-			ret = vfio_spapr_iommu_eeh_ioctl(NULL, cmd, arg);
+			ret = vfio_spapr_iommu_eeh_ioctl(NULL, cmd,
+							 arg, NULL, 0);
 			break;
 		}
 
@@ -953,17 +954,55 @@ static long tce_iommu_ioctl(void *iommu_data,
 		return 0;
 
 	case VFIO_EEH_PE_OP: {
-		struct tce_iommu_group *tcegrp;
-		int eeh_enabled;
+		struct tce_iommu_group *tmp, *tcegrp;
+		struct vfio_eeh_pe_op op;
+		int enabled, flag;
+
+		enabled = vfio_spapr_pci_eeh_enabled();
+		if (enabled == VFIO_EEH_DISABLED)
+			return -ENOTTY;
 
-		eeh_enabled = vfio_spapr_pci_eeh_enabled();
-		if (eeh_enabled == VFIO_EEH_DISABLED)
+		/* Get the specified version */
+		minsz = offsetofend(struct vfio_eeh_pe_op, flags);
+		if (copy_from_user(&op, (void __user *)arg, minsz))
+			return -EFAULT;
+		flag = (op.flags & VFIO_EEH_ENABLED_MASK);
+		if (flag > enabled)
 			return -ENOTTY;
+		else if (flag == VFIO_EEH_DISABLED)
+			flag = VFIO_EEH_ENABLED_V1;
+
+		if (flag == VFIO_EEH_ENABLED_V1)
+			minsz = offsetofend(struct vfio_eeh_pe_op, op);
+		else if (flag == VFIO_EEH_ENABLED_V2)
+			minsz = offsetofend(struct vfio_eeh_pe_op, groupid);
+		if (copy_from_user(&op, (void __user *)arg, minsz))
+			return -EFAULT;
+
+		if (op.argsz < minsz)
+			return -EINVAL;
+
+		if (flag == VFIO_EEH_ENABLED_V2) {
+			tcegrp = NULL;
+			list_for_each_entry(tmp, &container->group_list, next) {
+				if (tmp->grp &&
+				    iommu_group_id(tmp->grp) == op.groupid) {
+					tcegrp = tmp;
+					break;
+				}
+			}
+
+			if (!tcegrp)
+				return -ENODEV;
+
+			return vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
+					cmd, arg, &op, flag);
+		}
 
 		ret = 0;
 		list_for_each_entry(tcegrp, &container->group_list, next) {
 			ret = vfio_spapr_iommu_eeh_ioctl(tcegrp->grp,
-					cmd, arg);
+					cmd, arg, &op, flag);
 			if (ret)
 				return ret;
 		}
diff --git a/drivers/vfio/vfio_spapr_eeh.c b/drivers/vfio/vfio_spapr_eeh.c
index d208d77..e77dcb8 100644
--- a/drivers/vfio/vfio_spapr_eeh.c
+++ b/drivers/vfio/vfio_spapr_eeh.c
@@ -20,7 +20,7 @@
 
 int vfio_spapr_pci_eeh_enabled(void)
 {
-	return VFIO_EEH_ENABLED_V1;
+	return VFIO_EEH_ENABLED_V2;
 }
 EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_enabled);
 
@@ -38,11 +38,12 @@ void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
 EXPORT_SYMBOL_GPL(vfio_spapr_pci_eeh_release);
 
 long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
-				unsigned int cmd, unsigned long arg)
+				unsigned int cmd, unsigned long arg,
+				void *parm, int flag)
 {
 	struct eeh_pe *pe;
-	struct vfio_eeh_pe_op op;
-	unsigned long minsz;
+	struct vfio_eeh_pe_op *op;
+	unsigned long src, dst, len;
 	long ret = -EINVAL;
 
 	switch (cmd) {
@@ -54,17 +55,12 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 			ret = 0;
 		break;
 	case VFIO_EEH_PE_OP:
+		op = (struct vfio_eeh_pe_op *)parm;
 		pe = eeh_iommu_group_to_pe(group);
 		if (!pe)
 			return -ENODEV;
 
-		minsz = offsetofend(struct vfio_eeh_pe_op, op);
-		if (copy_from_user(&op, (void __user *)arg, minsz))
-			return -EFAULT;
-		if (op.argsz < minsz || op.flags)
-			return -EINVAL;
-
-		switch (op.op) {
+		switch (op->op) {
 		case VFIO_EEH_PE_DISABLE:
 			ret = eeh_pe_set_option(pe, EEH_OPT_DISABLE);
 			break;
@@ -93,14 +89,25 @@ long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 			ret = eeh_pe_configure(pe);
 			break;
 		case VFIO_EEH_PE_INJECT_ERR:
-			minsz = offsetofend(struct vfio_eeh_pe_op, err.mask);
-			if (op.argsz < minsz)
+			if (flag == VFIO_EEH_ENABLED_V1)
+				src = offsetofend(struct vfio_eeh_pe_op, op);
+			else if (flag == VFIO_EEH_ENABLED_V2)
+				src = offsetofend(struct vfio_eeh_pe_op,
+						  groupid);
+			else
+				return -ENOTTY;
+
+			len = sizeof(struct vfio_eeh_pe_err);
+			if (op->argsz < src + len)
 				return -EINVAL;
-			if (copy_from_user(&op, (void __user *)arg, minsz))
+
+			dst = offsetofend(struct vfio_eeh_pe_op, groupid);
+			if (copy_from_user(parm + dst,
+				(void __user *)(arg + src), len))
 				return -EFAULT;
 
-			ret = eeh_pe_inject_err(pe, op.err.type, op.err.func,
-						op.err.addr, op.err.mask);
+			ret = eeh_pe_inject_err(pe, op->err.type, op->err.func,
+						op->err.addr, op->err.mask);
 			break;
 		default:
 			ret = -EINVAL;
diff --git a/include/linux/vfio.h b/include/linux/vfio.h
index ff036ca..c004307 100644
--- a/include/linux/vfio.h
+++ b/include/linux/vfio.h
@@ -95,8 +95,8 @@ extern int vfio_spapr_pci_eeh_enabled(void);
 extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
 extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
 extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
-				       unsigned int cmd,
-				       unsigned long arg);
+				       unsigned int cmd, unsigned long arg,
+				       void *param, int flag);
 #else
 static inline int vfio_spapr_pci_eeh_enabled(void)
 {
@@ -113,7 +113,8 @@ static inline void vfio_spapr_pci_eeh_release(struct pci_dev *pdev)
 
 static inline long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
 					      unsigned int cmd,
-					      unsigned long arg)
+					      unsigned long arg,
+					      void *param, int flag)
 {
 	return -ENOTTY;
 }
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 74f5b8b..66ded6b 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -497,6 +497,7 @@ struct vfio_iommu_spapr_tce_info {
  */
 #define VFIO_EEH_DISABLED	0
 #define VFIO_EEH_ENABLED_V1	1
+#define VFIO_EEH_ENABLED_V2	2
 
 struct vfio_eeh_pe_err {
 	__u32 type;
@@ -508,7 +509,9 @@ struct vfio_eeh_pe_err {
 struct vfio_eeh_pe_op {
 	__u32 argsz;
 	__u32 flags;
+#define VFIO_EEH_ENABLED_MASK	0xFF
 	__u32 op;
+	__u32 groupid;
 	union {
 		struct vfio_eeh_pe_err err;
 	};
-- 
2.1.0
