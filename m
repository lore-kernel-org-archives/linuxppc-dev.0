Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) by ozlabs.org (Postfix) with ESMTP id B5003B70E2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:09:26 +1000 (EST)
Received: by iwn4 with SMTP id 4so2320517iwn.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 21 Sep 2010 15:09:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
	<2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Tue, 21 Sep 2010 17:08:54 -0500
Message-ID: <AANLkTinKbBBbC1gmPewhn1f3MW-1MbARtiQZNX4w7Mi+@mail.gmail.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
To: Dan Malek <ppc6dev@digitaldans.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, dan.j.williams@intel.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 21, 2010 at 5:05 PM, Dan Malek <ppc6dev@digitaldans.com> wrote:

> The DMA descriptors are accessed using DMA by the
> controller itself.

Yes and no.  Technically, it is DMA, but it's not something that
SWIOTLB could ever know about.  We just pass the physical address to
the DMA controller, and it does a memory read to obtain the data.
That's not the kind of DMA that SWIOTLB would deal with, I think.

> The APIs need to ensure proper coherency
> between the CPU and the DMA controller for the
> descriptor access. =A0The underlying implementation of the
> API will depend upon the hardware capabilities that
> ensure this coherency.

I think that's already covered.  The dma_set_mask() call is supposed
to only affect the dma_map_single() calls that dmaengine makes, as
Scott pointed out.

My question is, should dmaengine be using the same 'dev' that fsldma
uses to allocate the DMA descriptors?  I wonder if the 'dev' should be
allocated internally by dmaengine, or provided by the client drivers.

--=20
Timur Tabi
Linux kernel developer at Freescale
