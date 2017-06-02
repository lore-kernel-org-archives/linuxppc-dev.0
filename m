Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfTpr0w9mzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Jun 2017 02:16:03 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v52GDdYk131333
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 2 Jun 2017 12:15:59 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2att69e32q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Jun 2017 12:15:58 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 2 Jun 2017 17:15:57 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: andrew.donnellan@au1.ibm.com, linuxppc-dev@lists.ozlabs.org,
 vaibhav@linux.vnet.ibm.com, clombard@linux.vnet.ibm.com,
 philippe.bergheaud@fr.ibm.com
Subject: [PATCH] cxl: Fix error path on bad ioctl
Date: Fri,  2 Jun 2017 18:15:23 +0200
Message-Id: <20170602161523.14052-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix error path if we can't copy user structure on
CXL_IOCTL_START_WORK ioctl.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 drivers/misc/cxl/file.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 17b433f1ce23..caa44adfa60e 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -160,10 +160,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 	/* Do this outside the status_mutex to avoid a circular dependency with
 	 * the locking in cxl_mmap_fault() */
 	if (copy_from_user(&work, uwork,
-			   sizeof(struct cxl_ioctl_start_work))) {
-		rc = -EFAULT;
-		goto out;
-	}
+			   sizeof(struct cxl_ioctl_start_work)))
+		return -EFAULT;
 
 	mutex_lock(&ctx->status_mutex);
 	if (ctx->status != OPENED) {
-- 
2.11.0
