Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0C7F51A09BB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:19 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:18 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 12B3A19D803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:19:17 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556Q09627000840
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:26:00 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556SE9W008347
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:15 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 18/19] perf, tools: Handle header line in mapfile
Date: Thu,  4 Jun 2015 23:27:26 -0700
Message-Id: <1433485647-9314-19-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Andi Kleen <ak@linux.intel.com>

To work with existing mapfiles, assume that the first line in
'mapfile.csv' is a header line and skip over it.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v2]
	All architectures may not use the "Family" to identify. So,
	assume first line is header.
---
 tools/perf/pmu-events/jevents.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index ea3474b..7347cca 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -462,7 +462,12 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
 	print_mapping_table_prefix(outfp);
 
-	line_num = 0;
+	/* Skip first line (header) */
+	p = fgets(line, n, mapfp);
+	if (!p)
+		goto out;
+
+	line_num = 1;
 	while (1) {
 		char *cpuid, *version, *type, *fname;
 
@@ -506,8 +511,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 		fprintf(outfp, "},\n");
 	}
 
+out:
 	print_mapping_table_suffix(outfp);
-
 	return 0;
 }
 
-- 
1.7.9.5
