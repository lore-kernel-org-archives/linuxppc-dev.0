Return-Path: <hongbo.zhang@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe004.messaging.microsoft.com [216.32.180.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7153114008A
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 18:14:57 +1000 (EST)
Message-ID: <5347A46B.30206@freescale.com>
Date: Fri, 11 Apr 2014 16:14:35 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/8] DMA: Freescale: add fsl_dma_free_descriptor()
 to reduce code duplication
References: <1397113805-24171-1-git-send-email-hongbo.zhang@freescale.com>	
 <1397113805-24171-5-git-send-email-hongbo.zhang@freescale.com>
 <1397129361.11914.96.camel@smile.fi.intel.com>
In-Reply-To: <1397129361.11914.96.camel@smile.fi.intel.com>
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


On 04/10/2014 07:29 PM, Andy Shevchenko wrote:
> On Thu, 2014-04-10 at 15:10 +0800, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> There are several places where descriptors are freed using identical code.
>> This patch puts this code into a function to reduce code duplication.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
>> ---
>>   drivers/dma/fsldma.c |   30 ++++++++++++++++++------------
>>   1 file changed, 18 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
>> index b71cc04..b5a0ffa 100644
>> --- a/drivers/dma/fsldma.c
>> +++ b/drivers/dma/fsldma.c
>> @@ -418,6 +418,19 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>>   }
>>   
>>   /**
>> + * fsl_dma_free_descriptor - Free descriptor from channel's DMA pool.
>> + * @chan : Freescale DMA channel
>> + * @desc: descriptor to be freed
>> + */
>> +static void fsl_dma_free_descriptor(struct fsldma_chan *chan,
>> +		struct fsl_desc_sw *desc)
>> +{
>> +	list_del(&desc->node);
>> +	chan_dbg(chan, "LD %p free\n", desc);
>> +	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
>> +}
>> +
>> +/**
>>    * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
>>    * @chan : Freescale DMA channel
>>    *
>> @@ -489,11 +502,8 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
>>   {
>>   	struct fsl_desc_sw *desc, *_desc;
>>   
>> -	list_for_each_entry_safe(desc, _desc, list, node) {
>> -		list_del(&desc->node);
>> -		chan_dbg(chan, "LD %p free\n", desc);
>> -		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
>> -	}
>> +	list_for_each_entry_safe(desc, _desc, list, node)
>> +		fsl_dma_free_descriptor(chan, desc);
>>   }
>>   
>>   static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
>> @@ -501,11 +511,8 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
>>   {
>>   	struct fsl_desc_sw *desc, *_desc;
>>   
>> -	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
>> -		list_del(&desc->node);
>> -		chan_dbg(chan, "LD %p free\n", desc);
>> -		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
>> -	}
>> +	list_for_each_entry_safe_reverse(desc, _desc, list, node)
>> +		fsl_dma_free_descriptor(chan, desc);
>>   }
>>   
>>   /**
>> @@ -819,8 +826,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
>>   	dma_run_dependencies(txd);
>>   
>>   	dma_descriptor_unmap(txd);
>> -	chan_dbg(chan, "LD %p free\n", desc);
>> -	dma_pool_free(chan->desc_pool, desc, txd->phys);
>> +	fsl_dma_free_descriptor(chan, desc);
> Here is no list_del() call since it's been called in dma_do_tasklet().
> What will be the result of double list_del() against the same node?

Not clear with your point.
This patch is only introducing a common fsl_dma_free_descriptor() to 
reduce code duplication. And later in the patch 6/8 the 
fsldma_cleanup_descriptor() is replaced by fsldma_cleanup_descriptorS().

>>   }
>>   
>>   /**
>
