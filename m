Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 524E4DDDF0
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Nov 2008 20:26:07 +1100 (EST)
Subject: Re: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <200811131149.14715.yur@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
Content-Type: text/plain
Date: Thu, 13 Nov 2008 20:25:52 +1100
Message-Id: <1226568352.7178.44.camel@pasglop>
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

On Thu, 2008-11-13 at 11:49 +0300, Yuri Tikhonov wrote:
> Hello,
> 
> This patch extends DMA ranges for PCI(X) to 4GB, so that it could
> work on Katmais with 4GB RAM installed.

And where do you put MMIO ?

The 32 bit part of the PCI space need to be split between MMIO and DMA. 

Ideally, for 64-bit capable DMA, device, we should create a second DMA
range mapping the whole memory at something like 1T or so on PCI, and
keep a smaller (ie. 2G) DMA range for 32-bit only devices backed with
swiotlb.

Cheers,
Ben.
