Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e4.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EBB582C00B9
 for <linuxppc-dev@ozlabs.org>; Thu,  8 Nov 2012 06:17:39 +1100 (EST)
Received: from /spool/local
 by e4.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 7 Nov 2012 14:17:35 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id E08506E803C
 for <linuxppc-dev@ozlabs.org>; Wed,  7 Nov 2012 14:17:32 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 qA7JHWUr62914624
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 14:17:32 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 qA7JHV8e010578
 for <linuxppc-dev@ozlabs.org>; Wed, 7 Nov 2012 14:17:32 -0500
Date: Wed, 7 Nov 2012 11:18:47 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Anton Blanchard <anton@au1.ibm.com>, robert.richter@amd.com
Subject: [PATCH 2/4] perf/Power7: Use macros to identify perf events
Message-ID: <20121107191846.GB16211@us.ibm.com>
References: <20121107191818.GA16211@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20121107191818.GA16211@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>From 8a0dbd8f3fce2834292efa50c15ca64d4f6a6536 Mon Sep 17 00:00:00 2001
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Date: Wed, 7 Nov 2012 09:36:14 -0800
Subject: [PATCH 2/4] perf/Power7: Use macros to identify perf events

Define and use macros to identify perf events codes This would make it
easier and more readable when these event codes need to be used in more
than one place.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power7-pmu.c |   25 +++++++++++++++++--------
 1 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 441af08..256db4f 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -295,15 +295,24 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 		mmcr[1] &= ~(0xffUL << MMCR1_PMCSEL_SH(pmc));
 }
 
+#define	PM_CYC				0x1e
+#define	PM_GCT_NOSLOT_CYC		0x100f8
+#define	PM_CMPLU_STALL			0x4000a
+#define	PM_INST_CMPL			0x2
+#define	PM_LD_REF_L1			0xc880
+#define	PM_LD_MISS_L1			0x400f0
+#define	PM_BRU_FIN			0x10068
+#define	PM_BRU_MPRED			0x400f6
+
 static int power7_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
-	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
-	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
-	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x10068,	/* BRU_FIN	*/
-	[PERF_COUNT_HW_BRANCH_MISSES] = 0x400f6,	/* BR_MPRED	*/
+	[PERF_COUNT_HW_CPU_CYCLES] = 			PM_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 	PM_GCT_NOSLOT_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 	PM_CMPLU_STALL,
+	[PERF_COUNT_HW_INSTRUCTIONS] = 			PM_INST_CMPL,
+	[PERF_COUNT_HW_CACHE_REFERENCES] = 		PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] = 			PM_LD_MISS_L1,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 		PM_BRU_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] = 		PM_BRU_MPRED,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
-- 
1.7.1
