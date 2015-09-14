Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0120.outbound.protection.outlook.com [65.55.169.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 96D661A2BFB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Sep 2015 02:32:29 +1000 (AEST)
Message-ID: <1442248334.2909.85.camel@freescale.com>
Subject: Re: [PATCH v2] powerpc32: memcpy/memset: only use dcbz once cache
 is enabled
From: Scott Wood <scottwood@freescale.com>
To: christophe leroy <christophe.leroy@c-s.fr>
CC: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>,
 <sojkam1@fel.cvut.cz>, <linux-kernel@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 14 Sep 2015 11:32:14 -0500
In-Reply-To: <55F3F701.5030303@c-s.fr>
References: <20150910064112.7B7791A241C@localhost.localdomain>
 <1441922743.2909.8.camel@freescale.com>
 <1441934656.23806.3.camel@ellerman.id.au> <55F3F701.5030303@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2015-09-12 at 11:57 +0200, christophe leroy wrote:
> Le 11/09/2015 03:24, Michael Ellerman a écrit :
> > On Thu, 2015-09-10 at 17:05 -0500, Scott Wood wrote:
> > > 
> > > I don't think this duplication is what Michael meant by "the normal cpu
> > > feature sections".  What else is going to use this very specific
> > > infrastructure?
> > Yeah, sorry, I was hoping you could do it with the existing cpu feature
> > mechanism.
> > 
> > It looks like the timing doesn't work, ie. you need to patch this stuff in
> > machine_init(), which is later than the regular patching which gets done 
> > in
> > early_init().
> > 
> > This is one of the festering differences we have between the 32 and 64-bit
> > initialisation code, ie. on 64-bit we do the patching much later.
> > 
> > 
> 
> I've just thought about maybe another alternative.
> Is there any issue with calling do_feature_fixups() twice for the same 
> features ?
> If not, we could define a MMU_CACHE_NOW_ON dummy MMU feature, then
> call again do_feature_fixups() in machine_init() to patch memcpy/memset 
> stuff, something like:
> 
> In arch/powerpc/include/asm/mmu.h:
> +#define MMU_CACHE_NOW_ON                ASM_CONST(0x00008000)
> 
> In arch/powerpc/kernel/setup_32.c: @machine_init()
> 
>          udbg_early_init();
> 
> +        spec = identify_cpu(0, mfspr(SPRN_PVR));
> +        do_feature_fixups(spec->mmu_features | MMU_CACHE_NOW_ON,
> +                          &__start___mmu_ftr_fixup,
> +                          &__stop___mmu_ftr_fixup);

This will cause cpu_setup() to be called twice on booke.  I'm not sure if 
that will cause any harm with the current cpu_setup() implementation, but 
it's complexity that is better avoided.  Why not just use cur_cpu_spec?

How much code is between the enabling of caches and the application of fixups 
(quite a lot on booke where cache is enabled by the bootloader...)?  Perhaps 
it's better to label it something that indicates that cache block operations 
are safe to use, so nobody gets the idea that it's OK to use it to protect 
things that can only be done before caches are enabled.

What happens if someone sees MMU_CACHE_NOW_ON (or whatever it ends up being 
called) and decides to call mmu_has_feature()?  At least set the bit in
spec->mmu_features rather than just for the do_feature_fixups() argument, and 
hope that nobody implements MMU_FTRS_POSSIBLE/ALWAYS, or checks the feature 
on 64-bit...  I'm not 100% convinced that abusing cpu feature mechanisms for 
boot sequence control is a good idea.  The direct patching alternative is 
quite simple, and if we were to accumulate enough instances of that (or more 
complicated instances) then patching infrastructure that is explicitly 
relating to the current state of the system rather than permanent hardware 
description could be justified.

-Scott
