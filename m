Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmR9D0JvJzDqL2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 18:37:35 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5C8Xkmd095944
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 04:37:33 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2b1qbpgjth-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Jun 2017 04:37:33 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Mon, 12 Jun 2017 02:37:31 -0600
Date: Mon, 12 Jun 2017 14:07:27 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH 01/14] powerpc/64s: idle move soft interrupt mask logic
 into C code
Reply-To: ego@linux.vnet.ibm.com
References: <20170611235835.7400-1-npiggin@gmail.com>
 <20170611235835.7400-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170611235835.7400-2-npiggin@gmail.com>
Message-Id: <20170612083727.GA10921@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

(Added Paul Mackerass to the Cc)
On Mon, Jun 12, 2017 at 09:58:22AM +1000, Nicholas Piggin wrote:
> This simplifies the asm and fixes irq-off tracing over sleep
> instructions.
> 
> Also move powersave_nap check for POWER8 into C code, and move
> PSSCR register value calculation for POWER9 into C.
>

Thanks for doing this. Only one minor comment.

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> index 98a6d07ecb5c..35cf5bb7daed 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S

[..snip..]

> @@ -109,13 +109,9 @@ core_idle_lock_held:
>  /*
>   * Pass requested state in r3:
>   *	r3 - PNV_THREAD_NAP/SLEEP/WINKLE in POWER8
> - *	   - Requested STOP state in POWER9
> + *	   - Requested PSSCR value in POWER9
>   *
> - * To check IRQ_HAPPENED in r4
> - * 	0 - don't check
> - * 	1 - check
> - *
> - * Address to 'rfid' to in r5
> + * Address of idle handler to 'rfid' to in r4
>   */
>  pnv_powersave_common:
>  	/* Use r3 to pass state nap/sleep/winkle */
> @@ -131,30 +127,7 @@ pnv_powersave_common:
>  	std	r0,_LINK(r1)
>  	std	r0,_NIP(r1)
> 
> -	/* Hard disable interrupts */
> -	mfmsr	r9
> -	rldicl	r9,r9,48,1
> -	rotldi	r9,r9,16
> -	mtmsrd	r9,1			/* hard-disable interrupts */
> -
> -	/* Check if something happened while soft-disabled */
> -	lbz	r0,PACAIRQHAPPENED(r13)
> -	andi.	r0,r0,~PACA_IRQ_HARD_DIS@l
> -	beq	1f
> -	cmpwi	cr0,r4,0

There were callers to power7_nap() in the dynamic-core-split/unsplit
which wanted nap to be forced irrespective of whether an irq was
pending or not. With this new patch, there won't be a way to enforce
that on POWER8.

> -	beq	1f
> -	addi	r1,r1,INT_FRAME_SIZE
> -	ld	r0,16(r1)
> -	li	r3,0			/* Return 0 (no nap) */
> -	mtlr	r0
> -	blr
> -

[..snip..]

> diff --git a/arch/powerpc/platforms/powernv/subcore.c b/arch/powerpc/platforms/powernv/subcore.c
> index 0babef11136f..d975d78188a9 100644
> --- a/arch/powerpc/platforms/powernv/subcore.c
> +++ b/arch/powerpc/platforms/powernv/subcore.c
> @@ -18,6 +18,7 @@
>  #include <linux/stop_machine.h>
> 
>  #include <asm/cputhreads.h>
> +#include <asm/cpuidle.h>
>  #include <asm/kvm_ppc.h>
>  #include <asm/machdep.h>
>  #include <asm/opal.h>
> @@ -182,7 +183,7 @@ static void unsplit_core(void)
>  	cpu = smp_processor_id();
>  	if (cpu_thread_in_core(cpu) != 0) {
>  		while (mfspr(SPRN_HID0) & mask)
> -			power7_nap(0);
> +			power7_idle_insn(PNV_THREAD_NAP);

This is the place where we are unsplitting the core after exiting the
guest and returning to the host. This required us to execute the nap
instruction. With the new patch, will just loop inside this loop
without executing nap. Paul, will this be an issue ?

> 
>  		per_cpu(split_state, cpu).step = SYNC_STEP_UNSPLIT;
>  		return;
> diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
> index 45eaf06462ae..79152676f62b 100644
> --- a/drivers/cpuidle/cpuidle-powernv.c
> +++ b/drivers/cpuidle/cpuidle-powernv.c
> @@ -73,9 +73,8 @@ static int nap_loop(struct cpuidle_device *dev,
>  			struct cpuidle_driver *drv,
>  			int index)
>  {
> -	ppc64_runlatch_off();
> -	power7_idle();
> -	ppc64_runlatch_on();
> +	power7_idle_type(PNV_THREAD_NAP);
> +
>  	return index;
>  }
> 
> @@ -98,7 +97,8 @@ static int fastsleep_loop(struct cpuidle_device *dev,
>  	new_lpcr &= ~LPCR_PECE1;
> 
>  	mtspr(SPRN_LPCR, new_lpcr);
> -	power7_sleep();
> +
> +	power7_idle_type(PNV_THREAD_SLEEP);
> 
>  	mtspr(SPRN_LPCR, old_lpcr);
> 
> @@ -110,10 +110,8 @@ static int stop_loop(struct cpuidle_device *dev,
>  		     struct cpuidle_driver *drv,
>  		     int index)
>  {
> -	ppc64_runlatch_off();
> -	power9_idle_stop(stop_psscr_table[index].val,
> +	power9_idle_type(stop_psscr_table[index].val,
>  			 stop_psscr_table[index].mask);
> -	ppc64_runlatch_on();
>  	return index;
>  }
> 
> -- 
> 2.11.0
> 

--
Thanks and Regards
gautham.
