Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DDD11A035A
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2015 10:13:32 +1000 (AEST)
Message-ID: <1430871212.1759.2.camel@ellerman.id.au>
Subject: Re: [PATCH 1/6] dump_stack: Support adding to the dump stack arch
 description
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 06 May 2015 10:13:32 +1000
In-Reply-To: <20150505141647.a1529e46f5ba42645264769c@linux-foundation.org>
References: <1430824337-15339-1-git-send-email-mpe@ellerman.id.au>
 <20150505141647.a1529e46f5ba42645264769c@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: tj@kernel.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-05-05 at 14:16 -0700, Andrew Morton wrote:
> On Tue,  5 May 2015 21:12:12 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> 
> > Arch code can set a "dump stack arch description string" which is
> > displayed with oops output to describe the hardware platform.
> > 
> > It is useful to initialise this as early as possible, so that an early
> > oops will have the hardware description.
> > 
> > However in practice we discover the hardware platform in stages, so it
> > would be useful to be able to incrementally fill in the hardware
> > description as we discover it.
> > 
> > This patch adds that ability, by creating dump_stack_add_arch_desc().
> > 
> > If there is no existing string it behaves exactly like
> > dump_stack_set_arch_desc(). However if there is an existing string it
> > appends to it, with a leading space.
> > 
> > This makes it easy to call it multiple times from different parts of the
> > code and get a reasonable looking result.
> 
> Some example output in the changelog would be useful, to help people
> understand the value.  

OK, an example from a power system is:

Hardware name: POWER8E (raw) 8286-42A PowerNV skiboot-5.0 MI SV830_027 SV810_085 SV830_027
               ^             ^        ^       ^
	       |             |        |       firmware version
	       cpu name      |        platform name
	                     device tree model

Those are all added in separate parts of the code.

> In particular, is there any convention for how these fields should be
> presented?  "name:value name:value", etc?  Or it is just put random stuff in
> there, hopefully with self-evident meanings.

I was thinking there was no convention and it's basically up to arch/platform
authors to put what they want in there. I see it as a human readable bag of
stuff that might be helpful in diagnosing an oops, with the emphasis being on
having more information rather than precisely specified fields & values.

Having said that I did use name:value in one of my patches, just to
differentiate the various version numbers. So maybe I should do that for all
the fields. Though then we have the problem that the values contain spaces ...

> We're going to blow out the 128 byte dump_stack_arch_desc_str[] pretty
> quickly.  Is dynamic allocation a possibility?

Are we? I think that's enough for us on most powerpc systems, and ideally it's
not too long or it will wrap when printed to the console.

I'd be inclined to avoid dynamic allocation until we absolutely need it, if
anything we could just bump it to 256.

> >  /**
> > + * dump_stack_add_arch_desc - add arch-specific info to show with task dumps
> > + * @fmt: printf-style format string
> > + * @...: arguments for the format string
> > + *
> > + * See dump_stack_set_arch_desc() for why you'd want to use this.
> > + *
> > + * This version adds to any existing string already created with either
> > + * dump_stack_set_arch_desc() or dump_stack_add_arch_desc(). If there is an
> > + * existing string a space will be prepended to the passed string.
> > + */
> > +void __init dump_stack_add_arch_desc(const char *fmt, ...)
> > +{
> > +	va_list args;
> > +	int pos, len;
> > +	char *p;
> > +
> > +	/*
> > +	 * If there's an existing string we snprintf() past the end of it, and
> > +	 * then turn the terminating NULL of the existing string into a space
> > +	 * to create one string separated by a space.
> > +	 *
> > +	 * If there's no existing string we just snprintf() to the buffer, like
> > +	 * dump_stack_set_arch_desc(), but without calling it because we'd need
> > +	 * a varargs version.
> > +	 */
> > +
> > +	len = strnlen(dump_stack_arch_desc_str, sizeof(dump_stack_arch_desc_str));
> > +	pos = len;
> > +
> > +	if (len)
> > +		pos++;
> > +
> > +	if (pos >= sizeof(dump_stack_arch_desc_str))
> > +		return; /* Ran out of space */
> > +
> > +	p = &dump_stack_arch_desc_str[pos];
> > +
> > +	va_start(args, fmt);
> > +	vsnprintf(p, sizeof(dump_stack_arch_desc_str) - pos, fmt, args);
> > +	va_end(args);
>
> This code is almost race-free.  A (documented) smp_wmb() in here would
> make that 100%?

Yeah good idea.

I'll send a v2 with that change and an updated changelog.

cheers
