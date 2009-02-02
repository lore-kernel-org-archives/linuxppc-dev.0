Return-Path: <eric@anholt.net>
Received: from kingsolver.anholt.net (69-30-77-85.dq1sn.easystreet.com
	[69.30.77.85]) by ozlabs.org (Postfix) with ESMTP id 2B418DDF34
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Feb 2009 06:08:31 +1100 (EST)
Subject: Re: [PATCH 1/3] drm: Use resource_size_t for
	drm_get_resource_{start, len}
From: Eric Anholt <eric@anholt.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090202055557.57CECDDF4A@ozlabs.org>
References: <20090202055557.57CECDDF4A@ozlabs.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-3fT8HN9wKDnTyGEibrMF"
Date: Mon, 02 Feb 2009 11:02:43 -0800
Message-Id: <1233601363.4932.0.camel@gaiman>
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


--=-3fT8HN9wKDnTyGEibrMF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2009-02-02 at 16:55 +1100, Benjamin Herrenschmidt wrote:
> The DRM uses its own wrappers to obtain resources from PCI devices,
> which currently convert the resource_size_t into an unsigned long.
>=20
> This is broken on 32-bit platforms with >32-bit physical address
> space.
>=20
> This fixes them, along with a few occurences of unsigned long used
> to store such a resource in drivers.

Do we just want to dump the wrappers, instead?

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>=20
>  drivers/gpu/drm/drm_bufs.c          |    4 ++--
>  drivers/gpu/drm/i915/i915_dma.c     |    2 +-
>  drivers/gpu/drm/mga/mga_drv.h       |    4 ++--
>  drivers/gpu/drm/radeon/radeon_drv.h |    2 +-
>  drivers/gpu/drm/savage/savage_bci.c |    8 ++++----
>  include/drm/drmP.h                  |    6 +++---
>  include/drm/drm_crtc.h              |    2 +-
>  7 files changed, 14 insertions(+), 14 deletions(-)
>=20
> --- linux-work.orig/drivers/gpu/drm/drm_bufs.c	2009-02-02 14:11:26.000000=
000 +1100
> +++ linux-work/drivers/gpu/drm/drm_bufs.c	2009-02-02 14:11:35.000000000 +=
1100
> @@ -36,13 +36,13 @@
>  #include <linux/vmalloc.h>
>  #include "drmP.h"
> =20
> -unsigned long drm_get_resource_start(struct drm_device *dev, unsigned in=
t resource)
> +resource_size_t drm_get_resource_start(struct drm_device *dev, unsigned =
int resource)
>  {
>  	return pci_resource_start(dev->pdev, resource);
>  }
>  EXPORT_SYMBOL(drm_get_resource_start);
> =20
> -unsigned long drm_get_resource_len(struct drm_device *dev, unsigned int =
resource)
> +resource_size_t drm_get_resource_len(struct drm_device *dev, unsigned in=
t resource)
>  {
>  	return pci_resource_len(dev->pdev, resource);
>  }
> Index: linux-work/drivers/gpu/drm/i915/i915_dma.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/gpu/drm/i915/i915_dma.c	2009-02-02 14:25:44.0=
00000000 +1100
> +++ linux-work/drivers/gpu/drm/i915/i915_dma.c	2009-02-02 14:28:19.000000=
000 +1100
> @@ -1051,7 +1051,7 @@ void i915_master_destroy(struct drm_devi
>  int i915_driver_load(struct drm_device *dev, unsigned long flags)
>  {
>  	struct drm_i915_private *dev_priv =3D dev->dev_private;
> -	unsigned long base, size;
> +	resource_size_t base, size;
>  	int ret =3D 0, mmio_bar =3D IS_I9XX(dev) ? 0 : 1;
> =20
>  	/* i915 has 4 more counters */
> Index: linux-work/drivers/gpu/drm/mga/mga_drv.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/gpu/drm/mga/mga_drv.h	2009-02-02 14:18:10.000=
000000 +1100
> +++ linux-work/drivers/gpu/drm/mga/mga_drv.h	2009-02-02 14:18:37.00000000=
0 +1100
> @@ -113,8 +113,8 @@ typedef struct drm_mga_private {
>  	 * \sa drm_mga_private_t::mmio
>  	 */
>  	/*@{ */
> -	u32 mmio_base;		   /**< Bus address of base of MMIO. */
> -	u32 mmio_size;		   /**< Size of the MMIO region. */
> +	resource_size_t mmio_base;	   /**< Bus address of base of MMIO. */
> +	resource_size_t mmio_size;	   /**< Size of the MMIO region. */
>  	/*@} */
> =20
>  	u32 clear_cmd;
> Index: linux-work/drivers/gpu/drm/radeon/radeon_drv.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/gpu/drm/radeon/radeon_drv.h	2009-02-02 14:13:=
35.000000000 +1100
> +++ linux-work/drivers/gpu/drm/radeon/radeon_drv.h	2009-02-02 14:13:44.00=
0000000 +1100
> @@ -316,7 +316,7 @@ typedef struct drm_radeon_private {
> =20
>  	/* starting from here on, data is preserved accross an open */
>  	uint32_t flags;		/* see radeon_chip_flags */
> -	unsigned long fb_aper_offset;
> +	resource_size_t fb_aper_offset;
> =20
>  	int num_gb_pipes;
>  	int track_flush;
> Index: linux-work/drivers/gpu/drm/savage/savage_bci.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/gpu/drm/savage/savage_bci.c	2009-02-02 14:15:=
43.000000000 +1100
> +++ linux-work/drivers/gpu/drm/savage/savage_bci.c	2009-02-02 14:16:04.00=
0000000 +1100
> @@ -599,8 +599,8 @@ int savage_driver_firstopen(struct drm_d
>  			    drm_mtrr_add(dev_priv->mtrr[2].base,
>  					 dev_priv->mtrr[2].size, DRM_MTRR_WC);
>  		} else {
> -			DRM_ERROR("strange pci_resource_len %08lx\n",
> -				  drm_get_resource_len(dev, 0));
> +			DRM_ERROR("strange pci_resource_len %08llx\n",
> +				  (unsigned long long)drm_get_resource_len(dev, 0));
>  		}
>  	} else if (dev_priv->chipset !=3D S3_SUPERSAVAGE &&
>  		   dev_priv->chipset !=3D S3_SAVAGE2000) {
> @@ -620,8 +620,8 @@ int savage_driver_firstopen(struct drm_d
>  			    drm_mtrr_add(dev_priv->mtrr[0].base,
>  					 dev_priv->mtrr[0].size, DRM_MTRR_WC);
>  		} else {
> -			DRM_ERROR("strange pci_resource_len %08lx\n",
> -				  drm_get_resource_len(dev, 1));
> +			DRM_ERROR("strange pci_resource_len %08llx\n",
> +				  (unsigned long long)drm_get_resource_len(dev, 1));
>  		}
>  	} else {
>  		mmio_base =3D drm_get_resource_start(dev, 0);
> Index: linux-work/include/drm/drmP.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/include/drm/drmP.h	2009-02-02 14:16:43.000000000 +110=
0
> +++ linux-work/include/drm/drmP.h	2009-02-02 14:16:57.000000000 +1100
> @@ -1173,10 +1173,10 @@ extern int drm_freebufs(struct drm_devic
>  extern int drm_mapbufs(struct drm_device *dev, void *data,
>  		       struct drm_file *file_priv);
>  extern int drm_order(unsigned long size);
> -extern unsigned long drm_get_resource_start(struct drm_device *dev,
> +extern resource_size_t drm_get_resource_start(struct drm_device *dev,
> +					      unsigned int resource);
> +extern resource_size_t drm_get_resource_len(struct drm_device *dev,
>  					    unsigned int resource);
> -extern unsigned long drm_get_resource_len(struct drm_device *dev,
> -					  unsigned int resource);
> =20
>  				/* DMA support (drm_dma.h) */
>  extern int drm_dma_setup(struct drm_device *dev);
> Index: linux-work/include/drm/drm_crtc.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/include/drm/drm_crtc.h	2009-02-02 14:24:56.000000000 =
+1100
> +++ linux-work/include/drm/drm_crtc.h	2009-02-02 14:25:03.000000000 +1100
> @@ -550,7 +550,7 @@ struct drm_mode_config {
>  	int min_width, min_height;
>  	int max_width, max_height;
>  	struct drm_mode_config_funcs *funcs;
> -	unsigned long fb_base;
> +	resource_size_t fb_base;
> =20
>  	/* pointers to standard properties */
>  	struct list_head property_blob_list;
>=20
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by:
> SourcForge Community
> SourceForge wants to tell your story.
> http://p.sf.net/sfu/sf-spreadtheword
> --
> _______________________________________________
> Dri-devel mailing list
> Dri-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/dri-devel
--=20
Eric Anholt
eric@anholt.net                         eric.anholt@intel.com



--=-3fT8HN9wKDnTyGEibrMF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkmHQ1AACgkQHUdvYGzw6vcOdACeN+2UQ41/MYYqsvNl/qz8pCez
oy0AmQFPTi3aYSW8x5ZcJIhzvtaOVUHO
=dFgk
-----END PGP SIGNATURE-----

--=-3fT8HN9wKDnTyGEibrMF--
