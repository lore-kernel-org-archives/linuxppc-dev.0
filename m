Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by ozlabs.org (Postfix) with ESMTP id 7C199B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:18:08 +1000 (EST)
Received: from mail56-tx2 (localhost.localdomain [127.0.0.1])	by
	mail56-tx2-R.bigfish.com (Postfix) with ESMTP id D487EFB83B9	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 22:17:51 +0000 (UTC)
Received: from TX2EHSMHS028.bigfish.com (unknown [10.9.14.253])	by
	mail56-tx2.bigfish.com (Postfix) with ESMTP id AB891117004E	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 22:17:51 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o8LMHmkp000063	for
	<linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2010 15:17:48 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o8LMXEa8008603	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 17:33:14 -0500 (CDT)
Date: Tue, 21 Sep 2010 17:17:46 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur.tabi@gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Message-ID: <20100921171746.381f2e89@udp111988uds.am.freescale.net>
In-Reply-To: <AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
	<2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
	<AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Dan Malek <ppc6dev@digitaldans.com>, linuxppc-dev@lists.ozlabs.org,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Sep 2010 17:08:54 -0500
Timur Tabi <timur.tabi@gmail.com> wrote:

> On Tue, Sep 21, 2010 at 5:05 PM, Dan Malek <ppc6dev@digitaldans.com> wrote:
> 
> > The DMA descriptors are accessed using DMA by the
> > controller itself.
> 
> Yes and no.  Technically, it is DMA, but it's not something that
> SWIOTLB could ever know about.  We just pass the physical address to
> the DMA controller, and it does a memory read to obtain the data.
> That's not the kind of DMA that SWIOTLB would deal with, I think.

SWIOTLB should see that the address is directly DMAable and do nothing,
but you don't want to skip the DMA API altogether.  You still need to
flush caches if DMA is noncoherent, etc.

> My question is, should dmaengine be using the same 'dev' that fsldma
> uses to allocate the DMA descriptors?  I wonder if the 'dev' should be
> allocated internally by dmaengine, or provided by the client drivers.

It needs to be the actual device that is performing the DMA -- the
platform may need to do things such as IOMMU manipulation where
knowing the device matters.

-Scott
