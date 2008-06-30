Return-Path: <jcrigby@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.239])
	by ozlabs.org (Postfix) with ESMTP id 4D159DDF88
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 14:01:10 +1000 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1057067rvb.9
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 21:01:08 -0700 (PDT)
Message-ID: <4b73d43f0806292101v21192746v54bebcb2a3919bab@mail.gmail.com>
Date: Sun, 29 Jun 2008 22:01:08 -0600
From: "John Rigby" <jcrigby@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 4/6] MPC5121 Add MPC5121ADS cpld support
In-Reply-To: <20080629053646.GC13876@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1213981119-1979-1-git-send-email-jrigby@freescale.com>
	<1213981119-1979-2-git-send-email-jrigby@freescale.com>
	<1213981119-1979-3-git-send-email-jrigby@freescale.com>
	<1213981119-1979-4-git-send-email-jrigby@freescale.com>
	<1213981119-1979-5-git-send-email-jrigby@freescale.com>
	<20080629053646.GC13876@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jun 28, 2008 at 11:36 PM, Grant Likely
<grant.likely@secretlab.ca> wrote:
> Minor comments below.
>
> On Fri, Jun 20, 2008 at 10:58:37AM -0600, John Rigby wrote:
>> Add a interrupt host for the interrupt
>> controller in the mpc5121ads cpld.
>> PCI interrupts are 0-7 the rest are 8-15
>> Touchscreen pendown irq is hardwired to irq1
>> All other irqs are chainged to irq0
>>
>> Signed-off-by: John Rigby <jrigby@freescale.com>
>> ---
>>  arch/powerpc/platforms/512x/Kconfig            |    1 +
>>  arch/powerpc/platforms/512x/Makefile           |    2 +-
>>  arch/powerpc/platforms/512x/mpc5121_ads.c      |   14 ++-
>>  arch/powerpc/platforms/512x/mpc5121_ads.h      |   14 ++
>>  arch/powerpc/platforms/512x/mpc5121_ads_cpld.c |  204 ++++++++++++++++++++++++
>>  5 files changed, 233 insertions(+), 2 deletions(-)
>>  create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads.h
>>  create mode 100644 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
>>
>> diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
>> index f9a04da..0fd3b00 100644
>> --- a/arch/powerpc/platforms/512x/Kconfig
>> +++ b/arch/powerpc/platforms/512x/Kconfig
>> @@ -12,6 +12,7 @@ config MPC5121_ADS
>>       depends on PPC_MULTIPLATFORM && PPC32
>>       select DEFAULT_UIMAGE
>>       select PPC_MPC5121
>> +     select MPC5121_ADS_CPLD
>
> What is this for?  I don't see it used anywhere.
Yes you are right, the Makefile just uses MPC5121_ADS to include the cpld code.
>
>>       help
>>         This option enables support for the MPC5121E ADS board.
>>
>> diff --git a/arch/powerpc/platforms/512x/mpc5121_ads.c b/arch/powerpc/platforms/512x/mpc5121_ads.c
>> index 45bb2ef..36805fd 100644
>> --- a/arch/powerpc/platforms/512x/mpc5121_ads.c
>> +++ b/arch/powerpc/platforms/512x/mpc5121_ads.c
>> @@ -1,5 +1,5 @@
>>  /*
>> - * Copyright (C) 2007 Freescale Semiconductor, Inc. All rights reserved.
>> + * Copyright (C) 2007, 2008 Freescale Semiconductor, Inc. All rights reserved.
>>   *
>>   * Author: John Rigby, <jrigby@freescale.com>, Thur Mar 29 2007
>>   *
>> @@ -23,6 +23,16 @@
>>  #include <asm/time.h>
>>
>>  #include "mpc512x.h"
>> +#include "mpc5121_ads.h"
>> +
>> +static void __init mpc5121_ads_setup_arch(void)
>> +{
>> +     printk(KERN_INFO "MPC5121 ADS board from Freescale Semiconductor\n");
>> +     /*
>> +      * cpld regs are needed early
>> +      */
>> +     mpc5121_ads_cpld_map();
>> +}
>>
>>  static struct of_device_id __initdata of_bus_ids[] = {
>>       { .name = "soc", },
>> @@ -41,6 +51,7 @@ static void __init mpc5121_ads_declare_of_platform_devices(void)
>>  static void __init mpc5121_ads_init_IRQ(void)
>>  {
>>       mpc512x_init_IRQ();
>> +     mpc5121_ads_cpld_pic_init();
>
> Ah, I understand now.  Ignore my related comment in the previous patch.
>
>>  }
>>
>>  /*
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
