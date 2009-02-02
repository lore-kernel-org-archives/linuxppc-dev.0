Return-Path: <eric@anholt.net>
Received: from kingsolver.anholt.net (69-30-77-85.dq1sn.easystreet.com
	[69.30.77.85]) by ozlabs.org (Postfix) with ESMTP id 656A7DDF00
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 08:01:07 +1100 (EST)
Subject: Re: [PATCH 3/3] drm: Make drm_local_map use a resource_size_t offset
From: Eric Anholt <eric@anholt.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090202055559.8D600DDF51@ozlabs.org>
References: <20090202055559.8D600DDF51@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-E8P7eaaBYc6sPdjDdUDB"
Date: Mon, 02 Feb 2009 13:01:04 -0800
Message-Id: <1233608464.4932.15.camel@gaiman>
Mime-Version: 1.0
Cc: David Airlie <airlied@linux.ie>, linuxppc-dev@ozlabs.org,
	dri-devel@lists.sf.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-E8P7eaaBYc6sPdjDdUDB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-02-02 at 16:55 +1100, Benjamin Herrenschmidt wrote:
> This changes drm_local_map to use a resource_size for its "offset"
> member instead of an unsigned long, thus allowing 32-bit machines
> with a >32-bit physical address space to be able to store there
> their register or framebuffer addresses when those are above 4G,
> such as when using a PCI video card on a recent AMCC 440 SoC.
>=20
> This patch isn't as "trivial" as it sounds: A few functions needed
> to have some unsigned long/int changed to resource_size_t and a few
> printk's had to be adjusted.
>=20
> But also, because userspace isn't capable of passing such offsets,
> I had to modify drm_find_matching_map() to ignore the offset passed
> in for maps of type _DRM_FRAMEBUFFER or _DRM_REGISTERS.
>=20
> If we ever support multiple _DRM_FRAMEBUFFER or _DRM_REGISTERS maps
> for a given device, we might have to change that trick, but I don't
> think that happens on any current driver.
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Just one little comment I think then I'd be happy:

> ---
>=20
>  drivers/gpu/drm/drm_bufs.c         |   33 ++++++++++++++++++++++++------=
---
>  drivers/gpu/drm/drm_proc.c         |    4 ++--
>  drivers/gpu/drm/drm_vm.c           |   22 ++++++++++++----------
>  drivers/gpu/drm/mga/mga_dma.c      |   17 +++++++++--------
>  drivers/gpu/drm/mga/mga_drv.h      |    4 ++--
>  drivers/gpu/drm/r128/r128_cce.c    |    7 ++++---
>  drivers/gpu/drm/radeon/radeon_cp.c |    9 +++++----
>  include/drm/drmP.h                 |   12 ++++++------
>  8 files changed, 64 insertions(+), 44 deletions(-)
>=20
> --- linux-work.orig/drivers/gpu/drm/drm_bufs.c	2009-02-02 16:29:54.000000=
000 +1100
> +++ linux-work/drivers/gpu/drm/drm_bufs.c	2009-02-02 16:29:54.000000000 +=
1100
> @@ -54,11 +54,25 @@ static struct drm_map_list *drm_find_mat
>  {
>  	struct drm_map_list *entry;
>  	list_for_each_entry(entry, &dev->maplist, head) {
> -		if (entry->map && (entry->master =3D=3D dev->primary->master) && (map-=
>type =3D=3D entry->map->type) &&
> -		    ((entry->map->offset =3D=3D map->offset) ||
> -		     ((map->type =3D=3D _DRM_SHM) && (map->flags&_DRM_CONTAINS_LOCK)))=
) {
> +		/* Due to userspace API breakage, we ignore the map offset
> +		 * for maps of type _DRM_FRAMEBUFFER or _DRM_REGISTERS
> +		 */

Could this comment instead be maybe:

Because the kernel-userspace ABI is fixed at a 32-bit offset, while PCI
resources may live above that, we ignore the map offset for maps of type
_DRM_FRAMEBUFFER or _DRM_REGISTERS.  It is assumed that each driver will
have only one resource of each type.

(I want to remember later what exact ABI problem was in question)

--=20
Eric Anholt
eric@anholt.net                         eric.anholt@intel.com



--=-E8P7eaaBYc6sPdjDdUDB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmHXxAACgkQHUdvYGzw6vd+vACZAUNoZYuI8kZREVPCX31gHpJB
8ZIAnjd03toEViXv8Sx5tIfcHso/SYOV
=5Oz9
-----END PGP SIGNATURE-----

--=-E8P7eaaBYc6sPdjDdUDB--
