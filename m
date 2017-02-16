Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vP8FH10t4zDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:58 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1G8It2O061048
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 03:18:56 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 28n87p8k8f-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 03:18:56 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 16 Feb 2017 18:18:48 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id B3BFA2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:46 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1G8IcJg12582938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:46 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1G8IDFa005939
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Feb 2017 19:18:14 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Cc: Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 2/2] perf: powerpc: choose LEP with kretprobes
Date: Thu, 16 Feb 2017 13:47:39 +0530
In-Reply-To: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
References: <dbb93084a6bc96d44cf7436ab6d5f9c8c72b6a39.1487181941.git.naveen.n.rao@linux.vnet.ibm.com>
 <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <151bc1f382d804c8f776caa891b34ffa029b98d9.1487232416.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf now uses an offset from _text/_stext for kretprobes, rather than
the actual function name. As such, let's choose the LEP for powerpc
ABIv2 so as to ensure the probe gets hit.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 1030a6e504bb..9fe0f20aa56f 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -79,11 +79,8 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 	 * However, if the user specifies an offset, we fall back to using the
 	 * GEP since all userspace applications (objdump/readelf) show function
 	 * disassembly with offsets from the GEP.
-	 *
-	 * In addition, we shouldn't specify an offset for kretprobes.
 	 */
-	if (pev->point.offset || (!pev->uprobes && pev->point.retprobe) ||
-	    !map || !sym)
+	if (pev->point.offset || !map || !sym)
 		return;
 
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
-- 
2.11.0
