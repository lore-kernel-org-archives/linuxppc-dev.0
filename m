Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whmwX0p4mzDqLP
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 19:43:55 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v569ETR2134521
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Jun 2017 05:43:49 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2awpbtj144-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jun 2017 05:43:48 -0400
Received: from localhost
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Tue, 6 Jun 2017 10:43:46 +0100
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au,
 vaibhav@linux.vnet.ibm.com, andrew.donnellan@au1.ibm.com,
 clombard@linux.vnet.ibm.com, philippe.bergheaud@fr.ibm.com
Subject: [PATCH v2] cxl: Fix error path on bad ioctl
Date: Tue,  6 Jun 2017 11:43:41 +0200
Message-Id: <20170606094341.14629-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fix error path if we can't copy user structure on CXL_IOCTL_START_WORK
ioctl. We shouldn't unlock the context status mutex as it was not
locked (yet).

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
Fixes: 0712dc7e73e5 ("cxl: Fix issues when unmapping contexts")
---
Changelog:
v2: change sizeof() parameter (Vaibhav)
    tweak commit message and add 'Fixes:' (mpe)
    
 drivers/misc/cxl/file.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 17b433f1ce23..0761271d68c5 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -159,11 +159,8 @@ static long afu_ioctl_start_work(struct cxl_context *ctx,
 
 	/* Do this outside the status_mutex to avoid a circular dependency with
 	 * the locking in cxl_mmap_fault() */
-	if (copy_from_user(&work, uwork,
-			   sizeof(struct cxl_ioctl_start_work))) {
-		rc = -EFAULT;
-		goto out;
-	}
+	if (copy_from_user(&work, uwork, sizeof(work)))
+		return -EFAULT;
 
 	mutex_lock(&ctx->status_mutex);
 	if (ctx->status != OPENED) {
-- 
2.11.0
