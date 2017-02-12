Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vLw4T46DXzDqBn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Feb 2017 04:03:37 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1CGww77066984
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:35 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28hyjtp5aq-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 12:03:35 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Sun, 12 Feb 2017 22:33:32 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 917D6125804F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:30 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1CH3Tbf33489024
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1CH3SeC009426
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Feb 2017 22:33:29 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v2 3/6] powerpc/perf: Add alternative event table and function
 for power9
Date: Sun, 12 Feb 2017 22:33:12 +0530
In-Reply-To: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1486918995-16354-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1486918995-16354-3-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
Change v1:
No changes, just a rebase

 arch/powerpc/perf/power9-pmu.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/powerpc/perf/power9-pmu.c b/arch/powerpc/perf/power9-pmu.c
index 7332634e18c9..b38acff8a791 100644
--- a/arch/powerpc/perf/power9-pmu.c
+++ b/arch/powerpc/perf/power9-pmu.c
@@ -106,6 +106,21 @@ enum {
 /* PowerISA v2.07 format attribute structure*/
 extern struct attribute_group isa207_pmu_format_group;
 
+/* Table of alternatives, sorted by column 0 */
+static const unsigned int power9_event_alternatives[][MAX_ALT] = {
+	{ PM_INST_DISP,			PM_INST_DISP_ALT },
+};
+
+static int power9_get_alternatives(u64 event, unsigned int flags, u64 alt[])
+{
+	int num_alt = 0;
+
+	num_alt = isa207_get_alternatives(event, alt, power9_event_alternatives,
+				(int)ARRAY_SIZE(power9_event_alternatives));
+
+	return num_alt;
+}
+
 GENERIC_EVENT_ATTR(cpu-cycles,			PM_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-frontend,	PM_ICT_NOSLOT_CYC);
 GENERIC_EVENT_ATTR(stalled-cycles-backend,	PM_CMPLU_STALL);
@@ -383,6 +398,7 @@ static struct power_pmu power9_isa207_pmu = {
 	.config_bhrb		= power9_config_bhrb,
 	.bhrb_filter_map	= power9_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
+	.get_alternatives	= power9_get_alternatives,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_NO_SIAR | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
@@ -401,6 +417,7 @@ static struct power_pmu power9_pmu = {
 	.config_bhrb		= power9_config_bhrb,
 	.bhrb_filter_map	= power9_bhrb_filter_map,
 	.get_constraint		= isa207_get_constraint,
+	.get_alternatives	= power9_get_alternatives,
 	.disable_pmc		= isa207_disable_pmc,
 	.flags			= PPMU_HAS_SIER | PPMU_ARCH_207S,
 	.n_generic		= ARRAY_SIZE(power9_generic_events),
-- 
2.7.4
