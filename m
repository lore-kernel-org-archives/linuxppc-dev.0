Return-Path: <B02008@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5E029B6FA1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jun 2012 23:25:04 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Avi Kivity <avi@redhat.com>
Subject: RE: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in sregs
Date: Mon, 25 Jun 2012 13:24:54 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF14F93A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
 <4FE860CC.6080903@redhat.com>
In-Reply-To: <4FE860CC.6080903@redhat.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>,
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

> -----Original Message-----
> From: Avi Kivity [mailto:avi@redhat.com]
> Sent: Monday, June 25, 2012 4:00 PM
> To: Caraman Mihai Claudiu-B02008
> Cc: kvm-ppc@vger.kernel.org; kvm@vger.kernel.org; linuxppc-
> dev@lists.ozlabs.org; qemu-ppc@nongnu.org
> Subject: Re: [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support in
> sregs
>=20
> On 06/25/2012 03:26 PM, Mihai Caraman wrote:
> > Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs for
> > 64-bit hosts.
> >
> > Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> > ---
> >  arch/powerpc/kvm/booke.c |   14 ++++++++++++++
> >  1 files changed, 14 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c index
> > f9fa260..d15c4b5 100644
> > --- a/arch/powerpc/kvm/booke.c
> > +++ b/arch/powerpc/kvm/booke.c
> > @@ -1052,6 +1052,9 @@ static void get_sregs_base(struct kvm_vcpu *vcpu,
> >  	u64 tb =3D get_tb();
> >
> >  	sregs->u.e.features |=3D KVM_SREGS_E_BASE;
> > +#ifdef CONFIG_64BIT
> > +	sregs->u.e.features |=3D KVM_SREGS_E_64; #endif
> >
>=20
> This is an ABI, but I see no trace of it in Documentation.

The ppc sregs documentation in api.txt redirects to arch/powerpc/include/as=
m/kvm.h.
Isn't this enough?

Mike
