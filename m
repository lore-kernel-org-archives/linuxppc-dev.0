Return-Path: <SRS0=6LlZ=IC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9778C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 11:19:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E12364F0A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 11:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E12364F0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DrpL94h1Sz3d70
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Mar 2021 22:19:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=8bytes.org (client-ip=81.169.241.247; helo=theia.8bytes.org;
 envelope-from=joro@8bytes.org; receiver=<UNKNOWN>)
X-Greylist: delayed 550 seconds by postgrey-1.36 at boromir;
 Thu, 04 Mar 2021 22:19:27 AEDT
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DrpKq1jC9z3cZR
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Mar 2021 22:19:27 +1100 (AEDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
 id A5EF3321; Thu,  4 Mar 2021 12:10:08 +0100 (CET)
Date: Thu, 4 Mar 2021 12:10:04 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: cleanup unused or almost unused IOMMU APIs and the FSL PAMU driver
Message-ID: <20210304111004.GA26414@8bytes.org>
References: <20210301084257.945454-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210301084257.945454-1-hch@lst.de>
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
 Will Deacon <will@kernel.org>, dri-devel@lists.freedesktop.org,
 Li Yang <leoyang.li@nxp.com>, iommu@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 Lu Baolu <baolu.lu@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 01, 2021 at 09:42:40AM +0100, Christoph Hellwig wrote:
> Diffstat:
>  arch/powerpc/include/asm/fsl_pamu_stash.h   |   12 
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c     |    2 
>  drivers/iommu/amd/iommu.c                   |   23 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   85 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  122 +---
>  drivers/iommu/dma-iommu.c                   |    8 
>  drivers/iommu/fsl_pamu.c                    |  264 ----------
>  drivers/iommu/fsl_pamu.h                    |   10 
>  drivers/iommu/fsl_pamu_domain.c             |  694 ++--------------------------
>  drivers/iommu/fsl_pamu_domain.h             |   46 -
>  drivers/iommu/intel/iommu.c                 |   55 --
>  drivers/iommu/iommu.c                       |   75 ---
>  drivers/soc/fsl/qbman/qman_portal.c         |   56 --
>  drivers/vfio/vfio_iommu_type1.c             |   31 -
>  drivers/vhost/vdpa.c                        |   10 
>  include/linux/iommu.h                       |   81 ---
>  16 files changed, 214 insertions(+), 1360 deletions(-)

Nice cleanup, thanks. The fsl_pamu driver and interface has always been
a little bit of an alien compared to other IOMMU drivers. I am inclined
to merge this after -rc3 is out, given some reviews. Can you also please
add changelogs to the last three patches?

Thanks,

	Joerg
