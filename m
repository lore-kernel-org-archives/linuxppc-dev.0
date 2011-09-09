Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp06.in.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AB647B6F86
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Sep 2011 17:12:17 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp06.in.ibm.com (8.14.4/8.13.1) with ESMTP id p897C9sc005074
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 12:42:09 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p897C9q73305590
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 12:42:09 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p897C83V027294
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 9 Sep 2011 17:12:09 +1000
Message-ID: <4E69BC46.4000809@linux.vnet.ibm.com>
Date: Fri, 09 Sep 2011 12:42:06 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Michael Neuling <michael.neuling@au1.ibm.com>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] perf events,
	powerpc: Add POWER7 stalled-cycles-frontend/backend events
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf events, powerpc: Add POWER7 stalled-cycles-frontend/backend events

Extent the POWER7 PMU driver with definitions for generic front-end and back-end
stall events.

As explained in Ingo's original comment(8f62242246351b5a4bc0c1f00c0c7003edea128a
), the exact definitions of the stall events are very much processor specific as
different things mean different in their respective instruction pipeline. These
two Power7 raw events are the closest approximation to the concept detailed in
Ingo's comment.

[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
It means cycles when the Global Completion Table has no slots from this thread

[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
It means no groups completed and GCT not empty for this thread

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
Version 2: added new comments in commit message as suggested by Mikey.
No code changes.

diff --git a/arch/powerpc/kernel/power7-pmu.c b/arch/powerpc/kernel/power7-pmu.c
index 593740f..e5d2844 100644
--- a/arch/powerpc/kernel/power7-pmu.c
+++ b/arch/powerpc/kernel/power7-pmu.c
@@ -297,6 +297,8 @@ static void power7_disable_pmc(unsigned int pmc, unsigned long mmcr[])
 
 static int power7_generic_events[] = {
 	[PERF_COUNT_HW_CPU_CYCLES] = 0x1e,
+	[PERF_COUNT_HW_STALLED_CYCLES_FRONTEND] = 0x100f8, /* GCT_NOSLOT_CYC */
+	[PERF_COUNT_HW_STALLED_CYCLES_BACKEND] = 0x4000a,  /* CMPLU_STALL */
 	[PERF_COUNT_HW_INSTRUCTIONS] = 2,
 	[PERF_COUNT_HW_CACHE_REFERENCES] = 0xc880,	/* LD_REF_L1_LSU*/
 	[PERF_COUNT_HW_CACHE_MISSES] = 0x400f0,		/* LD_MISS_L1	*/

-- 
Anshuman Khandual 
LTC India 
