Return-Path: <SRS0=2g3y=OW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB94BC67839
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6376020811
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Dec 2018 20:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6376020811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43G4M43XTGzDqjv
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Dec 2018 07:01:36 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43G4Hd34nTzDqjY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Dec 2018 06:58:35 +1100 (AEDT)
Received: by newverein.lst.de (Postfix, from userid 2407)
 id D452568DD6; Thu, 13 Dec 2018 20:58:31 +0100 (CET)
Date: Thu, 13 Dec 2018 20:58:31 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH] dma-direct: Fix return value of dma_direct_supported
Message-ID: <20181213195831.GA15478@lst.de>
References: <20181003234746.3586.42014.stgit@localhost.localdomain>
 <5329f992-d3aa-c16c-1218-c26d758889b8@arm.com>
 <CAKgT0UfbAokpR=-xrfNjeYMroEDH4HtPgM6qK_nWmBqK3QOf6A@mail.gmail.com>
 <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebe0d4aa-5f37-cc40-4a80-cfe499d5b8e4@amd.com>
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
Cc: "open list:LINUX FOR POWERPC \(32-BIT AND 64-BIT\)"
 <linuxppc-dev@lists.ozlabs.org>, Alexander Duyck <alexander.duyck@gmail.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 Greg KH <gregkh@linuxfoundation.org>,
 "alexander.h.duyck@linux.intel.com" <alexander.h.duyck@linux.intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
 Guenter Roeck <linux@roeck-us.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 13, 2018 at 07:45:57PM +0000, Lendacky, Thomas wrote:
> So I think this needs to be __phys_to_dma() here. I only recently got a
> system that had a device where the driver only supported 32-bit DMA and
> found that when SME is active this returns 0 and causes the driver to fail
> to initialize. This is because the SME encryption bit (bit 47) is part of
> the check when using phys_to_dma(). During actual DMA when SME is active,
> bounce buffers will be used for anything that can't meet the 48-bit
> requirement. But for this test, using __phys_to_dma() should give the
> desired results, right?
> 
> If you agree with this, I'll submit a patch to make the change. I missed
> this in 4.19, so I'll need to submit something to stable, too. The only
> issue there is the 4.20 fix won't apply cleanly to 4.19.

Yes, please send a patch.  Please make sure it includes a code comment
that explains why the __-prefixed version is used.
