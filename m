Return-Path: <hongbo.zhang@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8484814008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 15:26:36 +1000 (EST)
Message-ID: <5350A57A.1060509@freescale.com>
Date: Fri, 18 Apr 2014 12:09:30 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/8] DMA: Freescale: add fsl_dma_free_descriptor()
 to reduce code duplication
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>	
 <1397113805-24171-5-git-send-email-hongbo.zhang@freescale.com>	
 <1397129361.11914.96.camel@smile.fi.intel.com>	
 <5347A46B.30206@freescale.com> <1397482830.11914.126.camel@smile.fi
In-Reply-To: <1397482830.11914.126.camel@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
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


On 04/14/2014 09:40 PM, Andy Shevchenko wrote:
> On Fri, 2014-04-11 at 16:14 +0800, Hongbo Zhang wrote:
>> On 04/10/2014 07:29 PM, Andy Shevchenko wrote:
>>> On Thu, 2014-04-10 at 15:10 +0800, hongbo.zhang@freescale.com wrote:
> []
>
>>>> @@ -819,8 +826,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
>>>>    	dma_run_dependencies(txd);
>>>>    
>>>>    	dma_descriptor_unmap(txd);
>>>> -	chan_dbg(chan, "LD %p free\n", desc);
>>>> -	dma_pool_free(chan->desc_pool, desc, txd->phys);
>>>> +	fsl_dma_free_descriptor(chan, desc);
>>> Here is no list_del() call since it's been called in dma_do_tasklet().
>>> What will be the result of double list_del() against the same node?
>> Not clear with your point.
>> This patch is only introducing a common fsl_dma_free_descriptor() to
>> reduce code duplication. And later in the patch 6/8 the
>> fsldma_cleanup_descriptor() is replaced by fsldma_cleanup_descriptorS().
> In the last case you could have a broken kernel which will fails on
> double list_del(). I think it's better to leave this one untouched and
> you may remove it later.
>
> Or move this patch after you have removed that lines.
>

Good catch, thank you Andy.
Yes I prefer to leave this untouched and handle it later.
