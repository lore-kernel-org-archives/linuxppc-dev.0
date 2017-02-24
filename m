Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV1Z64k13zDqJM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:26 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1O6SgES100478
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:24 -0500
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28td8bwfk2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:24 -0500
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 16:35:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 318BB3578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:19 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1O6ZB8134013346
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1O6Ykq0006457
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:34:46 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/2] powerpc/cpuhotplug: Force ESL=1 for offline cpus
Date: Fri, 24 Feb 2017 12:04:15 +0530
In-Reply-To: <20170224063416.7201-1-svaidy@linux.vnet.ibm.com>
References: <20170224063416.7201-1-svaidy@linux.vnet.ibm.com>
Message-Id: <20170224063416.7201-2-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

ESL=1 losses some HYP SPR context and not idea for cpuidle,
however can be used for offline cpus.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    | 15 +++++++++++++++
 arch/powerpc/platforms/powernv/idle.c | 11 +++++++++++
 2 files changed, 26 insertions(+)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index fd321eb4..31192d8 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -40,6 +40,21 @@
 #define ERR_EC_ESL_MISMATCH		-1
 #define ERR_DEEP_STATE_ESL_MISMATCH	-2
 
+/* Additional defs for debug and trace */
+
+#define RL_SHIFT      0
+#define MTL_SHIFT     4
+#define TR_SHIFT      8
+#define PSLL_SHIFT    16
+#define EC_SHIFT      20
+#define ESL_SHIFT     21
+#define INIT_PSSCR(ESL, EC, PSLL, TR, MTL, RL)	(((ESL) << (ESL_SHIFT)) | \
+						 ((EC) << (EC_SHIFT)) | \
+						 ((PSLL) << (PSLL_SHIFT)) | \
+						 ((TR) << (TR_SHIFT)) | \
+						 ((MTL) << (MTL_SHIFT)) | \
+						 ((RL) << (RL_SHIFT)))
+
 #ifndef __ASSEMBLY__
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 4ee837e..4f0663a 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -524,6 +524,17 @@ static int __init pnv_init_idle_states(void)
 
 	pnv_alloc_idle_core_states();
 
+	/* On POWER9 DD1, enter stop2 with ESL=EC=1 on Hotplug */
+	if (cpu_has_feature(CPU_FTR_POWER9_DD1)) {
+		pnv_deepest_stop_psscr_val =
+				/* ESL, EC, PSSL, TR,  MTL, RL */
+			INIT_PSSCR(0x1, 0x1, 0xf, 0x3, 0x3, 0x2);
+		pnv_deepest_stop_psscr_mask = PSSCR_HV_DEFAULT_MASK;
+		pr_warn("Overriding deepest_stop_psscr to: val=0x%016llx,mask=0x%016llx\n",
+			pnv_deepest_stop_psscr_val,
+			pnv_deepest_stop_psscr_mask);
+	}
+
 	if (supported_cpuidle_states & OPAL_PM_NAP_ENABLED)
 		ppc_md.power_save = power7_idle;
 	else if (supported_cpuidle_states & OPAL_PM_STOP_INST_FAST)
-- 
2.9.3
