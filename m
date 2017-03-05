Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vbdH835hszDqXX
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 20:41:56 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v259caXV027715
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 04:41:43 -0500
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 290byk66q0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 05 Mar 2017 04:41:42 -0500
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 5 Mar 2017 15:11:40 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 7C7F3E0045
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 Mar 2017 15:13:26 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v259fc2Q13828256
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:38 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v259fZMk014639
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 5 Mar 2017 15:11:37 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Daniel Axtens <dja@axtens.net>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH 5/6] powerpc/perf: Support to export SIERs bit in Power9
Date: Sun,  5 Mar 2017 15:11:16 +0530
In-Reply-To: <1488706877-28604-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1488706877-28604-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1488706877-28604-6-git-send-email-maddy@linux.vnet.ibm.com>
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

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>
Cc: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
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
