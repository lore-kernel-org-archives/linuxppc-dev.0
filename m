Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 675692C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 14:10:37 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH] powerpc: kvm: optimize "sc 0" as fast return
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Fri, 8 Nov 2013 04:10:26 +0100
Message-Id: <470E7CC0-6397-4343-89DA-6818531E6775@suse.de>
References: <1383878656-4196-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 08.11.2013, at 03:44, Liu Ping Fan <kernelfans@gmail.com> wrote:

> syscall is a very common behavior inside guest, and this patch
> optimizes the path for the emulation of BOOK3S_INTERRUPT_SYSCALL,
> so hypervisor can return to guest without heavy exit, i.e, no need
> to swap TLB, HTAB,.. etc

The syscall exit you touch here only happens when you do an sc > 0 with =
MSR_PR set inside the guest. The only case you realistically see this is =
when you run PR KVM inside of an HV KVM guest.

I don't think we should optimize for that case. Instead, we should =
rather try to not bounce to the 1st hypervisor in the first place in =
that scenario :).


Alex

>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
> Compiled, but lack of bare metal, I have not tested it yet.
> ---
> arch/powerpc/kvm/book3s_hv.c            |  6 ------
> arch/powerpc/kvm/book3s_hv_rmhandlers.S | 13 ++++++++++++-
> 2 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/book3s_hv.c =
b/arch/powerpc/kvm/book3s_hv.c
> index 62a2b5a..73dc852 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -628,12 +628,6 @@ static int kvmppc_handle_exit(struct kvm_run =
*run, struct kvm_vcpu *vcpu,
> 		/* hcall - punt to userspace */
> 		int i;
>=20
> -		if (vcpu->arch.shregs.msr & MSR_PR) {
> -			/* sc 1 from userspace - reflect to guest =
syscall */
> -			kvmppc_book3s_queue_irqprio(vcpu, =
BOOK3S_INTERRUPT_SYSCALL);
> -			r =3D RESUME_GUEST;
> -			break;
> -		}
> 		run->papr_hcall.nr =3D kvmppc_get_gpr(vcpu, 3);
> 		for (i =3D 0; i < 9; ++i)
> 			run->papr_hcall.args[i] =3D kvmppc_get_gpr(vcpu, =
4 + i);
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S =
b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index c71103b..9f626c3 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1388,7 +1388,8 @@ kvmppc_hisi:
> hcall_try_real_mode:
> 	ld	r3,VCPU_GPR(R3)(r9)
> 	andi.	r0,r11,MSR_PR
> -	bne	guest_exit_cont
> +	/* sc 1 from userspace - reflect to guest syscall */
> +	bne	sc_0_fast_return
> 	clrrdi	r3,r3,2
> 	cmpldi	r3,hcall_real_table_end - hcall_real_table
> 	bge	guest_exit_cont
> @@ -1409,6 +1410,16 @@ hcall_try_real_mode:
> 	ld	r11,VCPU_MSR(r4)
> 	b	fast_guest_return
>=20
> +sc_0_fast_return:
> +	ld	r10,VCPU_PC(r9)
> +	ld	r11,VCPU_MSR(r9)
> +	mtspr	SPRN_SRR0,r10
> +	mtspr	SPRN_SRR1,r11
> +	li	r10, BOOK3S_INTERRUPT_SYSCALL
> +	LOAD_REG_IMMEDIATE(r3,0xffffffff87a0ffff)	/* zero =
33:36,42:47 */
> +	and	r11,r11,r3
> +	b	fast_guest_return
> +
> 	/* We've attempted a real mode hcall, but it's punted it back
> 	 * to userspace.  We need to restore some clobbered volatiles
> 	 * before resuming the pass-it-to-qemu path */
> --=20
> 1.8.1.4
>=20
