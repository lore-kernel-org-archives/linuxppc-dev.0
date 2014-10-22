Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 687A51A0035
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 18:13:28 +1100 (AEDT)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 22 Oct 2014 03:13:24 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A607FC90042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 03:02:05 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9M7DECr1048918
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 07:13:22 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9M7Cnce011922
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Oct 2014 03:12:49 -0400
Message-ID: <544758DB.1020809@linux.vnet.ibm.com>
Date: Wed, 22 Oct 2014 12:42:27 +0530
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

Hi Liu,

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

This does not look right. Let me explain.

We can get hypervisor decrementer interrupts on the secondary threads
since they are online. And we would ideally want to handle them. They
could be scheduler tick interrupts or some timer queued on that thread
could have fired.

If it is a scheduler tick, we would want to exit to host to schedule the
next task if the timeslice of the vcpu running on the secondary thread
is over.

To the best of my understanding, this is what I can tell happens when we
get a hypervisor decrementer interrupt in the guest. We call all threads
in the core to exit to the kernel. The secondaries now return to the
code in idle_power7.S where the wakeup from idle path takes effect. Then
we do an rfid which lands after the nap code above. And we spin.

>From your above code you seem to be indicating that you do not want the
secondary threads to exit to the kernel once they are made to run guest
for the first time. Is this right? Or am I missing something ?

Moreover the changelog in [patch 10/11] says that you cease the
scheduler. This pushes me to think that you do not expect the scheduler
to run on the secondary threads ever again after you have launched the
guest. This does not look right to me.

Regards
Preeti U Murthy
