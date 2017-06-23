Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wvQT826lXzDqjf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Jun 2017 03:30:36 +1000 (AEST)
Date: Sat, 24 Jun 2017 02:30:31 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] trace/kprobes: Sanitize derived event names
Message-Id: <20170624023031.8eade91e3510c8208050137f@kernel.org>
In-Reply-To: <20170622190345.6444-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170622182953.e1959ce03145b8bb45ec55de@kernel.org>
 <20170622190345.6444-1-naveen.n.rao@linux.vnet.ibm.com>
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

On Fri, 23 Jun 2017 00:33:45 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> On 2017/06/22 06:29PM, Masami Hiramatsu wrote:
> > On Thu, 22 Jun 2017 00:20:27 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > When we derive event names, convert some expected symbols (such as ':'
> > > used to specify module:name and '.' present in some symbols) into
> > > underscores so that the event name is not rejected.
> > 
> > Oops, ok, this is my mistake.
> > 
> > Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
> > 
> > This must be marked as bugfix for stable trees.
> > 
> > Could you also add a testcase for this (module name) bug?
> > 
> > MODNAME=`lsmod | head -n 2 | tail -n 1 | cut -f 1 -d " "`
> > FUNCNAME=`grep -m 1 "\\[$MODNAME\\]" /proc/kallsyms | xargs | cut -f 3 -d " "`
> > 
> > May gives you a target name :)
> 
> Sure. Here is a test.
> 
> Thanks for the review,
> Naveen
> 
> -
> [PATCH] selftests/ftrace: Add a test to probe module functions
> 
> Add a kprobes test to ensure that we are able to add a probe on a
> module function using 'p <mod>:<func>' format, without having to
> specify a probe name.
> 
> Suggested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Perfect! :)

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks!

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
> +echo p $MOD:$FUNC > kprobe_events
> +grep $MOD kprobe_events
> +echo > kprobe_events
> +clear_trace
> -- 
> 2.13.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
