Return-Path: <SRS0=xr3w=PS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18068C43444
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:08:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 550B5214DA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Jan 2019 15:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NLZQlgo+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 550B5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43b8XH4HwRzDqmq
	for <linuxppc-dev@archiver.kernel.org>; Fri, 11 Jan 2019 02:08:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=none (mailfrom)
 smtp.mailfrom=bombadil.srs.infradead.org (client-ip=2607:7c80:54:e::133;
 helo=bombadil.infradead.org;
 envelope-from=batv+29c58aa94a33a714bb69+5618+infradead.org+hch@bombadil.srs.infradead.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="NLZQlgo+"; dkim-atps=neutral
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43b8VR75N8zDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jan 2019 02:07:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lvfzosJuddrFKfxlTxirJtxC4G1KmQ//h+Z1IYceZJQ=; b=NLZQlgo+50c/ncNqv2uiv5/ze
 NVtabWHCSC7UWzbrdOdkoJ+xVMCp7QU88jUdlLOeO9PEVuoskCncA3OSX68ioNXb65c5QNbQbVRK3
 omz5NI8dTfzJ5GZyhCRx46i5CZ+zuBbjsiJvnQmuTcW4/gElZFTx3cYukN1uArLlx25htZdzNyO0m
 J5Pd0RvSjuHmJOYyzzLyliFvi42BJfMRDvwS0ZE8CX09Y1Dv+nKqhf9R/Vo2uLm2a3xFrBOoN/E+b
 77p7P/AoGH3+WIepAz6T79G6l0gmMFGM1FHKl2v4RhLHp8foqQHqNTmClm3ytkzV1qhULatAfo9kB
 h/g7hQf5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red
 Hat Linux)) id 1ghbvD-00071a-Rj; Thu, 10 Jan 2019 15:07:03 +0000
Date: Thu, 10 Jan 2019 07:07:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Subject: Re: [PATCH] ibmvscsi: use GFP_ATOMIC with dma_alloc_coherent in
 map_sg_data
Message-ID: <20190110150703.GA26696@infradead.org>
References: <1547089136-20264-1-git-send-email-tyreld@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547089136-20264-1-git-send-email-tyreld@linux.vnet.ibm.com>
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
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
 stable@vger.kernel.org, james.bottomley@hansenpartnership.com,
 brking@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Jan 09, 2019 at 06:58:56PM -0800, Tyrel Datwyler wrote:
> While mapping DMA for scatter list when a scsi command is queued the
> existing call to dma_alloc_coherent() in our map_sg_data() function
> passes zero for the gfp_flags parameter. We are most definitly in atomic
> context at this point as queue_command() is called in softirq context
> and further we have a spinlock holding the scsi host lock.
> 
> Fix this by passing GFP_ATOMIC to dma_alloc_coherent() to prevent any
> sort of sleeping in atomic context deadlock.

This is a pretty clear sign you should not be using dma_alloc_coherent
to start with.  GFP_ATOMIC support in many of the implementations either
doesn't work at all or is severly constrained.  Given that the
descriptor is written by the OS and read by the hardware exactly once
there is no point in having the coherent mapping to start with.
