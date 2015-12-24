Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0146.outbound.protection.outlook.com [157.56.111.146])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0DE31A0163
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 11:47:29 +1100 (AEDT)
From: Zhao C.H. <chenhui.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Denis Kirjanov
 <kda@linux-powerpc.org>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the
 first to setup TLB1
Date: Thu, 24 Dec 2015 00:47:21 +0000
Message-ID: <BY2PR0301MB1544D70A46256FB25AE4BFF09FE70@BY2PR0301MB1544.namprd03.prod.outlook.com>
References: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOJe8K1_S1EwfjO1qW6mBKA+ighFBKbuKCW6-Q5B_og4-NuzFg@mail.gmail.com>
 <1449142041.11289.0@remotesmtp.freescale.net>,
 <1450906073.18314.118.camel@freescale.com>
In-Reply-To: <1450906073.18314.118.camel@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

I updated the patch a moment ago at http://patchwork.ozlabs.org/patch/56077=
1/ .

Thanks,
Chenhui
________________________________________
From: Wood Scott-B07421
Sent: Thursday, December 24, 2015 5:27
To: Zhao Chenhui-B35336; Denis Kirjanov
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the f=
irst to setup TLB1

On Thu, 2015-12-03 at 19:27 +0800, Chenhui Zhao wrote:
>
> On Wed, Dec 2, 2015 at 8:12 PM, Denis Kirjanov <kda@linux-powerpc.org>
> wrote:
> > On 11/20/15, Chenhui Zhao <chenhui.zhao@freescale.com> wrote:
> > >  On e6500, in the case of cpu hotplug, either thread in one core
> > >  may be the first thread initilzing the TLB1. The subsequent threads
> > >  must not setup it again.
> > >
> > >  The code is derived from the comment of Scott Wood.
> > >
> > >  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> > >  ---
> > >   arch/powerpc/include/asm/cputhreads.h | 7 +++++++
> > >   arch/powerpc/mm/tlb_nohash.c          | 4 +---
> > >   2 files changed, 8 insertions(+), 3 deletions(-)
> > >
> > >  diff --git a/arch/powerpc/include/asm/cputhreads.h
> > >  b/arch/powerpc/include/asm/cputhreads.h
> > >  index ba42e46..b56cece 100644
> > >  --- a/arch/powerpc/include/asm/cputhreads.h
> > >  +++ b/arch/powerpc/include/asm/cputhreads.h
> > >  @@ -94,6 +94,13 @@ static inline int cpu_last_thread_sibling(int
> > > cpu)
> > >           return cpu | (threads_per_core - 1);
> > >   }
> > >
> > >  +static inline u32 get_tensr(void)
> > >  +{
> > >  +        if (cpu_has_feature(CPU_FTR_SMT))
> > >  +                return mfspr(SPRN_TENSR);
> > >  +        else
> > >  +                return 1;
> > >  +}
> > If i get it right, SPRN_TENSR used in the code only if CONFIG_PPC64
> > is defined. Then we can make it noop on ppc32.
> >
> > Thanks!
>
> Yeah, SPRN_TENSR is defined when CONFIG_BOOKE or CONFIG_40x is enabled.
> I'd like to change the code like:
>
> static inline u32 get_tensr(void)
> {
> #ifdef CONFIG_BOOKE
>         if (cpu_has_feature(CPU_FTR_SMT))
>                 return mfspr(SPRN_TENSR);
> #endif
>         return 1;
> }

Are you going to respin?

-Scott
