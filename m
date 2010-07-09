Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [122.248.162.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp03.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 92215B7086
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jul 2010 18:52:29 +1000 (EST)
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
	by e28smtp03.in.ibm.com (8.14.4/8.13.1) with ESMTP id o698qNtp005831
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 14:22:23 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
	by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o698qNAJ2687026
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 14:22:23 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
	by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o698qN8F014253
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Jul 2010 14:22:23 +0530
Date: Fri, 9 Jul 2010 14:22:17 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 02/13] powerpc/book3e: Hack to get gdb moving along on
	Book3E 64-bit
Message-ID: <20100709085217.GA9668@in.ibm.com>
References: <1278656215-24705-1-git-send-email-benh@kernel.crashing.org>
	<1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1278656215-24705-2-git-send-email-benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 09, 2010 at 04:16:44PM +1000, Benjamin Herrenschmidt wrote:

Hi,
   A few questions and some trivial comments below.

> Our handling of debug interrupts on Book3E 64-bit is not quite
> the way it should be just yet. This is a workaround to let gdb
> work at least for now. We ensure that when context switching,
> we set the appropriate DBCR0 value for the new task. We also
> make sure that we turn off MSR[DE] within the kernel, and set
> it as part of the bits that get set when going back to userspace.
> 

I think I'm missing the code where MSR_DE is set before returning
to user-space? I just found one instance where MSR_USER64 (which now
includes MSR_DE) is used (in start_thread()). If not set, we'll lose the
interrupts caused in IDM too.

> In the long run, we will probably set the userspace DBCR0 on the
> exception exit code path and ensure we have some proper kernel
> value to set on the way into the kernel, a bit like ppc32 does,
> but that will take more work.

The effort to port ppc32 BookIII E debug register usage to use generic
hw-breakpoint interfaces (linuxppc-dev message-id:
20100629165152.GA8586@in.ibm.com), in its final form, should cleanup
most of this code. Even the hook switch_booke_debug_regs() in
__switch_to() should be done away.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/reg_booke.h |    4 ++--
>  arch/powerpc/kernel/process.c        |   22 ++++++++++++++++++++++
>  2 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg_booke.h b/arch/powerpc/include/asm/reg_booke.h
> index 2360317..66dc6f0 100644
> --- a/arch/powerpc/include/asm/reg_booke.h
> +++ b/arch/powerpc/include/asm/reg_booke.h
> @@ -29,8 +29,8 @@
>  #if defined(CONFIG_PPC_BOOK3E_64)
>  #define MSR_		MSR_ME | MSR_CE
>  #define MSR_KERNEL      MSR_ | MSR_CM
> -#define MSR_USER32	MSR_ | MSR_PR | MSR_EE
> -#define MSR_USER64	MSR_USER32 | MSR_CM
> +#define MSR_USER32	MSR_ | MSR_PR | MSR_EE | MSR_DE
> +#define MSR_USER64	MSR_USER32 | MSR_CM | MSR_DE

MSR_DE is included twice in MSR_USER64 (once through MSR_USER32).

>  #elif defined (CONFIG_40x)
>  #define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
>  #define MSR_USER	(MSR_KERNEL|MSR_PR|MSR_EE)
> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
> index 1e78453..551f671 100644
> --- a/arch/powerpc/kernel/process.c
> +++ b/arch/powerpc/kernel/process.c
> @@ -477,6 +477,28 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	new_thread = &new->thread;
>  	old_thread = &current->thread;
> 
> +#if defined(CONFIG_PPC_BOOK3E_64)
> +	/* XXX Current Book3E code doesn't deal with kernel side DBCR0,

You may want to use the style
	/*
	 * ......

> +	 * we always hold the user values, so we set it now.
> +	 *
> +	 * However, we ensure the kernel MSR:DE is appropriately cleared too
> +	 * to avoid spurrious single step exceptions in the kernel.
                 ^^^spurious^^^

> +	 *
> +	 * This will have to change to merge with the ppc32 code at some point,
> +	 * but I don't like much what ppc32 is doing today so there's some
> +	 * thinking needed there
> +	 */
> +	if ((new_thread->dbcr0 | old_thread->dbcr0) & DBCR0_IDM) {
> +		u32 dbcr0;

thread->dbcr0 is defined as "unsigned long" in processor.h however "u32 dbcr0"
here must be fine (given that DBCR0 uses 32-bits in ppc32 and uses only 32:63
bits in BOOKIIIE_64). Should dbcr<0-n> be made u32, given that there
will be no 64-bit long value to store (or am I missing something)?

Thanks,
K.Prasad


> +
> +		mtmsr(mfmsr() & ~MSR_DE);
> +		isync();
> +		dbcr0 = mfspr(SPRN_DBCR0);
> +		dbcr0 = (dbcr0 & DBCR0_EDM) | new_thread->dbcr0;
> +		mtspr(SPRN_DBCR0, dbcr0);
> +	}
> +#endif /* CONFIG_PPC64_BOOK3E */
> +
>  #ifdef CONFIG_PPC64
>  	/*
>  	 * Collect processor utilization data per process
> -- 
> 1.6.3.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
