Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ySqn55dVBzDqvT
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Nov 2017 16:11:37 +1100 (AEDT)
Date: Fri, 3 Nov 2017 16:11:23 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH] KVM: PPC: Book3S HV: Handle host system reset in
 guest mode
Message-ID: <20171103051123.GA5046@fergus.ozlabs.ibm.com>
References: <20171103043803.6126-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171103043803.6126-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Nov 03, 2017 at 03:38:03PM +1100, Nicholas Piggin wrote:
> If the host takes a system reset interrupt while a guest is running,
> the CPU must exit the guest before processing the host exception
> handler.
> 
> After this patch, taking a sysrq+x with a CPU running in a guest
> gives a trace like this:
> 
>    cpu 0x27: Vector: 100 (System Reset) at [c000000fdf5776f0]
>        pc: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
>        lr: c008000010158b80: kvmppc_run_core+0x16b8/0x1ad0 [kvm_hv]
>        sp: c000000fdf577850
>       msr: 9000000002803033
>      current = 0xc000000fdf4b1e00
>      paca    = 0xc00000000fd4d680	 softe: 3	 irq_happened: 0x01
>        pid   = 6608, comm = qemu-system-ppc
>    Linux version 4.14.0-rc7-01489-g47e1893a404a-dirty #26 SMP
>    [c000000fdf577a00] c008000010159dd4 kvmppc_vcpu_run_hv+0x3dc/0x12d0 [kvm_hv]
>    [c000000fdf577b30] c0080000100a537c kvmppc_vcpu_run+0x44/0x60 [kvm]
>    [c000000fdf577b60] c0080000100a1ae0 kvm_arch_vcpu_ioctl_run+0x118/0x310 [kvm]
>    [c000000fdf577c00] c008000010093e98 kvm_vcpu_ioctl+0x530/0x7c0 [kvm]
>    [c000000fdf577d50] c000000000357bf8 do_vfs_ioctl+0xd8/0x8c0
>    [c000000fdf577df0] c000000000358448 SyS_ioctl+0x68/0x100
>    [c000000fdf577e30] c00000000000b220 system_call+0x58/0x6c
>    --- Exception: c01 (System Call) at 00007fff76868df0
>    SP (7fff7069baf0) is in userspace
> 
> Fixes: e36d0a2ed5 ("powerpc/powernv: Implement NMI IPI with OPAL_SIGNAL_SYSTEM_RESET")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Looks good, except that you don't need the last hunk (the change to
book3s_hv_rmhandlers.S) as far as I can see:

> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 68bf0f14a962..74958ad5efb9 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1427,6 +1427,10 @@ guest_exit_cont:		/* r9 = vcpu, r12 = trap, r13 = paca */
>  	/* don't overwrite fault_dar/fault_dsisr if HDSI */
>  	cmpwi	r12,BOOK3S_INTERRUPT_H_DATA_STORAGE
>  	beq	mc_cont
> +
> +	cmpwi	r12, BOOK3S_INTERRUPT_SYSTEM_RESET
> +	beq	mc_cont
> +
>  	std	r6, VCPU_FAULT_DAR(r9)
>  	stw	r7, VCPU_FAULT_DSISR(r9)
>  
> -- 
> 2.15.0

Paul.
