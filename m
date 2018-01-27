Return-Path: <srs0=awgr=ew=us.ibm.com=linuxram@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSyJv1rBbzF0TT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 12:06:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zSyJt6xDnz8tNv
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 12:06:22 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zSyJt3KK4z9t2Q
 for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2018 12:06:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0R14siP098242
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2018 20:06:20 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2frcgumsre-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2018 20:06:19 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <linuxram@us.ibm.com>;
 Sat, 27 Jan 2018 01:06:17 -0000
Date: Fri, 26 Jan 2018 17:06:10 -0800
From: Ram Pai <linuxram@us.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH] powerpc/powernv: Provide a way to force a core into
 SMT4 mode
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180125050512.GA18744@fergus.ozlabs.ibm.com>
Message-Id: <20180127010610.GA5428@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2018 at 04:05:12PM +1100, Paul Mackerras wrote:
> POWER9 processors up to and including "Nimbus" v2.2 have hardware
> bugs relating to transactional memory and thread reconfiguration.
> One of these bugs has a workaround which is to get the core into
> SMT4 state temporarily.  This workaround is only needed when
> running bare-metal.

..snip..

> 
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> ---
>  arch/powerpc/include/asm/paca.h       |  3 ++
>  arch/powerpc/kernel/asm-offsets.c     |  1 +
>  arch/powerpc/kernel/idle_book3s.S     | 15 +++++++++
>  arch/powerpc/platforms/powernv/idle.c | 62 +++++++++++++++++++++++++++++++++++
>  4 files changed, 81 insertions(+)
> 
..snip..
>  	STOP_SPR(STOP_PID, pid);
>  	STOP_SPR(STOP_LDBAR, ldbar);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 01e1c19..4a7f88c 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -430,10 +430,23 @@ ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
>   */
>  _GLOBAL(power9_idle_stop)
>  	std	r3, PACA_REQ_PSSCR(r13)
	
this instruction can go a little later and save a few cycles, in the
case it need not have to stop ?

> +	sync
> +	lwz	r5, PACA_DONT_STOP(r13)
> +	cmpwi	r5, 0
> +	bne	1f

I mean 'std r3, ...' can move here.

>  	mtspr 	SPRN_PSSCR,r3
>  	LOAD_REG_ADDR(r4,power_enter_stop)
>  	b	pnv_powersave_common
>  	/* No return */
> +1:
> +	/*
> +	 * We get here when TM / thread reconfiguration bug workaround
> +	 * code wants to get the CPU into SMT4 mode, and therefore
> +	 * we are being asked not to stop.
> +	 */
> +	li	r3, 0
> +	std	r3, PACA_REQ_PSSCR(r13)
> +	blr		/* return 0 for wakeup cause / SRR1 value */
> 
>  /*
>   * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
> @@ -584,6 +597,8 @@ FTR_SECTION_ELSE_NESTED(71)
>  	mfspr	r5, SPRN_PSSCR
>  	rldicl  r5,r5,4,60
>  ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 71)
> +	li	r0, 0		/* clear requested_psscr to say we're awake */
> +	std	r0, PACA_REQ_PSSCR(r13)
>  	cmpd	cr4,r5,r4
>  	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
> 
> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
> index 443d5ca..72d5a85 100644
> --- a/arch/powerpc/platforms/powernv/idle.c
> +++ b/arch/powerpc/platforms/powernv/idle.c
> @@ -24,6 +24,7 @@
>  #include <asm/code-patching.h>
>  #include <asm/smp.h>
>  #include <asm/runlatch.h>
> +#include <asm/dbell.h>
> 
>  #include "powernv.h"
>  #include "subcore.h"
> @@ -387,6 +388,67 @@ void power9_idle(void)
>  	power9_idle_type(pnv_default_stop_val, pnv_default_stop_mask);
>  }
> 
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +/*
> + * This is used in working around bugs in thread reconfiguration
> + * on POWER9 (at least up to Nimbus DD2.2) relating to transactional
> + * memory and the way that XER[SO] is checkpointed.
> + * This function forces the core into SMT4 in order by asking
> + * all other threads not to stop, and sending a message to any
> + * that are in a stop state.
> + * Must be called with preemption disabled.
> + */
> +void pnv_power9_force_smt4(void)
> +{
> +	int cpu, cpu0, thr;
> +	struct paca_struct *tpaca;
> +	int awake_threads = 1;		/* this thread is awake */
> +	int poke_threads = 0;
> +
> +	cpu = smp_processor_id();
> +	cpu0 = cpu & ~(threads_per_core - 1);
> +	tpaca = &paca[cpu0];
> +	for (thr = 0; thr < threads_per_core; ++thr) {
> +		if (cpu != cpu0 + thr)
> +			atomic_inc(&tpaca[thr].dont_stop);
> +	}
> +	/* order setting dont_stop vs testing requested_psscr */
> +	mb();
> +	for (thr = 0; thr < threads_per_core; ++thr) {
> +		if (!tpaca[thr].requested_psscr)
> +			++awake_threads;
> +		else
> +			poke_threads |= (1 << thr);

			ppc_msgsnd(...)  can be called here in the else part?
	
> +	}
> +
> +	/* If at least 3 threads are awake, the core is in SMT4 already */

small nitpick --  this comment mentions SMT4 and 3 threads. But the code
is generically applicable to SMTn and (n-1) threads.

> +	if (awake_threads < threads_per_core - 1) {


> +		/* We have to wake some threads; we'll use msgsnd */
> +		for (thr = 0; thr < threads_per_core; ++thr) {
> +			if (poke_threads & (1 << thr))
> +				ppc_msgsnd(PPC_DBELL_MSGTYPE, 0,
> +					   tpaca[thr].hw_cpu_id);
> +		}

and this loop can be deleted, which inturn can leads to further optimizations.


> +		/* now spin until at least 3 threads are awake */
> +		do {
> +			for (thr = 0; thr < threads_per_core; ++thr) {
> +				if ((poke_threads & (1 << thr)) &&
> +				    !tpaca[thr].requested_psscr) {
> +					++awake_threads;
> +					poke_threads &= ~(1 << thr);
> +				}
> +			}
> +		} while (awake_threads < threads_per_core - 1);
> +	}
> +	/* clear all the dont_stop flags */
> +	for (thr = 0; thr < threads_per_core; ++thr) {
> +		if (cpu != cpu0 + thr)
> +			atomic_dec(&tpaca[thr].dont_stop);
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pnv_power9_force_smt4);
> +#endif /* CONFIG_KVM_BOOK3S_HV_POSSIBLE */
> +
>  #ifdef CONFIG_HOTPLUG_CPU
>  static void pnv_program_cpu_hotplug_lpcr(unsigned int cpu, u64 lpcr_val)
>  {
> -- 
> 2.7.4

-- 
Ram Pai
