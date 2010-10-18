Return-Path: <rostedt@goodmis.org>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.122]) by ozlabs.org (Postfix) with ESMTP id 641DFB7112
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Oct 2010 01:31:16 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.51])
	by hrndva-qmta04.mail.rr.com with ESMTP
	id <20101018142614024.ZFSR23474@hrndva-qmta04.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Oct 2010 14:26:14 +0000
Subject: Re: BUG: dead loop in PowerPC hcall tracepoint (Was: [LTP] [PATCH
	v2] Add ftrace-stress-test to LTP)
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Zefan <lizf@cn.fujitsu.com>
In-Reply-To: <4CBBBCB0.8070406@cn.fujitsu.com>
References: <4C85A88D.10700@cn.fujitsu.com>
	<1285689961.11429.12.camel@subratamodak.linux.ibm.com>
	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>
	<4CB55FE6.6000604@cn.fujitsu.com> <4CB5615C.4070406@cn.fujitsu.com>
	<4CB59825.7060504@cn.fujitsu.com>
	<1286995066.4893.17.camel@subratamodak.linux.ibm.com>
	<4CBBBCB0.8070406@cn.fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-15"
Date: Mon, 18 Oct 2010 10:25:03 -0400
Message-ID: <1287411903.16971.275.camel@gandalf.stny.rr.com>
Mime-Version: 1.0
Cc: ltp-list@lists.sourceforge.net, Peter Zijlstra <peterz@infradead.org>,
	linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, Ingo Molnar <mingo@elte.hu>,
	subrata@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-10-18 at 11:19 +0800, Li Zefan wrote:

> This is a dead loop:
> 
> trace_hcall_entry() -> trace_clock_global() -> trace_hcall_entry() ..
> 
> And this is a PPC specific bug. Hope some ppc guys will fix it?
> Or we kill trace_clock_global() if no one actually uses it..

trace_clock_global() is used by many. I use it (and recommend using it)
on boxes where the TSC is horribly out of sync, and the trace needs
synchronization between CPUs.

The trace_hcall_entry and exit has wrappers already. Just add recursion
protection there.

Perhaps something like this:

(Not compiled nor ran)

+static DEFINE_PER_CPU(hcall_trace_disable);
+
 void hcall_tracepoint_regfunc(void)
 {
 	hcall_tracepoint_refcount++;
 }

 void hcall_tracepoint_unregfunc(void)
 {
 	hcall_tracepoint_refcount--;
 }

+int __trace_disable_check(void)
+{
+	if (!hcall_tracepoint_refcount)
+		return 1;
+
+	if (get_cpu_var(hcall_trace_disable)) {
+		put_cpu_var(hcall_trace_disable);
+		return 1;
+	}
+
+	__get_cpu_var(hcall_trace_disable)++;
+
+	return 0;
+}
+
+void __trace_disable_put(void)
+{
+	__get_cpu_var(hcall_trace_disable)--;
+	put_cpu_var(hcall_trace_disable);
+}
+
 void __trace_hcall_entry(unsigned long opcode, unsigned long *args)
 {
+	int trace_disable;
+
+	if (__trace_disable_check())
+		return;
+
 	trace_hcall_entry(opcode, args);
+	__trace_disable_put();
 }

 void __trace_hcall_exit(long opcode, unsigned long retval,
 			unsigned long *retbuf)
 {
+	if (__trace_disable_check())
+		return;
+
 	trace_hcall_exit(opcode, retval, retbuf);
+	__trace_disable_put();
 }

-- Steve
