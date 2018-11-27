Return-Path: <SRS0=zuPs=OR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700A8C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 10:28:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A821420837
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 10:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A821420837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Blt00FB6zDq5k
	for <linuxppc-dev@archiver.kernel.org>; Sat,  8 Dec 2018 21:28:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Blqj6Kp8zF09T
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  8 Dec 2018 21:26:25 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wARM5brv005125;
 Tue, 27 Nov 2018 16:05:43 -0600
Message-ID: <b04e3f11bfe732dd46fc40c2e086d5e8d0572308.camel@kernel.crashing.org>
Subject: Re: use generic DMA mapping code in powerpc V4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 28 Nov 2018 09:05:37 +1100
In-Reply-To: <20181127074253.GB30186@lst.de>
References: <20181114082314.8965-1-hch@lst.de> <20181127074253.GB30186@lst.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2018-11-27 at 08:42 +0100, Christoph Hellwig wrote:
> Any comments?  I'd like to at least get the ball moving on the easy
> bits.

I completely missed your posting of V4 ! I was wondering what was
taking you so long :)

I'll give it a spin & send acks over the next 2 or 3 days.

Cheers,
Ben.

> On Wed, Nov 14, 2018 at 09:22:40AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series switches the powerpc port to use the generic swiotlb and
> > noncoherent dma ops, and to use more generic code for the coherent
> > direct mapping, as well as removing a lot of dead code.
> > 
> > As this series is very large and depends on the dma-mapping tree I've
> > also published a git tree:
> > 
> >     git://git.infradead.org/users/hch/misc.git powerpc-dma.4
> > 
> > Gitweb:
> > 
> >     http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/powerpc-dma.4
> > 
> > Changes since v3:
> >  - rebase on the powerpc fixes tree
> >  - add a new patch to actually make the baseline amigaone config
> >    configure without warnings
> >  - only use ZONE_DMA for 64-bit embedded CPUs, on pseries an IOMMU is
> >    always present
> >  - fix compile in mem.c for one configuration
> >  - drop the full npu removal for now, will be resent separately
> >  - a few git bisection fixes
> > 
> > The changes since v1 are to big to list and v2 was not posted in public.
> > 
> > _______________________________________________
> > iommu mailing list
> > iommu@lists.linux-foundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/iommu
> ---end quoted text---

