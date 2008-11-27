Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77B3EDDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 11:42:54 +1100 (EST)
Subject: Re: Re[4]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <1351427808.20081127032633@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
	<1102187680.20081114074513@emcraft.com>
	<1226641289.7178.117.camel@pasglop>
	<1767195957.20081127032002@emcraft.com>
	<1351427808.20081127032633@emcraft.com>
Content-Type: text/plain
Date: Thu, 27 Nov 2008 11:42:39 +1100
Message-Id: <1227746559.7356.1.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>  I've implemented (2) (the code is below), and it works. But, 
> admittedly, this (working) looks strange to me because of the 
> following:
>  To be able to use 64-bit PCI mapping on PPC32 I had to replace the
> 'unsigned long' type of pci_dram_offset with 'resource_size_t', which 
> on ppc440spe is 'u64'. So, in dma_alloc_coherent() I put the 64-bit 
> value into the 'dma_addr_t' handle. I use 2.6.27 kernel for testing, 
> which has sizeof(dma_addr_t) == sizeof(u32). Thus, 
> dma_alloc_coherent() cuts the upper 32 bits of PCI address, and returns 
> only low 32-bit part of PCI address to its caller. And, regardless of 
> this fact, the PCI device does operate somehow (this is the PCI-E LSI 
> disk controller served by the drivers/message/fusion/mptbase.c + 
> mptsas.c drivers).
> 
>  I've verified that ppc440spe PCI-E bridge's BARs (PECFGn_BAR0L,H) are 
> configured with the new, 1TB, address value:

Strange... when I look at pci4xx_parse_dma_ranges() I see it
specifically avoiding PCI addresses above 4G ... That needs fixing.

To implement that trick you definitely need to make dma_addr_t 64 bits.

Cheers,
Ben.
