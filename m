Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5F4652C021C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 May 2013 13:05:37 +1000 (EST)
Date: Mon, 6 May 2013 22:05:26 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] kvm/ppc/booke64: Hard disable interrupts when entering
 the guest
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1367884994.29496.28.camel@pasglop> (from
 benh@kernel.crashing.org on Mon May  6 19:03:14 2013)
Message-ID: <1367895926.3398.14@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Mihai Caraman <mihai.caraman@freescale.com>,
 Paul Mackerras <paulus@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2013 07:03:14 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2013-05-06 at 18:53 -0500, Scott Wood wrote:
> >
> > > Ie. The last stage of entry will hard enable, so they should be
> > > soft-enabled too... if not, latency trackers will consider the =20
> whole
> > > guest periods as "interrupt disabled"...
> >
> > OK... I guess we already have that problem on 32-bit as well?
>=20
> 32-bit doesn't do lazy disable, so the situation is a lot easier =20
> there.

Right, but it still currently enters the guest with interrupts marked =20
as disabled, so we'd have the same latency tracker issue.

> Another problem is that hard_irq_disable() doesn't call
> trace_hardirqs_off()... We might want to fix that:
>=20
> static inline void hard_irq_disable(void)
> {
> 	__hard_irq_disable();
> 	if (get_paca()->soft_enabled)
> 		trace_hardirqs_off();
> 	get_paca()->soft_enabled =3D 0;
> 	get_paca()->irq_happened |=3D PACA_IRQ_HARD_DIS;
> }

Is it possible there are places that assume the current behavior?

> > We also don't want PACA_IRQ_HARD_DIS to be cleared the way
> > prep_irq_for_idle() does, because that's what lets the
> > local_irq_enable() do the hard-enabling after we exit the guest.
>=20
> Then set it again. Don't leave the kernel in a state where =20
> soft_enabled
> is 1 and irq_happened is non-zero. It might work in the specific KVM
> case we are looking at now because we know we are coming back via KVM
> exit and putting things right again but it's fragile, somebody will =20
> come
> back and break it, etc...

KVM is a pretty special case -- at least on booke, it's required that =20
all exits from guest state go through the KVM exception code.  I think =20
it's less likely that that changes, than something breaks in the code =20
to fix up lazy ee state (especially since we've already seen the latter =20
happen).

I'll give it a shot, though.

> If necessary, create (or improve existing) helpers that do the right
> state adjustement. The cost of a couple of byte stores is negligible,
> I'd rather you make sure everything remains in sync at all times.

My concern was mainly about complexity -- it seemed simpler to just say =20
that the during guest execution, CPU is in a special state that is not =20
visible to anything that cares about lazy EE.  The fact that EE can =20
actually be *off* and we still take the interrupt supports its =20
specialness. :-)

-Scott=
