Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6701EDDF8E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 15:56:35 +1100 (EST)
Subject: Re: [PATCH 2/3] powerpc: setup archdata for {of_}platform via a
	single platform_notify
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
References: <1235076557-24464-1-git-send-email-galak@kernel.crashing.org>
	<1235076557-24464-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 04 Mar 2009 15:56:11 +1100
Message-Id: <1236142571.6696.13.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-19 at 14:49 -0600, Kumar Gala wrote:
> Since a number of powerpc chips are SoCs we end up having dma-able
> devices that are registered as platform or of_platform devices.  We need
> to hook the archdata to setup proper dma_ops for these devices.
> 
> In the short term the majority of these devices only need the
> direct_dma_ops as the platforms don't have any IOMMUs.
> 
> In the future to enable >4G DMA support on ppc32 we can hook swiotlb ops.

I'm trying to figure out why I didn't use platform_notify back when I
did cell blades support and instead added the per-bus type notifier
support. I think I wanted to avoid the compare with bus types thingy
which somewhat suck.

Can't we do something akin to what the Cell IOMMU code does and just
have the platform code register a notifier for those bus types that
fill things up ?

IE. With this patch, if I'm not mistaken, on Cell blades, things will
start with a dma_direct_ops (which is bogus) and then end up being
hopefully "fixed up" by the iommu code. A bit weird.

Cheers,
Ben.
