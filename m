Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz8rj4Z97zDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 20:30:45 +1000 (AEST)
Date: Fri, 22 Sep 2017 20:30:40 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Michael Neuling <mikey@neuling.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Check for updated HDSISR on P9 HDSI
 exception
Message-ID: <20170922103040.GK4998@umbus.fritz.box>
References: <20170915052614.8231-1-mikey@neuling.org>
 <db59a8c7-30e7-08a1-ad57-45b9a631920e@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="GmiNL4+5WUWrod5m"
In-Reply-To: <db59a8c7-30e7-08a1-ad57-45b9a631920e@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--GmiNL4+5WUWrod5m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 10:46:36AM +0200, Paolo Bonzini wrote:
> On 15/09/2017 07:26, Michael Neuling wrote:
> > On POWER9 DD2.1 and below, sometimes on a Hypervisor Data Storage
> > Interrupt (HDSI) the HDSISR is not be updated at all.
> >=20
> > To work around this we put a canary value into the HDSISR before
> > returning to a guest and then check for this canary when we take a
> > HDSI. If we find the canary on a HDSI, we know the hardware didn't
> > update the HDSISR. In this case we return to the guest to retake the
> > HDSI which should correctly update the HDSISR the second time HDSI
> > entry.
> >=20
> > After talking to Paulus we've applied this workaround to all POWER9
> > CPUs. The workaround of returning to the guest shouldn't ever be
> > triggered on well behaving CPU. The extra instructions should have
> > negligible performance impact.
> >=20
> > Signed-off-by: Michael Neuling <mikey@neuling.org>
> > ---
> >  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 14 +++++++++++++-
> >  1 file changed, 13 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm=
/book3s_hv_rmhandlers.S
> > index 663a4a861e..70dca60569 100644
> > --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> > @@ -1118,6 +1118,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> >  BEGIN_FTR_SECTION
> >  	mtspr	SPRN_PPR, r0
> >  END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
> > +
> > +/* Move canary into DSISR to check for later */
> > +BEGIN_FTR_SECTION
> > +	li	r0, 0x7fff
> > +	mtspr	SPRN_HDSISR, r0
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> > +
> >  	ld	r0, VCPU_GPR(R0)(r4)
> >  	ld	r4, VCPU_GPR(R4)(r4)
> > =20
> > @@ -1947,9 +1954,14 @@ END_MMU_FTR_SECTION_IFSET(MMU_FTR_TYPE_RADIX)
> >  kvmppc_hdsi:
> >  	ld	r3, VCPU_KVM(r9)
> >  	lbz	r0, KVM_RADIX(r3)
> > -	cmpwi	r0, 0
> >  	mfspr	r4, SPRN_HDAR
> >  	mfspr	r6, SPRN_HDSISR
> > +BEGIN_FTR_SECTION
> > +	/* Look for DSISR canary. If we find it, retry instruction */
> > +	cmpdi	r6, 0x7fff
> > +	beq	6f
> > +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> > +	cmpwi	r0, 0
> >  	bne	.Lradix_hdsi		/* on radix, just save DAR/DSISR/ASDR */
> >  	/* HPTE not found fault or protection fault? */
> >  	andis.	r0, r6, (DSISR_NOHPTE | DSISR_PROTFAULT)@h
> >=20
>=20
> Applied to kvm/master, thanks.

I'm not seeing it; have you pushed out the tree?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--GmiNL4+5WUWrod5m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnE5lAACgkQbDjKyiDZ
s5IsGxAA3UV8Uc8eFYlmMFlK13Jhi1MAVpmVucYO/hvdNbHho64E1Y0e0W6oTr2J
1qpnxZRA4OioO84+y8WGo/F4P1WmIAI4ElwnHvX9LQXEz1BIhkcyHYCCT4upvEZn
zKOB2kQYTTkh+uYwPFIAkmIwqsTYTc43PuPPFF9BsmUUJxGsWu9tEZ9s8JmaW2eL
jG1f9xuYpuh7ZHzhBbgg2CHvDy3usGXxgD173fpzv8GADsYgw0csJwKlgceCdah6
sTYcKHAcfDaO1IHkw2uo+ttnRB1mS4l46cHDVcvfclzmY7RWcWS06961J3+3/Bve
3rkBO93wInGRAekzcnvoAOZZw+syk4LZbFVsOUHuQFLCDxdMp7lm0zsM/3lxiPs1
ro5jtDLTjV5hobZGIOvXux+loDDaLGCtTqkVoxZB1EXVrCd610R7rVGLqkO+vClJ
tWy8D3kOWIFV0EV2tCwMva4eSVRD2Y2YFyferYjWjuUHlfmXUxiXfRthEKS6l4hu
tfTqnGSyPRaNGqmOiz9DLOy0wa9Vu4TYAZfZ6DXjxqbsg7GH6DpFk2YVQHWRtAMS
TrGDy2zHsv0CcrS/5sTLgiz8N2xXo9SEyqb/rUrvWX/SS1surW31WVCUsUZsMNec
OSq8yCI+HB8FCViMKProH32Qsf0DeyH3zILL97wE6Lnjs/jkO70=
=npUB
-----END PGP SIGNATURE-----

--GmiNL4+5WUWrod5m--
