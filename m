Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CC4652C007C
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 17:24:01 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 23 Jan 2013 01:23:58 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 586A1C9003E
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 01:23:57 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0N6NvXw21299254
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 01:23:57 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0N6NtC3009272
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 01:23:56 -0500
Date: Tue, 22 Jan 2013 22:23:53 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>,
 Ingo Molnar <mingo@redhat.com>
Subject: [PATCH 1/6][v4]: perf/Power7: Use macros to identify perf events
Message-ID: <20130123062353.GB13720@us.ibm.com>
References: <20130123062201.GA13720@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130123062201.GA13720@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, robert.richter@amd.com,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[PATCH 1/6][v4]: perf/Power7: Use macros to identify perf events

Define and use macros to identify perf events codes This would make it
easier and more readable when these event codes need to be used in more
than one place.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---
 arch/powerpc/perf/power7-pmu.c |   28 ++++++++++++++++++++--------
 1 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/power7-pmu.c b/arch/powerpc/perf/power7-pmu.c
index 441af08..44e70d2 100644
--- a/arch/powerpc/perf/power7-pmu.c
+++ b/arch/powerpc/perf/power7-pmu.c
@@ -51,6 +51,18 @@
 #define MMCR1_PMCSEL_MSK	0xff
 
 /*
+ * Power7 event codes.
+ */
+#define	PME_PM_CYC			0x1e
+#define	PME_PM_GCT_NOSLOT_CYC		0x100f8
+#define	PME_PM_CMPLU_STALL		0x4000a
+#define	PME_PM_INST_CMPL		0x2
+#define	PME_PM_LD_REF_L1		0xc880
+#define	PME_PM_LD_MISS_L1		0x400f0
+#define	PME_PM_BRU_FIN			0x10068
+#define	PME_PM_BRU_MPRED		0x400f6
+
+/*
  * Layout of constraint bits:
  * 6666555555555544444444443333333333222222222211111111110000000000
  * 3210987654321098765432109876543210987654321098765432109876543210
@@ -296,14 +308,14 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 }
 
 static int power7_generic_events[] = {
-	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
-	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
-	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
-	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
-	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
-	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/
-	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] = 0x10068,	/* BRU_FIN	*/
-	[PERF_COUNT_HW_BRANCH_MISSES] = 0x400f6,	/* BR_MPRED	*/
+	[PERF_COUNT_HW_CPU_CYCLES] =			PME_PM_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] =	PME_PM_GCT_NOSLOT_CYC,
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] =	PME_PM_CMPLU_STALL,
+	[PERF_COUNT_HW_INSTRUCTIONS] =			PME_PM_INST_CMPL,
+	[PERF_COUNT_HW_CACHE_REFERENCES] =		PME_PM_LD_REF_L1,
+	[PERF_COUNT_HW_CACHE_MISSES] =			PME_PM_LD_MISS_L1,
+	[PERF_COUNT_HW_BRANCH_INSTRUCTIONS] =		PME_PM_BRU_FIN,
+	[PERF_COUNT_HW_BRANCH_MISSES] =			PME_PM_BRU_MPRED,
 };
 
 #define C(x)	PERF_COUNT_HW_CACHE_##x
-- 
1.7.1
