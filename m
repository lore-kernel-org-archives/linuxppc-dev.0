Return-Path: <SRS0=2HDf=PT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B092C43387
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:26:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C942621841
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 18:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qI6iU4IY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C942621841
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43brsk63VczDr0f
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 05:26:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+7463624bcd8ccf6d3e50+5619+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="qI6iU4IY"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43brqm3QBZzDq75
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Jan 2019 05:24:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QlJ1zwV417zWJFGC+GahrSftXjGZAzP/OwNXrHeeqTs=; b=qI6iU4IYleKSx12aJH2ORkJs3
 Za8SJI3Z1Vd3TwhlbZdiBuD5hFKoh5FDnOFRISWznbBi/lbcoxo9T+gWnGZpXg3cw2sp9T3QPng4U
 iEI7/zd2ND+B3MDrWDwe6Kj/YwCeqQ2rhL895018i2KMm8ari15xy+PudsSYjFnxkyLKeg1dcRM6M
 tzyc456rvk02BwcaZtq+gjAQztSxTtg9BIFSZAR4lMXpDtrK03lohumWxXO2es41nSD2+kKt/090x
 YsE09p5pfZbb7CjjopPsN3sTm0keq8kTbsNw6XX8KRaTV2cCHWsbbB1abqd5cFL4XSFumbA2COkM0
 SckND6jXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1gi1Tt-0004hD-6I; Fri, 11 Jan 2019 18:24:33 +0000
Date: Fri, 11 Jan 2019 10:24:33 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibmvscsi: use GFP_ATOMIC with dma_alloc_coherent in
 map_sg_data
Message-ID: <20190111182432.GA5469@infradead.org>
References: <1547089136-20264-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <20190110150703.GA26696@infradead.org>
 <1214b6b5-92f2-7789-7530-36a0d16323c5@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1214b6b5-92f2-7789-7530-36a0d16323c5@linux.vnet.ibm.com>
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

On Thu, Jan 10, 2019 at 12:11:53PM -0800, Tyrel Datwyler wrote:
> This allocation isn't a single use allocation. The driver is just lazy about allocating our ext_list area for large SG lists (ie. SG_ALL). When the driver was first written it only supported up to 10 indirect SRP buffers. James Bottemley added the large SG support back in 2005 with the commit referenced here in the fixes tag "4dddbc26c389". We only allocate the ext_list when we come across a SG list requiring more than 10 indirect buffers. Once allocated we will reuse if already allocated.

I think the right fix is to just allocate the buffer for the ext_list
as part of the scsi command using the .cmd_size field in the host
template, and then dma map it in queuecommand and unmap it on
completion. 
