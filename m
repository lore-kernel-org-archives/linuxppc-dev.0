Return-Path: <B02008@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CE5882C00D6
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 08:59:41 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
Date: Fri, 3 May 2013 22:59:32 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3E9D81@039-SN2MPN1-013.039d.mgd.msft.net>
References: <300B73AA675FCE4A93EB4FC1D42459FF3E9B37@039-SN2MPN1-013.039d.mgd.msft.net>
 (from B02008@freescale.com on Fri May  3 15:56:47 2013)
 <1367618808.19391.11@snotra>
In-Reply-To: <1367618808.19391.11@snotra>
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
> Sent: Saturday, May 04, 2013 1:07 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: Wood Scott-B07421; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
> linuxppc-dev@lists.ozlabs.org
> Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
>=20
> I replaced the two calls to kvmppc_lazy_ee_enable() with calls to
> hard_irq_disable(), and it seems to be working fine.

Please take a look on 'KVM: PPC64: booke: Hard disable interrupts when
entering guest' RFC thread and see if your solution addresses Ben's
comments.

>=20
> > > > > Where is the arch_local_irq_restore() instance you're talking
> > about?
> > > >
> > > > ./arch/power/kernel/irq.c
> > >
> > > I meant the caller. :-P
> >
> > ./arch/powerpc/include/asm/hw_irq.h
> >
> >   55static inline unsigned long arch_local_irq_disable(void)
> >   56{
> >   57        unsigned long flags, zero;
> >   58
> >   59        asm volatile(
> >   60                "li %1,0; lbz %0,%2(13); stb %1,%2(13)"
> >   61                : "=3Dr" (flags), "=3D&r" (zero)
> >   62                : "i" (offsetof(struct paca_struct, soft_enabled))
> >   63                : "memory");
> >   64
> >   65        return flags;
> >   66}
> >   67
> >   68extern void arch_local_irq_restore(unsigned long);
> >   69
> >   70static inline void arch_local_irq_enable(void)
> >   71{
> >   72        arch_local_irq_restore(1);
> >   73}
>=20
> Sigh.  I meant the real caller, who's calling local_irq_restore().

I'm not sure what you mean, arch_local_irq_restore() is called indirectly
by local_irq_enable() in our case from handle_exit().

-Mike
