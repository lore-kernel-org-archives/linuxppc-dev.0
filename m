Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtbs160hLzDr1T
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 19:29:57 +1000 (AEST)
Date: Thu, 22 Jun 2017 18:29:53 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/2] trace/kprobes: Sanitize derived event names
Message-Id: <20170622182953.e1959ce03145b8bb45ec55de@kernel.org>
In-Reply-To: <22e10dfa9457c28e0ffeaec3a4a7161ef23196fa.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
 <22e10dfa9457c28e0ffeaec3a4a7161ef23196fa.1498070485.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 22 Jun 2017 00:20:27 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> When we derive event names, convert some expected symbols (such as ':'
> used to specify module:name and '.' present in some symbols) into
> underscores so that the event name is not rejected.

Oops, ok, this is my mistake.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

This must be marked as bugfix for stable trees.

Could you also add a testcase for this (module name) bug?

MODNAME=`lsmod | head -n 2 | tail -n 1 | cut -f 1 -d " "`
FUNCNAME=`grep -m 1 "\\[$MODNAME\\]" /proc/kallsyms | xargs | cut -f 3 -d " "`

May gives you a target name :)

Thank you,

> 
> Before this patch:
>     # echo 'p kobject_example:foo_store' > kprobe_events
>     trace_kprobe: Failed to allocate trace_probe.(-22)
>     -sh: write error: Invalid argument
> 
> After this patch:
>     # echo 'p kobject_example:foo_store' > kprobe_events
>     # cat kprobe_events
>     p:kprobes/p_kobject_example_foo_store_0 kobject_example:foo_store
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/trace/trace_kprobe.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index c129fca6ec99..44fd819aa33d 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -598,6 +598,14 @@ static struct notifier_block trace_kprobe_module_nb = {
>  	.priority = 1	/* Invoked after kprobe module callback */
>  };
>  
> +/* Convert certain expected symbols into '_' when generating event names */
> +static inline void sanitize_event_name(char *name)
> +{
> +	while (*name++ != '\0')
> +		if (*name == ':' || *name == '.')
> +			*name = '_';
> +}
> +
>  static int create_trace_kprobe(int argc, char **argv)
>  {
>  	/*
> @@ -740,6 +748,7 @@ static int create_trace_kprobe(int argc, char **argv)
>  		else
>  			snprintf(buf, MAX_EVENT_NAME_LEN, "%c_0x%p",
>  				 is_return ? 'r' : 'p', addr);
> +		sanitize_event_name(buf);
>  		event = buf;
>  	}
>  	tk = alloc_trace_kprobe(group, event, addr, symbol, offset, maxactive,
> -- 
> 2.13.1
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
