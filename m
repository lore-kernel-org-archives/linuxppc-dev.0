Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v20lt4wvqzDqRL
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 15:35:38 +1100 (AEDT)
Date: Mon, 16 Jan 2017 15:35:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Cc: gleb@kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org, pbonzini@redhat.com,
 mahesh@linux.vnet.ibm.com, mpe@ellerman.id.au,
 bsingharora@gmail.com, kvm@vger.kernel.org, david@gibson.dropbear.id.au
Subject: Re: [PATCH v5 2/2] KVM: PPC: Exit guest upon MCE when FWNMI
 capability is enabled
Message-ID: <20170116043527.GA4577@fergus.ozlabs.ibm.com>
References: <148430634902.22799.7589829837646104546.stgit@aravinda>
 <148430650591.22799.7426036865298338317.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <148430650591.22799.7426036865298338317.stgit@aravinda>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 13, 2017 at 04:51:45PM +0530, Aravinda Prasad wrote:
> Enhance KVM to cause a guest exit with KVM_EXIT_NMI
> exit reason upon a machine check exception (MCE) in
> the guest address space if the KVM_CAP_PPC_FWNMI
> capability is enabled (instead of delivering a 0x200
> interrupt to guest). This enables QEMU to build error
> log and deliver machine check exception to guest via
> guest registered machine check handler.
> 
> This approach simplifies the delivery of machine
> check exception to guest OS compared to the earlier
> approach of KVM directly invoking 0x200 guest interrupt
> vector.
> 
> This design/approach is based on the feedback for the
> QEMU patches to handle machine check exception. Details
> of earlier approach of handling machine check exception
> in QEMU and related discussions can be found at:
> 
> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
> 
> Note:
> 
> This patch introduces a hook which is invoked at the time
> of guest exit to facilitate the host-side handling of
> machine check exception before the exception is passed
> on to the guest. Hence, the host-side handling which was
> performed earlier via machine_check_fwnmi is removed.
> 
> The reasons for this approach is (i) it is not possible
> to distinguish whether the exception occurred in the
> guest or the host from the pt_regs passed on the
> machine_check_exception(). Hence machine_check_exception()
> calls panic, instead of passing on the exception to
> the guest, if the machine check exception is not
> recoverable. (ii) the approach introduced in this
> patch gives opportunity to the host kernel to perform
> actions in virtual mode before passing on the exception
> to the guest. This approach does not require complex
> tweaks to machine_check_fwnmi and friends.
> 
> Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

This patch mostly looks OK.  I have a few relatively minor comments
below.

> ---
>  arch/powerpc/kvm/book3s_hv.c            |   27 +++++++++++++-----
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |   47 ++++++++++++++++---------------
>  arch/powerpc/platforms/powernv/opal.c   |   10 +++++++
>  3 files changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 3686471..cae4921 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -123,6 +123,7 @@ MODULE_PARM_DESC(halt_poll_ns_shrink, "Factor halt poll time is shrunk by");
>  
>  static void kvmppc_end_cede(struct kvm_vcpu *vcpu);
>  static int kvmppc_hv_setup_htab_rma(struct kvm_vcpu *vcpu);
> +static void kvmppc_machine_check_hook(void);
>  
>  static inline struct kvm_vcpu *next_runnable_thread(struct kvmppc_vcore *vc,
>  		int *ip)
> @@ -954,15 +955,14 @@ static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *vcpu,
>  		r = RESUME_GUEST;
>  		break;
>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
> +		/* Exit to guest with KVM_EXIT_NMI as exit reason */
> +		run->exit_reason = KVM_EXIT_NMI;
> +		r = RESUME_HOST;
>  		/*
> -		 * Deliver a machine check interrupt to the guest.
> -		 * We have to do this, even if the host has handled the
> -		 * machine check, because machine checks use SRR0/1 and
> -		 * the interrupt might have trashed guest state in them.
> +		 * Invoke host-kernel handler to perform any host-side
> +		 * handling before exiting the guest.
>  		 */
> -		kvmppc_book3s_queue_irqprio(vcpu,
> -					    BOOK3S_INTERRUPT_MACHINE_CHECK);
> -		r = RESUME_GUEST;
> +		kvmppc_machine_check_hook();

Note that this won't necessarily be called on the same CPU that
received the machine check.  This will be called on thread 0 of the
core (or subcore), whereas the machine check could have occurred on
some other thread.  Are you sure that the machine check handling code
will be OK with that?

>  		break;
>  	case BOOK3S_INTERRUPT_PROGRAM:
>  	{
> @@ -3491,6 +3491,19 @@ static void kvmppc_irq_bypass_del_producer_hv(struct irq_bypass_consumer *cons,
>  }
>  #endif
>  
> +/*
> + * Hook to handle machine check exceptions occurred inside a guest.
> + * This hook is invoked from host virtual mode from KVM before exiting
> + * the guest with KVM_EXIT_NMI exit reason. This gives an opportunity
> + * for the host to take action (if any) before passing on the machine
> + * check exception to the guest kernel.
> + */
> +static void kvmppc_machine_check_hook(void)
> +{
> +	if (ppc_md.machine_check_exception)
> +		ppc_md.machine_check_exception(NULL);
> +}

What is the advantage of having this as a separate function, as
opposed to just putting those two lines of code in line in the one
place where this gets called?

Paul.
