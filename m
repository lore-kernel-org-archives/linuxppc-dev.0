Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxr179dzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:03:59 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xnAe038106
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:58 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23mywwnsw0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:57 -0400
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:56 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 15/20] perf, tools: Handle header line in mapfile
Date: Mon, 20 Jun 2016 21:02:45 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-16-git-send-email-sukadev@linux.vnet.ibm.com>
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
index a4f117c..b701d77 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -463,7 +463,12 @@ static int process_mapfile(FILE *outfp, char *fpath)
 
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
 
@@ -507,8 +512,8 @@ static int process_mapfile(FILE *outfp, char *fpath)
 		fprintf(outfp, "},\n");
 	}
 
+out:
 	print_mapping_table_suffix(outfp);
-
 	return 0;
 }
 
-- 
2.5.3
