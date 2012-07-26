Return-Path: <B08782@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71A7B2C0080
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2012 22:39:36 +1000 (EST)
Message-ID: <50113A72.4000508@freescale.com>
Date: Thu, 26 Jul 2012 15:39:14 +0300
From: Claudiu Manoil <claudiu.manoil@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/85xx: Fix sram_offset parameter type
References: <1342693696-29734-1-git-send-email-claudiu.manoil@freescale.com>
 <37C94886-3DA3-4389-8A67-F13035D2CEA6@kernel.crashing.org>
In-Reply-To: <37C94886-3DA3-4389-8A67-F13035D2CEA6@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 7/19/2012 3:07 PM, Kumar Gala wrote:
>
> On Jul 19, 2012, at 5:28 AM, Claudiu Manoil wrote:
>
>> The sram_offset parameter represents a physical address
>> and should be of type phys_addr_t. As part of this fix,
>> the extraction of sram_params is being cleaned-up and
>> fixed.
>> This patch fixes now the case when the offset value of
>> 0xfff00000 was being rejected by the driver (returning
>> -EINVAL), although this is a valid offset value.
>>
>> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
>> Signed-off-by: Claudiu Manoil <claudiu.manoil@freescale.com>
>> ---
>> arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h |    4 +-
>> arch/powerpc/sysdev/fsl_85xx_l2ctlr.c     |   39 ++++++++++------------------
>> 2 files changed, 16 insertions(+), 27 deletions(-)
>>
>> diff --git a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>> index 60c9c0b..a4ce9b8 100644
>> --- a/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>> +++ b/arch/powerpc/sysdev/fsl_85xx_cache_ctlr.h
>> @@ -1,5 +1,5 @@
>> /*
>> - * Copyright 2009-2010 Freescale Semiconductor, Inc
>> + * Copyright 2009-2010 2012 Freescale Semiconductor, Inc
>
> we normally do 2009-2010, 2012
>
Hi Kumar,

Should I re-spin this patch, with the copyright year formatted per your 
suggestion above?

Thanks,
claudiu
