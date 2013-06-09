Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe002.messaging.microsoft.com [207.46.163.25])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D893A2C02C8
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  9 Jun 2013 21:28:49 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Wang Dongsheng-B40534 <B40534@freescale.com>, "johannes@sipsolutions.net"
 <johannes@sipsolutions.net>, "anton@enomsg.org" <anton@enomsg.org>, Wood
 Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v2 1/2] powerpc: add Book E support to 64-bit hibernation
Date: Sun, 9 Jun 2013 11:28:41 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259F6F7BA@039-SN2MPN1-021.039d.mgd.msft.net>
References: <1370755286-29852-1-git-send-email-dongsheng.wang@freescale.com>
In-Reply-To: <1370755286-29852-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, Please ignore this patch.
This is replaced.
Replace by: http://patchwork.ozlabs.org/patch/250032/

- dongsheng

> -----Original Message-----
> From: Wang Dongsheng-B40534
> Sent: Sunday, June 09, 2013 1:21 PM
> To: johannes@sipsolutions.net; anton@enomsg.org; Wood Scott-B07421
> Cc: galak@kernel.crashing.org; linuxppc-dev@lists.ozlabs.org; Wang
> Dongsheng-B40534
> Subject: [PATCH v2 1/2] powerpc: add Book E support to 64-bit hibernation
>=20
> Update the 64-bit hibernation code to support Book E CPUs.
> Some registers and instructions are not defined for Book3e
> (SDR reg, tlbia instruction).
>=20
> SDR: Storage Description Register. Book3S and Book3E have different
> address translation mode, we do not need HTABORG & HTABSIZE to
> translate virtual address to real address.
>=20
> More registers are saved in BookE-64bit.(TCR, SPRGx, ...)
>=20
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> ---
> v2:
> * Add: _tlbil_all
> *
> * The boot core get a virtual address, when the boot process,
> * the virtual address corresponds to a physical address. After
> * hibernation resume memory snapshots, The corresponding
> * relationship between the virtual memory and physical memory
> * might change again. We need to get a new page table. So we
> * need to invalidate TLB after resume pages.
> *
> * Invalidations TLB Using tlbilx/tlbivax/MMUCSR0.
> * tlbilx used here.
> *
> * Add: save/restore PID
> *
> * We must restore PID register, because TLB will use PID. The
> * hibernation suspend flow is trapped from user space to kernel
> * space, the PID register is user thread pid.
> *
> * The hibernation resume is begin in kernel start flow, the PID
> * alway 0. After the kernel thread back to user thread, there is
> * not have context switch and the pid can not update, because the
> * kernel thread is trapped form user space. So if we did't restore
> * PID the user space of thread will be addressing in the kernel
> * space.
> *
> * There are two ways to restore PID:
> * 1/ In this file save/resotre PID register.
> * 2/ Form restore_processor_state to restore. this function will
> *    do context switch.
> *    switch_mmu_context(current->active_mm, current->active_mm)
> *
> * PPC32 Using the second method. For consistency reason, PPC64
> * using the same way.
> *
> * History:
> * Wood Scott(A): Please investigate the issue of whether we are loading
> *                kernel module code in this step
> * R: Kernel will allocate the memory for module code segment and data
> *    segment. First allocate a memory, and copy the umod to hdr members
> *    of the struct load_info. Due to the temporary assigned module
> belongs
> *    to the kernel space, so it belongs to the kernel data.
> *
> *    The kernel of all data will be saved when hibernation suspend. So
> *    the module which has already been inserted will be saved.
>=20
>  arch/powerpc/kernel/swsusp_asm64.S | 102
> ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 100 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/swsusp_asm64.S
> b/arch/powerpc/kernel/swsusp_asm64.S
> index 86ac1d9..c7e2b4a 100644
> --- a/arch/powerpc/kernel/swsusp_asm64.S
> +++ b/arch/powerpc/kernel/swsusp_asm64.S
> @@ -46,10 +46,30 @@
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
> +#define SL_PID		0x148
> +#define SL_SIZE		SL_PID+8
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
> @@ -103,8 +123,22 @@ _GLOBAL(swsusp_arch_suspend)
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
> +	SAVE_SPR(PID);
> +#endif
>=20
>  	/* we push the stack up 128 bytes but don't store the
>  	 * stack pointer on the stack like a real stackframe */
> @@ -151,6 +185,7 @@ copy_page_loop:
>  	bne+	copyloop
>  nothing_to_copy:
>=20
> +#ifdef CONFIG_PPC_BOOK3S_64
>  	/* flush caches */
>  	lis	r3, 0x10
>  	mtctr	r3
> @@ -167,6 +202,7 @@ nothing_to_copy:
>  	sync
>=20
>  	tlbia
> +#endif
>=20
>  	ld	r11,swsusp_save_area_ptr@toc(r2)
>=20
> @@ -208,16 +244,78 @@ nothing_to_copy:
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
> +	/*
> +	 * We must restore PID register, because TLB will use PID. The
> +	 * hibernation suspend flow is trapped from user space to kernel
> +	 * space, the PID register is user thread pid.
> +	 *
> +	 * The hibernation resume is begin in kernel start flow, the PID
> +	 * alway 0. After the kernel thread back to user thread, there is
> +	 * not have context switch and the pid can not update, because the
> +	 * kernel thread is trapped form user space. So if we did't restore
> +	 * PID the user space of thread will be addressing in the kernel
> +	 * space.
> +	 *
> +	 * There are two ways to restore PID:
> +	 * 1/ In this file save/resotre PID register.
> +	 * 2/ Form restore_processor_state to restore. this function will
> +	 *    do context switch.
> +	 *    switch_mmu_context(current->active_mm, current->active_mm)
> +	 *
> +	 * PPC32 Using the second method. For consistency reason, PPC64
> +	 * using the same way.
> +	 */
> +//	RESTORE_SPR(PID)
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
> +	/*
> +	 * The boot core get a virtual address, when the boot process,
> +	 * the virtual address corresponds to a physical address. After
> +	 * hibernation resume memory snapshots, The corresponding
> +	 * relationship between the virtual memory and physical memory
> +	 * might change again. We need to get a new page table. So we
> +	 * need to invalidate TLB after resume pages.
> +	 *
> +	 * Invalidations TLB Using tlbilx/tlbivax/MMUCSR0.
> +	 * tlbilx used here.
> +	 */
> +	bl	_tlbil_all
> +
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
> 1.8.0
