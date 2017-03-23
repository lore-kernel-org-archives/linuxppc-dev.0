Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vpX5p1JFHzDqZp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 14:26:38 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2N3OCXt094214
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:26:27 -0400
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [125.16.236.2])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29c4yvbp3b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Mar 2017 23:26:26 -0400
Received: from localhost
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Thu, 23 Mar 2017 08:56:23 +0530
Received: from d28av08.in.ibm.com (d28av08.in.ibm.com [9.184.220.148])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2N3QLSd7209178
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:56:21 +0530
Received: from d28av08.in.ibm.com (localhost [127.0.0.1])
 by d28av08.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2N3QGBg006446
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Mar 2017 08:56:21 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Wang Nan <wangnan0@huawei.com>, Alexei Starovoitov <ast@kernel.org>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 5/6] powerpc/perf: Support to export SIERs bit in Power9
Date: Thu, 23 Mar 2017 08:56:07 +0530
In-Reply-To: <1490239568-30429-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1490239568-30429-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1490239568-30429-6-git-send-email-maddy@linux.vnet.ibm.com>
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

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Wang Nan <wangnan0@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Stephane Eranian <eranian@google.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power9-pmu.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 7f6582708e06..018f8e90ac35 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -427,6 +427,8 @@ static struct power_pmu power9_pmu = {
 	.bhrb_filter_map	= power9_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
 	.get_alternatives	= power9_get_alternatives,
+	.get_mem_data_src	= isa207_get_mem_data_src,
+	.get_mem_weight		= isa207_get_mem_weight,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
-- 
2.7.4
