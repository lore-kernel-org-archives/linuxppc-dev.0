Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4520E2C02A7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 05:07:45 +1000 (EST)
Date: Wed, 5 Jun 2013 14:07:34 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC PATCH 2/6] KVM: PPC: Book3E: Refactor SPE_FP exit handling
To: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
In-Reply-To: <300B73AA675FCE4A93EB4FC1D42459FF44EBF7@039-SN2MPN1-011.039d.mgd.msft.net>
 (from B02008@freescale.com on Wed Jun  5 02:29:47 2013)
Message-ID: <1370459254.26139.7@snotra>
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

On 06/05/2013 02:29:47 AM, Caraman Mihai Claudiu-B02008 wrote:
> > >  	case BOOKE_INTERRUPT_SPE_FP_ROUND:
> > > +#ifdef CONFIG_SPE
> > >  		kvmppc_booke_queue_irqprio(vcpu,
> > > BOOKE_IRQPRIO_SPE_FP_ROUND);
> > >  		r =3D RESUME_GUEST;
> > >  		break;
> >
> > Why not use kvmppc_supports_spe() here, for consistency?
>=20
> I added cpu_has_feature(CPU_FTR_SPE) for the case specified above, =20
> but here
> SPE_FP_ROUND is not shared with ALTIVEC. CONFIG_SPE is used in other =20
> places
> in KVM without this check, shouldn't be all or nothing?

I'd rather it be consistent, at least between handling one exception =20
and another.

-Scott=
