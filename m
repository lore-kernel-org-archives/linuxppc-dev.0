Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y1S026ZCwzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 14:00:02 +1000 (AEST)
Date: Tue, 26 Sep 2017 13:56:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 qemu-ppc@nongnu.org
Subject: Re: [PATCH] KVM: PPC: Book3S PR: only call slbmte for valid SLB
 entries
Message-ID: <20170926035638.GI12504@umbus>
References: <150607286967.26027.12529646475118424696.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="qVyHzDF4yf4A8jkR"
In-Reply-To: <150607286967.26027.12529646475118424696.stgit@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--qVyHzDF4yf4A8jkR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 22, 2017 at 11:34:29AM +0200, Greg Kurz wrote:
> Userland passes an array of 64 SLB descriptors to KVM_SET_SREGS,
> some of which are valid (ie, SLB_ESID_V is set) and the rest are
> likely all-zeroes (with QEMU at least).
>=20
> Each of them is then passed to kvmppc_mmu_book3s_64_slbmte(), which
> assumes to find the SLB index in the 3 lower bits of its rb argument.
> When passed zeroed arguments, it happily overwrites the 0th SLB entry
> with zeroes. This is exactly what happens while doing live migration
> with QEMU when the destination pushes the incoming SLB descriptors to
> KVM PR. When reloading the SLBs at the next synchronization, QEMU first
> clears its SLB array and only restore valid ones, but the 0th one is
> now gone and we cannot access the corresponding memory anymore:
>=20
> (qemu) x/x $pc
> c0000000000b742c: Cannot access memory
>=20
> To avoid this, let's filter out non-valid SLB entries, like we
> already do for Book3S HV.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

This seems like a good idea, but to make it fully correct, don't we
also need to fully flush the SLB before inserting the new entries.

> ---
>  arch/powerpc/kvm/book3s_pr.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 3beb4ff469d1..cb6894e55f97 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1328,8 +1328,10 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct=
 kvm_vcpu *vcpu,
>  	vcpu3s->sdr1 =3D sregs->u.s.sdr1;
>  	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
>  		for (i =3D 0; i < 64; i++) {
> -			vcpu->arch.mmu.slbmte(vcpu, sregs->u.s.ppc64.slb[i].slbv,
> -						    sregs->u.s.ppc64.slb[i].slbe);
> +			u64 rb =3D sregs->u.s.ppc64.slb[i].slbe;
> +			u64 rs =3D sregs->u.s.ppc64.slb[i].slbv;
> +			if (rb & SLB_ESID_V)
> +				vcpu->arch.mmu.slbmte(vcpu, rs, rb);
>  		}
>  	} else {
>  		for (i =3D 0; i < 16; i++) {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qVyHzDF4yf4A8jkR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnJz/YACgkQbDjKyiDZ
s5JYPw/7Be4T6rPsPnjGG41qeIsjw4i1ruq3MOj0a6gFXwpiCaVf11LA9g/FcTdm
15Y+9Yh9dKOVy77j0cB6ltpQmWGEekvHbn68bKyh0j6Q32Yyj2UUVeGNKBSRKuXE
8Jf5D5VmzRREfH8HHp/uBmERHaRAOY2Cbv+1xDjekWMOrCOspQiAm9vWDTQuMz0t
790IzmmkpiJw7flX4pTtMOoZAk4idn+7t40UNe4SyafrYn8oeQyTw7FXb74iojNJ
9RTCGtgG9hYNLPboEswieQFROf0W3K+iCSwAoJDOPFiO194GUrXAkJDzO2+Law3+
DZymJH7oHFbonM8DoswISUx2iB9fJj1T4j2UofyIG9yp+0UkrCm43ATnD5KmccQI
fQOsDuEStSgC3nWTwokC4uWzOj9Vvl1AjkAqhnFO8sleaheZTdYF/Y1F8gN1Dto2
taB4LagCiwf/g8fxhByyahiZT2MYojB1/Lk0AUgS4+zA3RG9c4DgNpbRJHGS/znH
BP6f/cALWrG08fnxJ2cfDyH2khrEkvJmvpfGOTjjb1g1O2n0yIXyNpIJBYBLGyS/
ItKot/47CQswCgO3hwAnmZQnb6n18lKx7sx0VjWu9xqGDFds0xvEmL1jE1yTLflO
Z7sFr7YNH6TBZT9ES2+bDODJth3BkowB99E/X3LTbVQk0CR5Peg=
=H2CU
-----END PGP SIGNATURE-----

--qVyHzDF4yf4A8jkR--
