Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYYxT36JLzDqLm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 14:03:41 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5L3xqxb075969
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:39 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23my7xxj8c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jun 2016 00:03:38 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Mon, 20 Jun 2016 22:03:38 -0600
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Olsa <jolsa@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, <linux-kernel@vger.kernel.org>
Subject: [PATCH v20 04/20] perf, tools: Support CPU ID matching for Powerpc
Date: Mon, 20 Jun 2016 21:02:34 -0700
In-Reply-To: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1466481770-25290-1-git-send-email-sukadev@linux.vnet.ibm.com>
Message-Id: <1466481770-25290-5-git-send-email-sukadev@linux.vnet.ibm.com>
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
index f8ccee1..9aaa6f5 100644
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
2.5.3
