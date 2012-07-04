Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 72D582C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 00:14:56 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 09/17] KVM: PPC64: booke: Hard disable
 interrupts when entering guest
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-10-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 16:14:49 +0200
Message-Id: <10CBFB35-5A18-4EA8-A129-58CCC4CFBB83@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-10-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: "qemu-ppc@nongnu.org List" <qemu-ppc@nongnu.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, KVM list <kvm@vger.kernel.org>,
 "<kvm-ppc@vger.kernel.org>" <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> 64-bit host runs with lazy interrupt disabling, so local_irq_disable() =
does
> not disable interrupts right away and does not protect against =
preemption
> required by __kvmppc_vcpu_run(). Define a macro for 64-bit to use
> hard_irq_disable().
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
> arch/powerpc/kvm/booke.c |   14 ++++++++++----
> 1 files changed, 10 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 93b48e0..db05692 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -45,6 +45,12 @@ unsigned long kvmppc_booke_handlers;
> #define VM_STAT(x) offsetof(struct kvm, stat.x), KVM_STAT_VM
> #define VCPU_STAT(x) offsetof(struct kvm_vcpu, stat.x), KVM_STAT_VCPU
>=20
> +#ifdef CONFIG_64BIT
> +#define _hard_irq_disable() hard_irq_disable()
> +#else
> +#define _hard_irq_disable() local_irq_disable()
> +#endif

So you only swap out the disable bit, but not the enable one? Ben, would =
this work out?


Alex

> +
> struct kvm_stats_debugfs_item debugfs_entries[] =3D {
> 	{ "mmio",       VCPU_STAT(mmio_exits) },
> 	{ "dcr",        VCPU_STAT(dcr_exits) },
> @@ -456,7 +462,7 @@ int kvmppc_core_prepare_to_enter(struct kvm_vcpu =
*vcpu)
> 		local_irq_enable();
> 		kvm_vcpu_block(vcpu);
> 		clear_bit(KVM_REQ_UNHALT, &vcpu->requests);
> -		local_irq_disable();
> +		_hard_irq_disable();
>=20
> 		kvmppc_set_exit_type(vcpu, EMULATED_MTMSRWE_EXITS);
> 		r =3D 1;
> @@ -480,7 +486,7 @@ static int kvmppc_prepare_to_enter(struct kvm_vcpu =
*vcpu)
> 		if (need_resched()) {
> 			local_irq_enable();
> 			cond_resched();
> -			local_irq_disable();
> +			_hard_irq_disable();
> 			continue;
> 		}
>=20
> @@ -515,7 +521,7 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 		return -EINVAL;
> 	}
>=20
> -	local_irq_disable();
> +	_hard_irq_disable();
> 	if (kvmppc_prepare_to_enter(vcpu)) {
> 		kvm_run->exit_reason =3D KVM_EXIT_INTR;
> 		ret =3D -EINTR;
> @@ -955,7 +961,7 @@ int kvmppc_handle_exit(struct kvm_run *run, struct =
kvm_vcpu *vcpu,
> 	 * aren't already exiting to userspace for some other reason.
> 	 */
> 	if (!(r & RESUME_HOST)) {
> -		local_irq_disable();
> +		_hard_irq_disable();
> 		if (kvmppc_prepare_to_enter(vcpu)) {
> 			run->exit_reason =3D KVM_EXIT_INTR;
> 			r =3D (-EINTR << 2) | RESUME_HOST | (r & =
RESUME_FLAG_NV);
> --=20
> 1.7.4.1
>=20
>=20
>=20
