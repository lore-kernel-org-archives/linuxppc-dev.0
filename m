Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 23CFA2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Sep 2012 01:16:59 +1000 (EST)
Subject: Re: [RFC][PATCH 1/3] iommu/fsl: Store iommu domain information
 pointer in archdata.
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1348060632-12997-2-git-send-email-b16395@freescale.com>
Date: Wed, 19 Sep 2012 08:50:14 -0500
Message-Id: <5BDB4D18-CB0D-4EBA-B38F-A278B7C00A61@kernel.crashing.org>
References: <1348060632-12997-1-git-send-email-b16395@freescale.com>
 <1348060632-12997-2-git-send-email-b16395@freescale.com>
To: "<b16395@freescale.com>" <b16395@freescale.com>
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


On Sep 19, 2012, at 8:17 AM, <b16395@freescale.com> =
<b16395@freescale.com> wrote:

> From: Varun Sethi <Varun.Sethi@freescale.com>
>=20
> Add a new field in the device (powerpc) archdata structure for storing =
iommu domain
> information pointer. This pointer is stored when the device is =
attached to a particular
> domain.
>=20
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> arch/powerpc/include/asm/device.h |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

Not too familiar, but what does the IBM Server IOMMU do for =
iommu_domain?

>=20
> diff --git a/arch/powerpc/include/asm/device.h =
b/arch/powerpc/include/asm/device.h
> index 77e97dd..6dc79fe 100644
> --- a/arch/powerpc/include/asm/device.h
> +++ b/arch/powerpc/include/asm/device.h
> @@ -28,6 +28,10 @@ struct dev_archdata {
> 		void		*iommu_table_base;
> 	} dma_data;
>=20
> +	/* IOMMU domain information pointer. This would be set
> +	 * when this device is attached to an iommu_domain.
> +	 */
> +	void			*iommu_domain;
> #ifdef CONFIG_SWIOTLB
> 	dma_addr_t		max_direct_dma_addr;
> #endif
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe =
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
