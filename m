Return-Path: <dev@codyps.com>
Received: from mail-yh0-x229.google.com (mail-yh0-x229.google.com
 [IPv6:2607:f8b0:4002:c01::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D73861A05A6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 May 2014 10:27:10 +1000 (EST)
Received: by mail-yh0-f41.google.com with SMTP id f73so8240035yha.28
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 17:27:07 -0700 (PDT)
From: Cody P Schafer <dev@codyps.com>
To: LKML <linux-kernel@vger.kernel.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Adrian Hunter <adrian.hunter@intel.com>, Andi Kleen <ak@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Cody P Schafer <dev@codyps.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Stephane Eranian <eranian@google.com>
Subject: [PATCH 06/16] tools/perf: annotate list_head with type info
Date: Tue, 27 May 2014 17:22:01 -0700
Message-Id: <1401236684-10579-7-git-send-email-dev@codyps.com>
In-Reply-To: <1401236684-10579-1-git-send-email-dev@codyps.com>
References: <1401236684-10579-1-git-send-email-dev@codyps.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

CC: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Signed-off-by: Cody P Schafer <dev@codyps.com>
---
 tools/perf/util/pmu.c | 4 ++--
 tools/perf/util/pmu.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 00a7dcb..906ae40 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -14,8 +14,8 @@
 
 struct perf_pmu_alias {
 	char *name;
-	struct list_head terms;
-	struct list_head list;
+	struct list_head terms; /* HEAD struct parse_events_term -> list */
+	struct list_head list;  /* ELEM */
 	char unit[UNIT_MAX_LEN+1];
 	double scale;
 };
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 8b64125..4a85230 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -17,9 +17,9 @@ struct perf_pmu {
 	char *name;
 	__u32 type;
 	struct cpu_map *cpus;
-	struct list_head format;
-	struct list_head aliases;
-	struct list_head list;
+	struct list_head format;  /* HEAD struct perf_pmu_format -> list */
+	struct list_head aliases; /* HEAD struct perf_pmu_alias -> list */
+	struct list_head list;    /* ELEM */
 };
 
 struct perf_pmu *perf_pmu__find(const char *name);
-- 
1.9.3
