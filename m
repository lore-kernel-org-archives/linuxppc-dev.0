Return-Path: <SRS0=9KTJ=MR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA82C00449
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:21:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 056E5205C9
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 07:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 056E5205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42RLm20c4hzF3Mp
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Oct 2018 17:21:38 +1000 (AEST)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42RLgS1yBjzF3Qm
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Oct 2018 17:17:39 +1000 (AEST)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id 351C767357; Fri,  5 Oct 2018 09:17:36 +0200 (CEST)
Date: Fri, 5 Oct 2018 09:17:36 +0200
From: Christoph Hellwig <hch@lst.de>
To: Alexander Duyck <alexander.duyck@gmail.com>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Message-ID: <20181005071736.GA24011@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
 <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
 <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
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
Cc: Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>, alexander.h.duyck@linux.intel.com,
 "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 04, 2018 at 08:13:26AM -0700, Alexander Duyck wrote:
> Thanks for the review.
> 
> - Alex
> 
> P.S. It looks like I forgot to add Christoph to the original mail
> since I had just copied the To and Cc from the original submission, so
> I added him to the Cc for this.

Yes, there was some oddness with replies appearing out of nowhere that
I couldn't understand in my jetlagged state yesterday.   Now thay I've
caught up on iommu list traffic it all makes sense now.  I've applied
this with an Acked-by for Robin added based on his reply.
