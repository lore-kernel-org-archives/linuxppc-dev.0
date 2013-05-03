Return-Path: <B02008@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe005.messaging.microsoft.com [216.32.180.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A4DF2C00CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 06:01:35 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
Date: Fri, 3 May 2013 20:01:26 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3E984C@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Fri May  3 11:11:10 2013)
 <1367604287.19391.2@snotra>
In-Reply-To: <1367604287.19391.2@snotra>
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
> Sent: Friday, May 03, 2013 9:05 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
>=20
> > The unresponsiveness has to do with the fact that
> > arch_local_irq_restore()
> > does not guarantees to hard enable interrupts.
>=20
> Could you elaborate?  If the saved IRQ state was "enabled", why
> wouldn't arch_local_irq_restore() hard-enable IRQs?  The last thing it
> does is __hard_irq_enable().

	if (!irq_happened)
		return;

>=20
> Where is the arch_local_irq_restore() instance you're talking about?

./arch/power/kernel/irq.c

>=20
> > To do so replace exception
> > function calls like timer_interrupt() with irq_happened flags. The
> > local_irq_enable() call takes care of replaying them and lets the
> > interrupts
> > hard enabled.
>=20
> Not sure what you mean by "lets the interrupts hard enabled"... Do you
> mean the EE bit in regs->msr, as opposed to the EE bit in the current
> MSR?

If irq_happened "the last thing it does is __hard_irq_enable()".

> > @@ -789,16 +788,16 @@ static void kvmppc_restart_interrupt(struct
> > kvm_vcpu *vcpu,
> >  	switch (exit_nr) {
> >  	case BOOKE_INTERRUPT_EXTERNAL:
> >  		kvmppc_fill_pt_regs(&regs);
> > -		do_IRQ(&regs);
> > +		local_paca->irq_happened |=3D PACA_IRQ_EE;
> >  		break;
>=20
> Aren't you breaking 32-bit here?

I had eyes only for 64-bit hangs :)

-Mike
