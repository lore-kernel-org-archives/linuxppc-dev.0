Return-Path: <B16395@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6FA622C0087
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 16:24:47 +1100 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: "joerg.roedel@amd.com" <joerg.roedel@amd.com>
Subject: RE: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 26 Nov 2012 05:24:37 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D29AE2A@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1353419697-31269-1-git-send-email-Varun.Sethi@freescale.com>
 <1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
In-Reply-To: <1353419697-31269-4-git-send-email-Varun.Sethi@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Tabi Timur-B04825 <B04825@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Sethi Varun-B16395 <B16395@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Joerg,
Any comments? Can we apply this patch?

Regards
Varun

> -----Original Message-----
> From: Sethi Varun-B16395
> Sent: Tuesday, November 20, 2012 7:25 PM
> To: joerg.roedel@amd.com; iommu@lists.linux-foundation.org; linuxppc-
> dev@lists.ozlabs.org; linux-kernel@vger.kernel.org; Wood Scott-B07421;
> Tabi Timur-B04825
> Cc: Sethi Varun-B16395
> Subject: [PATCH 3/4 v5] iommu/fsl: Add iommu domain attributes required
> by fsl PAMU driver.
>=20
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> changes in v5:
> - Updated description of the subwindows field.
> changes in v4:
> - Updated comment explaining subwindows(as mentioned by Scott).
> change in v3:
> -renamed the stash attribute targets
>  include/linux/iommu.h |   43 +++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 43 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> f3b99e1..7ca1cda 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,41 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be mapped
> */
>  	dma_addr_t aperture_end;   /* Last address that can be mapped
> */
>  	bool force_aperture;       /* DMA only allowed in mappable range?
> */
> +
> +	/*
> +	 * A geometry mapping can be created in one of the following ways
> +	 * for an IOMMU:
> +	 * 1. A single contiguous window
> +	 * 2. Through arbritary paging throughout the aperture.
> +	 * 3. Using multiple subwindows
> +	 *
> +	 * In absence of arbritary paging, subwindows allow for supporting
> +	 * physically discontiguous mappings.
> +	 *
> +	 * This attribute indicates number of DMA subwindows supported by
> +	 * the geometry. If there is a single window that maps the entire
> +	 * geometry, attribute must be set to "1". A value of "0" implies
> +	 * that this mechanism is not used at all(normal paging is used).
> +	 * Value other than* "0" or "1" indicates the actual number of
> +	 * subwindows.
> +	 */
> +	u32 subwindows;
> +};
> +
> +/* cache stash targets */
> +#define IOMMU_ATTR_CACHE_L1 1
> +#define IOMMU_ATTR_CACHE_L2 2
> +#define IOMMU_ATTR_CACHE_L3 3
> +
> +/* This attribute corresponds to IOMMUs capable of generating
> + * a stash transaction. A stash transaction is typically a
> + * hardware initiated prefetch of data from memory to cache.
> + * This attribute allows configuring stashig specific parameters
> + * in the IOMMU hardware.
> + */
> +struct iommu_stash_attribute {
> +	u32 	cpu;	/* cpu number */
> +	u32 	cache;	/* cache to stash to: L1,L2,L3 */
>  };
>=20
>  struct iommu_domain {
> @@ -60,6 +95,14 @@ struct iommu_domain {  enum iommu_attr {
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
>=20
>  #ifdef CONFIG_IOMMU_API
> --
> 1.7.4.1
