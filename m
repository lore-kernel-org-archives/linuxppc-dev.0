Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 80C892C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Feb 2013 00:52:44 +1100 (EST)
Subject: Re: [PATCH 06/17] powerpc: Add transactional memory paca scratch
 register to show_regs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1360729895-304-7-git-send-email-mikey@neuling.org>
Date: Wed, 13 Feb 2013 07:52:35 -0600
Message-Id: <7B4CE428-128F-43FC-9ABE-CE3728B3CF93@kernel.crashing.org>
References: <1360729895-304-1-git-send-email-mikey@neuling.org>
 <1360729895-304-7-git-send-email-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org, Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 12, 2013, at 10:31 PM, Michael Neuling wrote:

> Add transactional memory paca scratch register to show_regs.  This is =
useful
> for debugging.
>=20
> Signed-off-by: Matt Evans <matt@ozlabs.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> ---
> arch/powerpc/include/asm/paca.h   |    1 +
> arch/powerpc/kernel/asm-offsets.c |    1 +
> arch/powerpc/kernel/entry_64.S    |    4 ++++
> arch/powerpc/kernel/process.c     |    3 +++
> 4 files changed, 9 insertions(+)
>=20
> diff --git a/arch/powerpc/include/asm/paca.h =
b/arch/powerpc/include/asm/paca.h
> index c47d687..07e9851 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -137,6 +137,7 @@ struct paca_struct {
> 	u8 irq_work_pending;		/* IRQ_WORK interrupt while =
soft-disable */
> 	u8 nap_state_lost;		/* NV GPR values lost in =
power7_idle */
> 	u64 sprg3;			/* Saved user-visible sprg */

#ifdef CONFIG_PPC_TRANSACTIONAL_MEM

> +	u64 tm_scratch;                 /* TM scratch area for reclaim =
*/

#endif

>=20
> #ifdef CONFIG_PPC_POWERNV
> 	/* Pointer to OPAL machine check event structure set by the
> diff --git a/arch/powerpc/kernel/asm-offsets.c =
b/arch/powerpc/kernel/asm-offsets.c
> index b67e4c3..f9654b6 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -126,6 +126,7 @@ int main(void)
> 	DEFINE(THREAD_TAR, offsetof(struct thread_struct, tar));
> #endif
> #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	DEFINE(PACATMSCRATCH, offsetof(struct paca_struct, tm_scratch));
> 	DEFINE(THREAD_TM_TFHAR, offsetof(struct thread_struct, =
tm_tfhar));
> 	DEFINE(THREAD_TM_TEXASR, offsetof(struct thread_struct, =
tm_texasr));
> 	DEFINE(THREAD_TM_TFIAR, offsetof(struct thread_struct, =
tm_tfiar));
> diff --git a/arch/powerpc/kernel/entry_64.S =
b/arch/powerpc/kernel/entry_64.S
> index 9ae8451..612ea13 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -785,6 +785,10 @@ fast_exception_return:
> 	andc	r4,r4,r0	 /* r0 contains MSR_RI here */
> 	mtmsrd	r4,1
>=20
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	/* TM debug */
> +	std	r3, PACATMSCRATCH(r13) /* Stash returned-to MSR */
> +#endif
> 	/*
> 	 * r13 is our per cpu area, only restore it if we are returning =
to
> 	 * userspace the value stored in the stack frame may belong to
> diff --git a/arch/powerpc/kernel/process.c =
b/arch/powerpc/kernel/process.c
> index b0a0321..1cc4053 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -754,6 +754,9 @@ void show_regs(struct pt_regs * regs)
> 	printk("NIP ["REG"] %pS\n", regs->nip, (void *)regs->nip);
> 	printk("LR ["REG"] %pS\n", regs->link, (void *)regs->link);
> #endif
> +#ifdef CONFIG_PPC_TRANSACTIONAL_MEM
> +	printk("PACATMSCRATCH [%llx]\n", get_paca()->tm_scratch);
> +#endif
> 	show_stack(current, (unsigned long *) regs->gpr[1]);
> 	if (!user_mode(regs))
> 		show_instructions(regs);
> --=20
> 1.7.10.4
>=20
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
