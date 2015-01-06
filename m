Return-Path: <stripathi@apm.com>
Received: from exprod5og123.obsmtp.com (exprod5og123.obsmtp.com [64.18.0.198])
 by lists.ozlabs.org (Postfix) with SMTP id 4F0451A083A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 22:47:31 +1100 (AEDT)
Received: by mail-yk0-f177.google.com with SMTP id 9so11215534ykp.36
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Jan 2015 03:47:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3866536.C6OiUcuGCr@wuerfel>
References: <1418662867-9210-1-git-send-email-stripathi@apm.com>
 <1418662867-9210-2-git-send-email-stripathi@apm.com>
 <3866536.C6OiUcuGCr@wuerfel>
Date: Tue, 6 Jan 2015 17:10:29 +0530
Message-ID: <CAOHikRCV7RaxJz-A_s6g++ueg3CDe9Jrqcog1Lc2_+KXR9QqnQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: host: arasan: Add addition of-arasan quirks and
 add IOMMU support.
From: Suman Tripathi <stripathi@apm.com>
To: Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Jon Masters <jcm@redhat.com>, anton@enomsg.org, linux-mmc@vger.kernel.org,
 chris@printf.net, patches@apm.com, Don Dutile <ddutile@redhat.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>                 goto clk_dis_ahb;
>         }
>
> +#if defined(CONFIG_IOMMU_SUPPORT)
> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
> +       if (!sdhci_arasan->domain) {
> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
> +               return PTR_ERR(sdhci_arasan->domain);
> +       }
> +
> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
> +#endif
> +
>

Device drivers should never care about the implementation details
of the iommu. Please change the code to use the regular dma_map_*
interfaces that will work both with and without IOMMU.

After refer to iommu binding , there is a service that allows "Remap
address space to allow devices to access physical memory ranges that
they otherwise wouldn't be capable of accessing." eg : 32-bit to 64
bit DMA .

So do we have any existing driver that uses this service ? Just asking
for suggestions.

On Tue, Dec 16, 2014 at 2:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Monday 15 December 2014 22:31:06 Suman Tripathi wrote:
>> @@ -162,6 +206,16 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>>                 goto clk_dis_ahb;
>>         }
>>
>> +#if defined(CONFIG_IOMMU_SUPPORT)
>> +       sdhci_arasan->domain = iommu_domain_alloc(&amba_bustype);
>> +       if (!sdhci_arasan->domain) {
>> +               dev_err(&pdev->dev, "Unable to allocate iommu domain\n");
>> +               return PTR_ERR(sdhci_arasan->domain);
>> +       }
>> +
>> +       iommu_attach_device(sdhci_arasan->domain, &pdev->dev);
>> +#endif
>> +
>>
>
> Device drivers should never care about the implementation details
> of the iommu. Please change the code to use the regular dma_map_*
> interfaces that will work both with and without IOMMU.
>
>         Arnd



-- 
Thanks,
with regards,
Suman Tripathi
CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, 
is for the sole use of the intended recipient(s) and contains information
that is confidential and proprietary to Applied Micro Circuits Corporation or its subsidiaries. 
It is to be used solely for the purpose of furthering the parties' business relationship. 
All unauthorized review, use, disclosure or distribution is prohibited. 
If you are not the intended recipient, please contact the sender by reply e-mail 
and destroy all copies of the original message.
