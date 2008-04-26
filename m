Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4ED11DDDEC
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 13:39:08 +1000 (EST)
Subject: Re: Enabling 64 bit data type for dma_addr_t on non PPC64 architecture
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tushar Tyagi <ttyagi@amcc.com>
In-Reply-To: <BA76C315ECE5B149AE7194FE094819E205E59014@SDCEXCHANGE01.ad.amcc.com>
References: <BA76C315ECE5B149AE7194FE094819E205E59014@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Sat, 26 Apr 2008 13:38:51 +1000
Message-Id: <1209181131.5420.42.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-25 at 19:52 -0700, Tushar Tyagi wrote:
> Hello,
> I'm working a new DMA hardware for PPC processors.
> The processor is a 32 bit architecture having 40 bit physical address
> space. 
> So we need the 32 bit processor code base but we want the type
> dma_addr_t to represent 64 bit data, without enabling the CONFIG_PPC64
> flag.

That shouldn't be a big issue, we already support 64 bits resources,
extending dma_addr_t shouldn't too hard.

> We want to use the Linux generic DMA layer to offload DMA operations to
> the hw and the Linux code path goes through function
> dma_async_memcpy_buf_to_buf and then dma_map_single.
>  
> Currently the dma_map_single function has 2 versions based upon
> CONFIG_PPC64 defined or not.
>  
> Is it possible to reuse the CONFIG_PPC64 based code only pertaining to
> DMA by doing the following:

It's possible, it might be a good idea even as it would allow to have
different implementations for different busses, which is in fact needed
for some things like 4xx if we start changing the mapping between
different PCI bridges vs. SoCs. In fact, I think there's been some
patches from Becky Bruce posted in februrary for doing just that, which
I totally forgot to review...
 
> Add a new flag called CONFIG_DMA64 along with CONFIG_PPC64 and
> __powerpc64__ flags, enabling our code to use the generic DMA layer with
> 64 bit data type for dma_addr_t.
>  
> With the above modification, the function dma_map_single starts
> returning 64 bit data type instead of 32.
>  
> Do you have any comments or suggestions ?

I'd suggest working with Becky on her initial patch and using that as
the basis for your stuff. I'll try to give it a good review asap.

Cheers,
Ben.
