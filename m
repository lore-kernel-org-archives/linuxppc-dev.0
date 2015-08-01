Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3BFCD1A0CBA
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  1 Aug 2015 10:42:07 +1000 (AEST)
Message-ID: <1438389711.19345.99.camel@freescale.com>
Subject: Re: [PATCH 3/4] powerpc: pm: add EPU FSM configuration for deep sleep
From: Scott Wood <scottwood@freescale.com>
To: Chenhui Zhao <chenhui.zhao@freescale.com>
CC: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <Jason.Jin@freescale.com>
Date: Fri, 31 Jul 2015 19:41:51 -0500
In-Reply-To: <1438347186-8462-3-git-send-email-chenhui.zhao@freescale.com>
References: <1438347186-8462-1-git-send-email-chenhui.zhao@freescale.com>
 <1438347186-8462-3-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-07-31 at 20:53 +0800, Chenhui Zhao wrote:
> In the last stage of deep sleep, software will trigger a Finite
> State Machine (FSM) to control the hardware precedure, such as
> board isolation, killing PLLs, removing power, and so on.
> 
> When the system is waked up by an interrupt, the FSM controls the
> hardware to complete the early resume precedure.
> 
> This patch configure the EPU FSM preparing for deep sleep.
> 
> Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
> ---
>  arch/powerpc/platforms/85xx/Makefile    |   2 +-
>  arch/powerpc/platforms/85xx/sleep_fsm.c | 256 
> ++++++++++++++++++++++++++++++++
>  arch/powerpc/platforms/85xx/sleep_fsm.h | 104 +++++++++++++
>  3 files changed, 361 insertions(+), 1 deletion(-)
>  create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.c
>  create mode 100644 arch/powerpc/platforms/85xx/sleep_fsm.h

When I asked why this was in drivers/platform[1], you said it was to share 
with LS1, and that the values used were the same -- so why did you move it to 
arch/powerpc?

[1] Note that other proposed patches create a drivers/soc/fsl instead of 
drivers/platform/fsl...  We need one of them, not both.

> +void fsl_fsm_setup(void __iomem *base, struct fsm_reg_vals *val)
> +{
> +     struct fsm_reg_vals *data = val;
> +
> +     BUG_ON(!base || !data);

This BUG_ON is useless.  If one of those is NULL you'll get an oops anyway.

> diff --git a/arch/powerpc/platforms/85xx/sleep_fsm.h 
> b/arch/powerpc/platforms/85xx/sleep_fsm.h
> new file mode 100644
> index 0000000..2c60b40
> --- /dev/null
> +++ b/arch/powerpc/platforms/85xx/sleep_fsm.h
> @@ -0,0 +1,104 @@
> +/*
> + * Freescale deep sleep FSM (finite-state machine) configuration
> + *
> + * Copyright 2015 Freescale Semiconductor Inc.
> + *
> + * This program is free software; you can redistribute  it and/or modify it
> + * under  the terms of  the GNU General  Public License as published by the
> + * Free Software Foundation;  either version 2 of the  License, or (at your
> + * option) any later version.
> + */
> +#ifndef _FSL_SLEEP_FSM_H
> +#define _FSL_SLEEP_FSM_H
> +
> +#define FSL_STRIDE_4B        4
> +#define FSL_STRIDE_8B        8

Why not just use 4/8 directly?

> 
> +/* Block offsets */
> +#define RCPM_BLOCK_OFFSET    0x00022000
> +#define EPU_BLOCK_OFFSET     0x00000000
> +#define NPC_BLOCK_OFFSET     0x00001000

I thought you said OK to not putting these offsets in the kernel source...

-Scott
