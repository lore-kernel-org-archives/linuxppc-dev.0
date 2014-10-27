Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 07E931A0030
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 17:07:55 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 02:07:53 -0400
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 60CE738C8041
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:07:51 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R67p933539368
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 06:07:51 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R67ovr030355
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:07:50 -0400
Message-ID: <544DE129.6010104@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 11:37:37 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 07/11] powerpc: kvm: the stopper func to cease secondary
 hwthread
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-8-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-8-git-send-email-kernelfans@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: Paul Mackerras <paulus@samba.org>, Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2014 12:59 AM, kernelfans@gmail.com wrote:
> To enter guest, primary hwtherad schedules the stopper func on
> secondary threads and force them into NAP mode.
> When exit to host,secondary threads hardcode to restore the stack,
> then switch back to the stopper func, i.e host.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kvm/book3s_hv.c            | 15 +++++++++++++++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 34 +++++++++++++++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index ba258c8..4348abd 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1486,6 +1486,21 @@ static void kvmppc_remove_runnable(struct kvmppc_vcore *vc,
>  	list_del(&vcpu->arch.run_list);
>  }
>  
> +#ifdef KVMPPC_ENABLE_SECONDARY
> +
> +extern void kvmppc_secondary_stopper_enter();
> +
> +static int kvmppc_secondary_stopper(void *data)
> +{
> +	int cpu =smp_processor_id();
> +	struct paca_struct *lpaca = get_paca();
> +	BUG_ON(!(cpu%thread_per_core));
> +
> +	kvmppc_secondary_stopper_enter();
> +}
> +
> +#endif
> +
>  static int kvmppc_grab_hwthread(int cpu)
>  {
>  	struct paca_struct *tpaca;
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index d5594b0..254038b 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -349,7 +349,41 @@ kvm_do_nap:
>  
>  #ifdef PPCKVM_ENABLE_SECONDARY
>  kvm_secondary_exit_trampoline:
> +
> +	/* all register is free to use, later kvmppc_secondary_stopper_exit set up them*/
> +	//loop-wait for the primary to signal that host env is ready
> +
> +	LOAD_REG_ADDR(r5, kvmppc_secondary_stopper_exit)
> +	/* fixme, load msr from lpaca stack */
> +	li	r6, MSR_IR | MSR_DR
> +	mtsrr0	r5
> +	mtsrr1	r6
> +	RFI
> +
> +_GLOBAL_TOC(kvmppc_secondary_stopper_enter)
> +	mflr	r0
> +	std	r0, PPC_LR_STKOFF(r1)
> +	stdu	r1, -112(r1)
> +
> +	/* fixme: store other register such as msr */
> +
> +	/* prevent us to enter kernel */
> +	li	r0, 1
> +	stb	r0, HSTATE_HWTHREAD_REQ(r13)
> +	/* tell the primary that we are ready */
> +        li      r0,KVM_HWTHREAD_IN_KERNEL
> +        stb     r0,HSTATE_HWTHREAD_STATE(r13)
> +	nap
>  	b	.

I see a fundamental issues with this design. Note that the secondaries
are still capable of getting IPIs, timer interrupts and scheduler
interrupts in nap. Scheduling ticks do not get stopped just because we
nap. So the primary thread cannot assume that the secondaries will wait
in nap until it has switched to guest context. There will definitely be
race conditions here between primary switching context and the secondary
handling some interrupt in virtual mode.

So your answer to above could be that we are preventing the secondaries
from entering the kernel by setting the HSTATE_HWTHREAD_REQ above. But
we cannot do this because the secondary thread is as alive and kicking
as the primary thread on the host. There can be hrtimers queued, there
may be an IPI from a thread in another core. We cannot ignore handling
them while we wait for the primary thread to switch context.

There is also a bug as far as I can see with having a b . after nap. I
mentioned that in one of my earlier replies to this patch.


Regards
Preeti U Murthy
> +
> +/* enter with vmode */
> +kvmppc_secondary_stopper_exit:
> +	/* fixme, restore the stack which we store on lpaca */
> +
> +	ld	r0, 112+PPC_LR_STKOFF(r1)
> +	addi	r1, r1, 112
> +	mtlr	r0
> +	blr
>  #endif
>  
>  /******************************************************************************
> 
