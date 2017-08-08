Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRW6X5v4BzDqpB
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 20:36:52 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v78Aaee5141079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 06:36:50 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c7ak3kund-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 06:36:50 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 06:36:48 -0400
Date: Tue, 8 Aug 2017 16:06:43 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@ozlabs.org>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 10/13] powerpc/64s: idle simplify KVM idle on POWER9
Reply-To: ego@linux.vnet.ibm.com
References: <20170805170241.22966-1-npiggin@gmail.com>
 <20170805170241.22966-11-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170805170241.22966-11-npiggin@gmail.com>
Message-Id: <20170808103643.GA9107@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nicholas,

On Sun, Aug 06, 2017 at 03:02:38AM +1000, Nicholas Piggin wrote:
> POWER9 CPUs have independent MMU contexts per thread so KVM
> does not have to bring sibling threads into real-mode when
> switching MMU mode to guest. This can simplify POWER9 sleep/wake
> paths and avoids hwsyncs.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_asm.h |  4 ++++
>  arch/powerpc/kernel/idle_book3s.S         |  8 ++-----
>  arch/powerpc/kvm/book3s_hv.c              | 37 ++++++++++++++++++++++++++-----
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  8 +++++++
>  4 files changed, 46 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
> index 7cea76f11c26..83596f32f50b 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_asm.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
> @@ -104,6 +104,10 @@ struct kvmppc_host_state {
>  	u8 napping;
> 
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/*
> +	 * hwthread_req/hwthread_state pair is used to pull sibling threads
> +	 * out of guest on pre-ISAv3.0B CPUs where threads share MMU.
> +	 */
>  	u8 hwthread_req;
>  	u8 hwthread_state;
>  	u8 host_ipi;
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index e6252c5a57a4..3ab73f9223e4 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -243,12 +243,6 @@ enter_winkle:
>   * r3 - PSSCR value corresponding to the requested stop state.
>   */
>  power_enter_stop:
> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> -	/* Tell KVM we're entering idle */
> -	li	r4,KVM_HWTHREAD_IN_IDLE
> -	/* DO THIS IN REAL MODE!  See comment above. */
> -	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> -#endif
>  /*
>   * Check if we are executing the lite variant with ESL=EC=0
>   */
> @@ -435,6 +429,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  	mr	r3,r12
> 
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +BEGIN_FTR_SECTION
>  	li	r0,KVM_HWTHREAD_IN_KERNEL
>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
>  	/* Order setting hwthread_state vs. testing hwthread_req */
> @@ -444,6 +439,7 @@ ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  	beq	1f
>  	b	kvm_start_guest
>  1:
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)

This would be 7 nops on power9. Should we move this to a different
function and do a bl to that?


>  #endif
> 
>  	/* Return SRR1 from power7_nap() */
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 359c79cdf0cc..bb1ab14f963a 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -2111,6 +2111,16 @@ static int kvmppc_grab_hwthread(int cpu)
>  	struct paca_struct *tpaca;
>  	long timeout = 10000;
> 
> +	/*
> +	 * ISA v3.0 idle routines do not set hwthread_state or test
> +	 * hwthread_req, so they can not grab idle threads.
> +	 */
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		WARN_ON(1);
> +		pr_err("KVM: can not control sibling threads\n");
> +		return -EBUSY;
> +	}
> +
>  	tpaca = &paca[cpu];
> 
>  	/* Ensure the thread won't go into the kernel if it wakes */
> @@ -2145,12 +2155,26 @@ static void kvmppc_release_hwthread(int cpu)
>  	struct paca_struct *tpaca;
> 
>  	tpaca = &paca[cpu];
> -	tpaca->kvm_hstate.hwthread_req = 0;
>  	tpaca->kvm_hstate.kvm_vcpu = NULL;
>  	tpaca->kvm_hstate.kvm_vcore = NULL;
>  	tpaca->kvm_hstate.kvm_split_mode = NULL;
>  }
> 
> +static void kvmppc_release_hwthread_secondary(int cpu)
> +{
> +	struct paca_struct *tpaca;
> +
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		WARN_ON(1);
> +		return;
> +	}
> +
> +	tpaca = &paca[cpu];
> +	tpaca->kvm_hstate.hwthread_req = 0;
> +	kvmppc_release_hwthread(cpu);
> +}
> +
> +

Extra blank line not needed.

>  static void radix_flush_cpu(struct kvm *kvm, int cpu, struct kvm_vcpu *vcpu)
>  {
>  	int i;
> @@ -2274,7 +2298,7 @@ static int on_primary_thread(void)
>  		if (kvmppc_grab_hwthread(cpu + thr)) {
>  			/* Couldn't grab one; let the others go */
>  			do {
> -				kvmppc_release_hwthread(cpu + thr);
> +				kvmppc_release_hwthread_secondary(cpu + thr);
>  			} while (--thr > 0);
>  			return 0;
>  		}
> @@ -2702,8 +2726,9 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
>  			kvmppc_vcore_preempt(pvc);
>  			spin_unlock(&pvc->lock);
>  		}
> -		for (i = 0; i < controlled_threads; ++i)
> -			kvmppc_release_hwthread(pcpu + i);
> +		for (i = 1; i < controlled_threads; ++i)
> +			kvmppc_release_hwthread_secondary(pcpu + i);
> +		kvmppc_release_hwthread(pcpu);
>  		return;
>  	}
> 
> @@ -2858,11 +2883,13 @@ static noinline void kvmppc_run_core(struct kvmppc_vcore *vc)
> 
>  	/* Let secondaries go back to the offline loop */
>  	for (i = 0; i < controlled_threads; ++i) {
> -		kvmppc_release_hwthread(pcpu + i);
>  		if (sip && sip->napped[i])
>  			kvmppc_ipi_thread(pcpu + i);
>  		cpumask_clear_cpu(pcpu + i, &vc->kvm->arch.cpu_in_guest);
>  	}

We are sending an IPI to the thread that has exited the guest and is
currently napping. The IPI wakes it up so that it can executes
offline loop. But we haven't released the hwthread yet, which means
that hwthread_req for this thread is still set.

The thread wakes up from nap, executes the pnv_powersave_wakeup code
where it can enter kvm_start_guest. Is this a legitimate race or am I
missing something?

> +	for (i = 1; i < controlled_threads; ++i)
> +		kvmppc_release_hwthread_secondary(pcpu + i);
> +	kvmppc_release_hwthread(pcpu);
> 
>  	spin_unlock(&vc->lock);
> 
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index c52184a8efdf..3e024fd71fe8 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -149,9 +149,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	subf	r4, r4, r3
>  	mtspr	SPRN_DEC, r4
> 
> +BEGIN_FTR_SECTION
>  	/* hwthread_req may have got set by cede or no vcpu, so clear it */
>  	li	r0, 0
>  	stb	r0, HSTATE_HWTHREAD_REQ(r13)
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
> 
>  	/*
>  	 * For external interrupts we need to call the Linux
> @@ -314,6 +316,7 @@ kvm_novcpu_exit:
>   * Relocation is off and most register values are lost.
>   * r13 points to the PACA.
>   * r3 contains the SRR1 wakeup value, SRR1 is trashed.
> + * This is not used by ISAv3.0B processors.
>   */
>  	.globl	kvm_start_guest
>  kvm_start_guest:
> @@ -432,6 +435,9 @@ kvm_secondary_got_guest:
>   * While waiting we also need to check if we get given a vcpu to run.
>   */
>  kvm_no_guest:
> +BEGIN_FTR_SECTION
> +	twi	31,0,0
> +END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)


>  	lbz	r3, HSTATE_HWTHREAD_REQ(r13)
>  	cmpwi	r3, 0
>  	bne	53f
> @@ -2509,8 +2515,10 @@ kvm_do_nap:
>  	clrrdi	r0, r0, 1
>  	mtspr	SPRN_CTRLT, r0
> 
> +BEGIN_FTR_SECTION
>  	li	r0,1
>  	stb	r0,HSTATE_HWTHREAD_REQ(r13)
> +END_FTR_SECTION_IFCLR(CPU_FTR_ARCH_300)
>  	mfspr	r5,SPRN_LPCR
>  	ori	r5,r5,LPCR_PECE0 | LPCR_PECE1
>  BEGIN_FTR_SECTION
> -- 
> 2.11.0
> 
