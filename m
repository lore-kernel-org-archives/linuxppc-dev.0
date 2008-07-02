Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFDE1DE097
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 03:06:17 +1000 (EST)
Message-Id: <7B906E0F-3149-43F0-815A-8314BF5BA039@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080625215051.GA11784@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 1/3] mpc83xx: Power Management support
Date: Wed, 2 Jul 2008 12:06:02 -0500
References: <20080625215051.GA11784@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/arch/powerpc/platforms/83xx/suspend-asm.S b/arch/ 
> powerpc/platforms/83xx/suspend-asm.S
> new file mode 100644
> index 0000000..03e29a2
> --- /dev/null
> +++ b/arch/powerpc/platforms/83xx/suspend-asm.S
> @@ -0,0 +1,539 @@
> +/*
> + * Enter and leave sleep state on MPC83xx
> + *
> + * Author: Scott Wood <scottwood@freescale.com>
> + *
> + * Copyright (c) 2006 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or  
> modify it
> + * under the terms of the GNU General Public License version 2 as  
> published
> + * by the Free Software Foundation.
> + */
> +
> +#include <asm/page.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/reg.h>
> +#include <asm/asm-offsets.h>
> +
> +#define SS_MEMSAVE	0x00

What is this? add a comment?

> +#define SS_HID		0x08 /* 3 HIDs */
> +#define SS_IABR		0x14 /* 2 IABRs */
> +#define SS_IBCR		0x1c
> +#define SS_DABR		0x20 /* 2 DABRs */
> +#define SS_DBCR		0x28
> +#define SS_SP		0x2c
> +#define SS_SR		0x30 /* 16 segment registers */
> +#define SS_CURRENT	0x70

How about SS_R2 to match the pmac sleep.S code.  It will make  
refactoring all this easier in the future.

> +#define SS_MSR		0x74
> +#define SS_SDR1		0x78
> +#define SS_LR		0x7c
> +#define SS_SPRG		0x80 /* 4 SPRGs */
> +#define SS_DBAT		0x90 /* 8 DBATs */
> +#define SS_IBAT		0xd0 /* 8 IBATs */
> +#define SS_TB		0x110
> +#define SS_CR		0x118
> +#define SS_GPREG	0x11c /* r12-r31 */
> +#define STATE_SAVE_SIZE 0x16c

- k
