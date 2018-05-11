Return-Path: <ukrishn@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40jKLk3JzJzF2rb
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 May 2018 05:06:06 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BIx203099303
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:06:03 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hwf1d4sbv-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 15:06:03 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ukrishn@linux.vnet.ibm.com>;
 Fri, 11 May 2018 15:06:02 -0400
From: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
To: linux-scsi@vger.kernel.org, James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
Subject: [PATCH 5/7] cxlflash: Add include guards to backend.h
Date: Fri, 11 May 2018 14:05:51 -0500
In-Reply-To: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
References: <1526065440-38806-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Message-Id: <1526065551-39005-1-git-send-email-ukrishn@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The new header file, backend.h, that was recently added is missing
the include guards. This commit adds the guards.

Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
---
 drivers/scsi/cxlflash/backend.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/cxlflash/backend.h b/drivers/scsi/cxlflash/backend.h
index bcd8a6c..55638d1 100644
--- a/drivers/scsi/cxlflash/backend.h
+++ b/drivers/scsi/cxlflash/backend.h
@@ -12,6 +12,9 @@
  * 2 of the License, or (at your option) any later version.
  */
 
+#ifndef _CXLFLASH_BACKEND_H
+#define _CXLFLASH_BACKEND_H
+
 extern const struct cxlflash_backend_ops cxlflash_cxl_ops;
 extern const struct cxlflash_backend_ops cxlflash_ocxl_ops;
 
@@ -45,3 +48,5 @@ struct cxlflash_backend_ops {
 	int (*fd_mmap)(struct file *file, struct vm_area_struct *vm);
 	int (*fd_release)(struct inode *inode, struct file *file);
 };
+
+#endif /* _CXLFLASH_BACKEND_H */
-- 
2.1.0
