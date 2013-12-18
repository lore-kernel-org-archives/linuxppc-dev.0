Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0206.outbound.protection.outlook.com [207.46.163.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8C612C00A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 14:42:48 +1100 (EST)
Message-ID: <1387338152.3140.37.camel@snotra.buserror.net>
Subject: Re: [v3][PATCH 5/8] book3e/kexec/kdump: introduce a kexec kernel flag
From: Scott Wood <scottwood@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Date: Tue, 17 Dec 2013 21:42:32 -0600
In-Reply-To: <1373357007-30785-6-git-send-email-tiejun.chen@windriver.com>
References: <1373357007-30785-1-git-send-email-tiejun.chen@windriver.com>
 <1373357007-30785-6-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-07-09 at 16:03 +0800, Tiejun Chen wrote:
> We need to introduce a flag to indicate we're already running
> a kexec kernel then we can go proper path. For example, We
> shouldn't access spin_table from the bootloader to up any secondary
> cpu for kexec kernel, and kexec kernel already know how to jump to
> generic_secondary_smp_init.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
> ---
>  arch/powerpc/include/asm/smp.h    |    1 +
>  arch/powerpc/kernel/head_64.S     |   10 ++++++++++
>  arch/powerpc/kernel/misc_64.S     |    6 ++++++
>  arch/powerpc/platforms/85xx/smp.c |   20 +++++++++++++++-----
>  4 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index ffbaabe..59165a3 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -200,6 +200,7 @@ extern void generic_secondary_thread_init(void);
>  extern unsigned long __secondary_hold_spinloop;
>  extern unsigned long __secondary_hold_acknowledge;
>  extern char __secondary_hold;
> +extern unsigned long __run_at_kexec;
>  
>  extern void __early_start(void);
>  #endif /* __ASSEMBLY__ */
> diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
> index 7dc56be..0b46c9d 100644
> --- a/arch/powerpc/kernel/head_64.S
> +++ b/arch/powerpc/kernel/head_64.S
> @@ -89,6 +89,10 @@ __secondary_hold_spinloop:
>  __secondary_hold_acknowledge:
>  	.llong	0x0
>  
> +	.globl	__run_at_kexec
> +__run_at_kexec:
> +	.llong	0x0	/* Flag for the secondary kernel from kexec. */
> +

No leading underscores please -- and why does this need to be 64-bit?

>  #ifdef CONFIG_RELOCATABLE
>  	/* This flag is set to 1 by a loader if the kernel should run
>  	 * at the loaded address instead of the linked address.  This
> @@ -417,6 +421,12 @@ _STATIC(__after_prom_start)
>  #if defined(CONFIG_PPC_BOOK3E)
>  	tovirt(r26,r26)			/* on booke, we already run at PAGE_OFFSET */
>  #endif
> +#if defined(CONFIG_KEXEC) || defined(CONFIG_CRASH_DUMP)
> +	/* If relocated we need to restore this flag on that relocated address. */
> +	ld	r7,__run_at_kexec-_stext(r26)
> +	std	r7,__run_at_kexec-_stext(r26)
> +#endif
> +
>  	lwz	r7,__run_at_load-_stext(r26)
>  #if defined(CONFIG_PPC_BOOK3E)
>  	tophys(r26,r26)			/* Restore for the remains. */
> diff --git a/arch/powerpc/kernel/misc_64.S b/arch/powerpc/kernel/misc_64.S
> index 20cbb98..c89aead 100644
> --- a/arch/powerpc/kernel/misc_64.S
> +++ b/arch/powerpc/kernel/misc_64.S
> @@ -619,6 +619,12 @@ _GLOBAL(kexec_sequence)
>  	bl	.copy_and_flush	/* (dest, src, copy limit, start offset) */
>  1:	/* assume normal blr return */
>  
> +	/* notify we're going into kexec kernel for SMP. */
> +	LOAD_REG_ADDR(r3,__run_at_kexec)
> +	li	r4,1
> +	std	r4,0(r3)
> +	sync
> +
>  	/* release other cpus to the new kernel secondary start at 0x60 */
>  	mflr	r5
>  	li	r6,1
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 5ced4f5..14d461b 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -150,6 +150,9 @@ static int smp_85xx_kick_cpu(int nr)
>  	int hw_cpu = get_hard_smp_processor_id(nr);
>  	int ioremappable;
>  	int ret = 0;
> +#ifdef CONFIG_PPC64
> +	unsigned long *ptr = NULL;
> +#endif

Looks like an unnecessary initialization.

>  
>  	WARN_ON(nr < 0 || nr >= NR_CPUS);
>  	WARN_ON(hw_cpu < 0 || hw_cpu >= NR_CPUS);
> @@ -238,11 +241,18 @@ out:
>  #else
>  	smp_generic_kick_cpu(nr);
>  
> -	flush_spin_table(spin_table);
> -	out_be32(&spin_table->pir, hw_cpu);
> -	out_be64((u64 *)(&spin_table->addr_h),
> -	  __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
> -	flush_spin_table(spin_table);
> +	ptr  = (unsigned long *)((unsigned long)&__run_at_kexec);
> +	/* We shouldn't access spin_table from the bootloader to up any
> +	 * secondary cpu for kexec kernel, and kexec kernel already
> +	 * know how to jump to generic_secondary_smp_init.
> +	 */
> +	if (!*ptr) {
> +		flush_spin_table(spin_table);
> +		out_be32(&spin_table->pir, hw_cpu);
> +		out_be64((u64 *)(&spin_table->addr_h),
> +		 __pa((u64)*((unsigned long long *)generic_secondary_smp_init)));
> +		flush_spin_table(spin_table);
> +	}
>  #endif

Please use a more descriptive name than "ptr".

How is all that different than just:

	if (!__run_at_kexec) {
		...
	}

-Scott
