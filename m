Return-Path: <hongbo.zhang@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 96B2A2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 20:12:30 +1100 (EST)
Message-ID: <52809F67.20901@freescale.com>
Date: Mon, 11 Nov 2013 17:12:07 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v11 3/3] DMA: Freescale: update driver to support 8-channel
 DMA engine
References: <1380188023-3936-1-git-send-email-hongbo.zhang@freescale.com>
 <1380188023-3936-4-git-send-email-hongbo.zhang@freescale.com>
 <525F7C18.3010409@freescale.com> <5278587F.7090500@freescale.com>
 <CAA9_cme3c7SjH3iio0oR3FHpfoMzgrBDO-2k_Yf68G-AgFNqfA@mail.gmail.com>
In-Reply-To: <CAA9_cme3c7SjH3iio0oR3FHpfoMzgrBDO-2k_Yf68G-AgFNqfA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, ian.campbell@citrix.com,
 pawel.moll@arm.com, Stephen Warren <swarren@wwwdotorg.org>, "Koul,
 Vinod" <vinod.koul@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 rob.herring@calxeda.com, dmaengine@vger.kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/08/2013 10:45 AM, Dan Williams wrote:
> On Mon, Nov 4, 2013 at 6:31 PM, Hongbo Zhang <hongbo.zhang@freescale.com> wrote:
>> Hi Vinod Koul and Dan Williams,
>> Ping?
>>
> Not much to review from the dmaengine side, just one question below.
> It would be helpful if you can send these to the new dmaengine
> patchwork at dmaengine@vger.kernel.org with the Acks you have already
> collected.
>

Sorry didn't notice this new mailing list.
I will resend these patches to it again.

>>
>> On 10/17/2013 01:56 PM, Hongbo Zhang wrote:
>>> Hi Vinod,
>>> I have gotten ACK from Mark for both the 1/3 and 2/3 patches.
>>> Thanks.
>>>
>>>
>>> On 09/26/2013 05:33 PM, hongbo.zhang@freescale.com wrote:
>>>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>>
>>>> This patch adds support to 8-channel DMA engine, thus the driver works
>>>> for both
>>>> the new 8-channel and the legacy 4-channel DMA engines.
>>>>
>>>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>>>> ---
>>>>    drivers/dma/Kconfig  |    9 +++++----
>>>>    drivers/dma/fsldma.c |    9 ++++++---
>>>>    drivers/dma/fsldma.h |    2 +-
>>>>    3 files changed, 12 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>>>> index 6825957..3979c65 100644
>>>> --- a/drivers/dma/Kconfig
>>>> +++ b/drivers/dma/Kconfig
>>>> @@ -89,14 +89,15 @@ config AT_HDMAC
>>>>          Support the Atmel AHB DMA controller.
>>>>      config FSL_DMA
>>>> -    tristate "Freescale Elo and Elo Plus DMA support"
>>>> +    tristate "Freescale Elo series DMA support"
>>>>        depends on FSL_SOC
>>>>        select DMA_ENGINE
>>>>        select ASYNC_TX_ENABLE_CHANNEL_SWITCH
>>>>        ---help---
>>>> -      Enable support for the Freescale Elo and Elo Plus DMA controllers.
>>>> -      The Elo is the DMA controller on some 82xx and 83xx parts, and the
>>>> -      Elo Plus is the DMA controller on 85xx and 86xx parts.
>>>> +      Enable support for the Freescale Elo series DMA controllers.
>>>> +      The Elo is the DMA controller on some mpc82xx and mpc83xx parts,
>>>> the
>>>> +      EloPlus is on mpc85xx and mpc86xx and Pxxx parts, and the Elo3 is
>>>> on
>>>> +      some Txxx and Bxxx parts.
>>>>      config MPC512X_DMA
>>>>        tristate "Freescale MPC512x built-in DMA engine support"
>>>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
>>>> index 49e8fbd..16a9a48 100644
>>>> --- a/drivers/dma/fsldma.c
>>>> +++ b/drivers/dma/fsldma.c
>>>> @@ -1261,7 +1261,9 @@ static int fsl_dma_chan_probe(struct fsldma_device
>>>> *fdev,
>>>>        WARN_ON(fdev->feature != chan->feature);
>>>>          chan->dev = fdev->dev;
>>>> -    chan->id = ((res.start - 0x100) & 0xfff) >> 7;
>>>> +    chan->id = (res.start & 0xfff) < 0x300 ?
>>>> +           ((res.start - 0x100) & 0xfff) >> 7 :
>>>> +           ((res.start - 0x200) & 0xfff) >> 7;
>>>>        if (chan->id >= FSL_DMA_MAX_CHANS_PER_DEVICE) {
> Isn't it a bit fragile to have this based on the resource address?
> Can't device tree tell you the channel id directly by an index into
> the "dma0: dma@100300" node?

Yes, both this way and putting a "cell-index" into device tree work.
This won't be fragile, because the resource address should always be 
defined correctly, otherwise even if we can tell a channel id by 
"cell-index" but with wrong resource address, nothing will work.
This piece of code only doesn't seem as neat as using "cell-index", but 
we prefer the style that let the device tree describes as true as what 
hardware really has. This doesn't mean "cell-index" isn't acceptable, if 
it is necessary and unavoidable, we can send another patch to add it, 
but currently there is no need and we don't have to do this.

> --
> Dan
>
