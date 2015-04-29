Return-Path: <vaibhav@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47A781A0201
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 20:17:51 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <vaibhav@linux.vnet.ibm.com>;
 Wed, 29 Apr 2015 15:47:48 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 459C5E0059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:50:31 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3TAHZT639321780
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:47:37 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3T9nFhh032093
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 15:19:15 +0530
From: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Implement an ioctl to fetch afu card-id,
 offset-id and mode
Date: Wed, 29 Apr 2015 15:47:23 +0530
Message-Id: <1430302643-10772-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, Ian Munsie <imunsie@au1.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Given a file descriptor on an afu device, libcxl currently uses the
major/minor number obtained from fstat on the fd to construct path to
the afu's sysfs directory. However it is possible that rather than using
one of the device in /dev/cxl, a kernel driver creates its own device
which export generic cxl interface to the userspace. This causes
problems with libcxl as it tries to use a wrong major/minor number to
construct the sysfs path and fail.

So this patch introduces a new ioctl called CXL_IOCTL_GET_AFU_ID on the
afu file descriptor to fetch the cxl_afu_id struct that holds the
card/offset-id and mode information. These info is then used by libcxl to
construct the correct path to the afu sysfs directory.

Testing:
	- Build against pseries be/le configs
	- Testing with corresponding libcxl changes to verify that it constructs
	  right sysfs path to the afu.

Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h  |  2 --
 drivers/misc/cxl/file.c | 22 ++++++++++++++++++++++
 include/uapi/misc/cxl.h | 22 ++++++++++++++++++++++
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a1cee47..9f280e3 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -315,8 +315,6 @@ static const cxl_p2n_reg_t CXL_PSL_WED_An     = {0x0A0};
 #define CXL_MAX_SLICES 4
 #define MAX_AFU_MMIO_REGS 3
 
-#define CXL_MODE_DEDICATED   0x1
-#define CXL_MODE_DIRECTED    0x2
 #define CXL_MODE_TIME_SLICED 0x4
 #define CXL_SUPPORTED_MODES (CXL_MODE_DEDICATED | CXL_MODE_DIRECTED)
 
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 2364bca..9855234 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -212,6 +212,25 @@ static long afu_ioctl_process_element(struct cxl_context *ctx,
 	return 0;
 }
 
+static long afu_ioctl_get_afu_id(struct cxl_context *ctx,
+				 struct cxl_afu_id __user *upafuid)
+{
+	struct cxl_afu_id afuid = { 0 };
+
+	afuid.card_id = ctx->afu->adapter->adapter_num;
+	afuid.afu_offset = ctx->afu->slice;
+	afuid.afu_mode = ctx->afu->current_mode;
+
+	/* set the flag bit in case the afu is a slave */
+	if (ctx->afu->current_mode == CXL_MODE_DIRECTED && !ctx->master)
+		afuid.flags |= CXL_AFUID_FLAG_SLAVE;
+
+	if (copy_to_user(upafuid, &afuid, sizeof(afuid)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -225,6 +244,9 @@ static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return afu_ioctl_start_work(ctx, (struct cxl_ioctl_start_work __user *)arg);
 	case CXL_IOCTL_GET_PROCESS_ELEMENT:
 		return afu_ioctl_process_element(ctx, (__u32 __user *)arg);
+	case CXL_IOCTL_GET_AFU_ID:
+		return afu_ioctl_get_afu_id(ctx, (struct cxl_afu_id __user *)
+					    arg);
 	}
 	return -EINVAL;
 }
diff --git a/include/uapi/misc/cxl.h b/include/uapi/misc/cxl.h
index cd6d789..99a8ca1 100644
--- a/include/uapi/misc/cxl.h
+++ b/include/uapi/misc/cxl.h
@@ -32,10 +32,32 @@ struct cxl_ioctl_start_work {
 #define CXL_START_WORK_ALL		(CXL_START_WORK_AMR |\
 					 CXL_START_WORK_NUM_IRQS)
 
+
+/* Possible modes that an afu can be in */
+#define CXL_MODE_DEDICATED   0x1
+#define CXL_MODE_DIRECTED    0x2
+
+/* possible flags for the cxl_afu_id flags field */
+#define CXL_AFUID_FLAG_SLAVE    0x1  /* In directed-mode afu is in slave mode */
+
+struct cxl_afu_id {
+	__u64 flags;     /* One of CXL_AFUID_FLAG_X */
+	__u32 card_id;
+	__u32 afu_offset;
+	__u32 afu_mode;  /* one of the CXL_MODE_X */
+	__u32 reserved1;
+	__u64 reserved2;
+	__u64 reserved3;
+	__u64 reserved4;
+	__u64 reserved5;
+	__u64 reserved6;
+};
+
 /* ioctl numbers */
 #define CXL_MAGIC 0xCA
 #define CXL_IOCTL_START_WORK		_IOW(CXL_MAGIC, 0x00, struct cxl_ioctl_start_work)
 #define CXL_IOCTL_GET_PROCESS_ELEMENT	_IOR(CXL_MAGIC, 0x01, __u32)
+#define CXL_IOCTL_GET_AFU_ID            _IOR(CXL_MAGIC, 0x02, struct cxl_afu_id)
 
 #define CXL_READ_MIN_SIZE 0x1000 /* 4K */
 
-- 
2.2.1
