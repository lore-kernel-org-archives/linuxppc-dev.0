Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd2gw3S29zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 03:49:48 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v27GiLBw190423
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 11:49:37 -0500
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2920499vph-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Mar 2017 11:49:36 -0500
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 7 Mar 2017 22:19:33 +0530
Received: from d28av07.in.ibm.com (d28av07.in.ibm.com [9.184.220.146])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v27GnU3041877698
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 22:19:30 +0530
Received: from d28av07.in.ibm.com (localhost [127.0.0.1])
 by d28av07.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v27GnTp3015016
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 7 Mar 2017 22:19:30 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v2 6/6] perf: powerpc: choose local entry point with kretprobes
Date: Tue,  7 Mar 2017 22:19:24 +0530
In-Reply-To: <df69909ec479d5ebc419026d7f6b33b02ceed8a7.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <df69909ec479d5ebc419026d7f6b33b02ceed8a7.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <20170307164924.20170-1-naveen.n.rao@linux.vnet.ibm.com>
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

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Changes:
- updated to address build issues due to dropping patch 5/6.

 tools/perf/arch/powerpc/util/sym-handling.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 1030a6e504bb..b8cbefc49aca 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -10,6 +10,7 @@
 #include "symbol.h"
 #include "map.h"
 #include "probe-event.h"
+#include "probe-file.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -79,11 +80,16 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
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
+	if (!pev->uprobes && pev->point.retprobe
+#ifdef HAVE_LIBELF_SUPPORT
+			&& !kretprobe_offset_is_supported()
+#endif
+			)
 		return;
 
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
-- 
2.11.1
