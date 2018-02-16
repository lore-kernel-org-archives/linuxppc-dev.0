Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjYDq2PPMzF1Nl
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Feb 2018 00:01:28 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1GCwpfw093016
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 08:01:26 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5wa1dxrt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 08:01:25 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 16 Feb 2018 13:01:23 -0000
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: andrew.donnellan@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Cc: dan.carpenter@oracle.com
Subject: [PATCH] ocxl: Fix potential bad errno on irq allocation
Date: Fri, 16 Feb 2018 14:01:18 +0100
Message-Id: <20180216130118.26008-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix some issues found by a static checker:

When allocating an AFU interrupt, if the driver cannot copy the output
parameters to userland, the errno value was not set to EFAULT

Remove a (now) useless cast.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/ocxl/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 2dd2db9bc1c9..337462e1569f 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -133,8 +133,10 @@ static long afu_ioctl(struct file *file, unsigned int cmd,
 		if (!rc) {
 			rc = copy_to_user((u64 __user *) args, &irq_offset,
 					sizeof(irq_offset));
-			if (rc)
+			if (rc) {
 				ocxl_afu_irq_free(ctx, irq_offset);
+				return -EFAULT;
+			}
 		}
 		break;
 
@@ -329,7 +331,7 @@ static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 
 	used += sizeof(header);
 
-	rc = (ssize_t) used;
+	rc = used;
 	return rc;
 }
 
-- 
2.14.1
