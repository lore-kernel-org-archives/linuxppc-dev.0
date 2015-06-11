Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 631F61A0E70
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 18:44:24 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 11 Jun 2015 14:14:22 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 642ECE004C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:17:42 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5B8iHuU655710
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:17 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5B8i1Gj016978
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jun 2015 14:14:02 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 sukadev@linux.vnet.ibm.com, eranian@google.com,
 khandual@linux.vnet.ibm.com, rusty@rustcorp.com.au,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH 7/8] powerpc/perf: Set data source value
Date: Thu, 11 Jun 2015 14:13:36 +0530
Message-Id: <1434012217-9776-8-git-send-email-maddy@linux.vnet.ibm.com>
In-Reply-To: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1434012217-9776-1-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf_sample_data_init initialize the data source variable "->val"
with PERF_MEM_NA. New value should not be ORed since the userspace
perf tool will look at bitmap field when displaying the hierarchy levels.

Reviewed-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 40e74a0..667736f 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -684,7 +684,7 @@ static void power8_get_mem_data_src(union perf_mem_data_src *dsrc,
 	if (is_load_store_inst(sier)) {
 		idx = (sier & POWER8_SIER_LDST_MASK) >> POWER8_SIER_LDST_SHIFT;
 
-		dsrc->val |= ldst_src_map[idx];
+		dsrc->val = ldst_src_map[idx];
 	}
 }
 
-- 
1.9.1
