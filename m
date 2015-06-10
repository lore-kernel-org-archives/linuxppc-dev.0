Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AF6591A0E3F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 17:26:19 +1000 (AEST)
Received: from /spool/local
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 03:26:17 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id DAEC6C90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:17:20 -0400 (EDT)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A7QDVs54198380
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 07:26:13 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A7QD3N014181
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 03:26:13 -0400
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: namhyung@kernel.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v15 06/19] perf, tools: Support CPU ID matching for Powerpc
Date: Wed, 10 Jun 2015 00:25:10 -0700
Message-Id: <1433921123-25327-7-git-send-email-sukadev@linux.vnet.ibm.com>
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

Implement code that returns the generic CPU ID string for Powerpc.
This will be used to identify the specific table of PMU events to
parse/compare user specified events against.

Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
---

Changelog[v14]
	- [Jiri Olsa] Move this independent code off into a separate patch.
---
 tools/perf/arch/powerpc/util/header.c | 11 +++++++++++
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
1.8.3.1
