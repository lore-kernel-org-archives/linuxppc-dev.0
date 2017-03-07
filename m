Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vctfS1c0MzDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 21:48:00 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27AhvoW117730
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 05:47:57 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2916rsbynt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 05:47:56 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 16:17:53 +0530
Received: from d28relay10.in.ibm.com (d28relay10.in.ibm.com [9.184.220.161])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 87F391258060
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 16:18:06 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27Akgiu11337888
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:16:42 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27AlmW1020280
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 16:17:50 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [RESEND PATCH 6/6] perf: powerpc: choose local entry point with
 kretprobes
Date: Tue,  7 Mar 2017 16:17:41 +0530
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <20170306220638.e7db155d44e14325c5c0174b@kernel.org>
 <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <df69909ec479d5ebc419026d7f6b33b02ceed8a7.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

perf now uses an offset from _text/_stext for kretprobes if the kernel
supports it, rather than the actual function name. As such, let's choose
the LEP for powerpc ABIv2 so as to ensure the probe gets hit. Do it only
if the kernel supports specifying offsets with kretprobes.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 1030a6e504bb..e93b3db25012 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -10,6 +10,7 @@
 #include "symbol.h"
 #include "map.h"
 #include "probe-event.h"
+#include "trace-event.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -79,11 +80,12 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
 	 * However, if the user specifies an offset, we fall back to using the
 	 * GEP since all userspace applications (objdump/readelf) show function
 	 * disassembly with offsets from the GEP.
-	 *
-	 * In addition, we shouldn't specify an offset for kretprobes.
 	 */
-	if (pev->point.offset || (!pev->uprobes && pev->point.retprobe) ||
-	    !map || !sym)
+	if (pev->point.offset || !map || !sym)
+		return;
+
+	/* For kretprobes, add an offset only if the kernel supports it */
+	if (!pev->uprobes && pev->point.retprobe && !kretprobe_offset_is_supported())
 		return;
 
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
-- 
2.11.1
