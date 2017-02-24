Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vV1Z63vJZzDqJL
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:26 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1O6YkHx052660
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:24 -0500
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28tdh24tjn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 01:35:24 -0500
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <svaidy@linux.vnet.ibm.com>;
 Fri, 24 Feb 2017 16:35:22 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 545373578052
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:20 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1O6ZChO39846096
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:35:20 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1O6YlOp006509
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 17:34:47 +1100
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] powerpc/cpuhotplug: print psscr and srr1 value for debug
Date: Fri, 24 Feb 2017 12:04:16 +0530
In-Reply-To: <20170224063416.7201-1-svaidy@linux.vnet.ibm.com>
References: <20170224063416.7201-1-svaidy@linux.vnet.ibm.com>
Message-Id: <20170224063416.7201-3-svaidy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a debug patch that helps trace various STOP
state transitions and look at srr1 and psscr at wakeup.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/smp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/powernv/smp.c
index e39e6c4..5b3f002 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -185,8 +185,12 @@ static void pnv_smp_cpu_kill_self(void)
 		ppc64_runlatch_off();
 
 		if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+			pr_info("CPU%d going offline with request psscr %016llx\n",
+				cpu, pnv_deepest_stop_psscr_val);
 			srr1 = power9_idle_stop(pnv_deepest_stop_psscr_val,
 						pnv_deepest_stop_psscr_mask);
+			pr_info("CPU%d coming online with psscr %016lx, srr1 %016lx\n",
+						cpu, mfspr(SPRN_PSSCR), srr1);
 		} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
 			srr1 = power7_winkle();
 		} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
-- 
2.9.3
