Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by ozlabs.org (Postfix) with ESMTP id 50447140112
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Apr 2014 23:40:36 +1000 (EST)
Message-ID: <1397482830.11914.126.camel@smile.fi.intel.com>
Subject: Re: [PATCH v3 4/8] DMA: Freescale: add fsl_dma_free_descriptor() to
 reduce code duplication
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Hongbo Zhang <hongbo.zhang@freescale.com>
Date: Mon, 14 Apr 2014 16:40:30 +0300
In-Reply-To: <5347A46B.30206@freescale.com>
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>
 <1397113805-24171-5-git-send-email-hongbo.zhang@freescale.com>
 <1397129361.11914.96.camel@smile.fi.intel.com>
 <5347A46B.30206@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-04-11 at 16:14 +0800, Hongbo Zhang wrote:
> On 04/10/2014 07:29 PM, Andy Shevchenko wrote:
> > On Thu, 2014-04-10 at 15:10 +0800, hongbo.zhang@freescale.com wrote:

[]

> >> @@ -819,8 +826,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
> >>   	dma_run_dependencies(txd);
> >>   
> >>   	dma_descriptor_unmap(txd);
> >> -	chan_dbg(chan, "LD %p free\n", desc);
> >> -	dma_pool_free(chan->desc_pool, desc, txd->phys);
> >> +	fsl_dma_free_descriptor(chan, desc);
> > Here is no list_del() call since it's been called in dma_do_tasklet().
> > What will be the result of double list_del() against the same node?
> 
> Not clear with your point.
> This patch is only introducing a common fsl_dma_free_descriptor() to 
> reduce code duplication. And later in the patch 6/8 the 
> fsldma_cleanup_descriptor() is replaced by fsldma_cleanup_descriptorS().

In the last case you could have a broken kernel which will fails on
double list_del(). I think it's better to leave this one untouched and
you may remove it later.

Or move this patch after you have removed that lines.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
