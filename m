Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0131F1A0452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:33 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 03:26:31 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 7E31638C8052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:29 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7QTfF58523724
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:29 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7QSgM015693
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:29 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 18/19] perf, tools: Handle header line in mapfile
Date: Wed, 10 Jun 2015 00:25:22 -0700
Message-Id: <1433921123-25327-19-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1433921123-25327-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v2]
	All architectures may not use the "Family" to identify. So,
	assume first line is header.
---
 tools/perf/pmu-events/jevents.c | 9 +++++++--
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
1.8.3.1
