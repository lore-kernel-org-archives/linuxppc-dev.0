Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0187.outbound.messaging.microsoft.com [213.199.154.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1AAFC2C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:52:37 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 3/6] KVM: PPC: Book3E: Rename IRQPRIO names to
 accommodate ALTIVEC
Date: Wed, 5 Jun 2013 07:52:03 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF44EDFB@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-4-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Mon Jun  3 15:54:25 2013)
 <1370384900.748.18@snotra>
In-Reply-To: <1370384900.748.18@snotra>
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
> Sent: Wednesday, June 05, 2013 1:28 AM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; Caraman Mihai Claudiu-B02008
> Subject: Re: [RFC PATCH 3/6] KVM: PPC: Book3E: Rename IRQPRIO names to
> accommodate ALTIVEC
>=20
> On 06/03/2013 03:54:25 PM, Mihai Caraman wrote:
> > Rename BOOKE_IRQPRIO_SPE_UNAVAIL and BOOKE_IRQPRIO_SPE_FP_DATA names
> > to accommodate ALTIVEC. Replace BOOKE_INTERRUPT_SPE_UNAVAIL and
> > BOOKE_INTERRUPT_SPE_FP_DATA with the common version.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> >  arch/powerpc/kvm/booke.c              |   12 ++++++------
> >  arch/powerpc/kvm/booke.h              |    4 ++--
> >  arch/powerpc/kvm/bookehv_interrupts.S |    8 ++++----
> >  arch/powerpc/kvm/e500.c               |   10 ++++++----
> >  arch/powerpc/kvm/e500_emulate.c       |    8 ++++----
> >  5 files changed, 22 insertions(+), 20 deletions(-)
>=20
> Can you remove the TODO separate definitions from 1/6 now?  And/or
> combine 1/6 with this patch?

TODO separate definitions are for kernel code, they require a new patch
depending on comments. I sent 1/6 to fix the build brake generated
by this

	/* altivec */
	#define BOOKE_INTERRUPT_ALTIVEC_UNAVAIL 42
	#define BOOKE_INTERRUPT_ALTIVEC_ASSIST 43

So if we agree that 42/43 numbers are wrong then I would prefer 1/6 (or som=
ething
similar) instead of adding new kvm_handlers (which legitimates the above co=
mmit)
just to remove them later.

-Mike
