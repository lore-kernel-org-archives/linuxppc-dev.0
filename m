Return-Path: <bauerman@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qmHSW57Y5zDq60
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2016 09:48:59 +1000 (AEST)
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <bauerman@linux.vnet.ibm.com>;
 Thu, 14 Apr 2016 20:48:55 -0300
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id 77A563520068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 19:48:38 -0400 (EDT)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3EMkZ6A4722940
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 19:46:35 -0300
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3ENmn1J027602
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 20:48:49 -0300
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] ftrace: filter: Match dot symbols when searching
 functions on ppc64.
Date: Thu, 14 Apr 2016 20:48:44 -0300
Message-ID: <2592130.ISnyKlUyAf@hactar>
In-Reply-To: <20160414065805.102dfd90@grimm.local.home>
References: <1459480972-20238-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <1460617895.2754.8.camel@ellerman.id.au>
 <20160414065805.102dfd90@grimm.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Am Donnerstag, 14 April 2016, 06:58:05 schrieb Steven Rostedt:
> On Thu, 14 Apr 2016 17:11:35 +1000
> 
> Michael Ellerman <mpe@ellerman.id.au> wrote:
> > Presumably Steve will have a preference for which style you use.
> 
> Actually, what I usually do is simply make a "weak" stub function and
> let the arch override it.

Ok, in the next version of the patch I'll use the weak function alternative.

> > It seems unfortunate that we need to introduce yet another mechanism to
> > deal with dot symbols. But I guess none of the existing mechanisms
> > work, eg. kprobe_lookup_name().
> 
> What about making a generic conversion to function name, like:
> 
> 	arch_sane_function_name(str);
> 
> Where all sane archs simply return the string name and powerpc can
> strip the '.' prefix. ;-)
> 
> Of course that would require:
> 
> 	sane_str = arch_sane_function(str);
> 	sane_search = arch_sane_function(g->search);
> 
> 	and then compare sane_str with sane_search.

I had a look at kprobe_lookup_name but it aims to convert a function name to 
an address while ftrace_match just wants to compare symbol names, so it's 
not applicable to what ftrace_match is trying to do. It also goes in the 
opposite direction of the other places which deal with dot symbols that I 
could find: it adds a dot because it wants to find the dot symbol, while 
everywhere else the code removes the dot from the name. For that reason, 
kprobe_lookup_name wouldn't be able to use a generalized solution for 
working with dot symbol names like arch_sane_function as proposed above.

I did find arch__compare_symbol_names in tools/perf/arch/powerpc/util/sym-
handling.c which could be used as-is (if I moved it to somewhere which is 
common to kernel and userspace code) if ftrace_match only matched the full 
string, but ftrace_match supports doing front, middle and end string matches 
as well. It looks like those additional comparison modes are not used at all 
though.

If we do want to reuse arch__compare_symbol_names instead of creating yet 
another arch-specific symbol comparison mechanism, there are two options:

1. remove ftrace_match and use arch__compare_symbol_names directly;
2. extend arch__compare_symbol_names to support front, middle and end 
matches.

What do you think?

> > >  #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > > 
> > > diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> > > index b1870fbd2b67..e806c2a3b7a8 100644
> > > --- a/kernel/trace/ftrace.c
> > > +++ b/kernel/trace/ftrace.c
> > > @@ -3444,11 +3444,24 @@ struct ftrace_glob {
> > > 
> > >  	int type;
> > >  
> > >  };
> > > 
> > > +#ifndef ARCH_HAS_FTRACE_MATCH_ADJUST
> > > +/*
> > > + * If symbols in an architecture don't correspond exactly to the
> > > user-visible + * name of what they represent, it is possible to
> > > define this function to + * perform the necessary adjustments.
> > > +*/
> > > +static inline void arch_ftrace_match_adjust(char **str, char *search)
> > > +{
> > > +}
> > > +#endif
> > > +
> > > 
> > >  static int ftrace_match(char *str, struct ftrace_glob *g)
> > >  {
> > >  
> > >  	int matched = 0;
> > >  	int slen;
> > > 
> > > +	arch_ftrace_match_adjust(&str, g->search);
> > 
> > I think this would less magical if it didn't modify str directly, 
instead doing:
> > 	str = arch_ftrace_match_adjust(str, g->search);
> > 
> > And arch_ftrace_match_adjust() would return the adjusted char *.
> > 
> > That would mean the generic version would need to return str rather than
> > being empty.
> 
> I agree, because if we need to free the string passed it, the function
> would modify the pointer and we wouldn't be able to free it. In those
> cases we could do:
> 
> 	tmp_str = arch_ftrace_match_adjust(str, search);
> 	/* use tmp_str and then ignore */
> 	kfree(str);

If you decide against either of my alternatives for using 
arch__compare_symbol_names, I'll change arch_ftrace_match_adjust to work as 
you suggested above in the next version of this patch.

> ** Disclaimer **
> 
> Note, I just took the red-eye (2 hours of sleep on the plane) and
> waiting for my next flight. My focus may be off in this email.

Ouch. Thanks for having a look at the patch and responding to my ping!

-- 
[]'s
Thiago Jung Bauermann
IBM Linux Technology Center
