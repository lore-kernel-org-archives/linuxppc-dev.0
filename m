Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 66BE32C007D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Oct 2012 09:05:53 +1100 (EST)
Date: Mon, 22 Oct 2012 17:05:31 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3 v3] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Varun Sethi <Varun.Sethi@freescale.com>
References: <1350495170-4593-1-git-send-email-Varun.Sethi@freescale.com>
 <1350495170-4593-3-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1350495170-4593-3-git-send-email-Varun.Sethi@freescale.com>
 (from Varun.Sethi@freescale.com on Wed Oct 17 12:32:49 2012)
Message-ID: <1350943531.30970.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: joerg.roedel@amd.com, iommu@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Varun Sethi <Varun.Sethi@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2012 12:32:49 PM, Varun Sethi wrote:
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> change in v3:
> -renamed the stash attribute targets
>=20
>  include/linux/iommu.h |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..c3b9d73 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,33 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be =20
> mapped    */
>  	dma_addr_t aperture_end;   /* Last address that can be =20
> mapped     */
>  	bool force_aperture;       /* DMA only allowed in mappable =20
> range? */
> +
> +	/* The subwindows field indicates number of DMA subwindows =20
> supported
> +	 * by the geometry. Following is the interpretation of
> +	 * values for this field:
> +	 * 0 : This implies that the supported geometry size is 1 MB
> +         * with each subwindow size being 4KB. Thus number of =20
> subwindows

Whitespace

> +	 * being =3D 1MB/4KB =3D 256.
> +	 * 1 : Only one DMA window i.e. no subwindows.
> +	 * value other than 0 or 1 would indicate actual number of =20
> subwindows.
> +	 */

This language is way too specific for the generic geometry struct =20
(especially when you start talking about specific sizes).  Please =20
explain in implementation-neutral terms what this field means.

> @@ -60,6 +87,14 @@ struct iommu_domain {
>  enum iommu_attr {
>  	DOMAIN_ATTR_MAX,
>  	DOMAIN_ATTR_GEOMETRY,
> +	/* Set the IOMMU hardware stashing
> +	 * parameters.
> +	 */
> +	DOMAIN_ATTR_STASH,
> +	/* Explicity enable/disable DMA for a
> +         * particular memory window.
> +         */
> +	DOMAIN_ATTR_ENABLE,
>  };

Whitespace

-Scott=
