Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FXZT1MwQzF3JJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 18:09:17 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J895Y2033317
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:15 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkfmcevr7-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:09:10 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 09:08:43 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 1/4] powerpc/pseries: Use macros for referring to the DTL
 enable mask
Date: Wed, 19 Sep 2018 13:38:18 +0530
In-Reply-To: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <5c81901cefa704fd662fd21a7febe65d5e8aa898.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Introduce macros to encode the DTL enable mask fields and use those
instead of hardcoding numbers.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h      | 11 +++++++++++
 arch/powerpc/platforms/pseries/dtl.c   |  8 +-------
 arch/powerpc/platforms/pseries/lpar.c  |  2 +-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 7c23ce8a5a4c..2c7e31187726 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -154,6 +154,17 @@ struct dtl_entry {
 #define DISPATCH_LOG_BYTES	4096	/* bytes per cpu */
 #define N_DISPATCH_LOG		(DISPATCH_LOG_BYTES / sizeof(struct dtl_entry))
 
+/*
+ * Dispatch trace log event enable mask:
+ *   0x1: voluntary virtual processor waits
+ *   0x2: time-slice preempts
+ *   0x4: virtual partition memory page faults
+ */
+#define DTL_LOG_CEDE		0x1
+#define DTL_LOG_PREEMPT		0x2
+#define DTL_LOG_FAULT		0x4
+#define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
+
 extern struct kmem_cache *dtl_cache;
 
 /*
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index 18014cdeb590..e0421aa6eafa 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -40,13 +40,7 @@ struct dtl {
 };
 static DEFINE_PER_CPU(struct dtl, cpu_dtl);
 
-/*
- * Dispatch trace log event mask:
- * 0x7: 0x1: voluntary virtual processor waits
- *      0x2: time-slice preempts
- *      0x4: virtual partition memory page faults
- */
-static u8 dtl_event_mask = 0x7;
+static u8 dtl_event_mask = DTL_LOG_ALL;
 
 
 /*
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index d3992ced0782..dd024a192512 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -125,7 +125,7 @@ void vpa_init(int cpu)
 			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
 			       "failed with %ld\n", smp_processor_id(),
 			       hwcpu, ret);
-		lppaca_of(cpu).dtl_enable_mask = 2;
+		lppaca_of(cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
 	}
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index ba1791fd3234..a48cb9757be2 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -293,7 +293,7 @@ static int alloc_dispatch_logs(void)
 		pr_err("WARNING: DTL registration of cpu %d (hw %d) failed "
 		       "with %d\n", smp_processor_id(),
 		       hard_smp_processor_id(), ret);
-	get_paca()->lppaca_ptr->dtl_enable_mask = 2;
+	get_paca()->lppaca_ptr->dtl_enable_mask = DTL_LOG_PREEMPT;
 
 	return 0;
 }
-- 
2.18.0
