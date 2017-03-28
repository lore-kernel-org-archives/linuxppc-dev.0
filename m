Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vsvbX4393zDqY6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Mar 2017 02:14:55 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2SFE3rs023945
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:14:48 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ft6f8fa0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Mar 2017 11:14:48 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 28 Mar 2017 16:14:45 +0100
From: Christophe Lombard <clombard@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com, andrew.donnellan@au1.ibm.com
Subject: [PATCH V3 2/7] cxl: Remove unused values in bare-metal environment.
Date: Tue, 28 Mar 2017 17:14:07 +0200
In-Reply-To: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
References: <1490714052-18902-1-git-send-email-clombard@linux.vnet.ibm.com>
Message-Id: <1490714052-18902-3-git-send-email-clombard@linux.vnet.ibm.com>
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
to fill the fields in the bare-metal environment. These two fields
are renamed to 'reserved' to avoid undefined behavior on bare-metal.
The PSL Process and Thread Identification Register (CXL_PSL_PID_TID_An)
is only used when attaching a dedicated process for PSL8 only. This
register goes away in CAIA2.

Signed-off-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
---
 drivers/misc/cxl/cxl.h    | 13 +++++++------
 drivers/misc/cxl/hcalls.c |  4 ++--
 drivers/misc/cxl/native.c |  5 -----
 3 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 79e60ec..2bbe077 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -895,19 +895,20 @@ int __detach_context(struct cxl_context *ctx);
  * plpar_hcall9() in hvCall.S
  * As a consequence:
  * - we don't need to do any endianness conversion
- * - the pid and tid are an exception. They are 32-bit values returned in
- *   the same 64-bit register. So we do need to worry about byte ordering.
+ * - the pid (reserved0) and tid (reserved1) are an exception. They are
+ *   32-bit values returned in the same 64-bit register. So we do need
+ *   to worry about byte ordering.
  */
 struct cxl_irq_info {
 	u64 dsisr;
 	u64 dar;
 	u64 dsr;
 #ifndef CONFIG_CPU_LITTLE_ENDIAN
-	u32 pid;
-	u32 tid;
+	u32 reserved0;
+	u32 reserved1;
 #else
-	u32 tid;
-	u32 pid;
+	u32 reserved1;
+	u32 reserved0;
 #endif
 	u64 afu_err;
 	u64 errstat;
diff --git a/drivers/misc/cxl/hcalls.c b/drivers/misc/cxl/hcalls.c
index d6d11f4..142a095 100644
--- a/drivers/misc/cxl/hcalls.c
+++ b/drivers/misc/cxl/hcalls.c
@@ -414,8 +414,8 @@ long cxl_h_collect_int_info(u64 unit_address, u64 process_token,
 	switch (rc) {
 	case H_SUCCESS:     /* The interrupt info is returned in return registers. */
 		pr_devel("dsisr:%#llx, dar:%#llx, dsr:%#llx, pid:%u, tid:%u, afu_err:%#llx, errstat:%#llx\n",
-			info->dsisr, info->dar, info->dsr, info->pid,
-			info->tid, info->afu_err, info->errstat);
+			info->dsisr, info->dar, info->dsr, info->reserved0,
+			info->reserved1, info->afu_err, info->errstat);
 		return 0;
 	case H_PARAMETER:   /* An incorrect parameter was supplied. */
 		return -EINVAL;
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
