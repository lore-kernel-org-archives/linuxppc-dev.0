Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5232D1A0912
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 22:06:26 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 28 Apr 2015 17:36:24 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 01E561258064
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:38:22 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3SC6ARM25493606
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:10 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3SC68LV004121
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Apr 2015 17:36:09 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: acme@kernel.org
Subject: [PATCH v3 7/7] perf probe/ppc64le: Fixup function entry if using
 kallsyms lookup
Date: Tue, 28 Apr 2015 17:35:40 +0530
Message-Id: <92253021e77a104b23b615c8c23bf9501dfe60bf.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430217967.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, masami.hiramatsu.pt@hitachi.com,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 srikar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On powerpc ABIv2, if no debug-info is found and we use kallsyms, we need
to fixup the function entry to point to the local entry point. Use
offset of 8 since current toolchains always generate 2 instructions (8
bytes).

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changes:
- No changes other than move to use __weak functions

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
index 5e62a07..afbb346 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2467,6 +2467,10 @@ static int find_probe_functions(struct map *map, char *name)
 #define strdup_or_goto(str, label)	\
 	({ char *__p = strdup(str); if (!__p) goto label; __p; })
 
+void __weak arch__fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+				struct probe_trace_event *tev __maybe_unused,
+				struct map *map __maybe_unused) { }
+
 /*
  * Find probe function addresses from map.
  * Return an error or the number of found probe_trace_event
@@ -2573,6 +2577,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
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
2.3.5
