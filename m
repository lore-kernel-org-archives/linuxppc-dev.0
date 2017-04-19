Return-Path: <yao.jin@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7Dgq4CDbzDqCd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Apr 2017 17:50:31 +1000 (AEST)
From: Jin Yao <yao.jin@linux.intel.com>
To: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
 alexander.shishkin@linux.intel.com
Cc: Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
 yao.jin@intel.com, linuxppc-dev@lists.ozlabs.org,
 Jin Yao <yao.jin@linux.intel.com>
Subject: [PATCH v5 4/7] perf report: Refactor the branch info printing code
Date: Wed, 19 Apr 2017 23:48:11 +0800
Message-Id: <1492616894-3635-5-git-send-email-yao.jin@linux.intel.com>
In-Reply-To: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
References: <1492616894-3635-1-git-send-email-yao.jin@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The branch info such as predicted/cycles/... are printed at the
callchain entries.

For example: perf report --branch-history --no-children --stdio

    --1.07%--main div.c:39 (predicted:52.4% cycles:1 iterations:17)
              main div.c:44 (predicted:52.4% cycles:1)
              main div.c:42 (cycles:2)
              compute_flag div.c:28 (cycles:2)
              compute_flag div.c:27 (cycles:1)
              rand rand.c:28 (cycles:1)
              rand rand.c:28 (cycles:1)
              __random random.c:298 (cycles:1)
              __random random.c:297 (cycles:1)
              __random random.c:295 (cycles:1)
              __random random.c:295 (cycles:1)
              __random random.c:295 (cycles:1)

But the current code is difficult to maintain and extend. This patch
refactors the code for easy maintenance.

Change log
----------

v5: It's a new patch in v5 patch series.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
---
 tools/perf/util/callchain.c | 106 +++++++++++++++++++-------------------------
 1 file changed, 45 insertions(+), 61 deletions(-)

diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 2e5eff5..8cae8a6 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1105,83 +1105,67 @@ int callchain_branch_counts(struct callchain_root *root,
 						  cycles_count);
 }
 
+static int count_pri64_printf(int index, const char *str, u64 value,
+	char *bf, int bfsize)
+{
+	int printed;
+
+	printed = scnprintf(bf, bfsize,
+		"%s%s:%" PRId64 "",
+		(index) ? " " : " (", str, value);
+
+	return printed;
+}
+
+static int count_float_printf(int index, const char *str, float value,
+	char *bf, int bfsize)
+{
+	int printed;
+
+	printed = scnprintf(bf, bfsize,
+		"%s%s:%.1f%%",
+		(index) ? " " : " (", str, value);
+
+	return printed;
+}
+
 static int counts_str_build(char *bf, int bfsize,
 			     u64 branch_count, u64 predicted_count,
 			     u64 abort_count, u64 cycles_count,
 			     u64 iter_count, u64 samples_count)
 {
-	double predicted_percent = 0.0;
-	const char *null_str = "";
-	char iter_str[32];
-	char cycle_str[32];
-	char *istr, *cstr;
 	u64 cycles;
+	int printed = 0, i = 0;
 
 	if (branch_count == 0)
 		return scnprintf(bf, bfsize, " (calltrace)");
 
 	cycles = cycles_count / branch_count;
+	if (cycles)
+		printed += count_pri64_printf(i++, "cycles",
+				cycles,
+				bf + printed, bfsize - printed);
 
-	if (iter_count && samples_count) {
-		if (cycles > 0)
-			scnprintf(iter_str, sizeof(iter_str),
-				 " iterations:%" PRId64 "",
-				 iter_count / samples_count);
-		else
-			scnprintf(iter_str, sizeof(iter_str),
-				 "iterations:%" PRId64 "",
-				 iter_count / samples_count);
-		istr = iter_str;
-	} else
-		istr = (char *)null_str;
-
-	if (cycles > 0) {
-		scnprintf(cycle_str, sizeof(cycle_str),
-			  "cycles:%" PRId64 "", cycles);
-		cstr = cycle_str;
-	} else
-		cstr = (char *)null_str;
+	if (iter_count && samples_count)
+		printed += count_pri64_printf(i++, "iterations",
+				iter_count / samples_count,
+				bf + printed, bfsize - printed);
 
-	predicted_percent = predicted_count * 100.0 / branch_count;
+	if (predicted_count < branch_count)
+		printed += count_float_printf(i++, "predicted",
+				predicted_count * 100.0 / branch_count,
+				bf + printed, bfsize - printed);
 
-	if ((predicted_count == branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize, " (%s%s)", cstr, istr);
-		else
-			return scnprintf(bf, bfsize, "%s", (char *)null_str);
-	}
-
-	if ((predicted_count < branch_count) && (abort_count == 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%% %s%s)",
-				predicted_percent, cstr, istr);
-		else {
-			return scnprintf(bf, bfsize,
-				" (predicted:%.1f%%)",
-				predicted_percent);
-		}
-	}
-
-	if ((predicted_count == branch_count) && (abort_count > 0)) {
-		if ((cycles > 0) || (istr != (char *)null_str))
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 " %s%s)",
-				abort_count, cstr, istr);
-		else
-			return scnprintf(bf, bfsize,
-				" (abort:%" PRId64 ")",
-				abort_count);
-	}
+	if (abort_count)
+		printed += count_float_printf(i++, "abort",
+				abort_count * 100.0 / branch_count,
+				bf + printed, bfsize - printed);
 
-	if ((cycles > 0) || (istr != (char *)null_str))
-		return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 " %s%s)",
-			predicted_percent, abort_count, cstr, istr);
+	if (i)
+		return scnprintf(bf + printed, bfsize - printed, ")");
 
-	return scnprintf(bf, bfsize,
-			" (predicted:%.1f%% abort:%" PRId64 ")",
-			predicted_percent, abort_count);
+	bf[0] = 0;
+	return 0;
 }
 
 static int callchain_counts_printf(FILE *fp, char *bf, int bfsize,
-- 
2.7.4
