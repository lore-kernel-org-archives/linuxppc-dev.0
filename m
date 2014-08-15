Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3824E1A1A34
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 17:26:35 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 15 Aug 2014 03:26:33 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 8F88FC9003E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 03:26:24 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s7F7QWdG36700250
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 07:26:32 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s7F7QUHQ027154
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Aug 2014 03:26:31 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, ak@linux.intel.com,
 Jiri Olsa <jolsa@redhat.com>, peterz@infradead.org, eranian@google.com
Subject: [PATCH v2 05/14] tools/perf: annotate list_head with type info
Date: Fri, 15 Aug 2014 00:26:14 -0700
Message-Id: <1408087583-32239-6-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1408087583-32239-1-git-send-email-sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, dev@codyps.com, linux-kernel@vger.kernel.org,
 Michael Ellerman <michaele@au1.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Cody P Schafer <dev@codyps.com>

CC: Haren Myneni <hbabu@us.ibm.com>
CC: Cody P Schafer <dev@codyps.com>
Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
---
 tools/perf/util/pmu.c | 4 ++--
 tools/perf/util/pmu.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7a811eb..9bf5827 100644
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
index c14a543..1c1e2ee 100644
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
1.8.3.1
