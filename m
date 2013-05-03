Return-Path: <B02008@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 617D22C00DD
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 06:57:00 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
Date: Fri, 3 May 2013 20:56:47 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3E9B37@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
 <1367604287.19391.2@snotra>
 <300B73AA675FCE4A93EB4FC1D42459FF3E984C@039-SN2MPN1-013.039d.mgd.msft.net>
 <1367612101.19391.8@snotra>
In-Reply-To: <1367612101.19391.8@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
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

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, May 03, 2013 11:15 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: Wood Scott-B07421; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
>=20
> > > > The unresponsiveness has to do with the fact that
> > > > arch_local_irq_restore()
> > > > does not guarantees to hard enable interrupts.
> > >
> > > Could you elaborate?  If the saved IRQ state was "enabled", why
> > > wouldn't arch_local_irq_restore() hard-enable IRQs?  The last thing
> > it
> > > does is __hard_irq_enable().
> >
> > 	if (!irq_happened)
> > 		return;
>=20
> OK, so the problem is that we're not setting PACA_IRQ_HARD_DIS when we
> hard-disable interrupts?

We enter guest with local_irq_disable() which means soft disabled, when
do we hard-disable interrupts? If we follow host exception handlers model
they set PACA_IRQ_EE/DEC/DBELL but not PACA_IRQ_HARD_DIS. Can you give it
a try to see how KVM behaves with PACA_IRQ_HARD_DIS? I can't do it right no=
w.

>=20
> > > Where is the arch_local_irq_restore() instance you're talking about?
> >
> > ./arch/power/kernel/irq.c
>=20
> I meant the caller. :-P

./arch/powerpc/include/asm/hw_irq.h

  55static inline unsigned long arch_local_irq_disable(void)
  56{
  57        unsigned long flags, zero;
  58
  59        asm volatile(
  60                "li %1,0; lbz %0,%2(13); stb %1,%2(13)"
  61                : "=3Dr" (flags), "=3D&r" (zero)
  62                : "i" (offsetof(struct paca_struct, soft_enabled))
  63                : "memory");
  64
  65        return flags;
  66}
  67
  68extern void arch_local_irq_restore(unsigned long);
  69
  70static inline void arch_local_irq_enable(void)
  71{
  72        arch_local_irq_restore(1);
  73}

-Mike
