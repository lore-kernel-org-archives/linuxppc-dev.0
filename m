Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49A0C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:47:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3689561957
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:47:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3689561957
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8q3H5fBcz3c3D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 23:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=bpwoXfzS;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bpwoXfzS; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8q2q2c8Yz30Bf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 23:46:59 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3199619B1;
 Tue, 30 Mar 2021 12:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617108417;
 bh=Gp7K5d/9JkaqMV3qnVlhi8uY18tBiGcqTqq9JQwzkk4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bpwoXfzSTI3OVxxT2qtuhI8DBVsGK1w2yo1XJO96Mcl6Cf7j98u0D7WhigRHOVp76
 jDVKAszVft1N//apcCn6FfTFty159qo7bzFF1FayYDictlQn2pRCLv717rqFyesXh6
 g/qwrAId2++/WokGRt8nGZEDGbvdPTeM6c+yqRQokfC3Qr+akdDdbTY7EJdRxABvTD
 356fURN2pLtcawXNYFkMj/4iVtdUrMed1IC/yAYXh7FliEQtMGcEDxYEIh/YHATK5l
 0cbhI80eGEGy6vBu0Pz0nymgiC2g+OQuCq7/dYQEV4VJ4nIDFcytvB+5jrYD5CldVL
 VUbbcLl88d4eQ==
Date: Tue, 30 Mar 2021 13:46:51 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 08/18] iommu/fsl_pamu: merge pamu_set_liodn and map_liodn
Message-ID: <20210330124651.GH5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-9-hch@lst.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: freedreno@lists.freedesktop.org, kvm@vger.kernel.org,
 Joerg Roedel <joro@8bytes.org>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Mar 16, 2021 at 04:38:14PM +0100, Christoph Hellwig wrote:
> Merge the two fuctions that configure the ppaace into a single coherent
> function.  I somehow doubt we need the two pamu_config_ppaace calls,
> but keep the existing behavior just to be on the safe side.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c | 65 +++++++++------------------------
>  1 file changed, 17 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index 40eff4b7bc5d42..4a4944332674f7 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -54,25 +54,6 @@ static int __init iommu_init_mempool(void)
>  	return 0;
>  }
>  
> -/* Map the DMA window corresponding to the LIODN */
> -static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
> -{
> -	int ret;
> -	struct iommu_domain_geometry *geom = &dma_domain->iommu_domain.geometry;
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&iommu_lock, flags);
> -	ret = pamu_config_ppaace(liodn, geom->aperture_start,
> -				 geom->aperture_end - 1, ~(u32)0,
> -				 0, dma_domain->snoop_id, dma_domain->stash_id,
> -				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);
> -	spin_unlock_irqrestore(&iommu_lock, flags);
> -	if (ret)
> -		pr_debug("PAACE configuration failed for liodn %d\n", liodn);
> -
> -	return ret;
> -}
> -
>  static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
>  			      u32 val)
>  {
> @@ -94,11 +75,11 @@ static int update_liodn_stash(int liodn, struct fsl_dma_domain *dma_domain,
>  }
>  
>  /* Set the geometry parameters for a LIODN */
> -static int pamu_set_liodn(int liodn, struct device *dev,
> -			  struct fsl_dma_domain *dma_domain,
> -			  struct iommu_domain_geometry *geom_attr)
> +static int pamu_set_liodn(struct fsl_dma_domain *dma_domain, struct device *dev,
> +			  int liodn)
>  {
> -	phys_addr_t window_addr, window_size;
> +	struct iommu_domain *domain = &dma_domain->iommu_domain;
> +	struct iommu_domain_geometry *geom = &domain->geometry;
>  	u32 omi_index = ~(u32)0;
>  	unsigned long flags;
>  	int ret;
> @@ -110,22 +91,25 @@ static int pamu_set_liodn(int liodn, struct device *dev,
>  	 */
>  	get_ome_index(&omi_index, dev);
>  
> -	window_addr = geom_attr->aperture_start;
> -	window_size = geom_attr->aperture_end + 1;
> -
>  	spin_lock_irqsave(&iommu_lock, flags);
>  	ret = pamu_disable_liodn(liodn);
> -	if (!ret)
> -		ret = pamu_config_ppaace(liodn, window_addr, window_size, omi_index,
> -					 0, dma_domain->snoop_id,
> -					 dma_domain->stash_id, 0);
> +	if (ret)
> +		goto out_unlock;
> +	ret = pamu_config_ppaace(liodn, geom->aperture_start,
> +				 geom->aperture_end - 1, omi_index, 0,
> +				 dma_domain->snoop_id, dma_domain->stash_id, 0);
> +	if (ret)
> +		goto out_unlock;
> +	ret = pamu_config_ppaace(liodn, geom->aperture_start,
> +				 geom->aperture_end - 1, ~(u32)0,
> +				 0, dma_domain->snoop_id, dma_domain->stash_id,
> +				 PAACE_AP_PERMS_QUERY | PAACE_AP_PERMS_UPDATE);

There's more '+1' / '-1' confusion here with aperture_end which I'm not
managing to follow. What am I missing?

Will
