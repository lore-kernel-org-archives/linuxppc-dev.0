Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17D892C00E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 06:56:53 +1100 (EST)
Message-ID: <1381952434.7979.739.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc 8xx: Fixing memory init issue with CONFIG_PIN_TLB
From: Scott Wood <scottwood@freescale.com>
To: leroy christophe <christophe.leroy@c-s.fr>
Date: Wed, 16 Oct 2013 14:40:34 -0500
In-Reply-To: <525E27ED.4000005@c-s.fr>
References: <201310111256.r9BCuepM006243@localhost.localdomain>
 <OFF3401910.4A8AA6D0-ONC1257C01.0052FC82-C1257C01.00539C55@transmode.se>
 <525D6CD4.5090403@c-s.fr> <1381869216.7979.718.camel@snotra.buserror.net>
 <525E27ED.4000005@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-10-16 at 07:45 +0200, leroy christophe wrote:
> Le 15/10/2013 22:33, Scott Wood a =C3=A9crit :
> > On Tue, 2013-10-15 at 18:27 +0200, leroy christophe wrote:
> >> Le 11/10/2013 17:13, Joakim Tjernlund a =C3=A9crit :
> >>> "Linuxppc-dev"
> >>> <linuxppc-dev-bounces+joakim.tjernlund=3Dtransmode.se@lists.ozlabs.=
org>
> >>> wrote on 2013/10/11 14:56:40:
> >>>> Activating CONFIG_PIN_TLB allows access to the 24 first Mbytes of =
memory
> >>> at
> >>>> bootup instead of 8. It is needed for "big" kernels for instance w=
hen
> >>> activating
> >>>> CONFIG_LOCKDEP_SUPPORT. This needs to be taken into account in ini=
t_32
> >>> too,
> >>>> otherwise memory allocation soon fails after startup.
> >>>>
> >>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> >>>>
> >>>> diff -ur linux-3.11.org/arch/powerpc/kernel/head_8xx.S
> >>> linux-3.11/arch/powerpc/kernel/head_8xx.S
> >>>> --- linux-3.11.org/arch/powerpc/mm/init_32.c   2013-09-02
> >>> 22:46:10.000000000 +0200
> >>>> +++ linux-3.11/arch/powerpc/mm/init_32.c   2013-09-09 11:28:54.000=
000000
> >>> +0200
> >>>> @@ -213,7 +213,12 @@
> >>>>        */
> >>>>       BUG_ON(first_memblock_base !=3D 0);
> >>>>
> >>>> +#ifdef CONFIG_PIN_TLB
> >>>> +   /* 8xx can only access 24MB at the moment */
> >>>> +   memblock_set_current_limit(min_t(u64, first_memblock_size,
> >>> 0x01800000));
> >>>> +#else
> >>>>       /* 8xx can only access 8MB at the moment */
> >>>>       memblock_set_current_limit(min_t(u64, first_memblock_size,
> >>> 0x00800000));
> >>>> +#endif
> >>>>    }
> >>>>    #endif /* CONFIG_8xx */
> >>> hmm, I think you should always map 24 MB (or less if RAM < 24 MB) a=
nd do
> >>> the same
> >>> in head_8xx.S.
> >>>
> >>> Or to keep it simple, just always map at least 16 MB here and in
> >>> head_8xx.S, assuming
> >>> that 16 MB is min RAM for any 8xx system running 3.x kernels.
> >> Yes we could do a more elaborated modification in the future. Howeve=
r it
> >> also has an impact on the boot loader, so I'm not sure we should mak=
e it
> >> the default without thinking twice.
> >>
> >> In the meantime, my patch does take into account the existing situat=
ion
> >> where you have 8Mb by default and 24Mb when you activate CONFIG_PIN_=
TLB.
> >> I see it as a bug fix and I believe we should include it at least in
> >> order to allow including in the stable releases.
> >>
> >> Do you see any issue with this approach ?
> > The patch is fine, but I don't think it's stable material (BTW, if it
> > were, you should have marked it as such when submitting).  If I
> > understand the situation correctly, there's no regression, and nothin=
g
> > fails to work with CONFIG_PIN_TLB that would have worked without it.
> > It's just making CONFIG_PIN_TLB more useful.
> >
> >
> Yes the patch is definitly stable.

It's not about whether the patch itself is "stable", but whether it is a
critical bugfix that should be applied to the 3.11.x stable tree and the
3.12 release, rather than being queued for 3.13.

>  How should I have mark it ?

https://www.kernel.org/doc/Documentation/stable_kernel_rules.txt

> The situation is that in 2010, I discovered that I was not able to star=
t=20
> a big Kernel because of the 8Mb limit.
> You told me (see attached mail) that in order to get rid of that limit =
I=20
> shall use CONFIG_PIN_TLB: it was the first step, it helped pass the=20
> memory zeroize at init, but it was not enough as I then got problems=20
> with the Device Tree being erased because being put inside the first 8M=
b=20
> area too. Then I temporarely gave up at that time.
>=20
> Recently I started again. After fixing my bootloader to get the device=20
> tree somewhere else, I discovered this 8Mb limit hardcoded in=20
> mm/init_32.c for the 8xx
> With the patch I submitted I can now boot a kernel which is bigger than=
 8Mb.
>=20
> So, I'm a bit lost here on what to do.

There's nothing you need to do -- I'll apply the patch and send it to
Ben for 3.13.

-Scott
