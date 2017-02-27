Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX6hC2K8XzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 03:32:59 +1100 (AEDT)
Date: Mon, 27 Feb 2017 11:32:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Arnaldo Carvalho de Melo <acme@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 3/5] trace/kprobes: allow return probes with offsets
 and absolute addresses
Message-ID: <20170227113252.05e9c0df@gandalf.local.home>
In-Reply-To: <183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
 <183e7ce2921a08c9c755ee9a5da3134febc6695b.1487770934.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 22 Feb 2017 19:23:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Since the kernel includes many non-global functions with same names, we
> will need to use offsets from other symbols (typically _text/_stext) or
> absolute addresses to place return probes on specific functions. Also,
> the core register_kretprobe() API never forbid use of offsets or
> absolute addresses with kretprobes.
> 
> Allow its use with the trace infrastructure. To distinguish kernels that
> support this, update ftrace README to explicitly call this out.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/trace/trace.c        | 1 +
>  kernel/trace/trace_kprobe.c | 8 --------
>  2 files changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d7449783987a..ababe56b3e8f 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4362,6 +4362,7 @@ static const char readme_msg[] =
>  	"\t           -:[<group>/]<event>\n"
>  #ifdef CONFIG_KPROBE_EVENT
>  	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
> +  "place (kretprobe): [<module>:]<symbol>[+<offset>]|<memaddr>\n"
>  #endif
>  #ifdef CONFIG_UPROBE_EVENT
>  	"\t    place: <path>:<offset>\n"
> diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
> index 7ad9e53ad174..2768cb60ebd7 100644
> --- a/kernel/trace/trace_kprobe.c
> +++ b/kernel/trace/trace_kprobe.c
> @@ -679,10 +679,6 @@ static int create_trace_kprobe(int argc, char **argv)
>  		return -EINVAL;
>  	}
>  	if (isdigit(argv[1][0])) {
> -		if (is_return) {
> -			pr_info("Return probe point must be a symbol.\n");
> -			return -EINVAL;
> -		}
>  		/* an address specified */
>  		ret = kstrtoul(&argv[1][0], 0, (unsigned long *)&addr);
>  		if (ret) {
> @@ -698,10 +694,6 @@ static int create_trace_kprobe(int argc, char **argv)
>  			pr_info("Failed to parse symbol.\n");
>  			return ret;
>  		}
> -		if (offset && is_return) {
> -			pr_info("Return probe must be used without offset.\n");
> -			return -EINVAL;
> -		}

I understand that your retprobes will now have an offset, but I'm
worried we are removing informative errors. For those archs that don't
allow an offset, will we still get the error telling users that offsets
are not allowed?

I don't want to lose informative error handling.

-- Steve


>  	}
>  	argc -= 2; argv += 2;
>  
