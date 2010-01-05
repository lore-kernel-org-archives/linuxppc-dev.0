Return-Path: <mhiramat@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 9F167B6EEE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 09:42:26 +1100 (EST)
From: Masami Hiramatsu <mhiramat@redhat.com>
Subject: [PATCH -tip 2/8] tracing/kprobe: Drop function argument access syntax
To: Ingo Molnar <mingo@elte.hu>, lkml<linux-kernel@vger.kernel.org>
Date: Tue, 05 Jan 2010 17:46:48 -0500
Message-ID: <20100105224648.19431.52309.stgit@dhcp-100-2-132.bos.redhat.com>
In-Reply-To: <20100105224634.19431.3259.stgit@dhcp-100-2-132.bos.redhat.com>
References: <20100105224634.19431.3259.stgit@dhcp-100-2-132.bos.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: DLE <dle-develop@lists.sourceforge.net>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	Oleg Nesterov <oleg@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
	systemtap <systemtap@sources.redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Roland McGrath <roland@redhat.com>,
	Masami Hiramatsu <mhiramat@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop function argument access syntax, because the function arguments
are depends on not only architecture but also compile-options and
function API. And now, we have perf-probe for finding register/memory
assigned to each argument.

Signed-off-by: Masami Hiramatsu <mhiramat@redhat.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@ozlabs.org
---

 Documentation/trace/kprobetrace.txt |   21 ++++++++++-----------
 kernel/trace/trace_kprobe.c         |   18 +-----------------
 2 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kprobetrace.txt
index c3eff6f..f30978e 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -37,15 +37,12 @@ Synopsis of kprobe_events
   @SYM[+|-offs]	: Fetch memory at SYM +|- offs (SYM should be a data symbol)
   $stackN	: Fetch Nth entry of stack (N >= 0)
   $stack	: Fetch stack address.
-  $argN		: Fetch function argument. (N >= 0)(*)
-  $retval	: Fetch return value.(**)
-  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(***)
+  $retval	: Fetch return value.(*)
+  +|-offs(FETCHARG) : Fetch memory at FETCHARG +|- offs address.(**)
   NAME=FETCHARG: Set NAME as the argument name of FETCHARG.
 
-  (*) aN may not correct on asmlinkaged functions and at the middle of
-      function body.
-  (**) only for return probe.
-  (***) this is useful for fetching a field of data structures.
+  (*) only for return probe.
+  (**) this is useful for fetching a field of data structures.
 
 
 Per-Probe Event Filtering
@@ -82,11 +79,14 @@ Usage examples
 To add a probe as a new event, write a new definition to kprobe_events
 as below.
 
-  echo p:myprobe do_sys_open dfd=$arg0 filename=$arg1 flags=$arg2 mode=$arg3 > /sys/kernel/debug/tracing/kprobe_events
+  echo p:myprobe do_sys_open dfd=%ax filename=%dx flags=%cx mode=+4($stack) > /sys/kernel/debug/tracing/kprobe_events
 
  This sets a kprobe on the top of do_sys_open() function with recording
-1st to 4th arguments as "myprobe" event. As this example shows, users can
-choose more familiar names for each arguments.
+1st to 4th arguments as "myprobe" event. Note, which register/stack entry is
+assigned to each function argument depends on arch-specific ABI. If you unsure
+the ABI, please try to use probe subcommand of perf-tools (you can find it
+under tools/perf/).
+As this example shows, users can choose more familiar names for each arguments.
 
   echo r:myretprobe do_sys_open $retval >> /sys/kernel/debug/tracing/kprobe_events
 
@@ -147,4 +147,3 @@ events, you need to enable it.
 returns from SYMBOL(e.g. "sys_open+0x1b/0x1d <- do_sys_open" means kernel
 returns from do_sys_open to sys_open+0x1b).
 
-
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47f54ab..7ac728d 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -91,11 +91,6 @@ static __kprobes unsigned long fetch_memory(struct pt_regs *regs, void *addr)
 	return retval;
 }
 
-static __kprobes unsigned long fetch_argument(struct pt_regs *regs, void *num)
-{
-	return regs_get_argument_nth(regs, (unsigned int)((unsigned long)num));
-}
-
 static __kprobes unsigned long fetch_retvalue(struct pt_regs *regs,
 					      void *dummy)
 {
@@ -231,9 +226,7 @@ static int probe_arg_string(char *buf, size_t n, struct fetch_func *ff)
 {
 	int ret = -EINVAL;
 
-	if (ff->func == fetch_argument)
-		ret = snprintf(buf, n, "$arg%lu", (unsigned long)ff->data);
-	else if (ff->func == fetch_register) {
+	if (ff->func == fetch_register) {
 		const char *name;
 		name = regs_query_register_name((unsigned int)((long)ff->data));
 		ret = snprintf(buf, n, "%%%s", name);
@@ -489,14 +482,6 @@ static int parse_probe_vars(char *arg, struct fetch_func *ff, int is_return)
 			}
 		} else
 			ret = -EINVAL;
-	} else if (strncmp(arg, "arg", 3) == 0 && isdigit(arg[3])) {
-		ret = strict_strtoul(arg + 3, 10, &param);
-		if (ret || param > PARAM_MAX_ARGS)
-			ret = -EINVAL;
-		else {
-			ff->func = fetch_argument;
-			ff->data = (void *)param;
-		}
 	} else
 		ret = -EINVAL;
 	return ret;
@@ -611,7 +596,6 @@ static int create_trace_probe(int argc, char **argv)
 	 *  - Add kprobe: p[:[GRP/]EVENT] KSYM[+OFFS]|KADDR [FETCHARGS]
 	 *  - Add kretprobe: r[:[GRP/]EVENT] KSYM[+0] [FETCHARGS]
 	 * Fetch args:
-	 *  $argN	: fetch Nth of function argument. (N:0-)
 	 *  $retval	: fetch return value
 	 *  $stack	: fetch stack address
 	 *  $stackN	: fetch Nth of stack (N:0-)


-- 
Masami Hiramatsu

Software Engineer
Hitachi Computer Products (America), Inc.
Software Solutions Division

e-mail: mhiramat@redhat.com
