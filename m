Return-Path: <SRS0=Gm8F=VT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158E2C76188
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 09:25:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E7AE21E6B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 09:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lWwY1OZQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E7AE21E6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45sbmV5B2vzDqJ2
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Jul 2019 19:24:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+8b691fc55bcfc6b3008b+5811+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="lWwY1OZQ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45sbkQ6sZlzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jul 2019 19:23:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pOTBY6AtVEUDX9/NDgELbMsFV/6Jx30XrIPuhDqSF1M=; b=lWwY1OZQ6NlBZRVOwRFqOAU9R
 e/Wv3qaaZxGg0hcOW/WhwAB+OGdI1MFapTX6SQwKdijL3BmjRFZ7Y55cAWLc7ed4OyCdDzaKkw5aG
 +quVEzCfekBv3Q/ZFCrN8PWNtfra7RWxIRPdhZXUJiNgeqvueXW6kHYuUzVrzw+jcFUgqEAqERC9E
 mKjkbwbuIFGWYddiLBTWFVPLmCqCLWcJObR5FOb9ryVT0MaQqv6jZScC4PK2mM5HQZX/l79kgyjlY
 RgwHX8IThrH/IunfsEU9DkcbqiSNLMCrqKVt6z1R2sp+y1CIhLohdlLa9Is5f3o5YJoMik1wI9SFM
 kVhRIUJ0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hpUXC-0006xE-OD; Mon, 22 Jul 2019 09:23:06 +0000
Date: Mon, 22 Jul 2019 02:23:06 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: question on "powerpc/pseries/dma: Allow SWIOTLB"
Message-ID: <20190722092306.GA12167@infradead.org>
References: <20190719071014.GA1922@infradead.org>
 <0f969485-a3fe-4436-a448-5f4c4f875cb2@ozlabs.ru>
 <20190719075348.GA2892@infradead.org>
 <33ba562c-1a87-58e2-4105-520834d5b969@ozlabs.ru>
 <20190719080532.GA3861@infradead.org>
 <14c9591a-5c8d-12a5-ed25-b7a41e0b1ad7@ozlabs.ru>
 <20190719122518.GA18682@infradead.org>
 <5c38b824-f703-bf97-3752-0f315b79b5a7@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c38b824-f703-bf97-3752-0f315b79b5a7@ozlabs.ru>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Jul 20, 2019 at 09:22:49PM +1000, Alexey Kardashevskiy wrote:
> 
> 
> On 19/07/2019 22:25, Christoph Hellwig wrote:
> > On Fri, Jul 19, 2019 at 06:23:59PM +1000, Alexey Kardashevskiy wrote:
> >> It is getting there and I still do not see why "swiotlb=force" should not
> >> work if chosed in the cmdline.
> > 
> > Ok, makes sense.  But that means we also have the issue in a few
> > other places..
> 
> Hmm, where? I got broadcom ethernet working with this.

In all the other IOMMU drivers that conditionally forward to the dma
direct ops.  So it shouldn't affect powerpc.
