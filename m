Return-Path: <anju@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yR68B6BsLzDr4V
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 20:52:10 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v9V9pPCO059137
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 05:52:08 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2dxj13rbgd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Oct 2017 05:52:08 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <anju@linux.vnet.ibm.com>;
 Tue, 31 Oct 2017 09:52:06 -0000
From: Anju T Sudhakar <anju@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, anju@linux.vnet.ibm.com
Subject: [PATCH] powerpc/perf: Change the data type for the variable 'ncpu' in
 IMC code
Date: Tue, 31 Oct 2017 15:22:00 +0530
Message-Id: <1509443520-27106-1-git-send-email-anju@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the data type for the variable 'ncpu' in ppc_core_imc_cpu_offline(),
since cpumask_any_but() returns an 'int' value.

Signed-off-by: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Reported-by: David Binderman <dcb314@hotmail.com>
---
 arch/powerpc/perf/imc-pmu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/imc-pmu.c b/arch/powerpc/perf/imc-pmu.c
index 8812624..64dae3e 100644
--- a/arch/powerpc/perf/imc-pmu.c
+++ b/arch/powerpc/perf/imc-pmu.c
@@ -597,7 +597,8 @@ static int ppc_core_imc_cpu_online(unsigned int cpu)
 
 static int ppc_core_imc_cpu_offline(unsigned int cpu)
 {
-	unsigned int ncpu, core_id;
+	unsigned int core_id;
+	int ncpu;
 	struct imc_pmu_ref *ref;
 
 	/*
-- 
2.7.4
