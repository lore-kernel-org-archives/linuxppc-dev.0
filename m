Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0178.hostedemail.com
 [216.40.44.178])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qlyMK2QSpzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 20:58:19 +1000 (AEST)
Date: Thu, 14 Apr 2016 06:58:05 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ingo Molnar
 <mingo@redhat.com>
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
Message-ID: <20160414065805.102dfd90@grimm.local.home>
In-Reply-To: <1460617895.2754.8.camel@ellerman.id.au>
References: <1459480972-20238-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1460617895.2754.8.camel@ellerman.id.au>
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

On Thu, 14 Apr 2016 17:11:35 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:
> > 
> > diff --git a/arch/powerpc/include/asm/ftrace.h b/arch/powerpc/include/asm/ftrace.h
> > index 50ca7585abe2..68f1858796c6 100644
> > --- a/arch/powerpc/include/asm/ftrace.h
> > +++ b/arch/powerpc/include/asm/ftrace.h
> > @@ -58,6 +58,15 @@ struct dyn_arch_ftrace {
> >  	struct module *mod;
> >  };
> >  #endif /*  CONFIG_DYNAMIC_FTRACE */
> > +
> > +#if CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2)
> > +#define ARCH_HAS_FTRACE_MATCH_ADJUST  
> 
> I *think* the consenus these days is that we don't add ARCH_HAS #defines in
> headers. Instead you should either:
>  - add a CONFIG_HAVE_ARCH_FOO and use that
>  - use the #define foo foo trick
> 
> The latter being that you do:
> 
> static inline void arch_ftrace_match_adjust(char **str, char *search)
> {
> 	...
> }
> #define arch_ftrace_match_adjust arch_ftrace_match_adjust
> 
> And in ftrace.c:
> 
> #ifndef arch_ftrace_match_adjust
> static inline void arch_ftrace_match_adjust(char **str, char *search) {}
> #endif
> 
> 
> Presumably Steve will have a preference for which style you use.

Actually, what I usually do is simply make a "weak" stub function and
let the arch override it.

> 
> > +static inline void arch_ftrace_match_adjust(char **str, char *search)
> > +{
> > +	if ((*str)[0] == '.' && search[0] != '.')
> > +		(*str)++;
> > +}
> > +#endif /* CONFIG_PPC64 && (!defined(_CALL_ELF) || _CALL_ELF != 2) */
> >  #endif /* __ASSEMBLY__ */  
> 
> It seems unfortunate that we need to introduce yet another mechanism to deal
> with dot symbols. But I guess none of the existing mechanisms work, eg.
> kprobe_lookup_name().

What about making a generic conversion to function name, like:

	arch_sane_function_name(str);

Where all sane archs simply return the string name and powerpc can
strip the '.' prefix. ;-)

Of course that would require:

	sane_str = arch_sane_function(str);
	sane_search = arch_sane_function(g->search);

	and then compare sane_str with sane_search.

> 
> 
> >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > index b1870fbd2b67..e806c2a3b7a8 100644
> > --- a/kernel/trace/ftrace.c
> > +++ b/kernel/trace/ftrace.c
> > @@ -3444,11 +3444,24 @@ struct ftrace_glob {
> >  	int type;
> >  };
> >  
> > +#ifndef ARCH_HAS_FTRACE_MATCH_ADJUST
> > +/*
> > + * If symbols in an architecture don't correspond exactly to the user-visible
> > + * name of what they represent, it is possible to define this function to
> > + * perform the necessary adjustments.
> > +*/
> > +static inline void arch_ftrace_match_adjust(char **str, char *search)
> > +{
> > +}
> > +#endif
> > +
> >  static int ftrace_match(char *str, struct ftrace_glob *g)
> >  {
> >  	int matched = 0;
> >  	int slen;
> >  
> > +	arch_ftrace_match_adjust(&str, g->search);  
> 
> I think this would less magical if it didn't modify str directly, instead doing:
> 
> 	str = arch_ftrace_match_adjust(str, g->search);
> 
> And arch_ftrace_match_adjust() would return the adjusted char *.
> 
> That would mean the generic version would need to return str rather than being
> empty.

I agree, because if we need to free the string passed it, the function
would modify the pointer and we wouldn't be able to free it. In those
cases we could do:

	tmp_str = arch_ftrace_match_adjust(str, search);
	/* use tmp_str and then ignore */
	kfree(str);

** Disclaimer **

Note, I just took the red-eye (2 hours of sleep on the plane) and
waiting for my next flight. My focus may be off in this email.

-- Steve
