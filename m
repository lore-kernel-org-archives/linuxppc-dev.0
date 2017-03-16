Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkL0g5g8dzDqYy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:39 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2G7bKPn033647
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:37 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297nt71usw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 03:37:37 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 17:37:34 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2G7bPsc37355682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:33 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2G7ax2o011247
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:37:00 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anju T Sudhakar <anju@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Michael Neuling <mikey@neuling.org>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>, Stephane Eranian <eranian@google.com>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 13/13] powerpc/perf: Enable/disable core engine during
 cpuhotplug
Date: Thu, 16 Mar 2017 13:05:07 +0530
In-Reply-To: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1489649707-8021-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1489649707-8021-14-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anju T Sudhakar <anju@linux.vnet.ibm.com>

This patch disables the core imc engine when we offline all the cpus available in
a core. Also it enables core imc when any of the cpu in that core comes back.
Enable/disable core imc is done through the opal calls OPAL_CORE_IMC_ENABLE
and OPAL_CORE_IMC_DISABLE respectively.

Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Cc: Balbir Singh <bsingharora@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Anton Blanchard <anton@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/imc-pmu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 2ff39fe2a5ce..278c7a427b43 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -127,6 +127,7 @@ static int ppc_core_imc_cpu_online(unsigned int cpu)
 
 	/* Else, set the cpu in the mask, and change the context */
 	cpumask_set_cpu(cpu, &core_imc_cpumask);
+	opal_core_imc_counters_control(OPAL_CORE_IMC_ENABLE, 0, 0, 0);
 	core_imc_change_cpu_context(-1, cpu);
 	return 0;
 }
@@ -149,8 +150,10 @@ static int ppc_core_imc_cpu_offline(unsigned int cpu)
 	if (ncpu < nr_cpu_ids) {
 		target = ncpu;
 		cpumask_set_cpu(target, &core_imc_cpumask);
-	} else
+	} else {
+		opal_core_imc_counters_control(OPAL_CORE_IMC_DISABLE, 0, 0, 0);
 		target = -1;
+	}
 
 	/* migrate the context */
 	core_imc_change_cpu_context(cpu, target);
-- 
2.7.4
