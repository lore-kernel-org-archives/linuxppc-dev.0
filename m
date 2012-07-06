Return-Path: <B02008@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe003.messaging.microsoft.com [216.32.180.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 37D072C0201
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Jul 2012 09:03:46 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf
 <agraf@suse.de>
Subject: RE: [Qemu-ppc] [RFC PATCH 09/17] KVM: PPC64: booke: Hard disable
 interrupts when entering guest
Date: Fri, 6 Jul 2012 23:03:38 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF15CE0B@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-10-git-send-email-mihai.caraman@freescale.com>
 <10CBFB35-5A18-4EA8-A129-58CCC4CFBB83@suse.de>
 <1341440465.16808.38.camel@pasglop>
In-Reply-To: <1341440465.16808.38.camel@pasglop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>,
 KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Linuxppc-dev [mailto:linuxppc-dev-
> bounces+mihai.caraman=3Dfreescale.com@lists.ozlabs.org] On Behalf Of
> Benjamin Herrenschmidt
> Sent: Thursday, July 05, 2012 1:21 AM
> To: Alexander Graf
> Cc: qemu-ppc@nongnu.org List; Caraman Mihai Claudiu-B02008; linuxppc-dev;
> KVM list; <kvm-ppc@vger.kernel.org>
> Subject: Re: [Qemu-ppc] [RFC PATCH 09/17] KVM: PPC64: booke: Hard disable
> interrupts when entering guest
>=20
> On Wed, 2012-07-04 at 16:14 +0200, Alexander Graf wrote:
> > > +#ifdef CONFIG_64BIT
> > > +#define _hard_irq_disable() hard_irq_disable()
> > > +#else
> > > +#define _hard_irq_disable() local_irq_disable()
> > > +#endif
> >
> > So you only swap out the disable bit, but not the enable one? Ben,
> > would this work out?
>=20
> hard_irq_disable() both soft and hard disable. local_irq_enable() will
> see that irqs are hard disabled and will hard enable.
>=20
> However, there's a nastier discrepancy above: local_irq_disable will
> properly inform lockdep that we are disabling, while hard_irq_disable
> won't.
>=20
> Arguably we might want to fix that inside hard_irq_disable() itself...
>=20
> Also you need to be careful. If you are coming with interrupts already
> enabled, it's fine, but if you have interrupts soft disabled, then
> you hard disable, before you enter the guest you probably want to
> check if anything was left "pending" and cancel the entering of the
> guest if that is the case.

On which cases I can find interrupts soft disabled if I call local_irq_enab=
le()
ahead? Can this happen when my kernel task is scheduled?=20

I presume that if I call hard_irq_disable() before entering the guest, a gu=
est exit
will find interrupts soft disabled.

-Mike
