Return-Path: <BATV+cde3ad3f600696023d18+4943+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vcVTP1RP4zDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Mar 2017 06:38:49 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 26/35] trace/kprobes: Allow return probes with offsets and
 absolute addresses
Date: Mon,  6 Mar 2017 16:38:16 -0300
Message-Id: <20170306193825.24011-27-acme@kernel.org>
In-Reply-To: <20170306193825.24011-1-acme@kernel.org>
References: <20170306193825.24011-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

Since the kernel includes many non-global functions with same names, we
will need to use offsets from other symbols (typically _text/_stext) or
absolute addresses to place return probes on specific functions. Also,
the core register_kretprobe() API never forbid use of offsets or
absolute addresses with kretprobes.

Allow its use with the trace infrastructure. To distinguish kernels that
support this, update ftrace README to explicitly call this out.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 kernel/trace/trace.c        | 1 +
 kernel/trace/trace_kprobe.c | 8 --------
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f35109514a01..0ed834d6beb0 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4355,6 +4355,7 @@ static const char readme_msg[] =
 	"\t           -:[<group>/]<event>\n"
 #ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
+  "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
 #ifdef CONFIG_UPROBE_EVENTS
 	"\t    place: <path>:<offset>\n"
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index eadd96ef772f..18775ef182f8 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -680,10 +680,6 @@ static int create_trace_kprobe(int argc, char **argv)
 		return -EINVAL;
 	}
 	if (isdigit(argv[1][0])) {
-		if (is_return) {
-			pr_info("Return probe point must be a symbol.\n");
-			return -EINVAL;
-		}
 		/* an address specified */
 		ret = kstrtoul(&argv[1][0], 0, (unsigned long *)&addr);
 		if (ret) {
@@ -699,10 +695,6 @@ static int create_trace_kprobe(int argc, char **argv)
 			pr_info("Failed to parse symbol.\n");
 			return ret;
 		}
-		if (offset && is_return) {
-			pr_info("Return probe must be used without offset.\n");
-			return -EINVAL;
-		}
 	}
 	argc -= 2; argv += 2;
 
-- 
2.9.3
