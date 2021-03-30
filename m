Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFA4C433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:40:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B7061953
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B7061953
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8pvY3syPz3bpV
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 23:40:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=nWgQteGw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=nWgQteGw; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8pv570FVz2yxS
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 23:40:17 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id E982E60232;
 Tue, 30 Mar 2021 12:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617108015;
 bh=IX2YifXUPutEwODCiJ5FkZ7svmqC2sPBx3924aa48Yg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nWgQteGwA5KJlS2JEm1DqLRTwpQa9MxXWOIN5GJCMFtjX0INuGG/yNdjsVWCFpiYJ
 oxPSJpF11duop8M2scavelMol6/AT8NTEQVpD99bNW9C8YnpWrW5SilD7uovqWEsBw
 9NXGPUDX+nSIkkaLAjXvH1N0TCwIw2ZKe5EClUtTpNYe36xPYxZpRn+GOishndd0RZ
 XkYFeNPS5aTR5cbmGiWYvlLf/h/vfoDZLBLAT/a/UKQp/8Kfhx8IIcqRyN0qW/Vx0V
 DJqO0c48Fq0jOR6T0u+2L2HLBIx3MQrqTW4L44QcFkRIAs0f/QJTlssAZuY9kevdw9
 EsfSKgPiTPvmQ==
Date: Tue, 30 Mar 2021 13:40:09 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/18] iommu/fsl_pamu: remove ->domain_window_enable
Message-ID: <20210330124009.GF5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-7-hch@lst.de>
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

On Tue, Mar 16, 2021 at 04:38:12PM +0100, Christoph Hellwig wrote:
> The only thing that fsl_pamu_window_enable does for the current caller
> is to fill in the prot value in the only dma_window structure, and to
> propagate a few values from the iommu_domain_geometry struture into the
> dma_window.  Remove the dma_window entirely, hardcode the prot value and
> otherwise use the iommu_domain_geometry structure instead.
> 
> Remove the now unused ->domain_window_enable iommu method.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c     | 182 +++-------------------------
>  drivers/iommu/fsl_pamu_domain.h     |  17 ---
>  drivers/iommu/iommu.c               |  11 --
>  drivers/soc/fsl/qbman/qman_portal.c |   7 --
>  include/linux/iommu.h               |  17 ---
>  5 files changed, 14 insertions(+), 220 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
> index e6bdd38fc18409..fd2bc88b690465 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -54,34 +54,18 @@ static int __init iommu_init_mempool(void)
>  	return 0;
>  }
>  
> -static phys_addr_t get_phys_addr(struct fsl_dma_domain *dma_domain, dma_addr_t iova)
> -{
> -	struct dma_window *win_ptr = &dma_domain->win_arr[0];
> -	struct iommu_domain_geometry *geom;
> -
> -	geom = &dma_domain->iommu_domain.geometry;
> -
> -	if (win_ptr->valid)
> -		return win_ptr->paddr + (iova & (win_ptr->size - 1));
> -
> -	return 0;
> -}
> -
>  /* Map the DMA window corresponding to the LIODN */
>  static int map_liodn(int liodn, struct fsl_dma_domain *dma_domain)
>  {
>  	int ret;
> -	struct dma_window *wnd = &dma_domain->win_arr[0];
> -	phys_addr_t wnd_addr = dma_domain->iommu_domain.geometry.aperture_start;
> +	struct iommu_domain_geometry *geom = &dma_domain->iommu_domain.geometry;
>  	unsigned long flags;
>  
>  	spin_lock_irqsave(&iommu_lock, flags);
> -	ret = pamu_config_ppaace(liodn, wnd_addr,
> -				 wnd->size,
> -				 ~(u32)0,
> -				 wnd->paddr >> PAMU_PAGE_SHIFT,
> -				 dma_domain->snoop_id, dma_domain->stash_id,
> -				 wnd->prot);
> +	ret = pamu_config_ppaace(liodn, geom->aperture_start,
> +				 geom->aperture_end - 1, ~(u32)0,

You're passing 'geom->aperture_end - 1' as the size here, but the old code
seemed to _add_ 1:

> -static int fsl_pamu_window_enable(struct iommu_domain *domain, u32 wnd_nr,
> -				  phys_addr_t paddr, u64 size, int prot)
> -{
> -	struct fsl_dma_domain *dma_domain = to_fsl_dma_domain(domain);
> -	struct dma_window *wnd;
> -	int pamu_prot = 0;
> -	int ret;
> -	unsigned long flags;
> -	u64 win_size;
> -
> -	if (prot & IOMMU_READ)
> -		pamu_prot |= PAACE_AP_PERMS_QUERY;
> -	if (prot & IOMMU_WRITE)
> -		pamu_prot |= PAACE_AP_PERMS_UPDATE;
> -
> -	spin_lock_irqsave(&dma_domain->domain_lock, flags);
> -	if (wnd_nr > 0) {
> -		pr_debug("Invalid window index\n");
> -		spin_unlock_irqrestore(&dma_domain->domain_lock, flags);
> -		return -EINVAL;
> -	}
> -
> -	win_size = (domain->geometry.aperture_end + 1) >> ilog2(1);

here ^^ when calculating the exclusive upper bound. In other words, I think
'1ULL << 36' used to get passed to pamu_config_ppaace(). Is that an
intentional change?

Will
