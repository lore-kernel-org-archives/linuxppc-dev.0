Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j6yM1fQWzF2Fm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 21:17:46 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w4BBACDb070000
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:17:45 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hw7b3qabt-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 07:17:44 -0400
Received: from localhost
 by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 11 May 2018 07:17:43 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 2/2] powerpc: Enable ASYM_SMT on interleaved big-core systems
Date: Fri, 11 May 2018 16:47:24 +0530
In-Reply-To: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1526037444-22876-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1526037444-22876-3-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Each of the SMT4 cores forming a fused-core are more or less
independent units. Thus when multiple tasks are scheduled to run on
the fused core, we get the best performance when the tasks are spread
across the pair of SMT4 cores.

Since the threads in the pair of SMT4 cores of an interleaved big-core
are numbered {0,2,4,6} and {1,3,5,7} respectively, enable ASYM_SMT on
such interleaved big-cores that will bias the load-balancing of tasks
on smaller numbered threads, which will automatically result in
spreading the tasks uniformly across the associated pair of SMT4
cores.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 9ca7148..0153f01 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1082,7 +1082,7 @@ static int powerpc_smt_flags(void)
 {
 	int flags = SD_SHARE_CPUCAPACITY | SD_SHARE_PKG_RESOURCES;
 
-	if (cpu_has_feature(CPU_FTR_ASYM_SMT)) {
+	if (cpu_has_feature(CPU_FTR_ASYM_SMT) || has_interleaved_big_core) {
 		printk_once(KERN_INFO "Enabling Asymmetric SMT scheduling\n");
 		flags |= SD_ASYM_PACKING;
 	}
-- 
1.9.4
