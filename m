Return-Path: <SRS0=u7Bz=I4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7991FC433C1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:16:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BA2619AA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 12:16:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BA2619AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F8pMb1Q2Qz3c2b
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Mar 2021 23:16:27 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=QQpwu09z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=will@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=QQpwu09z; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F8pM82YbRz2yx3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Mar 2021 23:16:04 +1100 (AEDT)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7EF476023F;
 Tue, 30 Mar 2021 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617106561;
 bh=bw8KBo/NNqB097evsMkXsyFAnnqW6iPTNtBok4bird8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QQpwu09zdg1APUNJpuxQhrkAfEgb8Xx8xBXTFO5/bqrnCy7nUn9ZszN5WLb+sq6vo
 5UJCLWYDMVJjHKt1uBKBD6MMh1tpUC2/ZJUxkV8BiHWJrvRd361XyyytEj+6Li42BI
 tfxcD7Rdfa0dzL9ZkwRo0SzzQKJrMa88AgwyNDnuPLKRwADNMLnkiOXhBm9+lE1tBR
 rdun4d9sUp5EgfOD94h55VT+FoWTTMYz/Myrov9kU9g5f+P8nfcOj+TX3m+W0J04yq
 y4bdrKMyq4yHZ4rqf7cqV7h7YmIgfRkPLJ7ViI7cikjVljJ7l7h/CdSxY5MyPkvqqz
 V8lAE4+4RFo3g==
Date: Tue, 30 Mar 2021 13:15:56 +0100
From: Will Deacon <will@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 03/18] iommu/fsl_pamu: remove support for setting
 DOMAIN_ATTR_GEOMETRY
Message-ID: <20210330121555.GC5908@willie-the-truck>
References: <20210316153825.135976-1-hch@lst.de>
 <20210316153825.135976-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316153825.135976-4-hch@lst.de>
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

On Tue, Mar 16, 2021 at 04:38:09PM +0100, Christoph Hellwig wrote:
> The default geometry is the same as the one set by qman_port given
> that FSL_PAMU depends on having 64-bit physical and thus DMA addresses.
> 
> Remove the support to update the geometry and remove the now pointless
> geom_size field.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/iommu/fsl_pamu_domain.c     | 55 +++--------------------------
>  drivers/iommu/fsl_pamu_domain.h     |  6 ----
>  drivers/soc/fsl/qbman/qman_portal.c | 12 -------
>  3 files changed, 5 insertions(+), 68 deletions(-)

Took me a minute to track down the other magic '36' which ends up in
aperture_end, but I found it eventually so:

Acked-by: Will Deacon <will@kernel.org>

(It does make me wonder what all this glue was intended to be used for)

Will
