Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsprk6C9jzDq88
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 12:41:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id s66so27078162pfs.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Jun 2017 19:41:58 -0700 (PDT)
Date: Wed, 21 Jun 2017 12:41:41 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, akpm@linux-foundation.org, Stephen
 Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/64: Initialise thread_info for emergency stacks
Message-ID: <20170621124141.5a5cde49@roar.ozlabs.ibm.com>
In-Reply-To: <87shiut7y6.fsf@concordia.ellerman.id.au>
References: <20170620135801.13272-1-npiggin@gmail.com>
 <87shiut7y6.fsf@concordia.ellerman.id.au>
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

On Wed, 21 Jun 2017 12:01:37 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> 
> > diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
> > index a941cc6fc3e9..5995e4b2996d 100644
> > --- a/arch/powerpc/include/asm/thread_info.h
> > +++ b/arch/powerpc/include/asm/thread_info.h
> > @@ -62,6 +63,24 @@ struct thread_info {
> >  
> >  #define THREAD_SIZE_ORDER	(THREAD_SHIFT - PAGE_SHIFT)
> >  
> > +/*
> > + * Emergency stacks are used for a range of things, from asynchronous
> > + * NMIs (system reset, machine check) to synchronous, process context.
> > + * Set HARDIRQ_OFFSET because we don't know exactly what context we
> > + * come from or if it had a valid stack, which is about the best we
> > + * can do.
> > + * TODO: what to do with accounting?
> > + */
> > +#define emstack_init_thread_info(ti, c)		\
> > +do {						\
> > +	(ti)->task = NULL;			\
> > +	(ti)->cpu = (c);			\
> > +	(ti)->preempt_count = HARDIRQ_OFFSET;	\
> > +	(ti)->local_flags = 0;			\
> > +	(ti)->flags = 0;			\
> > +	klp_init_thread_info(ti);		\
> > +} while (0)  
> 
> Why don't we just bzero() the whole thing? Like we do for the other
> stacks?

Wouldn't hurt to.

Thanks,
Nick
