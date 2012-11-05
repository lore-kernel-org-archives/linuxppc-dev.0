Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6483E2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2012 10:56:18 +1100 (EST)
Date: Mon, 5 Nov 2012 17:56:07 -0600
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v4] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
To: Varun Sethi <Varun.Sethi@freescale.com>
In-Reply-To: <1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
 (from Varun.Sethi@freescale.com on Mon Nov  5 05:19:20 2012)
Message-ID: <1352159767.28279.11@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: joerg.roedel@amd.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Varun Sethi <Varun.Sethi@freescale.com>,
 linuxppc-dev@lists.ozlabs.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2012 05:19:20 AM, Varun Sethi wrote:
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
>=20
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> changes in v4:
> - Updated comment explaining subwindows(as mentioned by Scott).
> change in v3:
> -renamed the stash attribute targets
>  include/linux/iommu.h |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
>=20
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..e72f5e5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,34 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be =20
> mapped    */
>  	dma_addr_t aperture_end;   /* Last address that can be =20
> mapped     */
>  	bool force_aperture;       /* DMA only allowed in mappable =20
> range? */
> +
> +	/**
> +	 * There could be a single contiguous window tha maps the entire
> +	 * geometry or it could be split in to multiple subwindows.

...or it could be a normal IOMMU that supports arbitrary paging =20
throughout the aperture.

> +	 * Subwindows allow for supporting physically discontiguous =20
> mappings.

...in the absence of arbitrary paging.

> +	 * This attribute indicates number of DMA subwindows supported =20
> by
> +	 * the geometry.

s/indicates number/indicates the number/

>   If there is a single window that maps the entire
> +	 * geometry, attribute must be set to "1". A value of "0" =20
> implies
> +	 * that there are 256 subwindows each of size 4K. Value other =20
> than
> +	 * "0" or "1" indicates the actual number of subwindows.

No, a value of "0" indicates that this mechanism is not in use at all, =20
and normal paging is used.  PAMU specific things like "256 subwindows" =20
must not be a default value in a generic API.

In the case of PAMU, if you specify 0 here, the aperture is limited to =20
1 MiB because that is the limit of PAMU's ability to simulate arbitrary =20
paging with subwindows, but this is only the limit of one =20
implementation.  It's not part of the API.

-Scott=
