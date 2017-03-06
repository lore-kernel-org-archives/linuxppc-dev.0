Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGf95TYnzDqZr
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:37 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26ASt94086874
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 05:45:25 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28yu2jqa1t-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 05:45:24 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 20:45:22 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 808643578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:19 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26AjB7f55443652
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:45:19 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26Aijab031216
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:44:46 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Daniel Axtens <dja@axtens.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] powerpc/perf: Support to export SIERs bit in Power8
Date: Mon,  6 Mar 2017 16:13:11 +0530
In-Reply-To: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488796993-25495-5-git-send-email-maddy@linux.vnet.ibm.com>
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
Cc: Daniel Axtens <dja@axtens.net>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
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
