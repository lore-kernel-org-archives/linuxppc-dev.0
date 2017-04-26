Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wCcCw4RRvzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Apr 2017 20:45:00 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Paul Clarke <pc@us.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kallsyms: optimize kallsyms_lookup_name() for a few cases
In-Reply-To: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20170425161822.18764-1-naveen.n.rao@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 20:44:59 +1000
Message-ID: <87lgqn1m8k.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> index 6a3b249a2ae1..d134b060564f 100644
> --- a/kernel/kallsyms.c
> +++ b/kernel/kallsyms.c
> @@ -205,6 +205,12 @@ unsigned long kallsyms_lookup_name(const char *name)
>  	unsigned long i;
>  	unsigned int off;
>  
> +	if (!name || *name == '\0')
> +		return false;
> +
> +	if (strnchr(name, MODULE_NAME_LEN, ':'))
> +		return module_kallsyms_lookup_name(name);
> +
>  	for (i = 0, off = 0; i < kallsyms_num_syms; i++) {
>  		off = kallsyms_expand_symbol(off, namebuf, ARRAY_SIZE(namebuf));
	...				
	}
       	return module_kallsyms_lookup_name(name);

Is the rest of the context.

Which looks a bit odd, we already did module lookup previously?

But it's correct, because you can lookup a symbol in a module without a
module prefix, it just looks in every module.

You could invert the logic, ie. check that there isn't a ":" in the name
and only in that case do the for loop, always falling back to module
lookup.

Or just add a comment explaining why we call module lookup in two places.

cheers
