Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xBtmR4TRpzDrJT
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:27 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6ILXgqF041132
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 17:37:25 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bskq6b2je-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jul 2017 17:37:24 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 19 Jul 2017 07:37:22 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6ILbKuL30802094
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6ILbBrC018714
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 07:37:11 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>
Subject: [PATCH v13 1/5] powerpc/platform/powernv: Update IMC OPAL APIs
Date: Wed, 19 Jul 2017 03:06:32 +0530
In-Reply-To: <1500413796-18340-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1500413796-18340-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1500413796-18340-2-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In-Memory Collection (IMC) counters are performance monitoring infrastrcuture.
These counters need special sequence of scoms to init/start/stop which is handled
by OPAL. And OPAL provides three APIs to init and control these IMC engines.

OPAL API documentation:
  https://github.com/open-power/skiboot/blob/master/doc/opal-api/opal-imc-counters.rst

Patch updates the kernel side powernv platform code to support the new OPAL APIs

Signed-off-by: Hemant Kumar <hemant@linux.vnet.ibm.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/opal-api.h            | 11 ++++++++++-
 arch/powerpc/include/asm/opal.h                |  5 +++++
 arch/powerpc/platforms/powernv/opal-wrappers.S |  3 +++
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/opal-api.h b/arch/powerpc/include/asm/opal-api.h
index 3130a73652c7..d568612ff188 100644
--- a/arch/powerpc/include/asm/opal-api.h
+++ b/arch/powerpc/include/asm/opal-api.h
@@ -190,7 +190,10 @@
 #define OPAL_NPU_INIT_CONTEXT			146
 #define OPAL_NPU_DESTROY_CONTEXT		147
 #define OPAL_NPU_MAP_LPAR			148
-#define OPAL_LAST				148
+#define OPAL_IMC_COUNTERS_INIT			149
+#define OPAL_IMC_COUNTERS_START			150
+#define OPAL_IMC_COUNTERS_STOP			151
+#define OPAL_LAST				151
 
 /* Device tree flags */
 
@@ -1084,6 +1087,12 @@ enum {
 	XIVE_DUMP_EMU_STATE	= 5,
 };
 
+/* "type" argument to OPAL_IMC_COUNTERS_* calls */
+enum {
+	OPAL_IMC_COUNTERS_NEST = 1,
+	OPAL_IMC_COUNTERS_CORE = 2,
+};
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __OPAL_API_H */
diff --git a/arch/powerpc/include/asm/opal.h b/arch/powerpc/include/asm/opal.h
index 588fb1c23af9..6b8513c3ad40 100644
--- a/arch/powerpc/include/asm/opal.h
+++ b/arch/powerpc/include/asm/opal.h
@@ -268,6 +268,11 @@ int64_t opal_xive_free_irq(uint32_t girq);
 int64_t opal_xive_sync(uint32_t type, uint32_t id);
 int64_t opal_xive_dump(uint32_t type, uint32_t id);
 
+int64_t opal_imc_counters_init(uint32_t type, uint64_t address,
+							uint64_t cpu_pir);
+int64_t opal_imc_counters_start(uint32_t type, uint64_t cpu_pir);
+int64_t opal_imc_counters_stop(uint32_t type, uint64_t cpu_pir);
+
 /* Internal functions */
 extern int early_init_dt_scan_opal(unsigned long node, const char *uname,
 				   int depth, void *data);
diff --git a/arch/powerpc/platforms/powernv/opal-wrappers.S b/arch/powerpc/platforms/powernv/opal-wrappers.S
index 4ca6c26a56d5..b77f52ee8263 100644
--- a/arch/powerpc/platforms/powernv/opal-wrappers.S
+++ b/arch/powerpc/platforms/powernv/opal-wrappers.S
@@ -310,3 +310,6 @@ OPAL_CALL(opal_xive_dump,			OPAL_XIVE_DUMP);
 OPAL_CALL(opal_npu_init_context,		OPAL_NPU_INIT_CONTEXT);
 OPAL_CALL(opal_npu_destroy_context,		OPAL_NPU_DESTROY_CONTEXT);
 OPAL_CALL(opal_npu_map_lpar,			OPAL_NPU_MAP_LPAR);
+OPAL_CALL(opal_imc_counters_init,		OPAL_IMC_COUNTERS_INIT);
+OPAL_CALL(opal_imc_counters_start,		OPAL_IMC_COUNTERS_START);
+OPAL_CALL(opal_imc_counters_stop,		OPAL_IMC_COUNTERS_STOP);
-- 
2.7.4
