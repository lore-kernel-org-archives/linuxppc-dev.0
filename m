Return-Path: <B02008@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D22162C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 17:30:21 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [RFC PATCH 2/6] KVM: PPC: Book3E: Refactor SPE_FP exit handling
Date: Wed, 5 Jun 2013 07:29:47 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF44EBF7@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1370292868-2697-1-git-send-email-mihai.caraman@freescale.com>
 <1370292868-2697-3-git-send-email-mihai.caraman@freescale.com>
 <1370384088.748.17@snotra>
In-Reply-To: <1370384088.748.17@snotra>
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

> > +		/*
> > +		 * The interrupt is shared, KVM support for the
> > featured unit
> > +		 * is detected at run-time.
> > +		 */
>=20
> This is a decent comment for the changelog, but for the code itself it
> seems fairly obvious if you look at the definition of
> kvmppc_supports_spe().

I will move it to change log.

>=20
> > +		bool handled =3D false;
> > +
> > +		if (kvmppc_supports_spe()) {
> > +#ifdef CONFIG_SPE
> > +			if (cpu_has_feature(CPU_FTR_SPE))
>=20
> Didn't you already check this using kvmppc_supports_spe()?

It makes sense with the next patch. It handles the improbable case of havin=
g
CONFIG_ALTIVEC and CONFIG_SPE defined:

	if (kvmppc_supports_altivec() || kvmppc_supports_spe()).

>=20
> >  	case BOOKE_INTERRUPT_SPE_FP_ROUND:
> > +#ifdef CONFIG_SPE
> >  		kvmppc_booke_queue_irqprio(vcpu,
> > BOOKE_IRQPRIO_SPE_FP_ROUND);
> >  		r =3D RESUME_GUEST;
> >  		break;
>=20
> Why not use kvmppc_supports_spe() here, for consistency?

I added cpu_has_feature(CPU_FTR_SPE) for the case specified above, but here
SPE_FP_ROUND is not shared with ALTIVEC. CONFIG_SPE is used in other places
in KVM without this check, shouldn't be all or nothing?

-Mike
