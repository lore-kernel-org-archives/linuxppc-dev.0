Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tk97Q0cGFzDwRy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 20:57:38 +1100 (AEDT)
Date: Wed, 21 Dec 2016 17:04:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
Subject: Re: [PATCH kernel v2 09/11] vfio iommu: Add helpers to (un)register
 blocking notifiers per group
Message-ID: <20161221060418.GF13024@umbus.fritz.box>
References: <20161218012900.18142-1-aik@ozlabs.ru>
 <20161218012900.18142-10-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
In-Reply-To: <20161218012900.18142-10-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 18, 2016 at 12:28:58PM +1100, Alexey Kardashevskiy wrote:
> c086de81 "vfio iommu: Add blocking notifier to notify DMA_UNMAP" added
> notifiers to a VFIO group. However even though the code underneath
> uses groups, the API takes device struct pointers.
>=20
> This adds helpers which do the same thing but take IOMMU groups instead.
>=20
> This adds vfio_iommu_group_set_kvm() which is a wrapper on top of
> vfio_group_set_kvm() but also takes an iommu_group.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Adding a second interface in parallel seems dubious.

Should the existing interface just be replaced with this one?

Or can the existing interface be re-implemented in terms of this one?

> ---
>  include/linux/vfio.h |  6 +++++
>  drivers/vfio/vfio.c  | 76 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 82 insertions(+)
>=20
> diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> index edf9b2cad277..8a3488ba4732 100644
> --- a/include/linux/vfio.h
> +++ b/include/linux/vfio.h
> @@ -127,9 +127,15 @@ extern int vfio_register_notifier(struct device *dev,
>  extern int vfio_unregister_notifier(struct device *dev,
>  				    enum vfio_notify_type type,
>  				    struct notifier_block *nb);
> +extern int vfio_iommu_group_register_notifier(struct iommu_group *grp,
> +		enum vfio_notify_type type, unsigned long *events,
> +		struct notifier_block *nb);
> +extern int vfio_iommu_group_unregister_notifier(struct iommu_group *grp,
> +		enum vfio_notify_type type, struct notifier_block *nb);
> =20
>  struct kvm;
>  extern void vfio_group_set_kvm(struct vfio_group *group, struct kvm *kvm=
);
> +extern void vfio_iommu_group_set_kvm(struct iommu_group *grp, struct kvm=
 *kvm);
> =20
>  /*
>   * Sub-module helpers
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index 9901c4671e2f..6b9a98508939 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -2077,6 +2077,23 @@ void vfio_group_set_kvm(struct vfio_group *group, =
struct kvm *kvm)
>  }
>  EXPORT_SYMBOL_GPL(vfio_group_set_kvm);
> =20
> +void vfio_iommu_group_set_kvm(struct iommu_group *grp, struct kvm *kvm)
> +{
> +	struct vfio_group *group;
> +
> +	if (!grp)
> +		return;
> +
> +	group =3D vfio_group_get_from_iommu(grp);
> +	if (!group)
> +		return;
> +
> +	vfio_group_set_kvm(group, kvm);
> +
> +	vfio_group_put(group);
> +}
> +EXPORT_SYMBOL_GPL(vfio_iommu_group_set_kvm);
> +
>  static int vfio_register_group_notifier(struct vfio_group *group,
>  					unsigned long *events,
>  					struct notifier_block *nb)
> @@ -2197,6 +2214,65 @@ int vfio_unregister_notifier(struct device *dev, e=
num vfio_notify_type type,
>  }
>  EXPORT_SYMBOL(vfio_unregister_notifier);
> =20
> +int vfio_iommu_group_register_notifier(struct iommu_group *iommugroup,
> +		enum vfio_notify_type type,
> +		unsigned long *events, struct notifier_block *nb)
> +{
> +	struct vfio_group *group;
> +	int ret;
> +
> +	if (!iommugroup || !nb || !events || (*events =3D=3D 0))
> +		return -EINVAL;
> +
> +	group =3D vfio_group_get_from_iommu(iommugroup);
> +	if (!group)
> +		return -ENODEV;
> +
> +	switch (type) {
> +	case VFIO_IOMMU_NOTIFY:
> +		ret =3D vfio_register_iommu_notifier(group, events, nb);
> +		break;
> +	case VFIO_GROUP_NOTIFY:
> +		ret =3D vfio_register_group_notifier(group, events, nb);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	vfio_group_put(group);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vfio_iommu_group_register_notifier);
> +
> +int vfio_iommu_group_unregister_notifier(struct iommu_group *grp,
> +		enum vfio_notify_type type, struct notifier_block *nb)
> +{
> +	struct vfio_group *group;
> +	int ret;
> +
> +	if (!grp || !nb)
> +		return -EINVAL;
> +
> +	group =3D vfio_group_get_from_iommu(grp);
> +	if (!group)
> +		return -ENODEV;
> +
> +	switch (type) {
> +	case VFIO_IOMMU_NOTIFY:
> +		ret =3D vfio_unregister_iommu_notifier(group, nb);
> +		break;
> +	case VFIO_GROUP_NOTIFY:
> +		ret =3D vfio_unregister_group_notifier(group, nb);
> +		break;
> +	default:
> +		ret =3D -EINVAL;
> +	}
> +
> +	vfio_group_put(group);
> +	return ret;
> +}
> +EXPORT_SYMBOL(vfio_iommu_group_unregister_notifier);
> +
>  /**
>   * Module/class support
>   */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYWhtgAAoJEGw4ysog2bOSKEcQAJJwnIFySN3dTvczPcZtAC8S
AMtUWuy7bWp6XXaynBbf99qd78yCwbsWOJkbKOCi7aG8UPqyTdA5CRqjJxFUr1R2
so+dIrPA617IyPrU/zNJ/6KbJN7GNP8YbZ8ELQnp6I8s1TDtGMdIK09PA1ElllWD
DI1LqEfm0bxNuOCwyag48Xbx+iEMxbJ/GgimH5EibFrQxIzFa7+6AMuuSuQhzRvd
F/LegximnS9kIUfXQaY1O3BU277FpZmoGaCe/nPMkMSPG2VnqFUlczTH1HXmX3gM
TS7Rhw6GwLeJgox6BvY8CEv3ggYvLIpMZsxT/4YKtOKWu1an3mBWg8UW9J/lUwi3
q4v+yOzsz3AM0AbJGXViWEUPQbpF1JYlNJ9qUYmqdqs8jyeJf2nF2GSLGA7uXy1Q
v6dnq44SwzkPehWY9tDubbgGskkMIQyEPYIqryJYXjiOcQ+rB5FGbr0uADLsLXqo
EU2vjw8AhfHdaYOMOYmnpyhGydOcO/KVkwrRRbxey20nhR6gfR3kX+bD3aaUzD7a
591OnxysRM/ZmXqhzxxbNIg2PlnzQ4DR3O698qr+xE279UDQq4RtCavK8Aboz21V
mG3Qn0pMLxmKbSvwT6pnWzx/TkPAnU0CAXtXFBGrCYn25lGpKtflJYqEhlWV0baM
Kx/q7OXzEVVw3VwV/fV5
=y4iB
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
