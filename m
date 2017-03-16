Return-Path: <BATV+b78c826e793104f7805f+4953+infradead.org+acme@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [65.50.211.133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkYN76m3vzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 03:10:15 +1100 (AEDT)
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@lists.ozlabs.org,
 Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/6] trace/kprobes: Fix check for kretprobe offset within
 function entry
Date: Thu, 16 Mar 2017 13:09:58 -0300
Message-Id: <20170316161002.15445-3-acme@kernel.org>
In-Reply-To: <20170316161002.15445-1-acme@kernel.org>
References: <20170316161002.15445-1-acme@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>

perf specifies an offset from _text and since this offset is fed
directly into the arch-specific helper, kprobes tracer rejects
installation of kretprobes through perf. Fix this by looking up the
actual offset from a function for the specified sym+offset.

Refactor and reuse existing routines to limit code duplication -- we
repurpose kprobe_addr() for determining final kprobe address and we
split out the function entry offset determination into a separate
generic helper.

Before patch:

  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
  probe-definition(0): do_open%return
  symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /boot/vmlinux for symbols
  Open Debuginfo file: /boot/vmlinux
  Try to find probe point from debuginfo.
  Matched function: do_open [2d0c7ff]
  Probe point found: do_open+0
  Matched function: do_open [35d76dc]
  found inline addr: 0xc0000000004ba9c4
  Failed to find "do_open%return",
   because do_open is an inlined function and has no return point.
  An error occurred in debuginfo analysis (-22).
  Trying to use symbols.
  Opening /sys/kernel/debug/tracing//README write=0
  Opening /sys/kernel/debug/tracing//kprobe_events write=1
  Writing event: r:probe/do_open _text+4469776
  Failed to write event: Invalid argument
    Error: Failed to add events. Reason: Invalid argument (Code: -22)
  naveen@ubuntu:~/linux/tools/perf$ dmesg | tail
  <snip>
  [   33.568656] Given offset is not valid for return probe.

After patch:

  naveen@ubuntu:~/linux/tools/perf$ sudo ./perf probe -v do_open%return
  probe-definition(0): do_open%return
  symbol:do_open file:(null) line:0 offset:0 return:1 lazy:(null)
  0 arguments
  Looking at the vmlinux_path (8 entries long)
  Using /boot/vmlinux for symbols
  Open Debuginfo file: /boot/vmlinux
  Try to find probe point from debuginfo.
  Matched function: do_open [2d0c7d6]
  Probe point found: do_open+0
  Matched function: do_open [35d76b3]
  found inline addr: 0xc0000000004ba9e4
  Failed to find "do_open%return",
   because do_open is an inlined function and has no return point.
  An error occurred in debuginfo analysis (-22).
  Trying to use symbols.
  Opening /sys/kernel/debug/tracing//README write=0
  Opening /sys/kernel/debug/tracing//kprobe_events write=1
  Writing event: r:probe/do_open _text+4469808
  Writing event: r:probe/do_open_1 _text+4956344
  Added new events:
    probe:do_open        (on do_open%return)
    probe:do_open_1      (on do_open%return)

  You can now use it in all perf tools, such as:

	  perf record -e probe:do_open_1 -aR sleep 1

  naveen@ubuntu:~/linux/tools/perf$ sudo cat /sys/kernel/debug/kprobes/list
  c000000000041370  k  kretprobe_trampoline+0x0    [OPTIMIZED]
  c0000000004ba0b8  r  do_open+0x8    [DISABLED]
  c000000000443430  r  do_open+0x0    [DISABLED]

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: linuxppc-dev@lists.ozlabs.org
Link: http://lkml.kernel.org/r/d8cd1ef420ec22e3643ac332fdabcffc77319a42.1488961018.git.naveen.n.rao@linux.vnet.ibm.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 include/linux/kprobes.h     |  1 +
 kernel/kprobes.c            | 40 ++++++++++++++++++++++++++--------------
 kernel/trace/trace_kprobe.c |  2 +-
 3 files changed, 28 insertions(+), 15 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 177bdf6c6aeb..47e4da5b4fa2 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -268,6 +268,7 @@ extern void show_registers(struct pt_regs *regs);
 extern void kprobes_inc_nmissed_count(struct kprobe *p);
 extern bool arch_within_kprobe_blacklist(unsigned long addr);
 extern bool arch_function_offset_within_entry(unsigned long offset);
+extern bool function_offset_within_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset);
 
 extern bool within_kprobe_blacklist(unsigned long addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 4780ec236035..d733479a10ee 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1391,21 +1391,19 @@ bool within_kprobe_blacklist(unsigned long addr)
  * This returns encoded errors if it fails to look up symbol or invalid
  * combination of parameters.
  */
-static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
+static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
+			const char *symbol_name, unsigned int offset)
 {
-	kprobe_opcode_t *addr = p->addr;
-
-	if ((p->symbol_name && p->addr) ||
-	    (!p->symbol_name && !p->addr))
+	if ((symbol_name && addr) || (!symbol_name && !addr))
 		goto invalid;
 
-	if (p->symbol_name) {
-		kprobe_lookup_name(p->symbol_name, addr);
+	if (symbol_name) {
+		kprobe_lookup_name(symbol_name, addr);
 		if (!addr)
 			return ERR_PTR(-ENOENT);
 	}
 
-	addr = (kprobe_opcode_t *)(((char *)addr) + p->offset);
+	addr = (kprobe_opcode_t *)(((char *)addr) + offset);
 	if (addr)
 		return addr;
 
@@ -1413,6 +1411,11 @@ static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
 	return ERR_PTR(-EINVAL);
 }
 
+static kprobe_opcode_t *kprobe_addr(struct kprobe *p)
+{
+	return _kprobe_addr(p->addr, p->symbol_name, p->offset);
+}
+
 /* Check passed kprobe is valid and return kprobe in kprobe_table. */
 static struct kprobe *__get_valid_kprobe(struct kprobe *p)
 {
@@ -1881,19 +1884,28 @@ bool __weak arch_function_offset_within_entry(unsigned long offset)
 	return !offset;
 }
 
+bool function_offset_within_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
+{
+	kprobe_opcode_t *kp_addr = _kprobe_addr(addr, sym, offset);
+
+	if (IS_ERR(kp_addr))
+		return false;
+
+	if (!kallsyms_lookup_size_offset((unsigned long)kp_addr, NULL, &offset) ||
+						!arch_function_offset_within_entry(offset))
+		return false;
+
+	return true;
+}
+
 int register_kretprobe(struct kretprobe *rp)
 {
 	int ret = 0;
 	struct kretprobe_instance *inst;
 	int i;
 	void *addr;
-	unsigned long offset;
-
-	addr = kprobe_addr(&rp->kp);
-	if (!kallsyms_lookup_size_offset((unsigned long)addr, NULL, &offset))
-		return -EINVAL;
 
-	if (!arch_function_offset_within_entry(offset))
+	if (!function_offset_within_entry(rp->kp.addr, rp->kp.symbol_name, rp->kp.offset))
 		return -EINVAL;
 
 	if (kretprobe_blacklist_size) {
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 12fb540da0e5..013f4e7146d4 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -697,7 +697,7 @@ static int create_trace_kprobe(int argc, char **argv)
 			return ret;
 		}
 		if (offset && is_return &&
-		    !arch_function_offset_within_entry(offset)) {
+		    !function_offset_within_entry(NULL, symbol, offset)) {
 			pr_info("Given offset is not valid for return probe.\n");
 			return -EINVAL;
 		}
-- 
2.9.3
