Return-Path: <jan.neskudla.ext@nsn.com>
Received: from demumfd002.nsn-inter.net (demumfd002.nsn-inter.net
	[217.115.75.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd002.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D7559DDDA5
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 20:06:47 +1000 (EST)
Subject: Re: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
From: Jan Neskudla <jan.neskudla.ext@nsn.com>
To: ext Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AF270294-0B90-4935-9D4A-F17EB7811CE2@kernel.crashing.org>
References: <1241705447.19689.114.camel@demuxf9c>
	<AF270294-0B90-4935-9D4A-F17EB7811CE2@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 08 May 2009 12:06:35 +0200
Message-Id: <1241777196.16400.25.camel@demuxf9c>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-05-07 at 10:21 -0500, ext Kumar Gala wrote:
> On May 7, 2009, at 9:10 AM, Jan Neskudla wrote:
> 
> > And one more think, when I enabled usage of DMA, rionet does not  
> > compile too,
> > but in this case I do not have a fix. I tested this on kernel  
> > 2.6.29.1 and
> > EP8548 as target board.
> 
> What exactly do you mean by that?  What CONFIG options cause compile  
> failure?  Can you post the compiler error.
> 
> - k

The problem is with the missing stucture dma_client in the kernel tree
sources. It looks to me that a dma model changed after 2.6
.28. Here are the details. 

I used a pristine kernel 2.6.29 + patch 2.6.29.1 than Leo's patches in
this order. 

 rio-warn_unused_result-warnings-fix.patch
 rionet-add-memory-access-to-simulated-Ethernet-over-rapidio.patch
 powerpc-add-memory-map-support-to-Freescale-RapioIO-block.patch
 powerpc-fsl_rio-use-LAW-address-from-device-tree.patch
 rapidio-add-common-mapping-APIs-for-RapidIO-memory-access.patch

Important CONFIG options are: 
PPC_86xx=y
HPC8641_HPCN=y
RAPIDIO=y
DMADEVICES=y
FSL_DMA=y !!
NETDEVICES=y
RIONET=y/m
RIONET_MEMMAP=y
RIONET_DMA=y !!

And the error during compilation:


  CC      drivers/net/rionet.o
drivers/net/rionet.c:110: error: field `rio_dma_client' has incomplete
type
drivers/net/rionet.c: In function `rio_send_mem':
drivers/net/rionet.c:239: error: parse error before "rnet"
drivers/net/rionet.c: At top level:
drivers/net/rionet.c:514: warning: "enum dma_state" declared inside
parameter list
drivers/net/rionet.c:514: warning: its scope is only this definition or
declaration, which is probably not what you want
drivers/net/rionet.c:515: error: parameter `state' has incomplete type
drivers/net/rionet.c:515: error: return type is an incomplete type
drivers/net/rionet.c: In function `rionet_dma_event':
drivers/net/rionet.c:516: warning: type defaults to `int' in declaration
of `__mptr'
drivers/net/rionet.c:516: warning: initialization from incompatible
pointer type
drivers/net/rionet.c:518: error: variable `ack' has initializer but
incomplete type
drivers/net/rionet.c:518: error: `DMA_DUP' undeclared (first use in this
function)
drivers/net/rionet.c:518: error: (Each undeclared identifier is reported
only once
drivers/net/rionet.c:518: error: for each function it appears in.)
drivers/net/rionet.c:518: error: storage size of 'ack' isn't known
drivers/net/rionet.c:522: error: `DMA_RESOURCE_AVAILABLE' undeclared
(first use in this function)
drivers/net/rionet.c:524: error: `DMA_ACK' undeclared (first use in this
function)
drivers/net/rionet.c:531: error: `DMA_RESOURCE_REMOVED' undeclared
(first use in this function)
drivers/net/rionet.c:544: warning: `return' with a value, in function
returning void
drivers/net/rionet.c:518: warning: unused variable `ack'
drivers/net/rionet.c: In function `rionet_dma_register':
drivers/net/rionet.c:553: error: implicit declaration of function
`dma_async_client_register'
drivers/net/rionet.c:554: error: implicit declaration of function
`dma_async_client_chan_request'
drivers/net/rionet.c: In function `rionet_close':
drivers/net/rionet.c:731: error: implicit declaration of function
`dma_async_client_unregister'
make[2]: *** [drivers/net/rionet.o] Error 1


                            Jan 
