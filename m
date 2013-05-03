Return-Path: <B07421@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CECB32C00A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:06:57 +1000 (EST)
Date: Fri, 3 May 2013 17:06:48 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF3E9B37@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B02008@freescale.com on Fri May  3 15:56:47 2013)
Message-ID: <1367618808.19391.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2013 03:56:47 PM, Caraman Mihai Claudiu-B02008 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, May 03, 2013 11:15 PM
> > To: Caraman Mihai Claudiu-B02008
> > Cc: Wood Scott-B07421; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
> > linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and =20
> hangs
> >
> > > > > The unresponsiveness has to do with the fact that
> > > > > arch_local_irq_restore()
> > > > > does not guarantees to hard enable interrupts.
> > > >
> > > > Could you elaborate?  If the saved IRQ state was "enabled", why
> > > > wouldn't arch_local_irq_restore() hard-enable IRQs?  The last =20
> thing
> > > it
> > > > does is __hard_irq_enable().
> > >
> > > 	if (!irq_happened)
> > > 		return;
> >
> > OK, so the problem is that we're not setting PACA_IRQ_HARD_DIS when =20
> we
> > hard-disable interrupts?
>=20
> We enter guest with local_irq_disable() which means soft disabled,

Hmm... I don't see any obvious breakage from that, but it makes me =20
nervous.  I'd be more comfortable if we just hard-disabled interrupts =20
there.

> when do we hard-disable interrupts?

Interrupts will be hard-disabled when we take an exception to exit =20
guest state.

> If we follow host exception handlers model
> they set PACA_IRQ_EE/DEC/DBELL but not PACA_IRQ_HARD_DIS. Can you =20
> give it
> a try to see how KVM behaves with PACA_IRQ_HARD_DIS? I can't do it =20
> right now.

I replaced the two calls to kvmppc_lazy_ee_enable() with calls to =20
hard_irq_disable(), and it seems to be working fine.

> > > > Where is the arch_local_irq_restore() instance you're talking =20
> about?
> > >
> > > ./arch/power/kernel/irq.c
> >
> > I meant the caller. :-P
>=20
> ./arch/powerpc/include/asm/hw_irq.h
>=20
>   55static inline unsigned long arch_local_irq_disable(void)
>   56{
>   57        unsigned long flags, zero;
>   58
>   59        asm volatile(
>   60                "li %1,0; lbz %0,%2(13); stb %1,%2(13)"
>   61                : "=3Dr" (flags), "=3D&r" (zero)
>   62                : "i" (offsetof(struct paca_struct, soft_enabled))
>   63                : "memory");
>   64
>   65        return flags;
>   66}
>   67
>   68extern void arch_local_irq_restore(unsigned long);
>   69
>   70static inline void arch_local_irq_enable(void)
>   71{
>   72        arch_local_irq_restore(1);
>   73}

Sigh.  I meant the real caller, who's calling local_irq_restore().

-Scott=
