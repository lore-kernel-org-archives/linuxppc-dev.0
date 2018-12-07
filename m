Return-Path: <SRS0=Xegb=OQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0330C07E85
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:11:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A22120892
	for <linuxppc-dev@archiver.kernel.org>; Fri,  7 Dec 2018 14:11:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A22120892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43BDsp27lZzDrfW
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 01:11:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=lst.de
 (client-ip=213.95.11.211; helo=newverein.lst.de; envelope-from=hch@lst.de;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=lst.de
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43BDqH6K6dzDrQW
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 01:09:14 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D3DD468AA6; Fri,  7 Dec 2018 15:09:10 +0100 (CET)
Date: Fri, 7 Dec 2018 15:09:10 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 01/34] powerpc: use mm zones more sensibly
Message-ID: <20181207140910.GA23609@lst.de>
References: <20181114082314.8965-1-hch@lst.de>
 <20181114082314.8965-2-hch@lst.de> <20181206140948.GB29741@infradead.org>
 <87sgz9jzsl.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgz9jzsl.fsf@concordia.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Dec 07, 2018 at 11:18:18PM +1100, Michael Ellerman wrote:
> Christoph Hellwig <hch@infradead.org> writes:
> 
> > Ben / Michael,
> >
> > can we get this one queued up for 4.21 to prepare for the DMA work later
> > on?
> 
> I was hoping the PASEMI / NXP regressions could be solved before
> merging.
> 
> My p5020ds is booting fine with this series, so I'm not sure why it's
> causing problems on Christian's machine.
> 
> The last time I turned on my PASEMI board it tripped some breakers, so I
> need to investigate that before I can help test that.
> 
> I'll see how things look on Monday and either merge the commits you
> identified or the whole series depending on if there's any more info
> from Christian.

Christian just confirmed everything up to at least
"powerpc/dma: stop overriding dma_get_required_mask" works for his
setups.
