Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tQ3J846wDzDvPc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 15:39:20 +1100 (AEDT)
Date: Fri, 25 Nov 2016 15:39:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
Subject: Re: [PATCH kernel v6 5/7] vfio/spapr: Postpone default window creation
Message-ID: <20161125043904.GE12287@umbus.fritz.box>
References: <1479966490-8739-1-git-send-email-aik@ozlabs.ru>
 <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
In-Reply-To: <1479966490-8739-6-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 24, 2016 at 04:48:08PM +1100, Alexey Kardashevskiy wrote:
> We are going to allow the userspace to configure container in
> one memory context and pass container fd to another so
> we are postponing memory allocations accounted against
> the locked memory limit. One of previous patches took care of
> it_userspace.
>=20
> At the moment we create the default DMA window when the first group is
> attached to a container; this is done for the userspace which is not
> DDW-aware but familiar with the SPAPR TCE IOMMU v2 in the part of memory
> pre-registration - such client expects the default DMA window to exist.
>=20
> This postpones the default DMA window allocation till one of
> the folliwing happens:
> 1. first map/unmap request arrives;
> 2. new window is requested;
> This adds noop for the case when the userspace requested removal
> of the default window which has not been created yet.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Hmm.. it just occurred to me: why do you even need to delay creation
of the default window?

In order to allow the open container - move to new process - map
scenario you need to delay binding of the mm to the container until
mapping actually occurs.  And if you're doing that, you also want to
delay allocation of the userspace table view, since the "userspace
view" is only well defined once you're bound to a particular mm.

But I don't see why you can't actually create the window - including
the actual TCE table and all - before that point.  After all, in the
non-ddw case that's effectively what happens - the fixed window is
there all the time.

If you leave the creation of the default window at the point the first
group is bound to the container, I think you'll simplify things -
including because you'll remove an extra difference between the ddw
and non-ddw cases.

The you treat the binding of a table to an mm as a later step, that
should go together with the allocation of the userspace view.

> ---
> Changes:
> v6:
> * new helper tce_iommu_create_default_window() moved to a separate patch;
> * creates a default window when new window is requested; it used to
> reset the def_window_pending flag instead;
> * def_window_pending handling (mostly) localized in
> tce_iommu_create_default_window() now, the only exception is removal
> of not yet created default window.
> ---
>  drivers/vfio/vfio_iommu_spapr_tce.c | 40 +++++++++++++++++++++++--------=
------
>  1 file changed, 25 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iomm=
u_spapr_tce.c
> index a67bbfd..88622be 100644
> --- a/drivers/vfio/vfio_iommu_spapr_tce.c
> +++ b/drivers/vfio/vfio_iommu_spapr_tce.c
> @@ -97,6 +97,7 @@ struct tce_container {
>  	struct mutex lock;
>  	bool enabled;
>  	bool v2;
> +	bool def_window_pending;
>  	unsigned long locked_pages;
>  	struct iommu_table *tables[IOMMU_TABLE_GROUP_MAX_TABLES];
>  	struct list_head group_list;
> @@ -717,6 +718,9 @@ static long tce_iommu_create_default_window(struct tc=
e_container *container)
>  	struct tce_iommu_group *tcegrp;
>  	struct iommu_table_group *table_group;
> =20
> +	if (!container->def_window_pending)
> +		return 0;
> +
>  	if (!tce_groups_attached(container))
>  		return -ENODEV;
> =20
> @@ -730,6 +734,9 @@ static long tce_iommu_create_default_window(struct tc=
e_container *container)
>  			table_group->tce32_size, 1, &start_addr);
>  	WARN_ON_ONCE(!ret && start_addr);
> =20
> +	if (!ret)
> +		container->def_window_pending =3D false;
> +
>  	return ret;
>  }
> =20
> @@ -823,6 +830,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  				VFIO_DMA_MAP_FLAG_WRITE))
>  			return -EINVAL;
> =20
> +		ret =3D tce_iommu_create_default_window(container);
> +		if (ret)
> +			return ret;
> +
>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>  		if (num < 0)
>  			return -ENXIO;
> @@ -886,6 +897,10 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (param.flags)
>  			return -EINVAL;
> =20
> +		ret =3D tce_iommu_create_default_window(container);
> +		if (ret)
> +			return ret;
> +
>  		num =3D tce_iommu_find_table(container, param.iova, &tbl);
>  		if (num < 0)
>  			return -ENXIO;
> @@ -1012,6 +1027,10 @@ static long tce_iommu_ioctl(void *iommu_data,
> =20
>  		mutex_lock(&container->lock);
> =20
> +		ret =3D tce_iommu_create_default_window(container);
> +		if (ret)
> +			return ret;
> +
>  		ret =3D tce_iommu_create_window(container, create.page_shift,
>  				create.window_size, create.levels,
>  				&create.start_addr);
> @@ -1044,6 +1063,11 @@ static long tce_iommu_ioctl(void *iommu_data,
>  		if (remove.flags)
>  			return -EINVAL;
> =20
> +		if (container->def_window_pending && !remove.start_addr) {
> +			container->def_window_pending =3D false;
> +			return 0;
> +		}
> +
>  		mutex_lock(&container->lock);
> =20
>  		ret =3D tce_iommu_remove_window(container, remove.start_addr);
> @@ -1141,7 +1165,6 @@ static int tce_iommu_attach_group(void *iommu_data,
>  	struct tce_container *container =3D iommu_data;
>  	struct iommu_table_group *table_group;
>  	struct tce_iommu_group *tcegrp =3D NULL;
> -	bool create_default_window =3D false;
> =20
>  	mutex_lock(&container->lock);
> =20
> @@ -1189,25 +1212,12 @@ static int tce_iommu_attach_group(void *iommu_dat=
a,
>  	} else {
>  		ret =3D tce_iommu_take_ownership_ddw(container, table_group);
>  		if (!tce_groups_attached(container) && !container->tables[0])
> -			create_default_window =3D true;
> +			container->def_window_pending =3D true;
>  	}
> =20
>  	if (!ret) {
>  		tcegrp->grp =3D iommu_group;
>  		list_add(&tcegrp->next, &container->group_list);
> -		/*
> -		 * If it the first group attached, check if there is
> -		 * a default DMA window and create one if none as
> -		 * the userspace expects it to exist.
> -		 */
> -		if (create_default_window) {
> -			ret =3D tce_iommu_create_default_window(container);
> -			if (ret) {
> -				list_del(&tcegrp->next);
> -				tce_iommu_release_ownership_ddw(container,
> -						table_group);
> -			}
> -		}
>  	}
> =20
>  unlock_exit:

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYN8BoAAoJEGw4ysog2bOSDRgP/0AVPCjQ05Pcyhla3k+Xq+pO
b0o3hTBqhueAhD2RRvwrugregmzpMz9p++K0dPcnoNh+z2QGFlY0nl/BmIW5s5rt
hnuaLlrb/C4ML+kMXGX9sNwofwYxhv2jNCblBvazcSm18cuBgByVIfQj5Jlckh5u
LVzCnO1g2oCdciMo0B4+WsSqW7mQkNPj7fDNmPNwGwuCAiFEitDeZjEqG1Ctlp6+
3BfBBTKw/qtLtHx43lmwYUGjuAu3ob6qv+xhll4nbY9Aw1glededP94qUgZovWvK
Tf1ICp0Pz8t8wtwSUCJRbG5qpwUTH3i3+c91VBPeBKPzUKMr8ISUPB8Tbkanalwc
Vbpm5zVRgegoJ7ufGPCbCD1/UbDvAiSybmXqOm7iQalXxRsMx/M8U5F7aTgtDMj/
rwkIIomqfHUWqLfUyWkuirIn35eYWpHMuTGxXGojok2GGUNj7AthX0nJMbnEOulS
gdpnQnhjGmF4UX40IPQd7HctL1zKFO+8Ft4D8eWE3OGu4XeTUJp4JdeHNTB7Xyea
jztVokLcL90wQNd1MlLpFZfBs5wYk2zwfv8js5lAEs16VwQ6oXMYh/5gYA5STAZW
347OTppsWixTBax/HQq4cfnrmNZD+u9Hhqj/lXvqCHb3POz7GtcLxv74GoelQI+y
Io3kVe4jv86SR+dUu1Lr
=TrSF
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
