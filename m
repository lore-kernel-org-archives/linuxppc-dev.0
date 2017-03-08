Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vdRTy2q0WzDqYt
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 19:27:34 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2889JTw007388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 03:27:32 -0500
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 292audg6m9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Mar 2017 03:27:32 -0500
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Wed, 8 Mar 2017 18:27:28 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v288RIje32309432
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:27:26 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v288QrCI008212
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Mar 2017 19:26:53 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH v5 5/5] perf: powerpc: choose local entry point with kretprobes
Date: Wed,  8 Mar 2017 13:56:10 +0530
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
Message-Id: <7445b5334673ef5404ac1d12609bad4d73d2b567.1488961018.git.naveen.n.rao@linux.vnet.ibm.com>
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
 tools/perf/arch/powerpc/util/sym-handling.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 1030a6e504bb..39dbe512b9fc 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -10,6 +10,7 @@
 #include "symbol.h"
 #include "map.h"
 #include "probe-event.h"
+#include "probe-file.h"
 
 #ifdef HAVE_LIBELF_SUPPORT
 bool elf__needs_adjust_symbols(GElf_Ehdr ehdr)
@@ -79,13 +80,18 @@ void arch__fix_tev_from_maps(struct perf_probe_event *pev,
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
 
+	/* For kretprobes, add an offset only if the kernel supports it */
+	if (!pev->uprobes && pev->point.retprobe) {
+#ifdef HAVE_LIBELF_SUPPORT
+		if (!kretprobe_offset_is_supported())
+#endif
+			return;
+	}
+
 	lep_offset = PPC64_LOCAL_ENTRY_OFFSET(sym->arch_sym);
 
 	if (map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
-- 
2.11.1
