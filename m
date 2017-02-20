Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vRlYG4h1RzDqBv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2017 00:56:50 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1KDtdx5046343
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:56:48 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28pk55xx9d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 08:56:47 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 20 Feb 2017 19:26:44 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5452E3940033
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:26:40 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1KDud5u40501490
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:26:39 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1KDucaZ000317
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2017 19:26:39 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Fix perf_get_data_addr() for power9 DD1
Date: Mon, 20 Feb 2017 19:26:30 +0530
Message-Id: <1487598990-28592-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Power9 DD1 do not support PMU_HAS_SIER flag and sdsync
in perf_get_data_addr() defaults to MMCRA_SDSYNC which
is wrong. Since power9 MMCRA does not support SDSYNC bit,
patch includes PPMU_NO_SIAR flag to the check and set the
sdsync with MMCRA_SAMPLE_ENABLE;

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 270eb9b74e2e..e9e6dfff032f 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -183,6 +183,8 @@ static inline void perf_get_data_addr(struct pt_regs *regs, u64 *addrp)
 			sdsync = POWER7P_MMCRA_SDAR_VALID;
 		else if (ppmu->flags & PPMU_ALT_SIPR)
 			sdsync = POWER6_MMCRA_SDSYNC;
+		else if (ppmu->flags & PPMU_NO_SIAR)
+			sdsync = MMCRA_SAMPLE_ENABLE;
 		else
 			sdsync = MMCRA_SDSYNC;
 
-- 
2.7.4
