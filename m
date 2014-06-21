Return-Path: <vincent.yang.fujitsu@gmail.com>
Received: from mail-yk0-x231.google.com (mail-yk0-x231.google.com
 [IPv6:2607:f8b0:4002:c07::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3470B1A000D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Jun 2014 14:29:08 +1000 (EST)
Received: by mail-yk0-f177.google.com with SMTP id 10so3321216ykt.36
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jun 2014 21:29:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20140620202638.GA21349@teo>
References: <1403256928-11359-1-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <1403256928-11359-2-git-send-email-Vincent.Yang@tw.fujitsu.com>
 <20140620202638.GA21349@teo>
Date: Sat, 21 Jun 2014 12:29:02 +0800
Message-ID: <CAOEd-H1AW9UYgtKiwrsU3Tkubinw+LbCfcKcbZwpy7vYK_xDgw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mmc: sdhci: add quirk for broken 3.0V support
From: Vincent Yang <vincent.yang.fujitsu@gmail.com>
To: Anton Vorontsov <anton@enomsg.org>
Content-Type: text/plain; charset=UTF-8
Cc: Andy Green <andy.green@linaro.org>, patches@linaro.org,
 linux-mmc@vger.kernel.org, chris@printf.net,
 Vincent Yang <Vincent.Yang@tw.fujitsu.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,
Thanks a lot for your review.
I will update it in next version.


Best regards,
Vincent Yang

2014-06-21 4:26 GMT+08:00 Anton Vorontsov <anton@enomsg.org>:
> On Fri, Jun 20, 2014 at 05:35:22PM +0800, Vincent Yang wrote:
>> This patch defines a quirk for platforms unable
>> to enable 3.0V support.
>> It is a preparation and will be used by Fujitsu
>> SDHCI controller f_sdh30 driver.
>>
>> Signed-off-by: Vincent Yang <Vincent.Yang@tw.fujitsu.com>
>
> I don't think you need this patch. Instead, you can exclude 3V using the
> voltage-ranges = <> in the device tree.
>
> Thanks,
>
> Anton
>
>>  drivers/mmc/host/sdhci.c  | 3 +++
>>  include/linux/mmc/sdhci.h | 2 ++
>>  2 files changed, 5 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 47055f3..523075f 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -3069,6 +3069,9 @@ int sdhci_add_host(struct sdhci_host *host)
>>       }
>>  #endif /* CONFIG_REGULATOR */
>>
>> +     if (host->quirks2 & SDHCI_QUIRK2_NO_3_0_V)
>> +             caps[0] &= ~SDHCI_CAN_VDD_300;
>> +
>>       /*
>>        * According to SD Host Controller spec v3.00, if the Host System
>>        * can afford more than 150mA, Host Driver should set XPC to 1. Also
>> diff --git a/include/linux/mmc/sdhci.h b/include/linux/mmc/sdhci.h
>> index 08abe99..cac0958 100644
>> --- a/include/linux/mmc/sdhci.h
>> +++ b/include/linux/mmc/sdhci.h
>> @@ -98,6 +98,8 @@ struct sdhci_host {
>>  #define SDHCI_QUIRK2_BROKEN_HS200                    (1<<6)
>>  /* Controller does not support DDR50 */
>>  #define SDHCI_QUIRK2_BROKEN_DDR50                    (1<<7)
>> +/* The system physically doesn't support 3.0v, even if the host does */
>> +#define SDHCI_QUIRK2_NO_3_0_V                                (1<<8)
>>
>>       int irq;                /* Device IRQ */
>>       void __iomem *ioaddr;   /* Mapped address */
>> --
>> 1.9.0
