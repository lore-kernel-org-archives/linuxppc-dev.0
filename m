Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F0CC43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:29:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 454962183F
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D1F3B0EJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 454962183F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43brwz24KXzDqtG
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 05:29:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+7463624bcd8ccf6d3e50+5619+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="D1F3B0EJ"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43brv90qXkzDq75
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 05:27:33 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n41D8P6/IHutEYxyG9udH33mpB5OHSUfLqhbAJKAN+Y=; b=D1F3B0EJxSmVNcRVof2eUhH+s
 Goxx/1SkkWMyoloWsVLk2eqtIxpFWi4xKaRbWMGyl4XHkYvRRpdluVjYXKCc47EEhxSH8aSTSs6ON
 g97+S8QGkda9khxhR1krA0VA6ASXnpKaxw6xQuSlinsPsvHtF38qZKGuEMZ5G3ieowaC1IIOiWU0n
 +pc69+D5EAph80b914YSDNNd9fnkhPOILXLhIPgrZ5yKv87NBYCWkdTwTJJz76Q5RrfcX5/Sbrsqt
 kd9HUDVDX1mNfrAEzxApY/awYfTKw8pl/cApQvB+efz02nbNxB0aSe7CnLm8sxnYny3/gnQpUetnl
 0Pa+GjRXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gi1Wj-0006HQ-3A; Fri, 11 Jan 2019 18:27:29 +0000
Date: Fri, 11 Jan 2019 10:27:28 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibmvscsi: use GFP_ATOMIC with dma_alloc_coherent in
 map_sg_data
Message-ID: <20190111182728.GB5469@infradead.org>
References: <1547089136-20264-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <20190110150703.GA26696@infradead.org>
 <4c5a470e-fa98-1ffd-7f55-5a4ffb3a692a@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c5a470e-fa98-1ffd-7f55-5a4ffb3a692a@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
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
Cc: james.bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 linux-scsi@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, brking@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Jan 10, 2019 at 03:15:35PM -0800, Tyrel Datwyler wrote:
> On a secondary note I was unaware of the GFP_ATOMIC limitations. Should this be
> added to the documentation somewhere? I don't see any mention here form
> DMA-API-HOWTO.txt.

The DMA documentation unfortauntely doesn't seem very good.  It's been
on my todo list to eventually update it, but I'm still discoverying
various warts.

GFP_ATOMIC allocations generally work fine on DMA coherent
architectures, but tend to cause problems on a lot of non-coherent
ones with the notable exceptions of arm and arm64 that go to great
length to introduce special pools for them.  But that code is rarely
exercised, so I found various bugs e.g. in the arm64 iommu code for
this case.

But more importantly there really should be no need for the coherent
allocation from irq context - we only need coherent for descriptors
that don't have clear ownership, and aything allocated in the I/O path
generally has that.
