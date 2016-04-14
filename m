Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qm1Bz6MvPzDq5y
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Apr 2016 23:06:19 +1000 (AEST)
Message-ID: <1460639178.21066.3.camel@ellerman.id.au>
Subject: Re: [PATCH 2/5] livepatch: Allow architectures to specify an
 alternate ftrace location
From: Michael Ellerman <mpe@ellerman.id.au>
To: Miroslav Benes <mbenes@suse.cz>
Cc: linuxppc-dev@ozlabs.org, bsingharora@gmail.com, duwe@lst.de,
 linux-kernel@vger.kernel.org, rostedt@goodmis.org,
 kamalesh@linux.vnet.ibm.com,  pmladek@suse.com, jeyu@redhat.com,
 jikos@kernel.org, live-patching@vger.kernel.org
Date: Thu, 14 Apr 2016 23:06:18 +1000
In-Reply-To: <alpine.LNX.2.00.1604141354130.10605@pobox.suse.cz>
References: <1460552003-15409-1-git-send-email-mpe@ellerman.id.au>
 <1460552003-15409-3-git-send-email-mpe@ellerman.id.au>
 <alpine.LNX.2.00.1604141354130.10605@pobox.suse.cz>
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

On Thu, 2016-04-14 at 14:01 +0200, Miroslav Benes wrote:
> On Wed, 13 Apr 2016, Michael Ellerman wrote:
> > diff --git a/kernel/livepatch/core.c b/kernel/livepatch/core.c
> > index d68fbf63b083..b0476bb30f92 100644
> > --- a/kernel/livepatch/core.c
> > +++ b/kernel/livepatch/core.c
> > @@ -298,6 +298,19 @@ unlock:
> >       rcu_read_unlock();
> >  }
> >  
> > +/*
> > + * Convert a function address into the appropriate ftrace location.
> > + *
> > + * Usually this is just the address of the function, but on some architectures
> > + * it's more complicated so allow them to provide a custom behaviour.
> > + */
> > +#ifndef klp_get_ftrace_location
> > +static unsigned long klp_get_ftrace_location(unsigned long faddr)
> > +{
> > +     return faddr;
> > +}
> > +#endif
> 
> Whoah, what an ugly hack :)
 
Hey it's a "cool trick" ;)

> Note to my future self - This is what you want to do if you need a weak 
> static inline function.
> 
> static inline is probably unnecessary here so __weak function would be 
> enough. It would introduce powerpc-specific livepatch.c though because of 
> it and this is not worth it.

Yeah that was my logic, at least for now. We can always change it in future
to be weak if anyone cares deeply.

> >  static void klp_disable_func(struct klp_func *func)
> >  {
> >       struct klp_ops *ops;
> > @@ -312,8 +325,14 @@ static void klp_disable_func(struct klp_func *func)
> >               return;
> >  
> >       if (list_is_singular(&ops->func_stack)) {
> > +             unsigned long ftrace_loc;
> 
> This is a nit, but could you move the definition up to have them all in 
> one place to be consistent with the rest of the code? The same applies to 
> klp_enable_func() below.

Hmm, actually I moved it in there because you pointed out we only needed it
inside the if:

http://lkml.kernel.org/r/alpine.LNX.2.00.1603151113020.20252@pobox.suse.cz

    Thinking about it, we need ftrace_loc only in cases where we call 
    ftrace_set_filter_ip() right? So we can move klp_get_ftrace_location() 
    call to appropriate if branch both in klp_disable_func() and 
    klp_enable_func().

But I guess you meant the function call, not the variable declaration.

Personally I think it's better this way, as the variable is in scope for the
shortest possible amount of time, but I can change it if you want me to.

cheers
