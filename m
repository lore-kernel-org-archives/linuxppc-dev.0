Return-Path: <hongbo.zhang@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8397314014E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Apr 2014 19:09:48 +1100 (EST)
Message-ID: <533D173C.9050204@freescale.com>
Date: Thu, 3 Apr 2014 16:09:32 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH 3/7] DMA: Freescale: add fsl_dma_free_descriptor() to
 reduce code duplication
References: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
 <1389851246-8564-4-git-send-email-hongbo.zhang@freescale.com>
 <20140311110616.GV1976@intel.com> <5334F022.3050402@freescale.com>
In-Reply-To: <5334F022.3050402@freescale.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Cc: scottwood@freescale.com, dmaengine@vger.kernel.org,
 dan.j.williams@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03/28/2014 11:44 AM, Hongbo Zhang wrote:
>
> On 03/11/2014 07:06 PM, Vinod Koul wrote:
>> On Thu, Jan 16, 2014 at 01:47:22PM +0800, hongbo.zhang@freescale.com 
>> wrote:
>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>
>>> There are several places where descriptors are freed using identical 
>>> code.
>>> This patch puts this code into a function to reduce code duplication.
>>>
>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>>> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
>>> ---
>>>   drivers/dma/fsldma.c |   38 ++++++++++++++++++++------------------
>>>   1 file changed, 20 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
>>> index 95236e6..ad73538 100644
>>> --- a/drivers/dma/fsldma.c
>>> +++ b/drivers/dma/fsldma.c
>>> @@ -418,6 +418,21 @@ static dma_cookie_t fsl_dma_tx_submit(struct 
>>> dma_async_tx_descriptor *tx)
>>>   }
>>>     /**
>>> + * fsl_dma_free_descriptor - Free descriptor from channel's DMA pool.
>>> + * @chan : Freescale DMA channel
>>> + * @desc: descriptor to be freed
>>> + */
>>> +static void fsl_dma_free_descriptor(struct fsldma_chan *chan,
>>> +        struct fsl_desc_sw *desc)
>>> +{
>>> +    list_del(&desc->node);
>>> +#ifdef FSL_DMA_LD_DEBUG
>>> +    chan_dbg(chan, "LD %p free\n", desc);
>>> +#endif
>> why not wrap the define stuff in the defination of chan_dbg rather 
>> than its
>> usage :(
>>
>
> OK, I will fix it by another separate patch.
> Thanks.
>

Think it again, I'd like to remove the FSL_DMA_LD_DEBUG usage, because 
the chan_dbg is a wrapper of dev_dbg, we do have macro to switch on/off 
dev_dbg, and most of other codes are calling chan_dbg directly without 
FSL_DMA_LD_DEBUG, the FSL_DMA_LD_DEBUG only shows up 3 times unnecessarily.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
