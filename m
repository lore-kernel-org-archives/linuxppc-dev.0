Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2Lz646WKzDqkF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 10:17:06 +1000 (AEST)
Received: by mail-pf0-x244.google.com with SMTP id z6so32368833pfk.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Jul 2017 17:17:06 -0700 (PDT)
Date: Wed, 5 Jul 2017 10:16:50 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc: do not call ppc_md.panic in panic notifier
 if fadump not used
Message-ID: <20170705101636.1ec6ab87@roar.ozlabs.ibm.com>
In-Reply-To: <87o9szydjd.fsf@concordia.ellerman.id.au>
References: <20170704100909.8738-1-npiggin@gmail.com>
 <20170704100909.8738-2-npiggin@gmail.com>
 <87o9szydjd.fsf@concordia.ellerman.id.au>
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

On Wed, 05 Jul 2017 09:42:46 +1000
Michael Ellerman <mpe@ellerman.id.au> wrote:

> Nicholas Piggin <npiggin@gmail.com> writes:
> > diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> > index 94a948207cd2..39ba09965b04 100644
> > --- a/arch/powerpc/kernel/setup-common.c
> > +++ b/arch/powerpc/kernel/setup-common.c
> > @@ -707,12 +707,15 @@ EXPORT_SYMBOL(check_legacy_ioport);
> >  static int ppc_panic_event(struct notifier_block *this,
> >                               unsigned long event, void *ptr)
> >  {
> > -	/*
> > -	 * If firmware-assisted dump has been registered then trigger
> > -	 * firmware-assisted dump and let firmware handle everything else.
> > -	 */
> > -	crash_fadump(NULL, ptr);
> > -	ppc_md.panic(ptr);  /* May not return */
> > +	if (is_fadump_active()) {
> > +		/*
> > +		 * If firmware-assisted dump has been registered then trigger
> > +		 * firmware-assisted dump and let firmware handle everything
> > +		 * else.
> > +		 */
> > +		crash_fadump(NULL, ptr);  
> 
> As Mahesh pointed out the check for fadump active is not correct.

Yep, I misread that code.

> 
> > +		ppc_md.panic(ptr);  /* May not return */  
> 
> But I wonder if this is the real problem?
> 
> AFAICS we only have two users of ppc_md.panic(), ps3 and pseries.
> 
> At least on ps3 it has nothing to do with fadump, so skipping it like
> you've done is not right.

But the call has to do with fadump -- at least that's what the comment
implies. ps3 does not want to panic here (it's .panic is just a hang).
It wants to go via the normal panic path and flush printk buffers etc.

> On pseries it uses rtas_os_term() which tells the HV that we "terminated
> normal operation", unless you're doing fadump it's supposed to return
> and shouldn't stop the regular panic path. Though maybe that's not true
> in practice.
> 
> It sounds like what we need to do is have a look at the panic flow and
> decide whether ppc_md.panic is useful at all, and if so is it called in
> the right place.

Yeah I would say you're probably right. The panic handling could possibly
go into the fadump code itself too, if it's relatively common across all
platforms that use it. It can register its own panic handler, no need for
this generic one.

Thanks,
Nick
