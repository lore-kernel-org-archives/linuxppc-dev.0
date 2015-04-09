Return-Path: <stripathi@apm.com>
Received: from mail-wi0-f172.google.com (exprod5og122.obsmtp.com [64.18.0.192])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BCD851A04E0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 02:17:21 +1000 (AEST)
Received: by wiaa2 with SMTP id a2so104817046wia.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Apr 2015 09:17:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOHikRArf+Fqv0JbQ1jM19zWGj-fBDcPie6apgkydgBLOm=x0w@mail.gmail.com>
References: <1427726768-17233-1-git-send-email-stripathi@apm.com>
 <1427726768-17233-3-git-send-email-stripathi@apm.com>
 <CAPDyKFoc0V5BdKCO8v92Y1qHzEPgwxRdYR3cCj8nCyU-s25NuQ@mail.gmail.com>
 <CAOHikRArf+Fqv0JbQ1jM19zWGj-fBDcPie6apgkydgBLOm=x0w@mail.gmail.com>
Date: Thu, 9 Apr 2015 21:41:18 +0530
Message-ID: <CAOHikRCD6MfqMmBzQR3XLUj8WSL1H+jH2KZrBXSQSRpTXuz1_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mmc: host: Add some quirks to be read from fdt in
 sdhci-pltm.c
From: Suman Tripathi <stripathi@apm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Mark Langsdorf <mlangsdo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
 Jon Masters <jcm@redhat.com>, Anton Vorontsov <anton@enomsg.org>,
 linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>,
 patches <patches@apm.com>, Don Dutile <ddutile@redhat.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
> This patch adds some quirks support to be read from fdt.
>
> Signed-off-by: Suman Tripathi <stripathi@apm.com>
> ---
>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
> index bef250e..9f6a4b9 100644
> --- a/drivers/mmc/host/sdhci-pltfm.c
> +++ b/drivers/mmc/host/sdhci-pltfm.c
> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device *pdev)
>
>                 if (of_get_property(np, "broken-cd", NULL))
>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
> +
> +               if (of_get_property(np, "delay-after-power", NULL))
> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
> +
> +               if (of_get_property(np, "no-hispd", NULL))
> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
> +
> +               if (of_get_property(np, "broken-adma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
> +
> +               if (of_get_property(np, "broken-dma", NULL))
> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
> +
> +               if (of_get_property(np, "no-cmd23", NULL))
> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;

Can't at least some of these be distinguished from what sdhci variant
that is being used? Instead of having them in DT...

We are using arasan controller in our SOC. So reusing a the existing
sdhci-of-arasan driver. Due to H/W issues we require this quirks. So
for us only option left to pass the info is DTS or ACPI table.

Kind regards
Uffe

On Thu, Apr 9, 2015 at 9:40 PM, Suman Tripathi <stripathi@apm.com> wrote:
> On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
>> This patch adds some quirks support to be read from fdt.
>>
>> Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> ---
>>  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c
>> b/drivers/mmc/host/sdhci-pltfm.c
>> index bef250e..9f6a4b9 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
>> *pdev)
>>
>>                 if (of_get_property(np, "broken-cd", NULL))
>>                         host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> +
>> +               if (of_get_property(np, "delay-after-power", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> +
>> +               if (of_get_property(np, "no-hispd", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> +
>> +               if (of_get_property(np, "broken-adma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> +
>> +               if (of_get_property(np, "broken-dma", NULL))
>> +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> +
>> +               if (of_get_property(np, "no-cmd23", NULL))
>> +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>
> Can't at least some of these be distinguished from what sdhci variant
> that is being used? Instead of having them in DT...
>
> We are using arasan controller in our SOC. So reusing a the existing
> sdhci-of-arasan driver. Due to H/W issues we require this quirks. So for us
> only option left to pass the info is DTS or ACPI table.
>
> Kind regards
> Uffe
>
> On Wed, Apr 8, 2015 at 3:10 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>
>> On 30 March 2015 at 16:46, Suman Tripathi <stripathi@apm.com> wrote:
>> > This patch adds some quirks support to be read from fdt.
>> >
>> > Signed-off-by: Suman Tripathi <stripathi@apm.com>
>> > ---
>> >  drivers/mmc/host/sdhci-pltfm.c | 15 +++++++++++++++
>> >  1 file changed, 15 insertions(+)
>> >
>> > diff --git a/drivers/mmc/host/sdhci-pltfm.c
>> > b/drivers/mmc/host/sdhci-pltfm.c
>> > index bef250e..9f6a4b9 100644
>> > --- a/drivers/mmc/host/sdhci-pltfm.c
>> > +++ b/drivers/mmc/host/sdhci-pltfm.c
>> > @@ -85,6 +85,21 @@ void sdhci_get_of_property(struct platform_device
>> > *pdev)
>> >
>> >                 if (of_get_property(np, "broken-cd", NULL))
>> >                         host->quirks |=
>> > SDHCI_QUIRK_BROKEN_CARD_DETECTION;
>> > +
>> > +               if (of_get_property(np, "delay-after-power", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_DELAY_AFTER_POWER;
>> > +
>> > +               if (of_get_property(np, "no-hispd", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_NO_HISPD_BIT;
>> > +
>> > +               if (of_get_property(np, "broken-adma", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_ADMA;
>> > +
>> > +               if (of_get_property(np, "broken-dma", NULL))
>> > +                       host->quirks |= SDHCI_QUIRK_BROKEN_DMA;
>> > +
>> > +               if (of_get_property(np, "no-cmd23", NULL))
>> > +                       host->quirks2 |= SDHCI_QUIRK2_HOST_NO_CMD23;
>>
>> Can't at least some of these be distinguished from what sdhci variant
>> that is being used? Instead of having them in DT...
>>
>> Kind regards
>> Uffe
>>
>> >
>> >                 if (of_get_property(np, "no-1-8-v", NULL))
>> >                         host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>> > --
>> > 1.8.2.1
>> >
>> > --
>> > To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>> > the body of a message to majordomo@vger.kernel.org
>> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
>
>
> --
> Thanks,
> with regards,
> Suman Tripathi



-- 
Thanks,
with regards,
Suman Tripathi
