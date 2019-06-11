Return-Path: <SRS0=3S3E=UK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 776CDC4321A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB084205ED
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Jun 2019 14:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tZm05BCt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB084205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45NX650zpkzDqcS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 Jun 2019 00:13:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45NWzS5kq3zDqZn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 00:07:32 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="tZm05BCt"; dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 45NWzR2nFMz8tFV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2019 00:07:31 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 45NWzQ5SDMz9sNw; Wed, 12 Jun 2019 00:07:30 +1000 (AEST)
Authentication-Results: ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+98d4ae9035936dc2f97b+5770+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="tZm05BCt"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 45NWzP5W3Hz9sN6
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jun 2019 00:07:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jwVSRVYpHoI+ZWo4MBq+1xKy3s947GP/tfP5zSWOihQ=; b=tZm05BCtFnROyHuy+UdTBO27s
 nwZqB51QgVq3veDuwxxZ9RsTyvV9tu+goRJlRmvlfU7fBlfyJA0IfHb1sGIEw5Guo4RCLQeheW2Ng
 +PmQXJ+uxE2ES1zCbmkTRCGNfA92g4nNmxQRcm+zI8DnUb3KD0nxOVHoUkdMMjWKhO8Krsf1h+u1m
 L6cjG+1OygWSiNapaKwuyx3JRNNuv6zj+YG4WfqA11TD1sZvd6Im5yni3ST5F8tAEjpMdTzQ0dClU
 wpxlbo2kBABvvoVl6XhSkKflygsn2wOz7Z780aeGhgDRi2OAEXZ3fpPnmmO7kIfI3WCpXJrtSE3/P
 JSD/8VaIA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat
 Linux)) id 1hahQr-0000sf-1G; Tue, 11 Jun 2019 14:07:25 +0000
Date: Tue, 11 Jun 2019 07:07:25 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: Question - check in runtime which architecture am I running on
Message-ID: <20190611140725.GA28902@infradead.org>
References: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFCwf11EM9+NDML9hQmk9-rPzSmDmAyVLW+qOfs6h62dGK6H9A@mail.gmail.com>
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
Cc: linuxppc-dev@ozlabs.org,
 "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Jun 11, 2019 at 03:30:08PM +0300, Oded Gabbay wrote:
> Hello POWER developers,
> 
> I'm trying to find out if there is an internal kernel API so that a
> PCI driver can call it to check if its PCI device is running inside a
> POWER9 machine. Alternatively, if that's not available, if it is
> running on a machine with powerpc architecture.

Your driver has absolutely not business knowing this.

> 
> I need this information as my device (Goya AI accelerator)
> unfortunately needs a slightly different configuration of its PCIe
> controller in case of POWER9 (need to set bit 59 to be 1 in all
> outbound transactions).

No, it doesn't.  You can query the output from dma_get_required_mask
to optimize for the DMA addresses you get, and otherwise you simply
set the maximum dma mask you support.  That is about the control you
get, and nothing else is a drivers business.
