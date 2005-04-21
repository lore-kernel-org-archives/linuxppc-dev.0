Return-Path: <roger.larsson@norran.net>
Received: from ns.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 8B95967A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 06:42:24 +1000 (EST)
Received: from icd.localnet (131.net95.skekraft.net [213.199.95.131])
	by ns.skekraft.net (Postfix) with ESMTP id 38750A4028
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 22:42:23 +0200 (CEST)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Date: Thu, 21 Apr 2005 22:42:20 +0200
References: <42669370.90706@tsi-telsys.com>
In-Reply-To: <42669370.90706@tsi-telsys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504212242.20464.roger.larsson@norran.net>
Subject: [DBG SRC] Re: DMA Problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 20 April 2005 19.37, Sanjay Bajaj wrote:
> I am having a setup issue with the DMA channel 0 with the DMA Controller
> on PPC440GX. The code I wrote is:
>
> #if defined(CONFIG_PPC4xx_DMA)
>     /* Setup the DMA */
>     DPRINTK("PPC4xx pwidth: %d\n", ppc4xx_get_peripheral_width(DMA_CH0));
>     ppc4xx_set_dma_mode(DMA_CH0, DMA_MODE_READ);
>     ppc4xx_set_src_addr(DMA_CH0, (phys_addr_t)(pdev->x2mem_phys_addr +
> src_addr));
>     ppc4xx_set_dst_addr(DMA_CH0, (phys_addr_t)dst_addr);
>     ppc4xx_set_dma_count(DMA_CH0, count);
>     ppc4xx_enable_dma(DMA_CH0);
>     DPRINTK("PPC4xx DMA Status: %d\n", ppc4xx_get_dma_status());
> #endif
>
> The DMA never completes and leaves a residue of 'count'. What am I missing?
>

Request irq and dma?

	if ((ret = request_irq(dma_irq, dma_irq_handler, SA_SHIRQ, "NAME")))
		- - -
	/* reserve a DMA channel */
	if (DBG_DMA(request_dma(DMA_CH0, const char *device_id))

BTW you should check return values, try this:

int fgrabber_report_dma_error(const char *call, int ret)
{
    switch (ret)
    {
	case DMA_STATUS_GOOD:
//	    printk(KERN_DEBUG "dma: %s STATUS_GOOD\n", call);
	    break;
	case DMA_STATUS_BAD_CHANNEL:
	    printk(KERN_DEBUG "dma: %s STATUS_BAD_CHANNEL\n", call);
	    break;
	case DMA_STATUS_BAD_HANDLE:
	    printk(KERN_DEBUG "dma: %s STATUS_BAD_HANDLE", call);
	    break;
	case DMA_STATUS_BAD_MODE:
	    printk(KERN_DEBUG "dma: %s STATUS_BAD_MODE", call);
	    break;
	case DMA_STATUS_NULL_POINTER:
	    printk(KERN_DEBUG "dma: %s STATUS_NULL_POINTER", call);
	    break;
	case DMA_STATUS_OUT_OF_MEMORY:
	    printk(KERN_DEBUG "dma: %s STATUS_OUT_OF_MEMORY", call);
	    break;
	case DMA_STATUS_SGL_LIST_EMPTY:
	    printk(KERN_DEBUG "dma: %s STATUS_SGL_LIST_EMPTY", call);
	    break;
	case DMA_STATUS_GENERAL_ERROR:
	    printk(KERN_DEBUG "dma: %s STATUS_GENERAL_ERROR", call);
	    break;
	case DMA_STATUS_CHANNEL_NOTFREE:   
	    printk(KERN_DEBUG "dma: %s STATUS_CHANNEL_NOTFREE", call);
	    break;
	default:
	    printk(KERN_DEBUG "dma: %s STATUS(0x%x)", call, ret);
	    break;
     }

    return ret;
}

#ifdef DEBUG_DMA
#define DBG_DMA(call) fgrabber_report_dma_error(#call, call)
#else
#define DBG_DMA(call) call
#endif

/RogerL
