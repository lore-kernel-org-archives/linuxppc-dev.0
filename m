Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6FE291A091D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:28:13 +1000 (AEST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Fri, 5 Jun 2015 00:28:11 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A927819D803F
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 00:19:10 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t556Pr0A26411138
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 23:25:53 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556S8FA007907
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 00:28:08 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, linuxppc-dev@lists.ozlabs.org,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH v14 06/19] perf, tools: Support CPU ID matching for Powerpc
Date: Thu,  4 Jun 2015 23:27:14 -0700
Message-Id: <1433485647-9314-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

Implement code that returns the generic CPU ID string for Powerpc.
This will be used to identify the specific table of PMU events to
parse/compare user specified events against.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>

Changelog[v14]
	- [Jiri Olsa] Move this independent code off into a separate patch.
---
 tools/perf/arch/powerpc/util/header.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/header.c b/tools/perf/arch/powerpc/util/header.c
index 6c1b8a7..65f9391 100644
--- a/tools/perf/arch/powerpc/util/header.c
+++ b/tools/perf/arch/powerpc/util/header.c
@@ -32,3 +32,14 @@ get_cpuid(char *buffer, size_t sz)
 	}
 	return -1;
 }
+
+char *
+get_cpuid_str(void)
+{
+	char *bufp;
+
+	if (asprintf(&bufp, "%.8lx", mfspr(SPRN_PVR)) < 0)
+		bufp = NULL;
+
+	return bufp;
+}
-- 
1.7.9.5
