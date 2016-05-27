Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGDC52GbyzDqZG
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 14:52:17 +1000 (AEST)
Date: Fri, 27 May 2016 14:52:11 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@samba.org>
Cc: Alexander Graf <agraf@suse.de>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Subject: Re: [PATCH v2] spapr: Don't set the TM ibm, pa-features bit in PR KVM
 mode
Message-ID: <20160527045211.GZ17226@voom.fritz.box>
References: <20160404164457.539a55f0@kryten> <57021123.6050506@ozlabs.ru>
 <20160404204346.1cf44df8@kryten> <20160404210928.0d9ae644@kryten>
 <F99A6122-6B6D-45A3-99E2-2F56F143FB50@suse.de>
 <20160430104800.0a7c1d11@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="9FlPK/CTwZII6yRd"
In-Reply-To: <20160430104800.0a7c1d11@kryten>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--9FlPK/CTwZII6yRd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 30, 2016 at 10:48:00AM +1000, Anton Blanchard wrote:
> We don't support transactional memory in PR KVM, so don't tell
> the OS that we do.
>=20
> Signed-off-by: Anton Blanchard <anton@samba.org>

Relying on CAP_PPC_GET_PVINFO is a hack we need in some cases, but
it's not something to be encouraged.  I'd prefer to see this examining
a new capability specifically advertising TM support in KVM, with a
fallback to PVINFO if necessary.

Come to that, we probably shouldn't be advertising TM support in TCG,
either, since IIRC our "support" for the TM instructions there is
basically worse than useless.

> ---
>=20
> v2: Fix build with CONFIG_KVM disabled, noticed by Alex.
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index b69995e..dc3e3c9 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -696,6 +696,14 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
>      } else /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */ {
>          pa_features =3D pa_features_207;
>          pa_size =3D sizeof(pa_features_207);
> +
> +#ifdef CONFIG_KVM
> +        /* Don't enable TM in PR KVM mode */
> +        if (kvm_enabled() &&
> +            kvm_vm_check_extension(cs->kvm_state, KVM_CAP_PPC_GET_PVINFO=
)) {
> +            pa_features[24] &=3D ~0x80;
> +        }
> +#endif
>      }
>      if (env->ci_large_pages) {
>          pa_features[3] |=3D 0x20;
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9FlPK/CTwZII6yRd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXR9J6AAoJEGw4ysog2bOSovYP/RhJYZNv+HE+O7LwtlEwRFuJ
2/GSydZMUF9RC80aqZMmmDkcUKDAF6MkRgoiLAwxNGXFs4sK03N3+qErZIiB968f
bNq2ie1A7AKsZReAkS9fDKkHQ3y8/GbSRD/348Ub4676O7W2KdGdjDO/C28Kf4AZ
3Y/NLmxxfcEmuUG1ZGCmhl9wtwxff1nDiXl+4dHmrAgyRCvboUIZC8iQ7Mb2de+2
CEQjKW1v0j0jMp60zy0VtG+Ey5zDiXYshhUI7pUXzBnEljkC3XIsHfWuhxBy0PoZ
WVK81d9rvRGx8l1tfN0ZABFTUgNqBTl8+f8vxRfwUY2QZ3a3wOzOjrx5tOAHbeS2
WeMScUOlPVmgZpf24xCQvwIuO3RvelbclBCYFVcGXwUvGd9F6NCfzZ3XO1oyo+yN
IDjD8tIZDQGtOjros3ghauMyQETirV3EhVYy4xKIHOLj9+KKGfpINgvET5Twej6j
acD4IeNIcZxvDH5msWclsSJEd2Wdf3oekrTEpfqsDtC+AKQPRFyVNEdyeiUFcKfQ
URdCIt2O5zIYFPJQuSgpxVFLguk1xEO7lAxz9vFcmNzCbxIu1r1rqPsHXnT1e/FO
TmIk1c6Hb4Yet8ZozGo9O6Btzkmx2Zzzjl9NMRjdLSCD/U6ZXzfl4ImCi8n9bkMc
QGhvCkeeqoep3Fzt36N/
=Rx8n
-----END PGP SIGNATURE-----

--9FlPK/CTwZII6yRd--
