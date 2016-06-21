Return-Path: <jonathanh@nvidia.com>
Received: from hqemgate16.nvidia.com (hqemgate16.nvidia.com [216.228.121.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rYvcJ10hKzDqCp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 03:19:59 +1000 (AEST)
Subject: Re: [PATCH 7/8] dmaengine: tegra20-apb-dma: Only calculate residue if
 txstate exists.
To: Vinod Koul <vinod.koul@intel.com>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
 <1465321121-22238-8-git-send-email-peter.griffin@linaro.org>
 <5757DCAD.1090106@nvidia.com> <20160621160139.GC16910@localhost>
CC: Peter Griffin <peter.griffin@linaro.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
 <kernel@stlinux.com>, <linus.walleij@linaro.org>, <dan.j.williams@intel.com>,
 <leoli@freescale.com>, <zw@zh-kernel.org>, <baohua@kernel.org>,
 <maxime.ripard@free-electrons.com>, <wens@csie.org>, <ldewangan@nvidia.com>,
 <swarren@wwwdotorg.org>, <thierry.reding@gmail.com>, <gnurou@gmail.com>,
 <lee.jones@linaro.org>, <dmaengine@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
From: Jon Hunter <jonathanh@nvidia.com>
Message-ID: <57697736.4050008@nvidia.com>
Date: Tue, 21 Jun 2016 18:19:50 +0100
MIME-Version: 1.0
In-Reply-To: <20160621160139.GC16910@localhost>
Content-Type: text/plain; charset="windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 21/06/16 17:01, Vinod Koul wrote:
> On Wed, Jun 08, 2016 at 09:51:57AM +0100, Jon Hunter wrote:
>> Hi Peter,
>>
>> On 07/06/16 18:38, Peter Griffin wrote:
>>> There is no point calculating the residue if there is
>>> no txstate to store the value.
>>>
>>> Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
>>> ---
>>>  drivers/dma/tegra20-apb-dma.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
>>> index 01e316f..7f4af8c 100644
>>> --- a/drivers/dma/tegra20-apb-dma.c
>>> +++ b/drivers/dma/tegra20-apb-dma.c
>>> @@ -814,7 +814,7 @@ static enum dma_status tegra_dma_tx_status(struct dma_chan *dc,
>>>  	unsigned int residual;
>>>  
>>>  	ret = dma_cookie_status(dc, cookie, txstate);
>>> -	if (ret == DMA_COMPLETE)
>>> +	if (ret == DMA_COMPLETE || !txstate)
>>>  		return ret;
>>
>> Thanks for reporting this. I agree that we should not do this, however, 
>> looking at the code for Tegra, I am wondering if this could change the
>> actual state that is returned. Looking at dma_cookie_status() it will
>> call dma_async_is_complete() which will return either DMA_COMPLETE or
>> DMA_IN_PROGRESS. It could be possible that the actual state for the
>> DMA transfer in the tegra driver is DMA_ERROR, so I am wondering if we
>> should do something like the following  ...
> 
> This one is stopping code execution when residue is not valid. Do notice
> that it check for DMA_COMPLETE OR txstate. In other cases, wit will return
> 'that' state when txstate is NULL.

Sorry what do you mean by "this one"?

My point is that if the status is not DMA_COMPLETE, then it is possible
that it could be DMA_ERROR (for tegra that is). However,
dma_cookie_status will only return DMA_IN_PROGRESS or DMA_COMPLETE and
so if 'txstate' is NULL we will not see the DMA_ERROR status anymore and
just think it is in progress when it is actually an error.

I do agree that the driver is broken as we are not checking for
!txstate, but this also changes the behaviour a bit.

Cheers
Jon

-- 
nvpublic
