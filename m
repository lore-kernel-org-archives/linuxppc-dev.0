Return-Path: <ppc6dev@digitaldans.com>
Received: from digitaldans.com (digitaldans.com [69.36.177.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0B224B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 22 Sep 2010 08:16:03 +1000 (EST)
In-Reply-To: <20100921164944.164ed0af@udp111988uds.am.freescale.net>
References: <1285066638-7473-1-git-send-email-leoli@freescale.com>
	<877FD0B5-19A7-4A16-831E-369B80B104EA@kernel.crashing.org>
	<AANLkTimiwtoa6i10OTcgFnvbvcO9N4KWHyt4Poj-yj=T@mail.gmail.com>
	<20100921163456.7e2c9b32@udp111988uds.am.freescale.net>
	<AANLkTine--kry0c0n87WOqYyi3AQOb2KnmNRs-MeXcQt@mail.gmail.com>
	<20100921164944.164ed0af@udp111988uds.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2C3F2C02-35B6-46AF-82DA-44ACCBFB8362@digitaldans.com>
From: Dan Malek <ppc6dev@digitaldans.com>
Subject: Re: [PATCH] fsldma: add support to 36-bit physical address
Date: Tue, 21 Sep 2010 15:05:05 -0700
To: Scott Wood <scottwood@freescale.com>
Cc: Timur Tabi <timur.tabi@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	dan.j.williams@intel.com, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 21, 2010, at 2:49 PM, Scott Wood wrote:

>
> On Tue, 21 Sep 2010 16:43:12 -0500
> Timur Tabi <timur.tabi@gmail.com> wrote:
>
>> Since we don't DMA the descriptors themselves, I just don't see how
>> this patch does anything.
>
> Look in dmaengine.c, there are calls to dma_map_single() and
> dma_map_page(), using what I assume is that same device pointer --
> unless there's confusion between the channel and the controller.

The DMA descriptors are accessed using DMA by the
controller itself.  The APIs need to ensure proper coherency
between the CPU and the DMA controller for the
descriptor access.  The underlying implementation of the
API will depend upon the hardware capabilities that
ensure this coherency.

	-- Dan
