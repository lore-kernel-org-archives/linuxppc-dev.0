Return-Path: <nicolas.ferre@atmel.com>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
 by ozlabs.org (Postfix) with ESMTP id 28860B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Mar 2012 22:54:07 +1100 (EST)
Message-ID: <4F5F3374.8000506@atmel.com>
Date: Tue, 13 Mar 2012 12:45:56 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>,
 Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 0/9] DMA engine cookie handling cleanups
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Stephen Warren <swarren@nvidia.com>,
 Linus Walleij <linus.walleij@stericsson.com>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 Barry Song <baohua.song@csr.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/06/2012 11:33 PM, Russell King - ARM Linux :
> [v2 - more or less same description.  Including lakml in cc for the full
> set]
> 
> This patch series cleans up the handling of cookies in DMA engine drivers.
> This is done by providing a set of inline library functions for common
> tasks:
> 
> - moving the 'last completed cookie' into struct dma_chan - everyone
>   has this in their driver private channel data structure
> 
> - consolidate allocation of cookies to DMA descriptors
> 
> - common way to update 'last completed cookie' value
> 
> - standard way to implement tx_status callback and update the residue
> 
> - consolidate initialization of cookies
> 
> - update implementations differing from the majority of DMA engine drivers
>   to behave the same as the majority implementation in respect of cookies
> 
> What this means is that we get to the point where all DMA engine drivers
> will hand out cookie value '2' as the first, and incrementing cookie
> values up to INT_MAX, returning to cookie '1' as the next cookie.
> 
> Think of this patch series as round 1...  I am hoping over time that more
> code can be consolidated between the DMA engine drivers and end up with a
> consistent way to handle various common themes in DMA engine hardware
> (like physical channel<->peripheral request signal selection.)
> 
> Overall, the diffstat looks like this:
> 
>  arch/arm/include/asm/hardware/iop_adma.h |    2 -
>  drivers/dma/amba-pl08x.c                 |   38 ++++---------
>  drivers/dma/at_hdmac.c                   |   48 ++++------------
>  drivers/dma/at_hdmac_regs.h              |    2 -

For at_hdmac Atmel DMA driver:

Tested-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks a lot Russell.

Best regards,
-- 
Nicolas Ferre
