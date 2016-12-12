Return-Path: <npiggin@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tckJW2z7vzDvk0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Dec 2016 00:31:39 +1100 (AEDT)
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tckJV1TQHz9sdn
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Dec 2016 00:31:38 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id i88so539380pfk.2
 for <linuxppc-dev@ozlabs.org>; Mon, 12 Dec 2016 05:31:38 -0800 (PST)
Date: Mon, 12 Dec 2016 23:31:11 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>, Benjamin
 Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>
Subject: Re: [powerpc/nmi: RFC 2/2] Keep interrupts enabled even on soft
 disable
Message-ID: <20161212233111.1712ba79@roar.ozlabs.ibm.com>
In-Reply-To: <20161212095003.1885-3-bsingharora@gmail.com>
References: <20161212095003.1885-1-bsingharora@gmail.com>
 <20161212095003.1885-3-bsingharora@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 12 Dec 2016 20:50:03 +1100
Balbir Singh <bsingharora@gmail.com> wrote:

> This patch removes the disabling of interrupts
> in soft-disable mode, when interrupts are received
> (in lazy mode). The new scheme keeps the interrupts
> enabled when we receive an interrupt and does the
> following
> 
> a. On decrementer interrupt, instead of setting
> dec to maximum and returning, we do the following
>   i. Call a function handle_nmi_dec, which in
>      turn calls handle_soft_nmi
>   ii. handle_soft_nmi sets the decrementer value
>       to 1 second and checks if more than 30
>       seconds have passed since starting it. If
>       so it calls BUG_ON(1), we can do an NMI
>       panic as well.
> b. When an external interrupt is received, we
>    store the interrupt in local_paca via
>    ppc_md.get_irq(). Later when interrupts are
>    enabled and replayed, we reuse the stored
>    interrupt and process it via generic_handle_irq

This seems pretty good. My NMI handler should plug in just
the same to the masked decrementer, so that wouldn't be a
problem.

> 
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> 
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/include/asm/paca.h      |  1 +
>  arch/powerpc/kernel/exceptions-64s.S | 17 ++++++++++-------
>  arch/powerpc/kernel/irq.c            | 21 ++++++++++++++++++++-
>  arch/powerpc/kernel/time.c           | 27 ++++++++++++++++++++++++++-
>  4 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 6a6792b..091af5c 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -158,6 +158,7 @@ struct paca_struct {
>  	u8 irq_happened;		/* irq happened while soft-disabled */
>  	u8 io_sync;			/* writel() needs spin_unlock sync */
>  	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
> +	u32 irq;			/* IRQ pending */
>  	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
>  	u64 sprg_vdso;			/* Saved user-visible sprg */

Can you avoid some padding if you move it to below irq_happened?

>  #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index d39d611..2620a90 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1287,23 +1287,23 @@ EXC_VIRT_NONE(0x5800, 0x5900)
>  #define MASKED_INTERRUPT(_H)				\
>  masked_##_H##interrupt:					\
>  	std	r11,PACA_EXGEN+EX_R11(r13);		\
> +	std	r12,PACA_EXGEN+EX_R12(r13);		\
>  	lbz	r11,PACAIRQHAPPENED(r13);		\
>  	or	r11,r11,r10;				\
>  	stb	r11,PACAIRQHAPPENED(r13);		\
>  	cmpwi	r10,PACA_IRQ_DEC;			\
>  	bne	1f;					\
> -	lis	r10,0x7fff;				\
> -	ori	r10,r10,0xffff;				\
> -	mtspr	SPRN_DEC,r10;				\
> +	GET_SCRATCH0(r10);				\
> +	std	r13,PACA_EXGEN+EX_R13(r13);		\
> +	EXCEPTION_PROLOG_PSERIES_1(handle_nmi_dec, _H);	\
>  	b	2f;					\
>  1:	cmpwi	r10,PACA_IRQ_DBELL;			\
>  	beq	2f;					\
>  	cmpwi	r10,PACA_IRQ_HMI;			\
>  	beq	2f;					\
> -	mfspr	r10,SPRN_##_H##SRR1;			\
> -	rldicl	r10,r10,48,1; /* clear MSR_EE */	\
> -	rotldi	r10,r10,16;				\
> -	mtspr	SPRN_##_H##SRR1,r10;			\
> +	GET_SCRATCH0(r10);				\
> +	std	r13,PACA_EXGEN+EX_R13(r13);		\
> +	EXCEPTION_PROLOG_PSERIES_1(elevate_save_irq, _H);\
>  2:	mtcrf	0x80,r9;				\
>  	ld	r9,PACA_EXGEN+EX_R9(r13);		\
>  	ld	r10,PACA_EXGEN+EX_R10(r13);		\
> @@ -1321,6 +1321,9 @@ USE_FIXED_SECTION(virt_trampolines)
>  	MASKED_INTERRUPT()
>  	MASKED_INTERRUPT(H)
>  
> +EXC_COMMON(handle_nmi_dec, 0x900, handle_soft_nmi)
> +EXC_COMMON(elevate_save_irq, 0x500, handle_elevated_irq)

I wonder if the name should match the type of interrupt rather than
implementation detail (elevated?), and match the existing handlers
e.g, hardware_interrupt_masked common handler could call do_IRQ_masked.

As for the NMI, I would prefer just to keep it out of the timer path
completely and schedule a Linux timer for it as I had.

Otherwise, this looks nice if it does the right thing with the interrupt
controller. It hasn't taken a lot of lines to implement which is very
cool.

Thanks,
Nick
