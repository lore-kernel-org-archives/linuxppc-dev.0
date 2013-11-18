Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 7E3562C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 07:45:53 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1812\))
Subject: Re: [PATCH v3] powerpc: kvm: optimize "sc 1" as fast return
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1384736947-21437-1-git-send-email-pingfank@linux.vnet.ibm.com>
Date: Mon, 18 Nov 2013 15:45:38 -0500
Message-Id: <5573E8A3-CF3A-49F0-8EE1-3A34722BB425@suse.de>
References: <1384736947-21437-1-git-send-email-pingfank@linux.vnet.ibm.com>
To: Liu Ping Fan <qemulist@gmail.com>
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


On 17.11.2013, at 20:09, Liu Ping Fan <qemulist@gmail.com> wrote:

> In some scene, e.g openstack CI, PR guest can trigger "sc 1" =
frequently,
> this patch optimizes the path by directly delivering =
BOOK3S_INTERRUPT_SYSCALL
> to HV guest, so powernv can return to HV guest without heavy exit, =
i.e,
> no need to swap TLB, HTAB,.. etc
>=20
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
> arch/powerpc/kvm/book3s_hv.c            |  6 ------
> arch/powerpc/kvm/book3s_hv_rmhandlers.S | 12 +++++++++++-
> 2 files changed, 11 insertions(+), 7 deletions(-)
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

Please document the fact that we never get here for

 1) hypercall with MSR_PR
 2) hypercall that was handled by rm code

so that when anyone reads the C file he doesn't have to dig through =
piles of asm code to understand what's happening.

> 		run->papr_hcall.nr =3D kvmppc_get_gpr(vcpu, 3);
> 		for (i =3D 0; i < 9; ++i)
> 			run->papr_hcall.args[i] =3D kvmppc_get_gpr(vcpu, =
4 + i);
> diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S =
b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> index c71103b..0d1e2c2 100644
> --- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> +++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
> @@ -1388,7 +1388,8 @@ kvmppc_hisi:
> hcall_try_real_mode:
> 	ld	r3,VCPU_GPR(R3)(r9)
> 	andi.	r0,r11,MSR_PR
> -	bne	guest_exit_cont
> +	/* sc 1 from userspace - reflect to guest syscall */
> +	bne	sc_1_fast_return
> 	clrrdi	r3,r3,2
> 	cmpldi	r3,hcall_real_table_end - hcall_real_table
> 	bge	guest_exit_cont
> @@ -1409,6 +1410,15 @@ hcall_try_real_mode:
> 	ld	r11,VCPU_MSR(r4)
> 	b	fast_guest_return
>=20
> +sc_1_fast_return:
> +	mtspr	SPRN_SRR0,r10
> +	mtspr	SPRN_SRR1,r11
> +	li	r10, BOOK3S_INTERRUPT_SYSCALL
> +	li	r11, (MSR_ME << 1) | 1  /* synthesize MSR_SF | MSR_ME */
> +	rotldi	r11, r11, 63
> +	mr	r4,r9
> +	b	fast_guest_return

While at it, please also document the input registers to =
fast_guest_return. As you've seen it's very easy to get them right when =
they're not properly documented in the header of the function.

Apart from these minor bits, the patch looks very sound and hopefully =
speeds up PR-in-HV by quite a bit.


Alex
