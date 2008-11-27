Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADCA0DDDEA
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 15:08:03 +1100 (EST)
Subject: Re: Re[6]: [PATCH] katmai.dts: extend DMA ranges; add dma/sysace nodes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Yuri Tikhonov <yur@emcraft.com>
In-Reply-To: <8310162146.20081127035949@emcraft.com>
References: <200811131149.14715.yur@emcraft.com>
	<1226568352.7178.44.camel@pasglop>
	<1102187680.20081114074513@emcraft.com>
	<1226641289.7178.117.camel@pasglop>
	<1767195957.20081127032002@emcraft.com>
	<1351427808.20081127032633@emcraft.com>
	<1227746559.7356.1.camel@pasglop>
	<8310162146.20081127035949@emcraft.com>
Content-Type: text/plain
Date: Thu, 27 Nov 2008 15:07:41 +1100
Message-Id: <1227758861.7356.19.camel@pasglop>
Mime-Version: 1.0
Cc: sathya.prakash@lsi.com, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, linuxppc-dev@ozlabs.org,
	Ilya Yanok <yanok@emcraft.com>, Eric.Moore@lsi.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Strange... when I look at pci4xx_parse_dma_ranges() I see it
> > specifically avoiding PCI addresses above 4G ... That needs fixing.
> 
>  Right, it avoid. I guess you haven't read my e-mail to its end, 
> because my work-around patch, which I referenced there, fixes this :)

Ooops, I though I did :-)

>  Sure. The problem here is that the LSI (the PCI device I want to DMA 
> to/from 1TB PCI addresses) driver doesn't work with this (i.e. it's 
> broken in, e.g., 2.6.28-rc6) on ppc440spe-based platform. It looks 
> like there is no support for 32-bit CPUs with 64-bit physical 
> addresses in the LSI driver. E.g. the following mix in the 
> drivers/message/fusion/mptbase.h code points to the fact that the 
> driver supposes 64-bit dma_addr_t on 64-bit CPUs only:
> 
> #ifdef CONFIG_64BIT
> #define CAST_U32_TO_PTR(x)      ((void *)(u64)x)
> #define CAST_PTR_TO_U32(x)      ((u32)(u64)x)
> #else
> #define CAST_U32_TO_PTR(x)      ((void *)x)
> #define CAST_PTR_TO_U32(x)      ((u32)x)
> #endif
> 
> 
> #define mpt_addr_size() \
>         ((sizeof(dma_addr_t) == sizeof(u64)) ? MPI_SGE_FLAGS_64_BIT_ADDRESSING : \
>                 MPI_SGE_FLAGS_32_BIT_ADDRESSING)
> 

So far I don't see anything in this that hints about that brokenness...
not that it's not there, but the above macros seem unrelated.

Cheers,
Ben.

>  Regards, Yuri
> 
>  --
>  Yuri Tikhonov, Senior Software Engineer
>  Emcraft Systems, www.emcraft.com
