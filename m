Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E31F21A0030
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Oct 2015 20:59:24 +1100 (AEDT)
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 23431140D5F
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2015 20:59:23 +1100 (AEDT)
Received: from /spool/local
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Mon, 5 Oct 2015 15:29:21 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C18B8394005C
 for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2015 15:29:16 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t959xG9T7602482
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2015 15:29:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t959xE4T015388
 for <linuxppc-dev@ozlabs.org>; Mon, 5 Oct 2015 15:29:15 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org, dja@axtens.net
Subject: [PATCH V11 09/10] powerpc/perf: Enable privilege mode SW branch
 filters
Date: Mon,  5 Oct 2015 15:29:11 +0530
Message-Id: <1444039152-3665-10-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1444039152-3665-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1444039152-3665-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables privilege mode SW branch filters. Also modifies
POWER8 PMU branch filter configuration so that the privilege mode
branch filter implemented as part of base PMU event configuration
is reflected in bhrb filter mask. As a result, the SW will skip and
not try to process the privilege mode branch filters itself.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/perf_event_server.h |  3 +++
 arch/powerpc/perf/core-book3s.c              | 37 ++++++++++++++++++++++++++--
 arch/powerpc/perf/power8-pmu.c               | 13 ++++++++--
 3 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/perf_event_server.h b/arch/powerpc/include/asm/perf_event_server.h
index cb7ca1a..23d68d3 100644
--- a/arch/powerpc/include/asm/perf_event_server.h
+++ b/arch/powerpc/include/asm/perf_event_server.h
@@ -85,6 +85,9 @@ extern unsigned long int read_bhrb(int n);
 		for ((x) = PERF_SAMPLE_BRANCH_USER; \
 			(x) < PERF_SAMPLE_BRANCH_MAX; (x) <<= 1)
 
+#define POWER_ADDR_USER		0
+#define POWER_ADDR_KERNEL	1
+
 /*
  * Only override the default definitions in include/linux/perf_event.h
  * if we have hardware PMU support.
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index d106569..9c999b7 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -20,6 +20,7 @@
 #include <asm/firmware.h>
 #include <asm/ptrace.h>
 #include <asm/code-patching.h>
+#include <asm/cputable.h>
 
 #define BHRB_MAX_ENTRIES	32
 #define BHRB_TARGET		0x0000000000000002
@@ -474,10 +475,10 @@ static bool check_instruction(unsigned int *addr, u64 sw_filter)
  * Access the instruction contained in the address and then check
  * whether it complies with the applicable SW branch filters.
  */
-static bool keep_branch(u64 from, u64 sw_filter)
+static bool keep_branch(u64 from, u64 to, u64 sw_filter)
 {
 	unsigned int instr;
-	bool ret;
+	bool to_plm, ret, select_branch;
 
 	/*
 	 * The "from" branch for every branch record has to go
@@ -487,6 +488,37 @@ static bool keep_branch(u64 from, u64 sw_filter)
 	if (sw_filter == 0)
 		return true;
 
+	to_plm = is_kernel_addr(to) ? POWER_ADDR_KERNEL : POWER_ADDR_USER;
+
+	/*
+	 * XXX: Applying the privilege mode SW branch filters first on
+	 * the 'TO' address creates an AND semantic with other SW branch
+	 * filters which are ORed with each other being applied on the
+	 * 'FROM' address there after.
+	 */
+	if (sw_filter & PERF_SAMPLE_BRANCH_PLM_ALL) {
+		select_branch = false;
+
+		if (sw_filter & PERF_SAMPLE_BRANCH_USER) {
+			if (to_plm == POWER_ADDR_USER)
+				select_branch = true;
+		}
+
+		if (sw_filter & PERF_SAMPLE_BRANCH_KERNEL) {
+			if (to_plm == POWER_ADDR_KERNEL)
+				select_branch = true;
+		}
+
+		if (sw_filter & PERF_SAMPLE_BRANCH_HV) {
+			if (cpu_has_feature(CPU_FTR_HVMODE)
+				&& (to_plm == POWER_ADDR_KERNEL))
+					select_branch = true;
+		}
+
+		if (!select_branch)
+			return false;
+	}
+
 	if (is_kernel_addr(from)) {
 		return check_instruction((unsigned int *) from, sw_filter);
 	} else {
@@ -576,6 +608,7 @@ static void power_pmu_bhrb_read(struct cpu_hw_events *cpuhw)
 
 		/* Apply SW branch filters and drop the entry if required */
 		if (!keep_branch(cpuhw->bhrb_entries[u_index].from,
+					cpuhw->bhrb_entries[u_index].to,
 						cpuhw->bhrb_sw_filter))
 			u_index--;
 		u_index++;
diff --git a/arch/powerpc/perf/power8-pmu.c b/arch/powerpc/perf/power8-pmu.c
index 8fccf6c..b56afc6 100644
--- a/arch/powerpc/perf/power8-pmu.c
+++ b/arch/powerpc/perf/power8-pmu.c
@@ -670,9 +670,19 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filter)
 	 * filter configuration. BHRB is always recorded along with a
 	 * regular PMU event. As the privilege state filter is handled
 	 * in the basic PMC configuration of the accompanying regular
-	 * PMU event, we ignore any separate BHRB specific request.
+	 * PMU event, we ignore any separate BHRB specific request. But
+	 * this needs to be communicated with the branch filter mask.
 	 */
 
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_USER)
+		*bhrb_filter |= PERF_SAMPLE_BRANCH_USER;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_KERNEL)
+		*bhrb_filter |= PERF_SAMPLE_BRANCH_KERNEL;
+
+	if (branch_sample_type & PERF_SAMPLE_BRANCH_HV)
+		*bhrb_filter |= PERF_SAMPLE_BRANCH_HV;
+
 	/* Ignore user, kernel, hv bits */
 	branch_sample_type &= ~PERF_SAMPLE_BRANCH_PLM_ALL;
 
@@ -700,7 +710,6 @@ static u64 power8_bhrb_filter_map(u64 branch_sample_type, u64 *bhrb_filter)
 			if (branch_sample_type) {
 				/* Multiple filters will be processed in SW */
 				pmu_bhrb_filter = 0;
-				*bhrb_filter = 0;
 				return pmu_bhrb_filter;
 			} else {
 				/* Individual filter will be processed in HW */
-- 
2.1.0
