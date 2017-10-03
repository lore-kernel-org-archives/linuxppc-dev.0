Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5gx42lhjzDql8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 12:12:08 +1100 (AEDT)
Date: Tue, 3 Oct 2017 11:49:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Cc: kvm-ppc@vger.kernel.org, qemu-ppc@nongnu.org,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2] KVM: PPC: Book3S PR: only install valid SLBs during
 KVM_SET_SREGS
Message-ID: <20171003004956.GC2755@umbus.fritz.box>
References: <150693362232.15210.2878817650741484831.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
In-Reply-To: <150693362232.15210.2878817650741484831.stgit@bahia>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2017 at 10:40:22AM +0200, Greg Kurz wrote:
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
> also force a full SLB flush before installing new entries.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Seems sensible to me.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> v2: - flush SLB before installing new entries
> ---
>  arch/powerpc/kvm/book3s_pr.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 3beb4ff469d1..7cce08d610ae 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -1327,9 +1327,15 @@ static int kvm_arch_vcpu_ioctl_set_sregs_pr(struct=
 kvm_vcpu *vcpu,
> =20
>  	vcpu3s->sdr1 =3D sregs->u.s.sdr1;
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

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnS3rIACgkQbDjKyiDZ
s5JjExAA36LUfeYD7ZBM20mwMjsg2NPpIbIMtPprFVyDxgtZCVFrnPd8pHCNHKc8
jZUM7JlnE+x4LpJM0BL6bCRQM2PdBy8VoXUp1b7qLz8KKTNTkzgCUAABe0g84n9N
cSnPCblm3RkmvbY+t5y71xhkEFmn1O3pc3U6uWPEfyc9MDTIW55p4RKdBDdvE1cY
fAZ2Vh14TvrXz23hJALDBiGxvr8srSgNLHJj8R6GKt1zIvzba4nFcJdeTTf/Fqzj
SNrujmRGRzQBa6QY4dZzqV/Ne2oc5tk9wepTYOSmxh2Op6MT9G0kYJMWLcmnbDxm
VR2tLIOHYJJQuPMq0fK21wLrOgBMPwXg46YPhfT4k3XAy806Bm2BQYWqC9ISJk/K
IW2U2rsTAQ4nnQyDPdS9Bg8n4jTPCdcUX81Xj8je4esQTqmkdvNPeYD7b9L6Uec+
LXRUgKFPSXDqbCB+fnmqBPx3Ka8+9/bamvD3k5QEdFRPJxRTwyRKu0/vsscjCxRx
mePQMe3u6BIcoqoNatNvVjQ3oyWAh9reWvxpwqQhzN6UfaXqTZ/zqKbXHxa+XTc9
1+XVPe4KQx1uwS6MM6+R7mrUa2kczVlLEUz1Uzt5LLmMFt7VWOEhtRmL0NIAaZpz
pFF25z18GSxynOYdzz55ReS5kS9++bAFYyZ6ZLsklo2QSBtVihE=
=UFO7
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
