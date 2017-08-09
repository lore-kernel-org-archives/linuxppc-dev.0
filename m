Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xS2Fv25X3zDqty
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Aug 2017 17:00:03 +1000 (AEST)
Date: Wed, 9 Aug 2017 15:55:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org, Yongji Xie <elohimes@gmail.com>,
 Eric Auger <eric.auger@redhat.com>, Kyle Mahlkuch <Kyle.Mahlkuch@ibm.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jike Song <jike.song@intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Arvind Yadav <arvind.yadav.cs@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>,
 Neo Jia <cjia@nvidia.com>, Paul Mackerras <paulus@samba.org>,
 Vlad Tsyrklevich <vlad@tsyrklevich.net>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/5] iommu: Add capabilities to a group
Message-ID: <20170809055556.GK13670@umbus.fritz.box>
References: <20170807072548.3023-1-aik@ozlabs.ru>
 <20170807072548.3023-2-aik@ozlabs.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="nzri8VXeXB/g5ayr"
In-Reply-To: <20170807072548.3023-2-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--nzri8VXeXB/g5ayr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 07, 2017 at 05:25:44PM +1000, Alexey Kardashevskiy wrote:
> This introduces capabilities to IOMMU groups. The first defined
> capability is IOMMU_GROUP_CAP_ISOLATE_MSIX which tells the IOMMU
> group users that a particular IOMMU group is capable of MSIX message
> filtering; this is useful when deciding whether or not to allow mapping
> of MSIX table to the userspace. Various architectures will enable it
> when they decide that it is safe to do so.
>=20
> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This seems like a reasonable concept that's probably useful for
something, whether or not it's the best approach for the problem at
hand.

> ---
>  include/linux/iommu.h | 20 ++++++++++++++++++++
>  drivers/iommu/iommu.c | 28 ++++++++++++++++++++++++++++
>  2 files changed, 48 insertions(+)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 2cb54adc4a33..6b6f3c2f4904 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -155,6 +155,9 @@ struct iommu_resv_region {
>  	enum iommu_resv_type	type;
>  };
> =20
> +/* IOMMU group capabilities */
> +#define IOMMU_GROUP_CAP_ISOLATE_MSIX		(1U)
> +
>  #ifdef CONFIG_IOMMU_API
> =20
>  /**
> @@ -312,6 +315,11 @@ extern void *iommu_group_get_iommudata(struct iommu_=
group *group);
>  extern void iommu_group_set_iommudata(struct iommu_group *group,
>  				      void *iommu_data,
>  				      void (*release)(void *iommu_data));
> +extern void iommu_group_set_caps(struct iommu_group *group,
> +				 unsigned long clearcaps,
> +				 unsigned long setcaps);
> +extern bool iommu_group_is_capable(struct iommu_group *group,
> +				   unsigned long cap);
>  extern int iommu_group_set_name(struct iommu_group *group, const char *n=
ame);
>  extern int iommu_group_add_device(struct iommu_group *group,
>  				  struct device *dev);
> @@ -513,6 +521,18 @@ static inline void iommu_group_set_iommudata(struct =
iommu_group *group,
>  {
>  }
> =20
> +static inline void iommu_group_set_caps(struct iommu_group *group,
> +					unsigned long clearcaps,
> +					unsigned long setcaps)
> +{
> +}
> +
> +static inline bool iommu_group_is_capable(struct iommu_group *group,
> +					  unsigned long cap)
> +{
> +	return false;
> +}
> +
>  static inline int iommu_group_set_name(struct iommu_group *group,
>  				       const char *name)
>  {
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3f6ea160afed..6b2c34fe2c3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -52,6 +52,7 @@ struct iommu_group {
>  	void (*iommu_data_release)(void *iommu_data);
>  	char *name;
>  	int id;
> +	unsigned long caps;
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *domain;
>  };
> @@ -447,6 +448,33 @@ void iommu_group_set_iommudata(struct iommu_group *g=
roup, void *iommu_data,
>  EXPORT_SYMBOL_GPL(iommu_group_set_iommudata);
> =20
>  /**
> + * iommu_group_set_caps - Change the group capabilities
> + * @group: the group
> + * @clearcaps: capabilities mask to remove
> + * @setcaps: capabilities mask to add
> + *
> + * IOMMU groups can be capable of various features which device drivers
> + * may read and adjust the behavior.
> + */
> +void iommu_group_set_caps(struct iommu_group *group,
> +		unsigned long clearcaps, unsigned long setcaps)
> +{
> +	group->caps &=3D ~clearcaps;
> +	group->caps |=3D setcaps;
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_set_caps);
> +
> +/**
> + * iommu_group_is_capable - Returns if a group capability is present
> + * @group: the group
> + */
> +bool iommu_group_is_capable(struct iommu_group *group, unsigned long cap)
> +{
> +	return !!(group->caps & cap);
> +}
> +EXPORT_SYMBOL_GPL(iommu_group_is_capable);
> +
> +/**
>   * iommu_group_set_name - set name for a group
>   * @group: the group
>   * @name: name

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nzri8VXeXB/g5ayr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmKo+kACgkQbDjKyiDZ
s5I0vBAAhy1jVDxiK6a1NCKKJFq/IhRToUhelylStIdVsad3R9h0E1dq4elxrOcs
z976zHu5FRvCoaSD4SItOXSxHvqtDJRvnA94KL3ZZUF1ccfkDhMQy9UwXPDEwftU
rFbrdbjqqiJMiposBGxZTdlDbCLYB1Y0v0mfkCQudvaTHuNAzR18dT0TpWiA85ld
z/9nv/ztYNni8jYCLdLmLr4rUW4MmaKrTMdtGiEGz81EqMG09JyRqOGqOQ5FRNn2
5ORbkpINJKv4xRglYmBlXrhWrysSvWPCh9QfZohgOQmHmjxFg3GB0Wka/CvFVHfg
kuQFhTJWdHmLy3ucwDMlO48OQhxSZczRPNzGamFfMlEsrlrReGHmjmFhOy4awFSq
Eu7WmitKTzPrZ03MPpk7mNq271EOdgWkQhob1Nwi84JaQWJAbgNlGjiNy0ZzvVUz
gw/JsOe3FXjgLAWon3XWthHf/esWQQxficwuS0Nq2Wlf8eIv291GMEg45kEqLhaA
94PnizhHdWB4ZUIJ6G4CrpVcWHnMA5YyidOo9RxwrSrDA1ZIv3EwPBTR1jtjyjq1
wE6XKqsrtV/bRmH1VITr9uT1GuC3h0iLGFIeQgvbIy4Kaq6HcoXZV1JDaJq4m4nO
Uy3QWpn4vVvJtn3RWB4OuZQ8LSSI7yfzqOe7XUYpBbpY5C1NgPA=
=C9sa
-----END PGP SIGNATURE-----

--nzri8VXeXB/g5ayr--
