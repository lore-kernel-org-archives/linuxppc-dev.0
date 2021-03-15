Return-Path: <SRS0=qf4I=IN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40351C433DB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 08:34:16 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E85164E86
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 08:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E85164E86
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DzV856VJ9z304h
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Mar 2021 19:34:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=verein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DzV7l2r8fz2xgL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Mar 2021 19:33:54 +1100 (AEDT)
Received: by verein.lst.de (Postfix, from userid 2407)
 id D619068C4E; Mon, 15 Mar 2021 09:33:47 +0100 (CET)
Date: Mon, 15 Mar 2021 09:33:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 14/17] iommu: remove DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE
Message-ID: <20210315083347.GA28445@lst.de>
References: <20210301084257.945454-1-hch@lst.de>
 <20210301084257.945454-15-hch@lst.de>
 <1658805c-ed28-b650-7385-a56fab3383e3@arm.com> <20210310091501.GC5928@lst.de>
 <20210310092533.GA6819@lst.de> <fdacf87a-be14-c92c-4084-1d1dd4fc7766@arm.com>
 <20210311082609.GA6990@lst.de> <dff8eb80-8f74-972b-17e9-496c1fc0396f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dff8eb80-8f74-972b-17e9-496c1fc0396f@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
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
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, linuxppc-dev@lists.ozlabs.org,
 dri-devel@lists.freedesktop.org, Li Yang <leoyang.li@nxp.com>,
 iommu@lists.linux-foundation.org, netdev@vger.kernel.org,
 David Woodhouse <dwmw2@infradead.org>, linux-arm-kernel@lists.infradead.org,
 virtualization@lists.linux-foundation.org, freedreno@lists.freedesktop.org,
 Christoph Hellwig <hch@lst.de>, linux-arm-msm@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 12, 2021 at 04:18:24PM +0000, Robin Murphy wrote:
>> Let me know what you think of the version here:
>>
>> http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/iommu-cleanup
>>
>> I'll happily switch the patch to you as the author if you're fine with
>> that as well.
>
> I still have reservations about removing the attribute API entirely and 
> pretending that io_pgtable_cfg is anything other than a SoC-specific 
> private interface,

I think a private inteface would make more sense.  For now I've just
condensed it down to a generic set of quirk bits and dropped the
attrs structure, which seems like an ok middle ground for now.  That
being said I wonder why that quirk isn't simply set in the device
tree?

> but the reworked patch on its own looks reasonable to 
> me, thanks! (I wasn't too convinced about the iommu_cmd_line wrappers 
> either...) Just iommu_get_dma_strict() needs an export since the SMMU 
> drivers can be modular - I consciously didn't add that myself since I was 
> mistakenly thinking only iommu-dma would call it.

Fixed.  Can I get your signoff for the patch?  Then I'll switch it to
over to being attributed to you.
