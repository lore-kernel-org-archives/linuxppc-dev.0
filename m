Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcGfG5pkJzDqXk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:42 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v26ASmKl009154
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 05:45:27 -0500
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 by mx0b-001b2d01.pphosted.com with ESMTP id 290c4uhjpq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Mar 2017 05:45:27 -0500
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Mon, 6 Mar 2017 20:45:24 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 03EAD2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Mar 2017 21:45:23 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v26AjE4a40960072
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:45:22 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v26Aimba031320
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 6 Mar 2017 21:44:49 +1100
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2 5/6] powerpc/perf: Support to export SIERs bit in Power9
Date: Mon,  6 Mar 2017 16:13:12 +0530
In-Reply-To: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488796993-25495-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488796993-25495-6-git-send-email-maddy@linux.vnet.ibm.com>
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
