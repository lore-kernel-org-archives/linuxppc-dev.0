Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78347C64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:09:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C85AF213A2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 05:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C85AF213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Tldb0JFTzF3Bm
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 16:09:23 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TlSk4FVfzF3Nf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 16:01:42 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9951JY7002817;
 Tue, 9 Oct 2018 00:01:21 -0500
Message-ID: <8402ecc9c8ed9c69ad3e91eca4d07a5ab077b22d.camel@kernel.crashing.org>
Subject: Re: [PATCH 5/5] dma-direct: always allow dma mask <= physiscal
 memory size
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Duyck <alexander.duyck@gmail.com>, Christoph Hellwig
 <hch@lst.de>, Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Oct 2018 16:01:18 +1100
In-Reply-To: <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
References: <20180927223539.28449-1-hch@lst.de>
 <20180927223539.28449-6-hch@lst.de>
 <CAKgT0Ucii29i7S8eCj20D=a+=DeyKxREG0U2DBNRp3jFpgLu_A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
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
Cc: Greg KH <gregkh@linuxfoundation.org>,
 "open list:INTEL IOMMU \(VT-d\)" <iommu@lists.linux-foundation.org>,
 "open list:LINUX FOR POWERPC \(32-BIT
 AND 64-BIT\)" <linuxppc-dev@lists.ozlabs.org>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-10-03 at 16:10 -0700, Alexander Duyck wrote:
> > -        * Because 32-bit DMA masks are so common we expect every architecture
> > -        * to be able to satisfy them - either by not supporting more physical
> > -        * memory, or by providing a ZONE_DMA32.  If neither is the case, the
> > -        * architecture needs to use an IOMMU instead of the direct mapping.
> > -        */
> > -       if (mask < phys_to_dma(dev, DMA_BIT_MASK(32)))
> > +       u64 min_mask;
> > +
> > +       if (IS_ENABLED(CONFIG_ZONE_DMA))
> > +               min_mask = DMA_BIT_MASK(ARCH_ZONE_DMA_BITS);
> > +       else
> > +               min_mask = DMA_BIT_MASK(32);
> > +
> > +       min_mask = min_t(u64, min_mask, (max_pfn - 1) << PAGE_SHIFT);
> > +
> > +       if (mask >= phys_to_dma(dev, min_mask))
> >                  return 0;
> > -#endif
> >          return 1;
> >   }
> 
> So I believe I have run into the same issue that Guenter reported. On
> an x86_64 system w/ Intel IOMMU. I wasn't able to complete boot and
> all probe attempts for various devices were failing with -EIO errors.
> 
> I believe the last mask check should be "if (mask < phys_to_dma(dev,
> min_mask))" not a ">=" check.

Right, that test is backwards. I needed to change it here too (powermac
with the rest of the powerpc series).

Cheers,
Ben.


