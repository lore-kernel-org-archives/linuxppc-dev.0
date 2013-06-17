Return-Path: <B31939@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6E6DE2C02CD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 12:59:46 +1000 (EST)
Received: from mail100-tx2 (localhost [127.0.0.1])	by
 mail100-tx2-R.bigfish.com (Postfix) with ESMTP id C0D104200F0	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 02:59:41 +0000 (UTC)
Received: from TX2EHSMHS035.bigfish.com (unknown [10.9.14.252])	by
 mail100-tx2.bigfish.com (Postfix) with ESMTP id C9A2622005A	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 02:59:39 +0000 (UTC)
Message-ID: <51BE7BB1.1070309@freescale.com>
Date: Mon, 17 Jun 2013 11:00:01 +0800
From: Lian Minghuan-b31939 <B31939@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] powerpc/fsl_msi: add MSIIR1 support for MPIC v4.3
References: <1371194159-17332-1-git-send-email-Minghuan.Lian@freescale.com>
 <1371194159-17332-2-git-send-email-Minghuan.Lian@freescale.com>
 <1371247751.2996.16@snotra>
In-Reply-To: <1371247751.2996.16@snotra>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: Minghuan Lian <Minghuan.Lian@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Zang Roy-R61911 <r61911@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,

please see my comments inline.

On 06/15/2013 06:09 AM, Scott Wood wrote:
> On 06/14/2013 02:15:56 AM, Minghuan Lian wrote:
>> @@ -421,10 +440,29 @@ static int fsl_of_msi_probe(struct 
>> platform_device *dev)
>>          }
>>          msi->msiir_offset =
>>              features->msiir_offset + (res.start & 0xfffff);
>> +
>> +        /*
>> +         * First read the MSIIR/MSIIR1 offset from dts
>> +         * If failure use the hardcode MSIIR offset
>
> "On failure"
>
[Minghuan] OK, thanks.
>> +         */
>> +        if (of_address_to_resource(dev->dev.of_node, 1, &msiir))
>> +            msi->msiir_offset = features->msiir_offset +
>> +                        (res.start & MSIIR_OFFSET_MASK);
>> +        else
>> +            msi->msiir_offset = msiir.start & MSIIR_OFFSET_MASK;
>>      }
>>
>>      msi->feature = features->fsl_pic_ip;
>>
>> +    if (of_device_is_compatible(dev->dev.of_node, 
>> "fsl,mpic-msi-v4.3")) {
>> +        msi->srs_shift = MSIIR1_SRS_SHIFT;
>> +        msi->ibs_shift = MSIIR1_IBS_SHIFT;
>> +
>> +    } else {
>> +        msi->srs_shift = MSIIR_SRS_SHIFT;
>> +        msi->ibs_shift = MSIIR_IBS_SHIFT;
>> +    }
>
> Remove the blank line just before the "} else {".
>
[Minghuan] OK, Thanks.
>> diff --git a/arch/powerpc/sysdev/fsl_msi.h 
>> b/arch/powerpc/sysdev/fsl_msi.h
>> index 8225f86..43a9d99 100644
>> --- a/arch/powerpc/sysdev/fsl_msi.h
>> +++ b/arch/powerpc/sysdev/fsl_msi.h
>> @@ -16,7 +16,7 @@
>>  #include <linux/of.h>
>>  #include <asm/msi_bitmap.h>
>>
>> -#define NR_MSI_REG        8
>> +#define NR_MSI_REG        16
>>  #define IRQS_PER_MSI_REG    32
>>  #define NR_MSI_IRQS    (NR_MSI_REG * IRQS_PER_MSI_REG)
>
> I don't see where you update all_avail in fsl_of_msi_probe.
>
> We should also be bounds-checking the contents of msi-available-ranges.
> Currently it looks like we just silently overrun the bitmap if we get bad
> input from the device tree.
>
[Minghuan] all_avail definition: static const u32 all_avail[] = { 0, 
NR_MSI_IRQS };
When changing NR_MSI_REG to 16, NR_MSI_IRQS has been changed to 16*32, 
and all_avail also is updated.

Before calling fsl_msi_setup_hwirq(), the code has checked 
'msi-available-ranges',  only the interrupts lied in 
'msi-available-ranges' will be initialized by call fsl_msi_setup_hwirq() 
, and the corresponding bitmap will be freed. I moved 
msi_bitmap_free_hwirqs() to fsl_msi_setup_hwirq(), because the code 
would generate different bitmap when using MSIIR or MSIIR1.

> -Scott
