Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id E75B8B7134
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Nov 2011 08:42:23 +1100 (EST)
Received: from mail114-am1 (localhost [127.0.0.1])	by
 mail114-am1-R.bigfish.com (Postfix) with ESMTP id ACBC5360116	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 21:42:32 +0000 (UTC)
Received: from AM1EHSMHS002.bigfish.com (unknown [10.3.201.244])	by
 mail114-am1.bigfish.com (Postfix) with ESMTP id 932B45C0043	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 21:42:32 +0000 (UTC)
Message-ID: <4EC42E35.607@freescale.com>
Date: Wed, 16 Nov 2011 15:42:13 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Zhao Chenhui <chenhui.zhao@freescale.com>
Subject: Re: [PATCH v2 3/7] powerpc/85xx: add sleep and deep sleep support
References: <1321437344-19253-1-git-send-email-chenhui.zhao@freescale.com>
 <1321437344-19253-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1321437344-19253-3-git-send-email-chenhui.zhao@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/16/2011 03:55 AM, Zhao Chenhui wrote:
> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
> index ce4f7f1..d5cc385 100644
> --- a/arch/powerpc/kernel/Makefile
> +++ b/arch/powerpc/kernel/Makefile
> @@ -63,6 +63,7 @@ obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
>  ifeq ($(CONFIG_PPC32),y)
>  obj-$(CONFIG_E500)		+= idle_e500.o
>  endif
> +obj-$(CONFIG_PPC_85xx)		+= l2cr_85xx.o

Can you restrict this to e500v1/v2?

Also, don't call it "l2cr" -- that's a 6xx register that is not present
on 85xx.

> +	.section .data
> +	.align	5
> +mpc85xx_sleep_save_area:
> +	.space	STATE_SAVE_SIZE
> +ccsrbase_low:
> +	.long	0
> +ccsrbase_high:
> +	.long	0
> +powmgtreq:
> +	.long	POWMGTCSR_DPSLP_MASK
> +
> +	.section .text
> +	.align	12
> +
> +	/*
> +	 * r3 = high word of physical address of CCSR
> +	 * r4 = low word of physical address of CCSR
> +	 */

The whole point of powmgtreq is to store a dynamically-passed-in
value... and it doesn't look like you add it in the jog patch.

-Scott
