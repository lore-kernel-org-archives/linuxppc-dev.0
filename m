Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22a.google.com (mail-yk0-x22a.google.com
 [IPv6:2607:f8b0:4002:c07::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 023791A0C65
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Dec 2015 19:04:25 +1100 (AEDT)
Received: by ykdv3 with SMTP id v3so115678676ykd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Dec 2015 00:04:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1449170771.15946.8.camel@freescale.com>
References: <1448010842-22345-1-git-send-email-chenhui.zhao@freescale.com>
 <CAOJe8K1_S1EwfjO1qW6mBKA+ighFBKbuKCW6-Q5B_og4-NuzFg@mail.gmail.com>
 <1449170771.15946.8.camel@freescale.com>
Date: Fri, 4 Dec 2015 11:04:23 +0300
Message-ID: <CAOJe8K1Lmc4oceW1gLuwXsrLgzg=YgVbsVTzQgqm6yp+vSbM6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] powerpc/mm: any thread in one core can be the
 first to setup TLB1
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Scott Wood <scottwood@freescale.com>
Cc: Chenhui Zhao <chenhui.zhao@freescale.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/3/15, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, 2015-12-02 at 15:12 +0300, Denis Kirjanov wrote:
>> On 11/20/15, Chenhui Zhao <chenhui.zhao@freescale.com> wrote:
>> > On e6500, in the case of cpu hotplug, either thread in one core
>> > may be the first thread initilzing the TLB1. The subsequent threads
>> > must not setup it again.
>> >
>> > The code is derived from the comment of Scott Wood.
>> >
>> > Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
>> > ---
>> >  arch/powerpc/include/asm/cputhreads.h | 7 +++++++
>> >  arch/powerpc/mm/tlb_nohash.c          | 4 +---
>> >  2 files changed, 8 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/cputhreads.h
>> > b/arch/powerpc/include/asm/cputhreads.h
>> > index ba42e46..b56cece 100644
>> > --- a/arch/powerpc/include/asm/cputhreads.h
>> > +++ b/arch/powerpc/include/asm/cputhreads.h
>> > @@ -94,6 +94,13 @@ static inline int cpu_last_thread_sibling(int cpu)
>> >  	return cpu | (threads_per_core - 1);
>> >  }
>> >
>> > +static inline u32 get_tensr(void)
>> > +{
>> > +	if (cpu_has_feature(CPU_FTR_SMT))
>> > +		return mfspr(SPRN_TENSR);
>> > +	else
>> > +		return 1;
>> > +}
>> If i get it right, SPRN_TENSR used in the code only if CONFIG_PPC64
>> is defined. Then we can make it noop on ppc32.
>
> Please don't.  It accomplishes nothing other than adding an obstacle to
> supporting this on ppc32.

The idea is make it noop since the function defined in header file and
some core parts include it like:

arch/powerpc/kernel/smp.c
arch/powerpc/kernel/setup-common.c


>
> -Scott
>
>
