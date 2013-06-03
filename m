Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F129A2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Jun 2013 09:58:43 +1000 (EST)
Received: from mail52-db8 (localhost [127.0.0.1])	by mail52-db8-R.bigfish.com
 (Postfix) with ESMTP id 7C4037800A3	for
 <linuxppc-dev@lists.ozlabs.org>; Mon, 3 Jun 2013 23:58:30 +0000 (UTC)
Received: from DB8EHSMHS010.bigfish.com (unknown [10.174.8.242])	by
 mail52-db8.bigfish.com (Postfix) with ESMTP id B4B5E7C004E	for
 <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Jun 2013 23:58:27 +0000 (UTC)
Date: Mon, 3 Jun 2013 18:58:24 -0500
From: Scott Wood <scottwood@freescale.com>
To: chenhui zhao <chenhui.zhao@freescale.com>
Subject: Re: [1/4] powerpc/85xx: Add a head file for cpu type detection
Message-ID: <20130603235824.GA27557@home.buserror.net>
References: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1331025056-15983-1-git-send-email-chenhui.zhao@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 05, 2012 at 11:10:53PM -0000, chenhui zhao wrote:
> From: chenhui zhao <chenhui.zhao@freescale.com>
> 
> The workarounds need to detect the cpu type. Add these macros
> and inline routines to help cpu type detection in runtime.
> 
> Signed-off-by: Zhao Chenhui <chenhui.zhao@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>
> 
> ---
> arch/powerpc/include/asm/mpc85xx.h |   72 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 72 insertions(+), 0 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/mpc85xx.h
> 
> diff --git a/arch/powerpc/include/asm/mpc85xx.h b/arch/powerpc/include/asm/mpc85xx.h
> new file mode 100644
> index 0000000..451777c
> --- /dev/null
> +++ b/arch/powerpc/include/asm/mpc85xx.h
> @@ -0,0 +1,72 @@
> +/*
> + * MPC85xx cpu type detection
> + *
> + * Copyright 2011-2012 Freescale Semiconductor, Inc.
> + *
> + * This is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef __ASM_PPC_CPU_H
> +#define __ASM_PPC_CPU_H

s/CPU/MPC85xx/

> +#define SVR_REV(svr)	((svr) & 0xFF)		/* SOC design resision */

Please update U-Boot's definition, so that shared code doesn't run into
problems.

> +#define SVR_MAJ(svr)	(((svr) >>  4) & 0xF)	/* Major revision field*/
> +#define SVR_MIN(svr)	(((svr) >>  0) & 0xF)	/* Minor revision field*/
> +
> +/* Some parts define SVR[0:23] as the SOC version */
> +#define SVR_SOC_VER(svr) (((svr) >> 8) & 0xFFFFFF)	/* SOC Version fields */
> +
> +#define IS_SVR_REV(svr, maj, min) \
> +	((SVR_MAJ(svr) == (maj)) && (SVR_MIN(svr) == (min)))
> +
> +#define SVR_8533	0x803400
> +#define SVR_8533_E	0x803C00
> +#define SVR_8535	0x803701
> +#define SVR_8535_E	0x803F01
> +#define SVR_8536	0x803700
> +#define SVR_8536_E	0x803F00
> +#define SVR_8540	0x803000
> +#define SVR_8541	0x807200
> +#define SVR_8541_E	0x807A00
> +#define SVR_8543	0x803200
> +#define SVR_8543_E	0x803A00

Can we separate out E as an orthogonal bit, as we now do in U-Boot?

> +#define SVR_8544	0x803401
> +#define SVR_8544_E	0x803C01
> +#define SVR_8545	0x803102
> +#define SVR_8545_E	0x803902
> +#define SVR_8547_E	0x803901
> +#define SVR_8548	0x803100
> +#define SVR_8548_E	0x803900
> +#define SVR_8555	0x807100
> +#define SVR_8555_E	0x807900
> +#define SVR_8560	0x807000
> +#define SVR_8567	0x807501
> +#define SVR_8567_E	0x807D01
> +#define SVR_8568	0x807500
> +#define SVR_8568_E	0x807D00
> +#define SVR_8569	0x808000
> +#define SVR_8569_E	0x808800
> +#define SVR_8572	0x80E000
> +#define SVR_8572_E	0x80E800
> +
> +
> +static inline int fsl_svr_is(u32 svr)
> +{
> +	u32 id = SVR_SOC_VER(mfspr(SPRN_SVR));
> +
> +	return (id == svr);
> +}

fsl_svr_is() and IS_SVR_REV() are confusingly similar, and the
upper/lower difference and word-order difference is jarring.  I'm not
sure why you even need fsl_svr_is.  This file is obviously patterned
after U-Boot code, but U-Boot doesn't have this.  Why can't the caller do
the equality check?

> +/* Return true if current SOC revision is prior to (maj, min)  */
> +static inline int fsl_svr_older_than(u8 maj, u8 min)
> +{
> +	u32 rev = SVR_REV(mfspr(SPRN_SVR));
> +	u32 cmp = (maj << 4) | min;
> +
> +	return (rev < cmp);
> +}

Is this that much easier than the caller doing:

	if (SVR_REV(svr) < 0x20)

?

-Scott
 
