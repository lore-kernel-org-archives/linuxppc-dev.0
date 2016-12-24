Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tlvrn1pZwzDw3s
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 17:06:01 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBO63hPv069095
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 01:05:58 -0500
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [125.16.236.5])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27h8web1y6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 01:05:58 -0500
Received: from localhost
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sat, 24 Dec 2016 11:35:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id EC6DE125805F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 11:37:12 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBO65rFD28377324
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 11:35:53 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBO65qQv004303
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2016 11:35:53 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: use is_kernel_addr macro in
 perf_get_misc_flags()
Date: Sat, 24 Dec 2016 11:35:49 +0530
Message-Id: <1482559549-22273-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Cleanup to use is_kernel_addr macro.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/core-book3s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 2cdf2647cdb0..d9c74fd1b37b 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -243,7 +243,7 @@ static inline u32 perf_get_misc_flags(struct pt_regs *regs)
 	 */
 	if (ppmu->flags & PPMU_NO_SIPR) {
 		unsigned long siar = mfspr(SPRN_SIAR);
-		if (siar >= PAGE_OFFSET)
+		if (is_kernel_addr(siar))
 			return PERF_RECORD_MISC_KERNEL;
 		return PERF_RECORD_MISC_USER;
 	}
-- 
2.7.4
