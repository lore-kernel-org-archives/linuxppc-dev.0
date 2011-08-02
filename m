Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2FCE1B71D7
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Aug 2011 00:47:14 +1000 (EST)
Message-ID: <4E380DEC.8030803@suse.de>
Date: Tue, 02 Aug 2011 16:47:08 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 3/3] KVM: PPC: Implement H_CEDE hcall for book3s_hv in
	real-mode code
References: <20110723074111.GA17927@bloggs.ozlabs.ibm.com>
	<20110723074246.GC17927@bloggs.ozlabs.ibm.com>
In-Reply-To: <20110723074246.GC17927@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2011 09:42 AM, Paul Mackerras wrote:
> With a KVM guest operating in SMT4 mode (i.e. 4 hardware threads per
> core), whenever a CPU goes idle, we have to pull all the other
> hardware threads in the core out of the guest, because the H_CEDE
> hcall is handled in the kernel.  This is inefficient.
>
> This adds code to book3s_hv_rmhandlers.S to handle the H_CEDE hcall
> in real mode.  When a guest vcpu does an H_CEDE hcall, we now only
> exit to the kernel if all the other vcpus in the same core are also
> idle.  Otherwise we mark this vcpu as napping, save state that could
> be lost in nap mode (mainly GPRs and FPRs), and execute the nap
> instruction.  When the thread wakes up, because of a decrementer or
> external interrupt, we come back in at kvm_start_guest (from the
> system reset interrupt vector), find the `napping' flag set in the
> paca, and go to the resume path.
>
> This has some other ramifications.  First, when starting a core, we
> now start all the threads, both those that are immediately runnable and
> those that are idle.  This is so that we don't have to pull all the
> threads out of the guest when an idle thread gets a decrementer interrupt
> and wants to start running.  In fact the idle threads will all start
> with the H_CEDE hcall returning; being idle they will just do another
> H_CEDE immediately and go to nap mode.
>
> This required some changes to kvmppc_run_core() and kvmppc_run_vcpu().
> These functions have been restructured to make them simpler and clearer.
> We introduce a level of indirection in the wait queue that gets woken
> when external and decrementer interrupts get generated for a vcpu, so
> that we can have the 4 vcpus in a vcore using the same wait queue.
> We need this because the 4 vcpus are being handled by one thread.
>
> Secondly, when we need to exit from the guest to the kernel, we now
> have to generate an IPI for any napping threads, because an HDEC
> interrupt doesn't wake up a napping thread.
>
> Thirdly, we now need to be able to handle virtual external interrupts
> and decrementer interrupts becoming pending while a thread is napping,
> and deliver those interrupts to the guest when the thread wakes.
> This is done in kvmppc_cede_reentry, just before fast_guest_return.
>
> Finally, since we are not using the generic kvm_vcpu_block for book3s_hv,
> and hence not calling kvm_arch_vcpu_runnable, we can remove the #ifdef
> from kvm_arch_vcpu_runnable.
>
> Signed-off-by: Paul Mackerras<paulus@samba.org>
> ---
>   arch/powerpc/include/asm/kvm_book3s_asm.h |    1 +
>   arch/powerpc/include/asm/kvm_host.h       |   19 ++-
>   arch/powerpc/kernel/asm-offsets.c         |    6 +
>   arch/powerpc/kvm/book3s_hv.c              |  335 ++++++++++++++++-------------
>   arch/powerpc/kvm/book3s_hv_rmhandlers.S   |  297 ++++++++++++++++++++++---
>   arch/powerpc/kvm/powerpc.c                |   21 +-
>   6 files changed, 483 insertions(+), 196 deletions(-)
>
>

[...]

> diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
> index a107c9b..cd0e3e5 100644
> --- a/arch/powerpc/kvm/powerpc.c
> +++ b/arch/powerpc/kvm/powerpc.c
> @@ -39,12 +39,8 @@
>
>   int kvm_arch_vcpu_runnable(struct kvm_vcpu *v)
>   {
> -#ifndef CONFIG_KVM_BOOK3S_64_HV
>   	return !(v->arch.shared->msr&  MSR_WE) ||
>   	       !!(v->arch.pending_exceptions);
> -#else
> -	return !(v->arch.ceded) || !!(v->arch.pending_exceptions);
> -#endif
>   }
>
>   int kvmppc_kvm_pv(struct kvm_vcpu *vcpu)
> @@ -258,6 +254,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm, unsigned int id)
>   {
>   	struct kvm_vcpu *vcpu;
>   	vcpu = kvmppc_core_vcpu_create(kvm, id);
> +	vcpu->arch.wqp =&vcpu->wq;
>   	if (!IS_ERR(vcpu))
>   		kvmppc_create_vcpu_debugfs(vcpu, id);
>   	return vcpu;
> @@ -289,8 +286,8 @@ static void kvmppc_decrementer_func(unsigned long data)
>
>   	kvmppc_core_queue_dec(vcpu);
>
> -	if (waitqueue_active(&vcpu->wq)) {
> -		wake_up_interruptible(&vcpu->wq);
> +	if (waitqueue_active(vcpu->arch.wqp)) {
> +		wake_up_interruptible(vcpu->arch.wqp);
>   		vcpu->stat.halt_wakeup++;
>   	}
>   }
> @@ -543,13 +540,15 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
>
>   int kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_interrupt *irq)
>   {
> -	if (irq->irq == KVM_INTERRUPT_UNSET)
> +	if (irq->irq == KVM_INTERRUPT_UNSET) {
>   		kvmppc_core_dequeue_external(vcpu, irq);
> -	else
> -		kvmppc_core_queue_external(vcpu, irq);
> +		return 0;
> +	}

Not sure I understand this part. Mind to explain?

Alex

> +
> +	kvmppc_core_queue_external(vcpu, irq);
>
> -	if (waitqueue_active(&vcpu->wq)) {
> -		wake_up_interruptible(&vcpu->wq);
> +	if (waitqueue_active(vcpu->arch.wqp)) {
> +		wake_up_interruptible(vcpu->arch.wqp);
>   		vcpu->stat.halt_wakeup++;
>   	} else if (vcpu->cpu != -1) {
>   		smp_send_reschedule(vcpu->cpu);
