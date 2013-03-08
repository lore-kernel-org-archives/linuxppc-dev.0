Return-Path: <B25806@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0185.outbound.messaging.microsoft.com [213.199.154.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E042D2C0379
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 13:54:57 +1100 (EST)
Received: from mail168-db8 (localhost [127.0.0.1])	by
 mail168-db8-R.bigfish.com (Postfix) with ESMTP id 3E40BD40090	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 02:54:50 +0000 (UTC)
Received: from DB8EHSMHS007.bigfish.com (unknown [10.174.8.244])	by
 mail168-db8.bigfish.com (Postfix) with ESMTP id 8F28A1C004D	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 02:54:48 +0000 (UTC)
Message-ID: <513953B5.30707@freescale.com>
Date: Fri, 8 Mar 2013 10:57:57 +0800
From: Chunhe Lan <b25806@freescale.com>
MIME-Version: 1.0
To: Gala Kumar-B11780 <B11780@freescale.com>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Fix timeout on t4240's sdhci controller
References: <1362643535-2377-1-git-send-email-Chunhe.Lan@freescale.com>
 <CF1EE7AED478CD48A05574C8E2DA142D746975@039-SN1MPN1-004.039d.mgd.msft.net>
In-Reply-To: <CF1EE7AED478CD48A05574C8E2DA142D746975@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: "<linuxppc-dev@lists.ozlabs.org>" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/08/2013 12:30 AM, Gala Kumar-B11780 wrote:
> On Mar 7, 2013, at 2:05 AM, Chunhe Lan wrote:
>
>> This patch fixes timeout problems on t4240's sdhci controller:
>>
>> 	mmc0: Too large timeout requested for CMD25!
>> 	mmc0: Too large timeout requested for CMD25!
>> 	mmc0: Too large timeout requested for CMD25!
>>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> ---
>> drivers/mmc/host/sdhci-pltfm.c |    1 +
>> 1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-pltfm.c b/drivers/mmc/host/sdhci-pltfm.c
>> index 3145a78..9db7b12 100644
>> --- a/drivers/mmc/host/sdhci-pltfm.c
>> +++ b/drivers/mmc/host/sdhci-pltfm.c
>> @@ -94,6 +94,7 @@ void sdhci_get_of_property(struct platform_device *pdev)
>>
>> 		if (of_device_is_compatible(np, "fsl,p2020-esdhc") ||
>> 		    of_device_is_compatible(np, "fsl,p1010-esdhc") ||
>> +		    of_device_is_compatible(np, "fsl,t4240-esdhc") ||
>> 		    of_device_is_compatible(np, "fsl,mpc8536-esdhc"))
>> 			host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>
>> -- 
>> 1.7.6.5
>>
>
> Why does this occur?  Is it a board issue?  Is it a silicon issue?  Is it due to some erratum?  Why T4 only?
      It would be the property of T4 hardware, and please see below the 
patch which locates
      the mail list of freescale:

eSDHC: mmc:host host need long time to generate command complete interrupt

According to Spec 2.0, command complete interrupt will generate within 
150 SD-CLK.
But this was not enough on T4240 board. So give it sufficient time to 
detect command
timeout. 1000 * HZ will be enough, this value was test on all T4 board, 
all worked well.

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>

Thanks,
Chunhe
>
> - k
