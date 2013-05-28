Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0F5362C0309
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 14:48:08 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 28 May 2013 10:11:58 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C771C125804F
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 10:20:05 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4S4lwmJ8520102
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 10:17:58 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4S4m04u006047
 for <linuxppc-dev@ozlabs.org>; Tue, 28 May 2013 04:48:01 GMT
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 1/2] powerpc,
 perf: Ignore separate BHRB privilege state filter request
Date: Tue, 28 May 2013 10:17:31 +0530
Message-Id: <1369716452-28689-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369716452-28689-1-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Completely ignore BHRB privilege state filter request as we are
already configuring that with privilege state filtering attribute
for the accompanying PMU event. This would help achieve cleaner
user space interaction for BHRB.

This patch fixes a situation like this

Before patch:-
------------
./perf record -j any -e branch-misses:k ls
Error:
The sys_perf_event_open() syscall returned with 95 (Operation not supported) for event (branch-misses:k).
/bin/dmesg may provide additional information.
No CONFIG_PERF_EVENTS=y kernel support configured?

Here 'perf record' actually copies over ':k' filter request into BHRB
privilege state filter config and our previous check in kernel would
fail that.

After patch:-
-------------
./perf record -j any -e branch-misses:k ls
perf  perf.data  perf.data.old  test-mmap-ring
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.002 MB perf.data (~102 samples) ]

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/perf/power8-pmu.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index f7d1c4f..3a58416 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -525,16 +525,12 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type)
 	u64 pmu_bhrb_filter = 0;
 	u64 br_privilege = branch_sample_type & ONLY_PLM;
 
-	/* BHRB and regular PMU events share the same prvillege state
+	/* BHRB and regular PMU events share the same privilege state
 	 * filter configuration. BHRB is always recorded along with a
-	 * regular PMU event. So privilege state filter criteria for BHRB
-	 * and the companion PMU events has to be the same. As a default
-	 * "perf record" tool sets all privillege bits ON when no filter
-	 * criteria is provided in the command line. So as along as all
-	 * privillege bits are ON or they are OFF, we are good to go.
+	 * regular PMU event. As the privilege state filter is handled
+	 * in the basic PMC configuration of the accompanying regular
+	 * PMU event, we ignore any separate BHRB specific request.
 	 */
-	if ((br_privilege != 7) && (br_privilege != 0))
-		return -1;
 
 	/* No branch filter requested */
 	if (branch_sample_type & PERF_SAMPLE_BRANCH_ANY)
-- 
1.7.11.7
