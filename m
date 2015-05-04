Return-Path: <BATV+578e219acb784a2ea3b2+4271+infradead.org+acme@casper.srs.infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7B0E11A0DE1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 07:36:59 +1000 (AEST)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 06/21] perf probe ppc64le: Fixup function entry if using
 kallsyms lookup
Date: Mon,  4 May 2015 18:36:15 -0300
Message-Id: <1430775390-22523-7-git-send-email-acme@kernel.org>
In-Reply-To: <1430775390-22523-1-git-send-email-acme@kernel.org>
References: <1430775390-22523-1-git-send-email-acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

On powerpc ABIv2, if no debug-info is found and we use kallsyms, we need
to fixup the function entry to point to the local entry point. Use
offset of 8 since current toolchains always generate 2 instructions (8
bytes).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/92253021e77a104b23b615c8c23bf9501dfe60bf.1430217967.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/sym-handling.c | 15 +++++++++++++++
 tools/perf/util/probe-event.c               |  5 +++++
 tools/perf/util/probe-event.h               |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index a170060..bbc1a50 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -64,4 +64,19 @@ bool arch__prefers_symtab(void)
 {
 	return true;
 }
+
+#define PPC64LE_LEP_OFFSET	8
+
+void arch__fix_tev_from_maps(struct perf_probe_event *pev,
+			     struct probe_trace_event *tev, struct map *map)
+{
+	/*
+	 * ppc64 ABIv2 local entry point is currently always 2 instructions
+	 * (8 bytes) after the global entry point.
+	 */
+	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
+		tev->point.address += PPC64LE_LEP_OFFSET;
+		tev->point.offset += PPC64LE_LEP_OFFSET;
+	}
+}
 #endif
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 4dfb412..eb75a5e 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2447,6 +2447,10 @@ static int find_probe_functions(struct map *map, char *name)
 #define strdup_or_goto(str, label)	\
 	({ char *__p = strdup(str); if (!__p) goto label; __p; })
 
+void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+				struct probe_trace_event *tev __maybe_unused,
+				struct map *map __maybe_unused) { }
+
 /*
  * Find probe function addresses from map.
  * Return an error or the number of found probe_trace_event
@@ -2553,6 +2557,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 					strdup_or_goto(pev->args[i].type,
 							nomem_out);
 		}
+		arch__fix_tev_from_maps(pev, tev, map);
 	}
 
 out:
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 52bca4b..180f142 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -136,6 +136,8 @@ extern int show_available_vars(struct perf_probe_event *pevs, int npevs,
 extern int show_available_funcs(const char *module, struct strfilter *filter,
 				bool user);
 bool arch__prefers_symtab(void);
+void arch__fix_tev_from_maps(struct perf_probe_event *pev,
+			     struct probe_trace_event *tev, struct map *map);
 
 /* Maximum index number of event-name postfix */
 #define MAX_EVENT_INDEX	1024
-- 
2.1.0
