Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjBns74ZXzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 22:09:21 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2EB8tM1000862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:18 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0b-001b2d01.pphosted.com with ESMTP id 296c831nmu-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:09:18 -0400
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 14 Mar 2017 11:09:16 -0000
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V2 1/6] cxl: Remove unused values in bare-metal environment.
Date: Tue, 14 Mar 2017 12:08:37 +0100
In-Reply-To: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1489489722-935-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1489489722-935-2-git-send-email-clombard@linux.vnet.ibm.com>
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
index 7ae7105..7257e8b 100644
--- a/drivers/misc/cxl/native.c
+++ b/drivers/misc/cxl/native.c
@@ -859,8 +859,6 @@ static int native_detach_process(struct cxl_context *ctx)
 
 static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
 {
-	u64 pidtid;
-
 	/* If the adapter has gone away, we can't get any meaningful
 	 * information.
 	 */
@@ -870,9 +868,6 @@ static int native_get_irq_info(struct cxl_afu *afu, struct cxl_irq_info *info)
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
