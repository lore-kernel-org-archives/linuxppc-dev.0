Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79C641A061A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 23:49:57 +1100 (AEDT)
Message-ID: <1455713389.8408.1.camel@ellerman.id.au>
Subject: Re: [PATCH 2/2] powerpc: Add POWER9 cputable entry
From: Michael Ellerman <mpe@ellerman.id.au>
To: oliver <oohall@gmail.com>
Cc: Michael Neuling <mikey@neuling.org>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org, "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 17 Feb 2016 23:49:49 +1100
In-Reply-To: <CAOSf1CHJKbKW7ZRcHGfOr92+_8bwPPykS2RaVRycdgCkKZQBow@mail.gmail.com>
References: <1455685668-30198-1-git-send-email-mikey@neuling.org>
 <1455685668-30198-2-git-send-email-mikey@neuling.org>
 <1455707394.4450.4.camel@ellerman.id.au>
 <CAOSf1CHJKbKW7ZRcHGfOr92+_8bwPPykS2RaVRycdgCkKZQBow@mail.gmail.com>
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

On Wed, 2016-02-17 at 23:28 +1100, oliver wrote:

> On Wed, Feb 17, 2016 at 10:09 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> > On Wed, 2016-02-17 at 16:07 +1100, Michael Neuling wrote:
> > 
> > > Add a cputable entry for POWER9.  More code is required to actually
> > > boot and run on a POWER9 but this gets the base piece in which we can
> > > start building on.
> > >
> > > Copies over from POWER8 except for:
> > > - Adds a new CPU_FTR_ARCH_30 bit to start hanging new architecture
> > 
> > ARCH thirty?
> > 
> > Would CPU_FTR_ARCH_3 read better?
> > 
> > Or CPU_FTR_ARCH_3_00 ?

> The user visible version flags all have the pattern ARCH_X_XX while the
> in-kernel flags use ARCH_XXX. It should probably be CPU_FTR_ARCH_300 for
> consistency with the other kernel flags.

Yeah, 300 is ugly too.

I'm not sure if the plan is for the next version to be 3.01 or 4, hopefully the
latter.

It would be a pity if we had ARCH_300 and then the next version was 4.

So I'm inclined to say now is the time where we break from the 2.0x tradition,
and just use ARCH_3.

> > > +#define COMMON_USER_POWER9   (COMMON_USER_PPC64 | PPC_FEATURE_ARCH_2_06 |\
> > > +                              PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
> > > +                              PPC_FEATURE_TRUE_LE | \
> > > +                              PPC_FEATURE_PSERIES_PERFMON_COMPAT)
> > 
> > That looks like it's == COMMON_USER_POWER8.
> > 
> > > +#define COMMON_USER2_POWER9  (PPC_FEATURE2_ARCH_2_07 | \
> > > +                              PPC_FEATURE2_HTM_COMP | \
> > > +                              PPC_FEATURE2_HTM_NOSC_COMP | \
> > > +                              PPC_FEATURE2_DSCR | \
> > > +                              PPC_FEATURE2_ISEL | PPC_FEATURE2_TAR | \
> > > +                              PPC_FEATURE2_VEC_CRYPTO | \
> > > +                              PPC_FEATURE2_ARCH_3_00 | \
> > > +                              PPC_FEATURE2_HAS_IEEE128)
> > 
> > And this could be COMMON_USER_POWER8 + ARCH_3 + HAS_IEEE128 I think?

> It could be, but similarly the POWER8 flags could also be POWER7 + some.

You just found yourself another cleanup to do :)

> I think they're separate so flags can be easily removed if need be, but I'm not
> sure how useful that is.

It's not useful. Looking at the history it looks like we have literally *never*
removed a bit.

cheers
