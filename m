Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w295Y09ZwzDq9K
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 11:51:44 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3B1mY6H065572
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:43 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29rhv7gk3v-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 21:51:43 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Tue, 11 Apr 2017 07:21:40 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3B1pbNO8388854
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:21:37 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3B1pY7r029862
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 07:21:37 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, sukadev@linux.vnet.ibm.com,
 andrew.donnellan@au1.ibm.com, peterz@infradead.org, mingo@redhat.com,
 acme@kernel.org, alexander.shishkin@linux.intel.com,
 wangnan0@huawei.com, ast@kernel.org, eranian@google.com,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v3 4/6] powerpc/perf: Support to export SIERs bit in Power8
Date: Tue, 11 Apr 2017 07:21:08 +0530
In-Reply-To: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1491875470-17904-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1491875470-17904-5-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Patch to export SIER bits to userspace via
perf_mem_data_src and perf_sample_data struct.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index ce15b19a7962..932d7536f0eb 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -325,6 +325,8 @@ static struct power_pmu power8_pmu = {
 	.bhrb_filter_map	= power8_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.get_alternatives	= power8_get_alternatives,
+	.get_mem_data_src	= isa207_get_mem_data_src,
+	.get_mem_weight		= isa207_get_mem_weight,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power8_generic_events),
-- 
2.7.4
