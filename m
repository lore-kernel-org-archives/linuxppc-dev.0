Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1057A1A017E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 17:28:40 +1100 (AEDT)
Received: from /spool/local
 by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 27 Oct 2014 02:28:38 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id B0EB338C803D
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:28:36 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s9R6Sar5786862
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 06:28:36 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s9R6SajT027012
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Oct 2014 02:28:36 -0400
Message-ID: <544DE604.4040506@linux.vnet.ibm.com>
Date: Mon, 27 Oct 2014 11:58:20 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: kernelfans@gmail.com, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
Subject: Re: [RFC 08/11] powerpc: kvm: add a flag in vcore to sync primary
 with secondry hwthread
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-9-git-send-email-kernelfans@gmail.com>
In-Reply-To: <1413487800-7162-9-git-send-email-kernelfans@gmail.com>
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
> The secondary thread can only jump back to host until primary has set
> up the env. Add host_ready field in kvm_vcore to sync this action.

Do we need to do this? We already synchronize among the sibling threads
when there is a need to enter the host. Today too, the secondaries may
require host kernel's intervention and there is already code in which
under such circumstances, the secondaries set the HDEC of the sibling
threads and wait for the primary to switch context. I see the code under
secondary_too_late. Besides this, do we need anything additional to
synchronize the exit to host path? IIUC, we will need synchronization
only in the entry to guest path.

And of course there will be more guest exits now since the secondaries
are as alive in the host as the primary and will have scheduling
interrupts atleast, forcing them to exit to host. This cannot be
trivially solved unless we can isolate these threads in some way.

Regards
Preeti U Murthy
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h     |  3 +++
>  arch/powerpc/kernel/asm-offsets.c       |  3 +++
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S | 11 ++++++++++-
>  3 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 9a3355e..1310e03 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -305,6 +305,9 @@ struct kvmppc_vcore {
>  	u32 arch_compat;
>  	ulong pcr;
>  	ulong dpdes;		/* doorbell state (POWER8) */
> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
> +	u8 host_ready;
> +#endif
>  	void *mpp_buffer; /* Micro Partition Prefetch buffer */
>  	bool mpp_buffer_is_valid;
>  };
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 0faa8fe..9c04ac2 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -562,6 +562,9 @@ int main(void)
>  	DEFINE(VCORE_LPCR, offsetof(struct kvmppc_vcore, lpcr));
>  	DEFINE(VCORE_PCR, offsetof(struct kvmppc_vcore, pcr));
>  	DEFINE(VCORE_DPDES, offsetof(struct kvmppc_vcore, dpdes));
> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
> +	DEFINE(VCORE_HOST_READY, offsetof(struct kvmppc_vcore, host_ready));
> +#endif
>  	DEFINE(VCPU_SLB_E, offsetof(struct kvmppc_slb, orige));
>  	DEFINE(VCPU_SLB_V, offsetof(struct kvmppc_slb, origv));
>  	DEFINE(VCPU_SLB_SIZE, sizeof(struct kvmppc_slb));
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 254038b..89ea16c 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -351,7 +351,11 @@ kvm_do_nap:
>  kvm_secondary_exit_trampoline:
>  
>  	/* all register is free to use, later kvmppc_secondary_stopper_exit set up them*/
> -	//loop-wait for the primary to signal that host env is ready
> +	/* wait until the primary to set up host env */
> +	ld	r5, HSTATE_KVM_VCORE(r13)
> +	ld	r0, VCORE_HOST_READY(r5)
> +	cmp	r0,  //primary is ready?
> +	bne	kvm_secondary_exit_trampoline
>  
>  	LOAD_REG_ADDR(r5, kvmppc_secondary_stopper_exit)
>  	/* fixme, load msr from lpaca stack */
> @@ -1821,6 +1825,11 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_207S)
>  	li	r0, KVM_GUEST_MODE_NONE
>  	stb	r0, HSTATE_IN_GUEST(r13)
>  
> +#ifdef PPCKVM_ENABLE_SECONDARY
> +	/* signal the secondary that host env is ready */
> +	li	r0, 1
> +	stb	r0, VCORE_HOST_READY(r5)
> +#endif
>  	ld	r0, 112+PPC_LR_STKOFF(r1)
>  	addi	r1, r1, 112
>  	mtlr	r0
> 
