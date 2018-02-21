Return-Path: <srs0=nusq=fp=au1.ibm.com=alastair@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zmQHP4fvTzF0lq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 15:58:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zmQHP2YBDz8t0R
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Feb 2018 15:58:41 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zmQHN4Z81z9ryT
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2018 15:58:40 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1L4sXSm004211
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2018 23:58:38 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g8xuxwywd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Feb 2018 23:58:38 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 21 Feb 2018 04:58:36 -0000
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, andrew.donnellan@au1.ibm.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, alastair@au1.ibm.com,
 "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH] ocxl: Add get_metadata IOCTL to share OCXL information to
 userspace
Date: Wed, 21 Feb 2018 15:57:36 +1100
Message-Id: <20180221045736.7614-1-alastair@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

Some required information is not exposed to userspace currently (eg. the
PASID), pass this information back, along with other information which
is currently communicated via sysfs, which saves some parsing effort in
userspace.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/file.c | 27 +++++++++++++++++++++++++++
 include/uapi/misc/ocxl.h | 22 ++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index d9aa407db06a..11514a8444e5 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -102,10 +102,32 @@ static long afu_ioctl_attach(struct ocxl_context *ctx,
 	return rc;
 }
 
+static long afu_ioctl_get_metadata(struct ocxl_context *ctx,
+		struct ocxl_ioctl_get_metadata __user *uarg)
+{
+	struct ocxl_ioctl_get_metadata arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+	arg.version = 0;
+
+	arg.afu_version_major = ctx->afu->config.version_major;
+	arg.afu_version_minor = ctx->afu->config.version_minor;
+	arg.pasid = ctx->pasid;
+	arg.pp_mmio_size = ctx->afu->config.pp_mmio_stride;
+	arg.global_mmio_size = ctx->afu->config.global_mmio_size;
+
+	if (copy_to_user(uarg, &arg, sizeof(arg)))
+		return -EFAULT;
+
+	return 0;
+}
+
 #define CMD_STR(x) (x == OCXL_IOCTL_ATTACH ? "ATTACH" :			\
 			x == OCXL_IOCTL_IRQ_ALLOC ? "IRQ_ALLOC" :	\
 			x == OCXL_IOCTL_IRQ_FREE ? "IRQ_FREE" :		\
 			x == OCXL_IOCTL_IRQ_SET_FD ? "IRQ_SET_FD" :	\
+			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -157,6 +179,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 					irq_fd.eventfd);
 		break;
 
+	case OCXL_IOCTL_GET_METADATA:
+		rc = afu_ioctl_get_metadata(ctx,
+				(struct ocxl_ioctl_get_metadata __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 4b0b0b756f3e..16e1f48ce280 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -32,6 +32,27 @@ struct ocxl_ioctl_attach {
 	__u64 reserved3;
 };
 
+/*
+ * Version contains the version of the struct.
+ * Versions will always be backwards compatible, that is, new versions will not
+ * alter existing fields
+ */
+struct ocxl_ioctl_get_metadata {
+	__u16 version;
+
+	// Version 0 fields
+	__u8  afu_version_major;
+	__u8  afu_version_minor;
+	__u32 pasid;
+
+	__u64 pp_mmio_size;
+	__u64 global_mmio_size;
+
+	// End version 0 fields
+
+	__u64 reserved[13]; // Total of 16*u64
+};
+
 struct ocxl_ioctl_irq_fd {
 	__u64 irq_offset;
 	__s32 eventfd;
@@ -45,5 +66,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_ALLOC	_IOR(OCXL_MAGIC, 0x11, __u64)
 #define OCXL_IOCTL_IRQ_FREE	_IOW(OCXL_MAGIC, 0x12, __u64)
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
+#define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_get_metadata)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
