Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xHLfB1qtpzDqmS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Jul 2017 13:47:30 +1000 (AEST)
Date: Wed, 26 Jul 2017 13:25:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] include/linux/vfio.h: Guard powerpc-specific
 functions with CONFIG_VFIO_SPAPR_EEH
Message-ID: <20170726032548.GA31874@umbus.fritz.box>
References: <20170718172220.9954-1-mopsfelder@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20170718172220.9954-1-mopsfelder@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 02:22:20PM -0300, Murilo Opsfelder Araujo wrote:
> When CONFIG_EEH=3Dy and CONFIG_VFIO_SPAPR_EEH=3Dn, build fails with the
> following:
>=20
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_release':
>     vfio_pci.c:(.text+0xa98): undefined reference to `.vfio_spapr_pci_eeh=
_release'
>     drivers/vfio/pci/vfio_pci.o: In function `.vfio_pci_open':
>     vfio_pci.c:(.text+0x1420): undefined reference to `.vfio_spapr_pci_ee=
h_open'
>=20
> In this case, vfio_pci.c should use the empty definitions of
> vfio_spapr_pci_eeh_open and vfio_spapr_pci_eeh_release functions.
>=20
> This patch fixes it by guarding these function definitions with
> CONFIG_VFIO_SPAPR_EEH, the symbol that controls whether vfio_spapr_eeh.c =
is
> built, which is where the non-empty versions of these functions are. We n=
eed to
> make use of IS_ENABLED() macro because CONFIG_VFIO_SPAPR_EEH is a tristate
> option.
>=20
> This issue was found during a randconfig build. Logs are here:
>=20
>     http://kisskb.ellerman.id.au/kisskb/buildresult/12982362/
>=20
> Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Changes from v1:
> - Rebased on top of next-20170718.
>=20
>  include/linux/vfio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index 586809a..a47b985 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -152,7 +152,7 @@ extern int vfio_set_irqs_validate_and_prepare(struct =
vfio_irq_set *hdr,
>  					      size_t *data_size);
>=20
>  struct pci_dev;
> -#ifdef CONFIG_EEH
> +#if IS_ENABLED(CONFIG_VFIO_SPAPR_EEH)
>  extern void vfio_spapr_pci_eeh_open(struct pci_dev *pdev);
>  extern void vfio_spapr_pci_eeh_release(struct pci_dev *pdev);
>  extern long vfio_spapr_iommu_eeh_ioctl(struct iommu_group *group,
> @@ -173,7 +173,7 @@ static inline long vfio_spapr_iommu_eeh_ioctl(struct =
iommu_group *group,
>  {
>  	return -ENOTTY;
>  }
> -#endif /* CONFIG_EEH */
> +#endif /* CONFIG_VFIO_SPAPR_EEH */
>=20
>  /*
>   * IRQfd - generic

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4C7oACgkQbDjKyiDZ
s5LFFRAAzB3W+HTxJa/3qUHsPpdZkBlNg0rTH1d3/sQJCcBrGVRLnowphSkycB0n
aFWjQyEhBmimve9IcoMo5i0XH46SVQhk/OqogxgoJqb3qsGV0wEj2aW4lW1jfa1u
GBMSFNL9qzjDV+4LSAfpHiTbZxKWGMjjMp8qMklK9NNkeIXTMB03OURVO8wNneFM
IgkHn60LSE4l5yTjuRsjDPcSmlwaiSZosHAjezLoNCT0Ozz3kyY3DGEMUG8B9b1y
cI6cqZ8DVXydTUJGyo5W8cPU2dVypYZscPrnU8kUw6IK80aYEGBeAucBwLEK9kT0
ajheFEJ8FYkuP7LPLkzNuBx6R08NLcm4tSaimQxQxJuV5YAmFw4I4X//L2e0seuo
1A3BkrZPuOuZf8aMg+YERw9zAJUt/nXxcbbxM36uSBmIbz9qKiokVT4R/sqgJZj8
l5ugqV4Js27myaP7bAO3FRvLMD4tBxnlPv2vszKBfKRqH9aaF+Re8cdDrKWW7Dw2
SSQ+zTAcLkCHUrc9/h3iCO++U96cxP4PtQiQst3C0AeeArmh/LgHcYkCbeQFzgzK
XEqbrAwGNdalbOxgC238dqNFnjw01qQUNBs4eshMYb4qiwCN2HtTkAa+i9286zKt
nWOuA/3GOUMxlbopBnb+rIh6nuOiKI7RbdpK0inP8kULVZoSJQY=
=JpLZ
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
