Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xGn5w06YkzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 15:36:03 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6P5ZqaE083125
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:36:01 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bwu4pjf5r-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 01:36:01 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 25 Jul 2017 15:35:58 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6P5ZtwO28966932
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 15:35:55 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6P5ZkC6016627
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jul 2017 15:35:46 +1000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/perf: Update default sdar_mode value for power9
Date: Tue, 25 Jul 2017 11:05:51 +0530
Message-Id: <1500960951-18017-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Commit 20dd4c624d251 ('powerpc/perf: Fix SDAR_MODE value for continous
sampling on Power9') set the default sdar_mode value in MMCRA[SDAR_MODE]
to be used as 0b01 (Update on TLB miss). And this value is set if sdar_mode
from event is zero, or we are in continous sampling mode in power9 dd1.

But it is preferred to have the sdar_mode value for power9 as
0b10 (Update on dcache miss) for better sampling updates instead
of 0b01 (Update on TLB miss).

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/isa207-common.c | 2 +-
 arch/powerpc/perf/isa207-common.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
index 3f3aa9a7063a..582ed2c9bc56 100644
--- a/arch/powerpc/perf/isa207-common.c
+++ b/arch/powerpc/perf/isa207-common.c
@@ -99,7 +99,7 @@ static void mmcra_sdar_mode(u64 event, unsigned long *mmcra)
 		else if (!cpu_has_feature(CPU_FTR_POWER9_DD1) && p9_SDAR_MODE(event))
 			*mmcra |=  p9_SDAR_MODE(event) << MMCRA_SDAR_MODE_SHIFT;
 		else
-			*mmcra |= MMCRA_SDAR_MODE_TLB;
+			*mmcra |= MMCRA_SDAR_MODE_DCACHE;
 	} else
 		*mmcra |= MMCRA_SDAR_MODE_TLB;
 }
diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
index 8acbe6e802c7..7a0228bf283c 100644
--- a/arch/powerpc/perf/isa207-common.h
+++ b/arch/powerpc/perf/isa207-common.h
@@ -247,6 +247,7 @@
 #define MMCRA_SDAR_MODE_SHIFT		42
 #define MMCRA_SDAR_MODE_TLB		(1ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_SDAR_MODE_NO_UPDATES	~(0x3ull << MMCRA_SDAR_MODE_SHIFT)
+#define MMCRA_SDAR_MODE_DCACHE		(2ull << MMCRA_SDAR_MODE_SHIFT)
 #define MMCRA_IFM_SHIFT			30
 #define MMCRA_THR_CTR_MANT_SHIFT	19
 #define MMCRA_THR_CTR_MANT_MASK		0x7Ful
-- 
2.7.4
