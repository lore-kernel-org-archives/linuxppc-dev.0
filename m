Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EB3A72C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 18:35:53 +1100 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 18 Dec 2013 17:35:50 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 378E23578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 18:35:47 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBI7HQjh57802966
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 18:17:26 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBI7Zkp4026497
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Dec 2013 18:35:46 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: agraf@suse.de, benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH] powerpc: book3s: kvm: Don't abuse host r2 in exit path
In-Reply-To: <1384178387-22993-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1384178387-22993-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 18 Dec 2013 13:05:36 +0530
Message-ID: <87lhzilign.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Alex,

Any update on this ? We need this to got into 3.13.

-aneesh 

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>
> We don't use PACATOC for PR. Avoid updating HOST_R2 with PR
> KVM mode when both HV and PR are enabled in the kernel. Without this we
> get the below crash
>
> (qemu)
> Unable to handle kernel paging request for data at address 0xffffffffffff8310
> Faulting instruction address: 0xc00000000001d5a4
> cpu 0x2: Vector: 300 (Data Access) at [c0000001dc53aef0]
>     pc: c00000000001d5a4: .vtime_delta.isra.1+0x34/0x1d0
>     lr: c00000000001d760: .vtime_account_system+0x20/0x60
>     sp: c0000001dc53b170
>    msr: 8000000000009032
>    dar: ffffffffffff8310
>  dsisr: 40000000
>   current = 0xc0000001d76c62d0
>   paca    = 0xc00000000fef1100   softe: 0        irq_happened: 0x01
>     pid   = 4472, comm = qemu-system-ppc
> enter ? for help
> [c0000001dc53b200] c00000000001d760 .vtime_account_system+0x20/0x60
> [c0000001dc53b290] c00000000008d050 .kvmppc_handle_exit_pr+0x60/0xa50
> [c0000001dc53b340] c00000000008f51c kvm_start_lightweight+0xb4/0xc4
> [c0000001dc53b510] c00000000008cdf0 .kvmppc_vcpu_run_pr+0x150/0x2e0
> [c0000001dc53b9e0] c00000000008341c .kvmppc_vcpu_run+0x2c/0x40
> [c0000001dc53ba50] c000000000080af4 .kvm_arch_vcpu_ioctl_run+0x54/0x1b0
> [c0000001dc53bae0] c00000000007b4c8 .kvm_vcpu_ioctl+0x478/0x730
> [c0000001dc53bca0] c0000000002140cc .do_vfs_ioctl+0x4ac/0x770
> [c0000001dc53bd80] c0000000002143e8 .SyS_ioctl+0x58/0xb0
> [c0000001dc53be30] c000000000009e58 syscall_exit+0x0/0x98
> --- Exception: c00 (System Call) at 00001fffff960160
> SP (1ffffecbe3c0) is in userspace
>
> These changes were originally part of
> http://mid.gmane.org/20130806042205.GR19254@iris.ozlabs.ibm.com
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_book3s_asm.h | 1 +
>  arch/powerpc/kernel/asm-offsets.c         | 1 +
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S   | 7 +++----
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_book3s_asm.h b/arch/powerpc/include/asm/kvm_book3s_asm.h
> index 0bd9348..69fe837 100644
> --- a/arch/powerpc/include/asm/kvm_book3s_asm.h
> +++ b/arch/powerpc/include/asm/kvm_book3s_asm.h
> @@ -79,6 +79,7 @@ struct kvmppc_host_state {
>  	ulong vmhandler;
>  	ulong scratch0;
>  	ulong scratch1;
> +	ulong scratch2;
>  	u8 in_guest;
>  	u8 restore_hid5;
>  	u8 napping;
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 8e6ede6..841a4c8 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -583,6 +583,7 @@ int main(void)
>  	HSTATE_FIELD(HSTATE_VMHANDLER, vmhandler);
>  	HSTATE_FIELD(HSTATE_SCRATCH0, scratch0);
>  	HSTATE_FIELD(HSTATE_SCRATCH1, scratch1);
> +	HSTATE_FIELD(HSTATE_SCRATCH2, scratch2);
>  	HSTATE_FIELD(HSTATE_IN_GUEST, in_guest);
>  	HSTATE_FIELD(HSTATE_RESTORE_HID5, restore_hid5);
>  	HSTATE_FIELD(HSTATE_NAPPING, napping);
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index 339aa5e..16f7654 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -750,15 +750,14 @@ kvmppc_interrupt_hv:
>  	 * guest CR, R12 saved in shadow VCPU SCRATCH1/0
>  	 * guest R13 saved in SPRN_SCRATCH0
>  	 */
> -	/* abuse host_r2 as third scratch area; we get r2 from PACATOC(r13) */
> -	std	r9, HSTATE_HOST_R2(r13)
> +	std	r9, HSTATE_SCRATCH2(r13)
>  
>  	lbz	r9, HSTATE_IN_GUEST(r13)
>  	cmpwi	r9, KVM_GUEST_MODE_HOST_HV
>  	beq	kvmppc_bad_host_intr
>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>  	cmpwi	r9, KVM_GUEST_MODE_GUEST
> -	ld	r9, HSTATE_HOST_R2(r13)
> +	ld	r9, HSTATE_SCRATCH2(r13)
>  	beq	kvmppc_interrupt_pr
>  #endif
>  	/* We're now back in the host but in guest MMU context */
> @@ -778,7 +777,7 @@ kvmppc_interrupt_hv:
>  	std	r6, VCPU_GPR(R6)(r9)
>  	std	r7, VCPU_GPR(R7)(r9)
>  	std	r8, VCPU_GPR(R8)(r9)
> -	ld	r0, HSTATE_HOST_R2(r13)
> +	ld	r0, HSTATE_SCRATCH2(r13)
>  	std	r0, VCPU_GPR(R9)(r9)
>  	std	r10, VCPU_GPR(R10)(r9)
>  	std	r11, VCPU_GPR(R11)(r9)
> -- 
> 1.8.3.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
