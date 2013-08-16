Return-Path: <maddy@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA6F32C021C
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:59:07 +1000 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Fri, 16 Aug 2013 18:48:52 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 39B892BB0051
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:59:04 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r7G8hCI954722630
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:43:12 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r7G8x3Jl012212
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Aug 2013 18:59:03 +1000
Message-ID: <520DE9D4.5050402@linux.vnet.ibm.com>
Date: Fri, 16 Aug 2013 14:29:00 +0530
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 02/10] powerpc/book3s: Introduce exclusive emergency
 stack for machine check exception.
References: <20130816080213.680.50794.stgit@mars.in.ibm.com>
 <20130816080410.680.46919.stgit@mars.in.ibm.com>
In-Reply-To: <20130816080410.680.46919.stgit@mars.in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jeremy.kerr@au1.ibm.com>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Friday 16 August 2013 01:34 PM, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> This patch introduces exclusive emergency stack for machine check exception.
> We use emergency stack to handle machine check exception so that we can save
> MCE information (srr1, srr0, dar and dsisr) before turning on ME bit and be
> ready for re-entrancy. This helps us to prevent clobbering of MCE information
> in case of nested machine checks.
> 
> The reason for using emergency stack over normal kernel stack is that the
> machine check might occur in the middle of setting up a stack frame which may
> result into improper use of kernel stack.
> 
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/paca.h |    9 +++++++++
>  arch/powerpc/kernel/setup_64.c  |    8 +++++++-
>  arch/powerpc/xmon/xmon.c        |    2 ++
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 77c91e7..b4ca4e9 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -147,6 +147,15 @@ struct paca_struct {
>  	 */
>  	struct opal_machine_check_event *opal_mc_evt;
>  #endif
> +#ifdef CONFIG_PPC_BOOK3S_64
> +	/* Exclusive emergency stack pointer for machine check exception. */
> +	void *mc_emergency_sp;
> +	/*
> +	 * Flag to check whether we are in machine check early handler
> +	 * and already using emergency stack.
> +	 */
> +	u16 in_mce;
> +#endif
> 
>  	/* Stuff for accurate time accounting */
>  	u64 user_time;			/* accumulated usermode TB ticks */
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index 389fb807..3fdbdb0 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -529,7 +529,8 @@ static void __init exc_lvl_early_init(void)
> 
>  /*
>   * Stack space used when we detect a bad kernel stack pointer, and
> - * early in SMP boots before relocation is enabled.
> + * early in SMP boots before relocation is enabled. Exclusive emergency
> + * stack for machine checks.
>   */
>  static void __init emergency_stack_init(void)
>  {
> @@ -552,6 +553,11 @@ static void __init emergency_stack_init(void)
>  		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
>  		sp += THREAD_SIZE;
>  		paca[i].emergency_sp = __va(sp);
> +
> +		/* emergency stack for machine check exception handling. */
> +		sp  = memblock_alloc_base(THREAD_SIZE, THREAD_SIZE, limit);
> +		sp += THREAD_SIZE;
> +		paca[i].mc_emergency_sp = __va(sp);
>  	}
>  }
> 
Just a concern, kindly ignore it if it is irrelevant.
you have defined mc_emergency_sp under CONFIG_PPC_BOOK3S_64, but
assigning memory in a common code. This may break build for other
configs such as like ppc64e_defconfig.

> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
> index 96bf5bd..147a5e98 100644
> --- a/arch/powerpc/xmon/xmon.c
> +++ b/arch/powerpc/xmon/xmon.c
> @@ -2044,6 +2044,8 @@ static void dump_one_paca(int cpu)
>  	DUMP(p, stab_addr, "lx");
>  #endif
>  	DUMP(p, emergency_sp, "p");
> +	DUMP(p, mc_emergency_sp, "p");
> +	DUMP(p, in_mce, "x");
>  	DUMP(p, data_offset, "lx");
>  	DUMP(p, hw_cpu_id, "x");
>  	DUMP(p, cpu_start, "x");
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
