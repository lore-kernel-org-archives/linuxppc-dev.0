Return-Path: <B45939@freescale.com>
Message-ID: <51D39EE0.1040901@freescale.com>
Date: Wed, 3 Jul 2013 11:47:44 +0800
From: Hongbo Zhang <hongbo.zhang@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/2] DMA: Freescale: update driver to support 8-channel
 DMA engine
References: <1372806786.8183.127@snotra>
In-Reply-To: <1372806786.8183.127@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: vinod.koul@intel.com, devicetree-discuss@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, vakul@freescale.com, djbw@fb.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/03/2013 07:13 AM, Scott Wood wrote:
> On 06/30/2013 10:46:18 PM, hongbo.zhang@freescale.com wrote:
>> From: Hongbo Zhang <hongbo.zhang@freescale.com>
>>
>> This patch adds support to 8-channel DMA engine, thus the driver 
>> works for both
>> the new 8-channel and the legacy 4-channel DMA engines.
>>
>> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
>> ---
>>  drivers/dma/fsldma.c |   48 
>> ++++++++++++++++++++++++++++++++++--------------
>>  drivers/dma/fsldma.h |    4 ++--
>>  2 files changed, 36 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
>> index 4fc2980..0f453ea 100644
>> --- a/drivers/dma/fsldma.c
>> +++ b/drivers/dma/fsldma.c
>> @@ -1119,27 +1119,33 @@ static irqreturn_t fsldma_ctrl_irq(int irq, 
>> void *data)
>>      struct fsldma_device *fdev = data;
>>      struct fsldma_chan *chan;
>>      unsigned int handled = 0;
>> -    u32 gsr, mask;
>> +    u8 chan_sr[round_up(FSL_DMA_MAX_CHANS_PER_DEVICE, 4)];
>> +    u32 gsr;
>>      int i;
>>
>> -    gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs)
>> -                           : in_le32(fdev->regs);
>> -    mask = 0xff000000;
>> -    dev_dbg(fdev->dev, "IRQ: gsr 0x%.8x\n", gsr);
>> +    memset(&chan_sr, 0, sizeof(chan_sr));
>> +    gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ? in_be32(fdev->regs0)
>> +                           : in_le32(fdev->regs0);
>> +    memcpy(&chan_sr[0], &gsr, 4);
>> +    dev_dbg(fdev->dev, "IRQ: gsr0 0x%.8x\n", gsr);
>> +
>> +    if (of_device_is_compatible(fdev->dev->of_node, 
>> "fsl,eloplus-dma2")) {
>
> NACK; Figure out what sort of device you've got when you first probe 
> the device, and store the information for later.  Do not call device 
> tree stuff in an interrupt handler.
>
>> +        gsr = (fdev->feature & FSL_DMA_BIG_ENDIAN) ?
>> +            in_be32(fdev->regs1) : in_le32(fdev->regs1);
>> +        memcpy(&chan_sr[4], &gsr, 4);
>> +        dev_dbg(fdev->dev, "IRQ: gsr1 0x%.8x\n", gsr);
>> +    }
>
> Do these memcpy()s get inlined?  If not (and maybe even if they do), 
> it'd be better to use a union instead.
>
For this and the first comments: good catches, thank you.
But it is very likely I will remove these codes, see the last comments 
of yours and mine.
> Wait a second -- how are we even getting into this code on these new 
> DMA controllers?  All 85xx-family DMA controllers use fsldma_chan_irq 
> directly.
>
Right, we are using fsldma_chan_irq, this code never run.
I just see there is such code for elo/eloplus DMA controllers, so I 
update it for the new 8-channel DMA.
>> @@ -1341,13 +1349,22 @@ static int fsldma_of_probe(struct 
>> platform_device *op)
>>      INIT_LIST_HEAD(&fdev->common.channels);
>>
>>      /* ioremap the registers for use */
>> -    fdev->regs = of_iomap(op->dev.of_node, 0);
>> -    if (!fdev->regs) {
>> -        dev_err(&op->dev, "unable to ioremap registers\n");
>> +    fdev->regs0 = of_iomap(op->dev.of_node, 0);
>> +    if (!fdev->regs0) {
>> +        dev_err(&op->dev, "unable to ioremap register0\n");
>>          err = -ENOMEM;
>>          goto out_free_fdev;
>>      }
>>
>> +    if (of_device_is_compatible(op->dev.of_node, "fsl,eloplus-dma2")) {
>
> Not "fsl,eloplusplus-dma"? :-)
>
> More seriously, if we're sticking with this "elo" naming, maybe 
> "fsl,elo3-dma" would be better.  It would be odd to have "2" in the 
> name of the third generation of this hardware.
>
It was really hard for me to name this new controller.
Yes "fsl,elo3-dma" seems better.
>> diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
>> index f5c3879..880664d 100644
>> --- a/drivers/dma/fsldma.h
>> +++ b/drivers/dma/fsldma.h
>> @@ -112,10 +112,10 @@ struct fsldma_chan_regs {
>>  };
>>
>>  struct fsldma_chan;
>> -#define FSL_DMA_MAX_CHANS_PER_DEVICE 4
>> +#define FSL_DMA_MAX_CHANS_PER_DEVICE 8
>>
>>  struct fsldma_device {
>> -    void __iomem *regs;    /* DGSR register base */
>> +    void __iomem *regs0, *regs1;    /* DGSR registers */
>
> Either give these meaningful names, or use an array.  Or both (dgsr[2]).
>
> Or just get rid of this, since I don't see why we need DGSR1 at all, 
> as previously noted.
>
I choose the names regs* just to follow the previous pattern.

Here comes the key point: both the previous DGSR and the new DGSR0/DGSR1 
are not actually used because we are using per channel irq.
I see we had such codes to handle DGSR, so I just follow the same 
pattern to handle the new DGSR0/DGSR1.
Since getting rid of this unused  DGSR1 is permitted, I'd like to remove 
all the related codes, then this patch becomes simple :)

> -Scott
