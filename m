Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7D0012C009D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2013 08:06:20 +1000 (EST)
Date: Wed, 12 Jun 2013 17:03:48 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2] powerpc: add Book E support to 64-bit hibernation
To: Wang Dongsheng <dongsheng.wang@freescale.com>
In-Reply-To: <1370774260-31072-1-git-send-email-dongsheng.wang@freescale.com>
 (from dongsheng.wang@freescale.com on Sun Jun  9 05:37:39 2013)
Message-ID: <1371074628.18413.53@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: anton@enomsg.org, Wang Dongsheng <dongsheng.wang@freescale.com>,
 johannes@sipsolutions.net, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/09/2013 05:37:39 AM, Wang Dongsheng wrote:
>  /* these macros rely on the save area being
>   * pointed to by r11 */
> +
> +#define SAVE_SPR(register)		\
> +	mfspr	r0,SPRN_##register	;\
> +	std	r0,SL_##register(r11)
> +#define RESTORE_SPR(register)		\
> +	ld	r0,SL_##register(r11)	;\
> +	mtspr	SPRN_##register,r0
> +#define RESTORE_SPRG(n)			\
> +	ld	r0,SL_SPRG##n(r11)	;\
> +	mtsprg	n,r0
>  #define SAVE_SPECIAL(special)		\
>  	mf##special	r0		;\
>  	std	r0, SL_##special(r11)

Is there a particular SPR that you're trying to save, for which =20
SAVE_SPECIAL doesn't work?

> +#else
> +	/* Save SPRGs */
> +	RESTORE_SPRG(0)
> +	RESTORE_SPRG(1)
> +	RESTORE_SPRG(2)
> +	RESTORE_SPRG(3)
> +	RESTORE_SPRG(4)
> +	RESTORE_SPRG(5)
> +	RESTORE_SPRG(6)
> +	RESTORE_SPRG(7)

Why do we need this on book3e and not on book3s?

> +
> +	RESTORE_SPECIAL(MSR)
> +
> +	/* Restore TCR and clear any pending bits in TSR. */
> +	RESTORE_SPR(TCR)
> +	lis	r0, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
> +	mtspr	SPRN_TSR,r0

Please be internally consistent with whitespace after commas, even if =20
the rest of the file is already inconsistent. :-P

> +
> +	/* Kick decrementer */
> +	li	r0,1
> +	mtdec	r0

Why doesn't book3s need to kick the decrementer?

-Scott=
