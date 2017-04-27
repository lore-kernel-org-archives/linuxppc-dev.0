Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wD10b1qtzzDqJk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Apr 2017 12:21:35 +1000 (AEST)
Date: Thu, 27 Apr 2017 11:21:22 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, David Laight
 <David.Laight@ACULAB.COM>, Masami Hiramatsu <mhiramat@kernel.org>, Paul
 Clarke <pc@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
Message-Id: <20170427112122.b82014b321d387219bdbd7e4@kernel.org>
In-Reply-To: <20170426200810.2126-1-naveen.n.rao@linux.vnet.ibm.com>
References: <87lgqn1m8k.fsf@concordia.ellerman.id.au>
 <20170426200810.2126-1-naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 27 Apr 2017 01:38:10 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Michael Ellerman wrote:
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> >> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> >> index 6a3b249a2ae1..d134b060564f 100644
> >> --- a/kernel/kallsyms.c
> >> +++ b/kernel/kallsyms.c
> >> @@ -205,6 +205,12 @@ unsigned long kallsyms_lookup_name(const char *name)
> >>  	unsigned long i;
> >>  	unsigned int off;
> >>  
> >> +	if (!name || *name == '\0')
> >> +		return false;
> >> +
> >> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> >> +		return module_kallsyms_lookup_name(name);
> >> +
> >>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
> >>  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
> > 	...				
> > 	}
> >        	return module_kallsyms_lookup_name(name);
> > 
> > Is the rest of the context.
> > 
> > Which looks a bit odd, we already did module lookup previously?
> > 
> > But it's correct, because you can lookup a symbol in a module without a
> > module prefix, it just looks in every module.
> 
> Yes.
> 
> > 
> > You could invert the logic, ie. check that there isn't a ":" in the name
> > and only in that case do the for loop, always falling back to module
> > lookup.
> > 
> > Or just add a comment explaining why we call module lookup in two places.
> 
> Good point. Here's a v2 - I'm using a goto so as to not indent the code too much.
> 
> Thanks for the review!
> - Naveen
> 
> --
> [PATCH v2] kallsyms: optimize kallsyms_lookup_name() for a few cases
> 
> 1. Fail early for invalid/zero length symbols.
> 2. Detect names of the form <mod:name> and skip checking for kernel
> symbols in that case.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,


> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
>  kernel/kallsyms.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 6a3b249a2ae1..f7558dc5c6ac 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -205,12 +205,20 @@ unsigned long kallsyms_lookup_name(const char *name)
>  	unsigned long i;
>  	unsigned int off;
>  
> +	if (!name || *name == '\0')
> +		return 0;
> +
> +	/* For symbols of the form <mod>:<sym>, only check the modules */
> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> +		goto mod;
> +
>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
>  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
>  
>  		if (strcmp(namebuf, name) == 0)
>  			return kallsyms_sym_address(i);
>  	}
> +mod:
>  	return module_kallsyms_lookup_name(name);
>  }
>  EXPORT_SYMBOL_GPL(kallsyms_lookup_name);
> -- 
> 2.12.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
