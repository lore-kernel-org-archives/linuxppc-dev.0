Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C20A22C0079
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jul 2013 16:23:55 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 1 Jul 2013 16:03:54 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 74455357804E
 for <linuxppc-dev@ozlabs.org>; Mon,  1 Jul 2013 16:13:38 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r615wfIo55771230
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jul 2013 15:58:42 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r616Dbo5026353
 for <linuxppc-dev@ozlabs.org>; Mon, 1 Jul 2013 16:13:37 +1000
Message-ID: <51D11DEF.8070302@linux.vnet.ibm.com>
Date: Mon, 01 Jul 2013 11:43:03 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Linux PPC dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc, perf: Add generic cache reference and cache miss
 events for POWER8 PMU
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Ellerman <ellerman@au1.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

powerpc, perf: Add generic cache reference and cache miss events for POWER8 PMU

This enables generic cache reference and cache miss events on POWER8 systems by
utilizing raw PMU event codes for L1 cache reference and L1 cache miss events
respectively.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index f7d1c4f..5ccddac 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -24,6 +24,8 @@
 #define PM_INST_CMPL			0x00002
 #define PM_BRU_FIN			0x10068
 #define PM_BR_MPRED_CMPL		0x400f6
+#define PM_LD_MISS_L1			0x3E054
+#define PM_LD_REF_L1			0x100EE
 
 
 /*
@@ -518,6 +520,8 @@ static int power8_generic_events[] = {
 	[PERF_COUNT_HW_INSTRUCTIONS] =			PM_INST_CMPL,
 	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PM_BRU_FIN,
 	[PERF_COUNT_HW_BRANCH_MISSES] =			PM_BR_MPRED_CMPL,
+	[PERF_COUNT_HW_CACHE_REFERENCES] = 		PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] =			PM_LD_MISS_L1,
 };
 
 static u64 power8_bhrb_filter_map(u64 branch_sample_type)
