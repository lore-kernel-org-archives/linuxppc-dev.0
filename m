Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2d8Y1xt4zDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 11:56:29 +1000 (AEST)
Date: Thu, 28 Sep 2017 11:45:05 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Bobroff <sam.bobroff@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org, paulus@samba.org,
 benh@kernel.crashing.org, pbonzini@redhat.com
Subject: Re: [PATCH 1/1] KVM: PPC: Book3S: Fix server always zero from
 kvmppc_xive_get_xive()
Message-ID: <20170928014505.GW12504@umbus>
References: <4585437e86d14900985c7e16bfd4afef672b26c7.1506408341.git.sam.bobroff@au1.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="6AmSH+YAqnsWd9jO"
In-Reply-To: <4585437e86d14900985c7e16bfd4afef672b26c7.1506408341.git.sam.bobroff@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--6AmSH+YAqnsWd9jO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 26, 2017 at 04:47:04PM +1000, Sam Bobroff wrote:
> In KVM's XICS-on-XIVE emulation, kvmppc_xive_get_xive() returns the
> value of state->guest_server as "server". However, this value is not
> set by it's counterpart kvmppc_xive_set_xive(). When the guest uses
> this interface to migrate interrupts away from a CPU that is going
> offline, it sees all interrupts as belonging to CPU 0, so they are
> left assigned to (now) offline CPUs.
>=20
> This patch removes the guest_server field from the state, and returns
> act_server in it's place (that is, the CPU actually handling the
> interrupt, which may differ from the one requested).
>=20
> Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE
> interrupt controller")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>
> ---
> The other obvious way to patch this would be to set state->guest_server in
> kvmppc_xive_set_xive() and that does also work because act_server is usua=
lly
> equal to guest_server.
>=20
> However, in the cases where guest_server differed from act_server, the gu=
est
> would only move IRQs correctly if it got act_server (the CPU actually han=
dling
> the interrupt) here. So, that approach seemed better.

Paolo, again this is a pretty urgent fix for KVM on Power and Paulus
is away.  We're hoping BenH will ack shortly (he's the logical
technical reviewer), after which can you merge this direct into the
KVM staging tree?  (RHBZ 1477391, and we suspect several more are
related).

>  arch/powerpc/kvm/book3s_xive.c | 5 ++---
>  arch/powerpc/kvm/book3s_xive.h | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xiv=
e.c
> index 13304622ab1c..bf457843e032 100644
> --- a/arch/powerpc/kvm/book3s_xive.c
> +++ b/arch/powerpc/kvm/book3s_xive.c
> @@ -622,7 +622,7 @@ int kvmppc_xive_get_xive(struct kvm *kvm, u32 irq, u3=
2 *server,
>  		return -EINVAL;
>  	state =3D &sb->irq_state[idx];
>  	arch_spin_lock(&sb->lock);
> -	*server =3D state->guest_server;
> +	*server =3D state->act_server;
>  	*priority =3D state->guest_priority;
>  	arch_spin_unlock(&sb->lock);
> =20
> @@ -1331,7 +1331,7 @@ static int xive_get_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	xive->saved_src_count++;
> =20
>  	/* Convert saved state into something compatible with xics */
> -	val =3D state->guest_server;
> +	val =3D state->act_server;
>  	prio =3D state->saved_scan_prio;
> =20
>  	if (prio =3D=3D MASKED) {
> @@ -1507,7 +1507,6 @@ static int xive_set_source(struct kvmppc_xive *xive=
, long irq, u64 addr)
>  	/* First convert prio and mark interrupt as untargetted */
>  	act_prio =3D xive_prio_from_guest(guest_prio);
>  	state->act_priority =3D MASKED;
> -	state->guest_server =3D server;
> =20
>  	/*
>  	 * We need to drop the lock due to the mutex below. Hopefully
> diff --git a/arch/powerpc/kvm/book3s_xive.h b/arch/powerpc/kvm/book3s_xiv=
e.h
> index 5938f7644dc1..6ba63f8e8a61 100644
> --- a/arch/powerpc/kvm/book3s_xive.h
> +++ b/arch/powerpc/kvm/book3s_xive.h
> @@ -35,7 +35,6 @@ struct kvmppc_xive_irq_state {
>  	struct xive_irq_data *pt_data;	/* XIVE Pass-through associated data */
> =20
>  	/* Targetting as set by guest */
> -	u32 guest_server;		/* Current guest selected target */
>  	u8 guest_priority;		/* Guest set priority */
>  	u8 saved_priority;		/* Saved priority when masking */
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6AmSH+YAqnsWd9jO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnMVB8ACgkQbDjKyiDZ
s5IxxQ/9GEFSe/tIVqd0znIglYacHEgwPUPX3QFY9Z9ZslulHhVPhiZ5Kp5qOdEA
6RWlv0YJUqiPBtk22PJJyh/GChMmi2aOPSNLTXaxQ8z6B1qSG1RHlWyFwALKoKVq
2WuiZ4uLR/28MpC8e3rsKZH1eiPYcAcSMckVplKbpceq4WRBhRF8OyC7FLay0iTi
cY0MeQR6n6R0NzGpvWKYboWxAO3kgfEVF+rGJ1dIGkjhU9IsIwyxwBc4LDcVb8sF
0sLxu8KoDiAgyqETTAlnJTRZ4qtSiuetKS/cLeBC0YUa8oUyvoNhCrc8vIfbJQ8z
eDRgzWV1o+cyiz2ps0lOAXMND1/bHkZV4tizfAqvA/DkxIfBdnjVdOavphVDGx7K
QWP+c/FRNvcje+W+pngcFxddkcZIrTmEb9SDCmMkHj8qgkPH0QSZxLdThhMYYna2
LerEKNQawOp1xx8PPs461+x4NAgGnZ0UtO7enNWaj9q7TuBM/tLFPt8ha3ZdF0Op
aEBQNw+JwcFiHFXpCp6amPg1wW2JgYeat/PMsOOkHfWmErb2olo40hj7lo2zxH6T
Ih+zXZQMSBmwea9nfJgclKmYwhamB4Suz9ZOgThveJR6BrJs9qLUUUMYnUF96xwG
tdJsEqbpRnIi3/KQa+SX1XSRSLWwIwBVCEc5zG/+0hSoHLAbQzE=
=Ds2x
-----END PGP SIGNATURE-----

--6AmSH+YAqnsWd9jO--
