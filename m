Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42FYtK2B2XzDq61
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 19:08:09 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w8J84WNg019447
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:08:50 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2mkgknnacb-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Sep 2018 04:08:49 -0400
Received: from localhost
 by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 19 Sep 2018 09:08:47 +0100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH 3/4] powerpc/pseries: Introduce helpers to change the DTL
 enable mask
Date: Wed, 19 Sep 2018 13:38:20 +0530
In-Reply-To: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1537343904.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <692384bb1275a331d3c4c75f34f7778acc3e64ab.1537343905.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In a subsequent patch, we want to be able to change the DTL enable mask
globally for all cpus. This conflicts with the current debugfs interface
that provides access to the DTL buffer contents.

To ensure consistent behavior, we introduce helpers to change the DTL
enable mask on either a specific cpu, or globally for all cpus. Setting
the DTL enable mask globally prevents changes to cpu-specific DTL enable
mask, and vice versa. We also introduce 'dtl_mask' so that when the DTL
enable mask is changed globally, new cpus also honor that.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/lppaca.h      |  4 ++
 arch/powerpc/platforms/pseries/dtl.c   |  5 +-
 arch/powerpc/platforms/pseries/lpar.c  | 64 +++++++++++++++++++++++++-
 arch/powerpc/platforms/pseries/setup.c |  2 +-
 4 files changed, 71 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/lppaca.h b/arch/powerpc/include/asm/lppaca.h
index 2c7e31187726..144862f86392 100644
--- a/arch/powerpc/include/asm/lppaca.h
+++ b/arch/powerpc/include/asm/lppaca.h
@@ -165,6 +165,10 @@ struct dtl_entry {
 #define DTL_LOG_FAULT		0x4
 #define DTL_LOG_ALL		(DTL_LOG_CEDE | DTL_LOG_PREEMPT | DTL_LOG_FAULT)
 
+extern u8 dtl_mask;
+int set_dtl_mask(int cpu, int mask);
+void reset_dtl_mask(int cpu);
+
 extern struct kmem_cache *dtl_cache;
 
 /*
diff --git a/arch/powerpc/platforms/pseries/dtl.c b/arch/powerpc/platforms/pseries/dtl.c
index fe333c2525fb..3b98fc19c53f 100644
--- a/arch/powerpc/platforms/pseries/dtl.c
+++ b/arch/powerpc/platforms/pseries/dtl.c
@@ -104,7 +104,8 @@ static int dtl_start(struct dtl *dtl)
 	dtlr->write_ptr = dtl->buf;
 
 	/* enable event logging */
-	lppaca_of(dtl->cpu).dtl_enable_mask |= dtl_event_mask;
+	if (set_dtl_mask(dtl->cpu, dtl_event_mask))
+		return -EBUSY;
 
 	dtl_consumer = consume_dtle;
 	atomic_inc(&dtl_count);
@@ -121,7 +122,7 @@ static void dtl_stop(struct dtl *dtl)
 	dtlr->buf = NULL;
 
 	/* restore dtl_enable_mask */
-	lppaca_of(dtl->cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
+	reset_dtl_mask(dtl->cpu);
 
 	if (atomic_dec_and_test(&dtl_count))
 		dtl_consumer = NULL;
diff --git a/arch/powerpc/platforms/pseries/lpar.c b/arch/powerpc/platforms/pseries/lpar.c
index dd024a192512..6563e7a782a3 100644
--- a/arch/powerpc/platforms/pseries/lpar.c
+++ b/arch/powerpc/platforms/pseries/lpar.c
@@ -58,12 +58,74 @@
 #define HBR_AVPN	0x0200000000000000UL
 #define HBR_ANDCOND	0x0100000000000000UL
 
+u8 dtl_mask = DTL_LOG_PREEMPT;
+static u8 dtl_mask_global_refctr, dtl_mask_percpu_inuse;
+static DEFINE_MUTEX(dtl_mask_mutex);
 
 /* in hvCall.S */
 EXPORT_SYMBOL(plpar_hcall);
 EXPORT_SYMBOL(plpar_hcall9);
 EXPORT_SYMBOL(plpar_hcall_norets);
 
+int set_dtl_mask(int cpu, int mask)
+{
+	int rc = 0;
+
+	mutex_lock(&dtl_mask_mutex);
+
+	if ((cpu == -1 && dtl_mask_percpu_inuse) ||
+	    (cpu >= 0 && dtl_mask_global_refctr)) {
+		rc = -1;
+		goto out;
+	}
+
+	if (cpu >= 0) {
+		dtl_mask_percpu_inuse++;
+		lppaca_of(cpu).dtl_enable_mask = mask;
+		goto out;
+	}
+
+	if (dtl_mask_global_refctr && mask != dtl_mask) {
+		rc = -1;
+		goto out;
+	}
+
+	if (!dtl_mask_global_refctr) {
+		dtl_mask = mask;
+		for_each_present_cpu(cpu)
+			lppaca_of(cpu).dtl_enable_mask = mask;
+	}
+
+	dtl_mask_global_refctr++;
+
+out:
+	mutex_unlock(&dtl_mask_mutex);
+
+	return rc;
+}
+
+void reset_dtl_mask(int cpu)
+{
+	mutex_lock(&dtl_mask_mutex);
+
+	if (cpu >= 0) {
+		dtl_mask_percpu_inuse--;
+		lppaca_of(cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
+		goto out;
+	}
+
+	dtl_mask_global_refctr--;
+
+	if (!dtl_mask_global_refctr) {
+		dtl_mask = DTL_LOG_PREEMPT;
+		for_each_present_cpu(cpu)
+			lppaca_of(cpu).dtl_enable_mask = dtl_mask;
+	}
+
+out:
+	mutex_unlock(&dtl_mask_mutex);
+}
+
 void vpa_init(int cpu)
 {
 	int hwcpu = get_hard_smp_processor_id(cpu);
@@ -125,7 +187,7 @@ void vpa_init(int cpu)
 			pr_err("WARNING: DTL registration of cpu %d (hw %d) "
 			       "failed with %ld\n", smp_processor_id(),
 			       hwcpu, ret);
-		lppaca_of(cpu).dtl_enable_mask = DTL_LOG_PREEMPT;
+		lppaca_of(cpu).dtl_enable_mask = dtl_mask;
 	}
 }
 
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index a48cb9757be2..285a35f32d3d 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -293,7 +293,7 @@ static int alloc_dispatch_logs(void)
 		pr_err("WARNING: DTL registration of cpu %d (hw %d) failed "
 		       "with %d\n", smp_processor_id(),
 		       hard_smp_processor_id(), ret);
-	get_paca()->lppaca_ptr->dtl_enable_mask = DTL_LOG_PREEMPT;
+	get_paca()->lppaca_ptr->dtl_enable_mask = dtl_mask;
 
 	return 0;
 }
-- 
2.18.0
