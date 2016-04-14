Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlsKh29LBzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 17:11:36 +1000 (AEST)
Message-ID: <1460617895.2754.8.camel@ellerman.id.au>
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>,
 Ingo Molnar <mingo@redhat.com>
Date: Thu, 14 Apr 2016 17:11:35 +1000
In-Reply-To: <1459480972-20238-1-git-send-email-bauerman@linux.vnet.ibm.com>
References: <1459480972-20238-1-git-send-email-bauerman@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-04-01 at 00:22 -0300, Thiago Jung Bauermann wrote:

> In the ppc64 big endian ABI, function symbols point to function
> descriptors. The symbols which point to the function entry points
> have a dot in front of the function name. Consequently, when the
> ftrace filter mechanism searches for the symbol corresponding to
> an entry point address, it gets the dot symbol.
> 
> As a result, ftrace filter users have to be aware of this ABI detail on
> ppc64 and prepend a dot to the function name when setting the filter.
> 
> The perf probe command insulates the user from this by ignoring the dot
> in front of the symbol name when matching function names to symbols,
> but the sysfs interface does not. This patch makes the ftrace filter
> mechanism do the same when searching symbols.
> 
> Fixes the following failure in ftracetest's kprobe_ftrace.tc:
> 
>   .../kprobe_ftrace.tc: line 9: echo: write error: Invalid argument
> 
> That failure is on this line of kprobe_ftrace.tc:
> 
>   echo _do_fork > set_ftrace_filter
> 
> This is because there's no _do_fork entry in the functions list:
> 
>   # cat available_filter_functions | grep _do_fork
>   ._do_fork
> 
> This change introduces no regressions on the perf and ftracetest
> testsuite results.
> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/ftrace.h |  9 +++++++++
>  kernel/trace/ftrace.c             | 13 +++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> index 50ca7585abe2..68f1858796c6 100644
> --- a/arch/powerpc/include/asm/ftrace.h
> +++ b/arch/powerpc/include/asm/ftrace.h
> @@ -58,6 +58,15 @@ struct dyn_arch_ftrace {
>  	struct module *mod;
>  };
>  #endif /*  CONFIG_DYNAMIC_FTRACE */
> +
> +#if CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2)
> +#define ARCH_HAS_FTRACE_MATCH_ADJUST

I *think* the consenus these days is that we don't add ARCH_HAS #defines in
headers. Instead you should either:
 - add a CONFIG_HAVE_ARCH_FOO and use that
 - use the #define foo foo trick

The latter being that you do:

static inline void arch_ftrace_match_adjust(char **str, char *search)
{
	...
}
#define arch_ftrace_match_adjust arch_ftrace_match_adjust

And in ftrace.c:

#ifndef arch_ftrace_match_adjust
static inline void arch_ftrace_match_adjust(char **str, char *search) {}
#endif


Presumably Steve will have a preference for which style you use.

> +static inline void arch_ftrace_match_adjust(char **str, char *search)
> +{
> +	if ((*str)[0] == '.' && search[0] != '.')
> +		(*str)++;
> +}
> +#endif /* CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
>  #endif /* __ASSEMBLY__ */

It seems unfortunate that we need to introduce yet another mechanism to deal
with dot symbols. But I guess none of the existing mechanisms work, eg.
kprobe_lookup_name().


>  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index b1870fbd2b67..e806c2a3b7a8 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -3444,11 +3444,24 @@ struct ftrace_glob {
>  	int type;
>  };
>  
> +#ifndef ARCH_HAS_FTRACE_MATCH_ADJUST
> +/*
> + * If symbols in an architecture don't correspond exactly to the user-visible
> + * name of what they represent, it is possible to define this function to
> + * perform the necessary adjustments.
> +*/
> +static inline void arch_ftrace_match_adjust(char **str, char *search)
> +{
> +}
> +#endif
> +
>  static int ftrace_match(char *str, struct ftrace_glob *g)
>  {
>  	int matched = 0;
>  	int slen;
>  
> +	arch_ftrace_match_adjust(&str, g->search);

I think this would less magical if it didn't modify str directly, instead doing:

	str = arch_ftrace_match_adjust(str, g->search);

And arch_ftrace_match_adjust() would return the adjusted char *.

That would mean the generic version would need to return str rather than being
empty.

cheers
