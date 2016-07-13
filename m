Return-Path: <imunsie@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqWrq6kQ4zDqHC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:18:03 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6DL91nf142357
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:02 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2452atxqkp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 17:18:02 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <imunsie@au1.ibm.com>;
 Thu, 14 Jul 2016 07:17:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3D9182BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:57 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6DLHvkC25952430
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:57 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6DLHu0S029120
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jul 2016 07:17:57 +1000
From: "Ian Munsie" <imunsie@au1.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Huy Nguyen <huyn@mellanox.com>
Cc: Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH 04/15] cxl: Move cxl_afu_get / cxl_afu_put to base
Date: Thu, 14 Jul 2016 07:17:03 +1000
In-Reply-To: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
References: <1468444634-1866-1-git-send-email-imunsie@au.ibm.com>
Message-Id: <1468444634-1866-5-git-send-email-imunsie@au.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Ian Munsie <imunsie@au1.ibm.com>

The Mellanox CX4 uses a model where the AFU is one physical function of
the device, and is used by other peer physical functions of the same
device. This will require those other devices to grab a reference on the
AFU when they are initialised to make sure that it does not go away
during their lifetime.

Move the AFU refcount functions to base.c so they can be called from
the PHB code.

Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>
Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/base.c | 13 +++++++++++++
 drivers/misc/cxl/cxl.h  | 12 ------------
 include/misc/cxl-base.h |  4 ++++
 3 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/misc/cxl/base.c b/drivers/misc/cxl/base.c
index e6f49ac..d7dcf5b 100644
--- a/drivers/misc/cxl/base.c
+++ b/drivers/misc/cxl/base.c
@@ -54,6 +54,19 @@ static inline void cxl_calls_put(struct cxl_calls *calls) { }
 
 #endif /* CONFIG_CXL_MODULE */
 
+/* AFU refcount management */
+struct cxl_afu *cxl_afu_get(struct cxl_afu *afu)
+{
+	return (get_device(&afu->dev) == NULL) ? NULL : afu;
+}
+EXPORT_SYMBOL_GPL(cxl_afu_get);
+
+void cxl_afu_put(struct cxl_afu *afu)
+{
+	put_device(&afu->dev);
+}
+EXPORT_SYMBOL_GPL(cxl_afu_put);
+
 void cxl_slbia(struct mm_struct *mm)
 {
 	struct cxl_calls *calls;
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index 36b3237..d4aae6f 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -440,18 +440,6 @@ struct cxl_afu {
 	bool enabled;
 };
 
-/* AFU refcount management */
-static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu)
-{
-
-	return (get_device(&afu->dev) == NULL) ? NULL : afu;
-}
-
-static inline void  cxl_afu_put(struct cxl_afu *afu)
-{
-	put_device(&afu->dev);
-}
-
 
 struct cxl_irq_name {
 	struct list_head list;
diff --git a/include/misc/cxl-base.h b/include/misc/cxl-base.h
index 5ae9625..f53808f 100644
--- a/include/misc/cxl-base.h
+++ b/include/misc/cxl-base.h
@@ -36,11 +36,15 @@ static inline void cxl_ctx_put(void)
        atomic_dec(&cxl_use_count);
 }
 
+struct cxl_afu *cxl_afu_get(struct cxl_afu *afu);
+void cxl_afu_put(struct cxl_afu *afu);
 void cxl_slbia(struct mm_struct *mm);
 
 #else /* CONFIG_CXL_BASE */
 
 static inline bool cxl_ctx_in_use(void) { return false; }
+static inline struct cxl_afu *cxl_afu_get(struct cxl_afu *afu) { return NULL; }
+static inline void cxl_afu_put(struct cxl_afu *afu) {}
 static inline void cxl_slbia(struct mm_struct *mm) {}
 
 #endif /* CONFIG_CXL_BASE */
-- 
2.8.1
