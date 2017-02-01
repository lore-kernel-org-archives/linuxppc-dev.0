Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vD9Bz4m58zDq99
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2017 04:30:51 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v11HT2wE134668
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Feb 2017 12:30:49 -0500
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28bhej09eh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Feb 2017 12:30:49 -0500
Received: from localhost
 by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Wed, 1 Feb 2017 17:30:47 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id ACF2917D805F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Feb 2017 17:33:44 +0000 (GMT)
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH 2/7] cxl: Remove unused values in bare-metal environment.
Date: Wed,  1 Feb 2017 18:30:08 +0100
In-Reply-To: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1485970213-25532-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1485970213-25532-3-git-send-email-clombard@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The two fields pid and tid of the structure cxl_irq_info are only used
in the guest environment. To avoid confusion, it's not necessary
to fill the fields in the bare-metal environment.
The PSL Process and Thread Identification Register is only used when
attaching a dedicated process for PSL8 only.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/native.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/misc/cxl/native.c b/drivers/misc/cxl/native.c
index 09505f4..8a3ce99 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -858,8 +858,6 @@ static int native_detach_process(struct cxl_context *ctx)
 
 static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 {
-	u64 pidtid;
-
 	/* If the adapter has gone away, we can't get any meaningful
 	 * information.
 	 */
@@ -869,9 +867,6 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 	info->dsisr = cxl_p2n_read(afu, CXL_PSL_DSISR_An);
 	info->dar = cxl_p2n_read(afu, CXL_PSL_DAR_An);
 	info->dsr = cxl_p2n_read(afu, CXL_PSL_DSR_An);
-	pidtid = cxl_p2n_read(afu, CXL_PSL_PID_TID_An);
-	info->pid = pidtid >> 32;
-	info->tid = pidtid & 0xffffffff;
 	info->afu_err = cxl_p2n_read(afu, CXL_AFU_ERR_An);
 	info->errstat = cxl_p2n_read(afu, CXL_PSL_ErrStat_An);
 	info->proc_handle = 0;
-- 
2.7.4
