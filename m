Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0112.outbound.protection.outlook.com [157.56.111.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 98B431A02D1
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 22:01:42 +1000 (AEST)
Date: Mon, 3 Aug 2015 20:01:31 +0800
From: Chenhui Zhao <chenhui.zhao@freescale.com>
Subject: Re: [PATCH 3/4] powerpc: pm: add EPU FSM configuration for deep sleep
To: Scott Wood <scottwood@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Message-ID: <1438603291.7515.4@remotesmtp.freescale.net>
In-Reply-To: <1438389711.19345.99.camel@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
 <1438347186-8462-3-git-send-email-chenhui.zhao@freescale.com>
 <1438389711.19345.99.camel@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sat, Aug 1, 2015 at 8:41 AM, Scott Wood <scottwood@freescale.com> 
wrote:
> On Fri, 2015-07-31 at 20:53 +0800, Chenhui Zhao wrote:
>>  In the last stage of deep sleep, software will trigger a Finite
>>  State Machine (FSM) to control the hardware precedure, such as
>>  board isolation, killing PLLs, removing power, and so on.
>> 
>>  When the system is waked up by an interrupt, the FSM controls the
>>  hardware to complete the early resume precedure.
>> 
>>  This patch configure the EPU FSM preparing for deep sleep.
>> 
>>  Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
>>  ---
>>   arch/powerpc/platforms/85xx/Makefile    |   2 +-
>>   arch/powerpc/platforms/85xx/sleep_fsm.c | 256
>>  ++++++++++++++++++++++++++++++++
>>   arch/powerpc/platforms/85xx/sleep_fsm.h | 104 +++++++++++++
>>   3 files changed, 361 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
>>   create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h
> 
> When I asked why this was in drivers/platform[1], you said it was to 
> share
> with LS1, and that the values used were the same -- so why did you 
> move it to
> arch/powerpc?

There are some changes. LS1 will use PSCI (Power State Coordination 
Interface) to implement deep sleep. So these code just used by PowerPC.

> 
> [1] Note that other proposed patches create a drivers/soc/fsl instead 
> of
> drivers/platform/fsl...  We need one of them, not both.
> 
>>  +void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val)
>>  +{
>>  +     struct fsm_reg_vals *data = val;
>>  +
>>  +     BUG_ON(!base || !data);
> 
> This BUG_ON is useless.  If one of those is NULL you'll get an oops 
> anyway.
> 
> 
>>  diff --git a/arch/powerpc/platforms/85xx/sleep_fsm.h
>>  b/arch/powerpc/platforms/85xx/sleep_fsm.h
>>  new file mode 100644
>>  index 0000000..2c60b40
>>  --- /dev/null
>>  +++ b/arch/powerpc/platforms/85xx/sleep_fsm.h
>>  @@ -0,0 +1,104 @@
>>  +/*
>>  + * Freescale deep sleep FSM (finite-state machine) configuration
>>  + *
>>  + * Copyright 2015 Freescale Semiconductor Inc.
>>  + *
>>  + * This program is free software; you can redistribute  it and/or 
>> modify it
>>  + * under  the terms of  the GNU General  Public License as 
>> published by the
>>  + * Free Software Foundation;  either version 2 of the  License, or 
>> (at your
>>  + * option) any later version.
>>  + */
>>  +#ifndef _FSL_SLEEP_FSM_H
>>  +#define _FSL_SLEEP_FSM_H
>>  +
>>  +#define FSL_STRIDE_4B        4
>>  +#define FSL_STRIDE_8B        8
> 
> Why not just use 4/8 directly?
> 
>> 
>>  +/* Block offsets */
>>  +#define RCPM_BLOCK_OFFSET    0x00022000
>>  +#define EPU_BLOCK_OFFSET     0x00000000
>>  +#define NPC_BLOCK_OFFSET     0x00001000
> 
> I thought you said OK to not putting these offsets in the kernel 
> source...
> 
> -Scott

OK. Will change them.

-Chenhui
