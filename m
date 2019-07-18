Return-Path: <SRS0=Nz1t=VP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5D4C76195
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 13:59:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DE6D21849
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 13:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DE6D21849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45qG3C577GzDqXd
	for <linuxppc-dev@archiver.kernel.org>; Thu, 18 Jul 2019 23:59:35 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45qFzk6MWGzDqWp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jul 2019 23:56:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45qFzj3QpSz9sBF; Thu, 18 Jul 2019 23:56:33 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 03800e0526ee25ed7c843ca1e57b69ac2a5af642
In-Reply-To: <20190625141727.2883-1-aarcange@redhat.com>
To: Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH 1/1] powerpc: fix off by one in max_zone_pfn
 initialization for ZONE_DMA
Message-Id: <45qFzj3QpSz9sBF@ozlabs.org>
Date: Thu, 18 Jul 2019 23:56:33 +1000 (AEST)
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
Cc: Laurent Vivier <lvivier@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-06-25 at 14:17:27 UTC, Andrea Arcangeli wrote:
> 25078dc1f74be16b858e914f52cc8f4d03c2271a first introduced an off by
> one error in the ZONE_DMA initialization of PPC_BOOK3E_64=y and since
> 9739ab7eda459f0669ec9807e0d9be5020bab88c the off by one applies to
> PPC32=y too. This simply corrects the off by one and should resolve
> crashes like below:
> 
> [   65.179101] page 0x7fff outside node 0 zone DMA [ 0x0 - 0x7fff ]
> 
> Unfortunately in various MM places "max" means a non inclusive end of
> range. free_area_init_nodes max_zone_pfn parameter is one case and
> MAX_ORDER is another one (unrelated) that comes by memory.
> 
> Reported-by: Zorro Lang <zlang@redhat.com>
> Fixes: 25078dc1f74b ("powerpc: use mm zones more sensibly")
> Fixes: 9739ab7eda45 ("powerpc: enable a 30-bit ZONE_DMA for 32-bit pmac")
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/03800e0526ee25ed7c843ca1e57b69ac2a5af642

cheers
