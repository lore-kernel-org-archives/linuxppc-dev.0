Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x1CHt0rqDzDr4D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jul 2017 13:27:38 +1000 (AEST)
Date: Mon, 3 Jul 2017 12:27:33 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Shuah
 Khan <shuah@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] selftests/ftrace: Add a test to probe module
 functions
Message-Id: <20170703122733.e0f7043415e495352c0a12a9@kernel.org>
In-Reply-To: <04c3a67eb5fe13b12725f7198ef9904f992a512a.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498742261.git.naveen.n.rao@linux.vnet.ibm.com>
 <04c3a67eb5fe13b12725f7198ef9904f992a512a.1498742262.git.naveen.n.rao@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 29 Jun 2017 19:05:37 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Add a kprobes test to ensure that we are able to add a probe on a
> module function using 'p <mod>:<func>' format, without having to
> specify a probe name.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  .../testing/selftests/ftrace/test.d/kprobe/probe_module.tc | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> new file mode 100644
> index 000000000000..ea7657041ba6
> --- /dev/null
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/probe_module.tc
> @@ -0,0 +1,14 @@
> +#!/bin/sh
> +# description: Kprobe dynamic event - probing module
> +
> +[ -f kprobe_events ] || exit_unsupported # this is configurable
> +
> +echo 0 > events/enable
> +echo > kprobe_events
> +export MOD=`lsmod | head -n 2 | tail -n 1 | cut -f1 -d" "`
> +export FUNC=`grep -m 1 ".* t .*\\[$MOD\\]" /proc/kallsyms | xargs | cut -f3 -d" "`
> +[ "x" != "x$MOD" -a "y" != "y$FUNC" ] || exit_untested

Could you also add below case?

echo p:probe_$MOD/$FUNC $MOD/$FUNC > kprobe_events 

This is for "new event with name on module" case, your one is for "new event without name on module (automatic name generation)"

We should have different test case, because those kicks slightly different parts in kprobe tracer.

Thank you,

> +echo p $MOD:$FUNC > kprobe_events
> +grep $MOD kprobe_events
> +echo > kprobe_events
> +clear_trace
> -- 
> 2.13.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
