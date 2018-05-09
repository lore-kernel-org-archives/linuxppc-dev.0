Return-Path: <alastair@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40gczB2BjfzF23B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 May 2018 10:43:18 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w490dU3g124794
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 May 2018 20:43:15 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hujsasuxb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 May 2018 20:43:14 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <alastair@au1.ibm.com>;
 Wed, 9 May 2018 01:43:12 +0100
From: "Alastair D'Silva" <alastair@au1.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 malat@debian.org, felix@linux.vnet.ibm.com, pombredanne@nexb.com,
 sukadev@linux.vnet.ibm.com, npiggin@gmail.com,
 gregkh@linuxfoundation.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 corbet@lwn.net, "Alastair D'Silva" <alastair@d-silva.org>
Subject: [PATCH v3 6/7] ocxl: Add an IOCTL so userspace knows what OCXL
 features are available
Date: Wed,  9 May 2018 10:42:11 +1000
In-Reply-To: <20180509004212.4506-1-alastair@au1.ibm.com>
References: <20180417020950.21446-1-alastair@au1.ibm.com>
 <20180509004212.4506-1-alastair@au1.ibm.com>
Message-Id: <20180509004212.4506-7-alastair@au1.ibm.com>
Content-Type: text/plain
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Alastair D'Silva <alastair@d-silva.org>

In order for a userspace AFU driver to call the POWER9 specific
OCXL_IOCTL_ENABLE_P9_WAIT, it needs to verify that it can actually
make that call.

Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
---
 drivers/misc/ocxl/file.c | 25 +++++++++++++++++++++++++
 include/uapi/misc/ocxl.h |  4 ++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index eb409a469f21..33ae46ce0a8a 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -168,12 +168,32 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
 }
 #endif
 
+
+static long afu_ioctl_get_features(struct ocxl_context *ctx,
+		struct ocxl_ioctl_features __user *uarg)
+{
+	struct ocxl_ioctl_features arg;
+
+	memset(&arg, 0, sizeof(arg));
+
+#ifdef CONFIG_PPC64
+	if (cpu_has_feature(CPU_FTR_P9_TIDR))
+		arg.flags[0] |= OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT;
+#endif
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
 			x == OCXL_IOCTL_GET_METADATA ? "GET_METADATA" :	\
 			x == OCXL_IOCTL_ENABLE_P9_WAIT ? "ENABLE_P9_WAIT" :	\
+			x == OCXL_IOCTL_GET_FEATURES ? "GET_FEATURES" :	\
 			"UNKNOWN")
 
 static long afu_ioctl(struct file *file, unsigned int cmd,
@@ -239,6 +259,11 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		break;
 #endif
 
+	case OCXL_IOCTL_GET_FEATURES:
+		rc = afu_ioctl_get_features(ctx,
+				(struct ocxl_ioctl_features __user *) args);
+		break;
+
 	default:
 		rc = -EINVAL;
 	}
diff --git a/include/uapi/misc/ocxl.h b/include/uapi/misc/ocxl.h
index 8d2748e69c84..bb80f294b429 100644
--- a/include/uapi/misc/ocxl.h
+++ b/include/uapi/misc/ocxl.h
@@ -55,6 +55,9 @@ struct ocxl_ioctl_p9_wait {
 	__u64 reserved3[3];
 };
 
+#define OCXL_IOCTL_FEATURES_FLAGS0_P9_WAIT	0x01
+struct ocxl_ioctl_features {
+	__u64 flags[4];
 };
 
 struct ocxl_ioctl_irq_fd {
@@ -72,5 +75,6 @@ struct ocxl_ioctl_irq_fd {
 #define OCXL_IOCTL_IRQ_SET_FD	_IOW(OCXL_MAGIC, 0x13, struct ocxl_ioctl_irq_fd)
 #define OCXL_IOCTL_GET_METADATA _IOR(OCXL_MAGIC, 0x14, struct ocxl_ioctl_metadata)
 #define OCXL_IOCTL_ENABLE_P9_WAIT	_IOR(OCXL_MAGIC, 0x15, struct ocxl_ioctl_p9_wait)
+#define OCXL_IOCTL_GET_FEATURES _IOR(OCXL_MAGIC, 0x16, struct ocxl_ioctl_platform)
 
 #endif /* _UAPI_MISC_OCXL_H */
-- 
2.14.3
