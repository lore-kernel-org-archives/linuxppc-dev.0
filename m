Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 132681A05D3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:17 +1100 (AEDT)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Tue, 16 Dec 2014 00:51:16 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 61E9D2BB0065
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:14 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sBFEpEl612910782
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:14 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sBFEpD4N004796
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Dec 2014 01:51:14 +1100
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mpe@ellerman.id.au
Subject: [PATCHv2 8/8] perf probe powerpc: Fixup function entry if using
 kallsyms lookup
Date: Mon, 15 Dec 2014 20:20:38 +0530
Message-Id: <e27b74c5d94b240cb72ce0c7d6221acf758ebc8a.1418654436.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1418654435.git.naveen.n.rao@linux.vnet.ibm.com>
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
---
Changes:
Generalize and introduce helper to post-process trace point.

 tools/perf/arch/powerpc/util/sym-handling.c | 17 +++++++++++++++++
 tools/perf/util/probe-event.c               |  1 +
 tools/perf/util/probe-event.h               | 10 ++++++++++
 3 files changed, 28 insertions(+)

diff --git a/tools/perf/arch/powerpc/util/sym-handling.c b/tools/perf/arch/powerpc/util/sym-handling.c
index 22fc2e6..30c8797 100644
--- a/tools/perf/arch/powerpc/util/sym-handling.c
+++ b/tools/perf/arch/powerpc/util/sym-handling.c
@@ -45,3 +45,20 @@ inline bool prefer_symtab(void)
 	return false;
 #endif
 }
+
+void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+			    struct probe_trace_event *tev __maybe_unused,
+			    struct map *map __maybe_unused)
+{
+#if defined(_CALL_ELF) && _CALL_ELF == 2
+	/*
+	 * If we used kallsyms, we should fixup the function entry address here.
+	 * ppc64 ABIv2 local entry point is currently always 2 instructions (8 bytes)
+	 * after the global entry point. Fix this if it ever changes.
+	 */
+	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS) {
+		tev->point.address += 8;
+		tev->point.offset += 8;
+	}
+#endif
+}
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index dfc3151..85f37a4 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -2340,6 +2340,7 @@ static int find_probe_trace_events_from_map(struct perf_probe_event *pev,
 					strdup_or_goto(pev->args[i].type,
 							nomem_out);
 		}
+		arch_fix_tev_from_maps(pev, tev, map);
 	}
 
 out:
diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
index 5f92906..335a6a4 100644
--- a/tools/perf/util/probe-event.h
+++ b/tools/perf/util/probe-event.h
@@ -147,6 +147,16 @@ extern bool prefer_symtab(void);
 static inline bool prefer_symtab(void) { return false; };
 #endif
 
+#ifdef HAVE_ARCH_SYMBOL_HANDLING
+extern void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+				   struct probe_trace_event *tev __maybe_unused,
+				   struct map *map __maybe_unused);
+#else
+static inline void arch_fix_tev_from_maps(struct perf_probe_event *pev __maybe_unused,
+					  struct probe_trace_event *tev __maybe_unused,
+					  struct map *map __maybe_unused) { }
+#endif
+
 /* Maximum index number of event-name postfix */
 #define MAX_EVENT_INDEX	1024
 
-- 
2.1.3
