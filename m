Return-Path: <dan.j.williams@gmail.com>
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com
 [209.85.216.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EC04B1400DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Apr 2014 03:45:22 +1000 (EST)
Received: by mail-qc0-f178.google.com with SMTP id i8so6190599qcq.23
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Apr 2014 10:45:19 -0700 (PDT)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
References: <1397202086-22489-1-git-send-email-xuelin.shi@freescale.com>
 <CAA9_cme=Bo3tYi0-bNXBRNLZnC-4FZyaSYZ=3iRD_5xfiVX5Mw@mail.gmail.com>
Date: Fri, 11 Apr 2014 10:45:19 -0700
Message-ID: <CAA9_cmc1LkPdeHcXsWzrgNgXEYsPFGH=h96qJ6WpQB3F+K8K7A@mail.gmail.com>
Subject: Re: [PATCH v3] dmaengine: driver support for FSL RaidEngine device.
From: Dan Williams <dan.j.williams@intel.com>
To: xuelin.shi@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Harninder Rai <harninder.rai@freescale.com>, andriy.shevchenko@intel.com,
 "Koul, Vinod" <vinod.koul@intel.com>, Naveen Burmi <naveenburmi@freescale.com>,
 "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2014 at 10:42 AM, Dan Williams <dan.j.williams@intel.com> wrote:
> A few more comments:
>
> On Fri, Apr 11, 2014 at 12:41 AM,  <xuelin.shi@freescale.com> wrote:
>> From: Xuelin Shi <xuelin.shi@freescale.com>
>>
>> The RaidEngine is a new FSL hardware used for Raid5/6 acceration.
>>
>> This patch enables the RaidEngine functionality and provides
>> hardware offloading capability for memcpy, xor and pq computation.
>> It works with async_tx.
>>
>> Signed-off-by: Harninder Rai <harninder.rai@freescale.com>
>> Signed-off-by: Naveen Burmi <naveenburmi@freescale.com>
>> Signed-off-by: Xuelin Shi <xuelin.shi@freescale.com>
>> ---
>>  changes for v3:
>>   - fix memory allocation flag GFP_xxx usage.
>>   - add re_jr_issue_pending call in cleanup.
>>   - remove unnecessary dma_run_dependencies(...).
>>   - use dma_cookie_complete(...) instead of direct updating cookie.
>>
>>  drivers/dma/Kconfig    |  11 +
>>  drivers/dma/Makefile   |   1 +
>>  drivers/dma/fsl_raid.c | 878 +++++++++++++++++++++++++++++++++++++++++++++++++
>>  drivers/dma/fsl_raid.h | 308 +++++++++++++++++
>>  4 files changed, 1198 insertions(+)
>>  create mode 100644 drivers/dma/fsl_raid.c
>>  create mode 100644 drivers/dma/fsl_raid.h
>>
>> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
>> index 605b016..829f41c 100644
>> --- a/drivers/dma/Kconfig
>> +++ b/drivers/dma/Kconfig
>> @@ -100,6 +100,17 @@ config FSL_DMA
>>           EloPlus is on mpc85xx and mpc86xx and Pxxx parts, and the Elo3 is on
>>           some Txxx and Bxxx parts.
>>
>> +config FSL_RAID
>> +        tristate "Freescale RAID engine Support"
>> +        depends on FSL_SOC && !FSL_DMA
>
> This won't work in the case where FSL_DMA=m.
>
> Instead, I think you want to use "depends on
> !ASYNC_TX_ENABLE_CHANNEL_SWITCH" which is the actual dependency.
>
>> +        select DMA_ENGINE
>> +        select DMA_ENGINE_RAID
>> +        ---help---
>> +          Enable support for Freescale RAID Engine. RAID Engine is
>> +          available on some QorIQ SoCs (like P5020). It has
>> +          the capability to offload memcpy, xor and pq computation
>> +         for raid5/6.
>> +
> [..]
>> diff --git a/drivers/dma/fsl_raid.c b/drivers/dma/fsl_raid.c
>> new file mode 100644
>> index 0000000..4b389b1
>> --- /dev/null
>> +++ b/drivers/dma/fsl_raid.c
>> @@ -0,0 +1,878 @@
> [..]
>> +void fill_cfd_frame(struct cmpnd_frame *cf, u8 index,
>> +               size_t length, dma_addr_t addr, bool final)
>> +{
>> +       u32 efrl = length & CF_LENGTH_MASK;
>> +       efrl |= final << CF_FINAL_SHIFT;
>> +       cf[index].efrl32 = efrl;
>> +       cf[index].addr_high = (addr >> 32) & HWDESC_ADDR_HIGH_MASK;
>
> Use "upper_32_bits()" here otherwise:
>
>   drivers/dma/fsl_raid.c: In function 'fill_cfd_frame':
>   drivers/dma/fsl_raid.c:258:2: warning: right shift count >= width of type
>
>> +       cf[index].addr_low = (u32)addr;
>
> Use lower_32_bits() here to be symmetrical.
>
>> +}
>> +
>> +static struct fsl_re_dma_async_tx_desc *re_jr_init_desc(struct re_jr *jr,
>> +       struct fsl_re_dma_async_tx_desc *desc, void *cf, dma_addr_t paddr)
>> +{
>> +       desc->jr = jr;
>> +       desc->async_tx.tx_submit = re_jr_tx_submit;
>> +       dma_async_tx_descriptor_init(&desc->async_tx, &jr->chan);
>> +       INIT_LIST_HEAD(&desc->node);
>> +
>> +       desc->hwdesc.fmt32 = FRAME_FORMAT << HWDESC_FMT_SHIFT;
>> +       desc->hwdesc.lbea32 = (paddr >> 32) & HWDESC_ADDR_HIGH_MASK;
>
> Same comment/warning as above...
>
>> +       desc->hwdesc.addr_low = (u32)paddr;
>
> ditto.

Oh, and be mindful of checkpatch output:

ERROR: trailing whitespace
#35: FILE: drivers/dma/Kconfig:106:
+        select DMA_ENGINE $

ERROR: trailing whitespace
#42: FILE: drivers/dma/Kconfig:113:
+ $

total: 2 errors, 0 warnings, 1207 lines checked
