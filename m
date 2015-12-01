Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 70E111A09BC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 13:57:44 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 30 Nov 2015 21:57:42 -0500
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 4F5F16E8040
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:45:49 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tB12vdrx12648542
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Dec 2015 02:57:39 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tB12vcn1007117
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 21:57:39 -0500
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v19 15/19] perf, tools: Handle header line in mapfile
Date: Mon, 30 Nov 2015 18:57:10 -0800
Message-Id: <1448938635-29176-16-git-send-email-sukadev@linux.vnet.ibm.com>
In-Reply-To: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1448938635-29176-1-git-send-email-sukadev@linux.vnet.ibm.com>
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
index 8e6e813..b4e3f01 100644
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
1.8.3.1
