Return-Path: <B40534@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 411F92C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2013 18:36:29 +1100 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [RFC][PATCH] powerpc: add Book E support to 64-bit hibernation
Date: Fri, 22 Feb 2013 07:35:18 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259E728F2@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1360203915-22112-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1360203915-22112-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Benjamin & Johannes,

Any thoughts about this patch?

> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Thursday, February 07, 2013 10:25 AM
> To: linuxppc-dev@lists.ozlabs.org
> Cc: Wood Scott-B07421; Li Yang-R58472; Zhao Chenhui-B35336; Wang
> Dongsheng-B40534
> Subject: [RFC][PATCH] powerpc: add Book E support to 64-bit hibernation
>=20
> Update the 64-bit hibernation code to support Book E CPUs.
> Some registers and instructions are not defined for Book3e
> (SDR reg, tlbia instruction).
> SDR: Storage Description Register. Book3S and Book3E have different
> address translation mode, we do not need HTABORG & HTABSIZE to
> translate virtual address to real address.
> More registers are saved in BookE-64bit.(TCR, SPRGx)
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
>=20
> Hopefully someone can give me some advice about cache flush. It
> confused me that why only 1 MiB is flushed from KERNEL_START on
> Book3S. Is there a need to flush L2 cache if I have already flushed
> L1 cache? If yes, how about L3 cache? Cache levels are different
> in cores, the instruction sets may also be different.
>=20
>  1 files changed, 62 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/swsusp_asm64.S
> b/arch/powerpc/kernel/swsusp_asm64.S
> index 86ac1d9..608e4ceb 100644
> --- a/arch/powerpc/kernel/swsusp_asm64.S
> +++ b/arch/powerpc/kernel/swsusp_asm64.S
> @@ -46,10 +46,29 @@
>  #define SL_r29		0xe8
>  #define SL_r30		0xf0
>  #define SL_r31		0xf8
> -#define SL_SIZE		SL_r31+8
> +#define SL_SPRG0	0x100
> +#define SL_SPRG1	0x108
> +#define SL_SPRG2	0x110
> +#define SL_SPRG3	0x118
> +#define SL_SPRG4	0x120
> +#define SL_SPRG5	0x128
> +#define SL_SPRG6	0x130
> +#define SL_SPRG7	0x138
> +#define SL_TCR		0x140
> +#define SL_SIZE		SL_TCR+8
>=20
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
> @@ -103,8 +122,21 @@ _GLOBAL(swsusp_arch_suspend)
>  	SAVE_REGISTER(r30)
>  	SAVE_REGISTER(r31)
>  	SAVE_SPECIAL(MSR)
> -	SAVE_SPECIAL(SDR1)
>  	SAVE_SPECIAL(XER)
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	SAVE_SPECIAL(SDR1)
> +#else
> +	SAVE_SPR(TCR)
> +	/* Save SPRGs */
> +	SAVE_SPR(SPRG0)
> +	SAVE_SPR(SPRG1)
> +	SAVE_SPR(SPRG2)
> +	SAVE_SPR(SPRG3)
> +	SAVE_SPR(SPRG4)
> +	SAVE_SPR(SPRG5)
> +	SAVE_SPR(SPRG6)
> +	SAVE_SPR(SPRG7)
> +#endif
>=20
>  	/* we push the stack up 128 bytes but don't store the
>  	 * stack pointer on the stack like a real stackframe */
> @@ -151,6 +183,7 @@ copy_page_loop:
>  	bne+	copyloop
>  nothing_to_copy:
>=20
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	/* flush caches */
>  	lis	r3, 0x10
>  	mtctr	r3
> @@ -167,6 +200,7 @@ nothing_to_copy:
>  	sync
>=20
>  	tlbia
> +#endif
>=20
>  	ld	r11,swsusp_save_area_ptr@toc(r2)
>=20
> @@ -208,16 +242,42 @@ nothing_to_copy:
>  	RESTORE_REGISTER(r29)
>  	RESTORE_REGISTER(r30)
>  	RESTORE_REGISTER(r31)
> +
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	/* can't use RESTORE_SPECIAL(MSR) */
>  	ld	r0, SL_MSR(r11)
>  	mtmsrd	r0, 0
>  	RESTORE_SPECIAL(SDR1)
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
> +
> +	RESTORE_SPECIAL(MSR)
> +
> +	/* Restore TCR and clear any pending bits in TSR. */
> +	RESTORE_SPR(TCR)
> +	lis	r0, (TSR_ENW | TSR_WIS | TSR_DIS | TSR_FIS)@h
> +	mtspr	SPRN_TSR,r0
> +
> +	/* Kick decrementer */
> +	li	r0,1
> +	mtdec	r0
> +#endif
>  	RESTORE_SPECIAL(XER)
>=20
>  	sync
>=20
>  	addi	r1,r1,-128
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	bl	slb_flush_and_rebolt
> +#endif
>  	bl	do_after_copyback
>  	addi	r1,r1,128
>=20
> --
> 1.7.5.1
