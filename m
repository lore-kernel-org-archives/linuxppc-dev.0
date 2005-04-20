Return-Path: <sbajaj@tsi-telsys.com>
Received: from exchange.tsi-telsys.com (unknown [205.230.130.11])
	by ozlabs.org (Postfix) with ESMTP id 8895F67A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 03:38:00 +1000 (EST)
Message-ID: <42669370.90706@tsi-telsys.com>
Date: Wed, 20 Apr 2005 13:37:52 -0400
From: Sanjay Bajaj <sbajaj@tsi-telsys.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: DMA Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am having a setup issue with the DMA channel 0 with the DMA Controller 
on PPC440GX. The code I wrote is:

#if defined(CONFIG_PPC4xx_DMA)
    /* Setup the DMA */
    DPRINTK("PPC4xx pwidth: %d\n", ppc4xx_get_peripheral_width(DMA_CH0));
    ppc4xx_set_dma_mode(DMA_CH0, DMA_MODE_READ);
    ppc4xx_set_src_addr(DMA_CH0, (phys_addr_t)(pdev->x2mem_phys_addr + 
src_addr));
    ppc4xx_set_dst_addr(DMA_CH0, (phys_addr_t)dst_addr);
    ppc4xx_set_dma_count(DMA_CH0, count);
    ppc4xx_enable_dma(DMA_CH0);
    DPRINTK("PPC4xx DMA Status: %d\n", ppc4xx_get_dma_status());
#endif

The DMA never completes and leaves a residue of 'count'. What am I missing?

Please Help.
Sanjay
