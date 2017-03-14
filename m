Return-Path: <BATV+964c741336aa85246944+4951+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjP270lFdzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 05:50:39 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 17/19] perf powerpc: Choose local entry point with kretprobes
Date: Tue, 14 Mar 2017 15:50:21 -0300
Message-Id: <20170314185023.31303-18-acme@kernel.org>
In-Reply-To: <20170314185023.31303-1-acme@kernel.org>
References: <20170314185023.31303-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

perf now uses an offset from _text/_stext for kretprobes if the kernel
supports it, rather than the actual function name. As such, let's choose
the LEP for powerpc ABIv2 so as to ensure the probe gets hit. Do it only
if the kernel supports specifying offsets with kretprobes.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/7445b5334673ef5404ac1d12609bad4d73d2b567.1488961018.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.9.3
