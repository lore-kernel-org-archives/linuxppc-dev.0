Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 899D2C433E1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1D6C619BD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D6C619BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8qCT4tYJz3c2P
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 23:54:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=RvhuDRnn;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=RvhuDRnn; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8qC26KQlz30Lc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 23:54:06 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBEC161955;
 Tue, 30 Mar 2021 12:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617108844;
 bh=MUsAReQl36x7SR3EX7iZh5BEyF4eEO7patp68iu3zYw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=RvhuDRnnjbhKmZxor1XvWHCMInipWXvRtxAnhtWSHyskQigqXOQJZBpmkmtBZyI42
 Hzk9YR+zXiAqh+GqCuQsV/e9VwUlbbLL2WBWuGxyEgIjksxNm4QjWpE80+c+eJgjxa
 CDgfI0Go46YGTQMxgFvBCCBuNUOdQ5A9e4RX4fJZrV2JQkPw15LXMK/zAx+kh0z7vL
 kyRwRMIu/q/vE1ATdrsCa4384znPHm83guJWxqP2Cv0dXtUc4fw5FRdDw0Q8vG1MD6
 rhCut5ZrQW9EjJtIgqABXSUdPcCMBGGg98+FfQp3aOd/QWoqSzA6/B7VI2jDOm1MH1
 7esynnh6eCt1Q==
Date: Tue, 30 Mar 2021 13:53:58 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 10/18] iommu/fsl_pamu: enable the liodn when attaching a
 device
Message-ID: <20210330125358.GJ5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-11-hch@lst.de>
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

On Tue, Mar 16, 2021 at 04:38:16PM +0100, Christoph Hellwig wrote:
> Instead of a separate call to enable all devices from the list, just
> enablde the liodn one the device is attached to the iommu domain.

(typos: "enablde" and "one" probably needs to be "once"?)

> This also remove the DOMAIN_ATTR_FSL_PAMU_ENABLE iommu_attr.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c     | 47 ++---------------------------
>  drivers/iommu/fsl_pamu_domain.h     | 10 ------
>  drivers/soc/fsl/qbman/qman_portal.c | 11 -------
>  include/linux/iommu.h               |  1 -
>  4 files changed, 3 insertions(+), 66 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
