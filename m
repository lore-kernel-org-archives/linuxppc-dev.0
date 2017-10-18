Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yH05v3QBkzDrD6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Oct 2017 15:52:03 +1100 (AEDT)
Date: Wed, 18 Oct 2017 14:26:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: kvm-ppc@vger.kernel.org, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v3] KVM: PPC: Book3S PR: only install valid SLBs during
 KVM_SET_SREGS
Message-ID: <20171018032651.GN2776@umbus.fritz.box>
References: <150814978410.4979.16857563162569877345.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="88pBQ1/6ie/nQzMF"
In-Reply-To: <150814978410.4979.16857563162569877345.stgit@bahia.lan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--88pBQ1/6ie/nQzMF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 16, 2017 at 12:29:44PM +0200, Greg Kurz wrote:
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
> To avoid this, let's filter out non-valid SLB entries. While here, we
> also force a full SLB flush before installing new entries. Since SLB
> is for 64-bit only, we now build this path conditionally to avoid a
> build break on 32-bit, which doesn't define SLB_ESID_V.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v3: - build SLB path for 64-bit only [*]
>     - add blank line after declaration of rb and rs to silence checkpatch
>=20
> v2: - flush SLB before installing new entries
>=20
> [*] I'm wondering if other users of BOOK3S_HFLAG_SLB in this file
>     shouldn't be conditionally built as well, for consistency.
> ---
>  arch/powerpc/kvm/book3s_pr.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 3beb4ff469d1..68c1f8bc17c4 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1326,12 +1326,22 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struc=
t kvm_vcpu *vcpu,
>  	kvmppc_set_pvr_pr(vcpu, sregs->pvr);
> =20
>  	vcpu3s->sdr1 =3D sregs->u.s.sdr1;
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	if (vcpu->arch.hflags & BOOK3S_HFLAG_SLB) {
> +		/* Flush all SLB entries */
> +		vcpu->arch.mmu.slbmte(vcpu, 0, 0);
> +		vcpu->arch.mmu.slbia(vcpu);
> +
>  		for (i =3D 0; i < 64; i++) {
> -			vcpu->arch.mmu.slbmte(vcpu, sregs->u.s.ppc64.slb[i].slbv,
> -						    sregs->u.s.ppc64.slb[i].slbe);
> +			u64 rb =3D sregs->u.s.ppc64.slb[i].slbe;
> +			u64 rs =3D sregs->u.s.ppc64.slb[i].slbv;
> +
> +			if (rb & SLB_ESID_V)
> +				vcpu->arch.mmu.slbmte(vcpu, rs, rb);
>  		}
> -	} else {
> +	} else
> +#endif
> +	{
>  		for (i =3D 0; i < 16; i++) {
>  			vcpu->arch.mmu.mtsrin(vcpu, i, sregs->u.s.ppc32.sr[i]);
>  		}
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--88pBQ1/6ie/nQzMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnmyfkACgkQbDjKyiDZ
s5K+gxAA1YYAjRTLaFdt+h93OTBXdvnpTnoyAqldDvOhGjLefvnPZLqK2SK+YWrs
qQFRHRQjzY017sY2fzN6w36fhL83u2qJoEYizvOCV/LPq+yCJ+hSI6yWcaWyWCNw
PNDlM8qkpQaXEwv+xZThwpZ4gvuM8XMUfUQoUVLnC9cMnuNaT5WKswL3kjbECY1D
2+yTzqzs/ASIB2MQrl5IEgFxd2hky281pZZcRL7hkXO09UE320l4It4FN9D/yteQ
7V71qNVRgjOa0y8uStLZngKpI1QcLPvDARoZwz/8JIxeqk3Vw8TCkakWSgqXV/TI
28bEfYFaLEQFIe8U5x2qBlRkEXUksGsLaBJ8adhZOm6Jdc/QktfRf6+iviY0raEU
C7Slx4t2/4Io4gcrSVP9662TSSP9I3pxECymci9ibPmzFfANF14iO3SNHfty86Pw
HEwWKbM4qiTqcWOWiOzwgm920u2sdnduf+DbcAD0mwlO39nx4at3HLbFYDTws4Lj
25Un0yK4Qc7DUQDB7fK3Q37CLGWmGjKZuCbk7EjhrRTPbxHo3MmFdhD1vA3aFU8x
ixPQSJjg8eOid0kZOvK1LnGh3N9pQOT5K8Q0VHfEsLpanS7IPqpauBzDpiMU9KAY
VBHas/UeY7j/caJbBuELxvokWaOus8tmao54ksPeT6MQxabFnIg=
=9j9U
-----END PGP SIGNATURE-----

--88pBQ1/6ie/nQzMF--
