Return-Path: <agraf@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5C820B6EEC
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 29 Mar 2011 20:47:58 +1100 (EST)
Subject: Re: [PATCH 4/4] KVM: PPC: e500: SPE switch between guest and host
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20110328192559.GC11104@schlenkerla.am.freescale.net>
Date: Tue, 29 Mar 2011 11:47:51 +0200
Message-Id: <6785E5D0-DEE9-4661-88A4-B35A99DB3C66@suse.de>
References: <20110328192559.GC11104@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 28.03.2011, at 21:25, Scott Wood wrote:

> From: yu liu <yu.liu@freescale.com>
>=20
> This patch provide a lazy way to do SPE switch.
> The SPE save/restore will be done only if it's needed.
>=20
> Linux already switches SPEFSCR on context switch (non-lazily), so the
> only remaining bit is to save it between qemu and the guest.
>=20
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/kvm_host.h |    6 +++
> arch/powerpc/kernel/asm-offsets.c   |    6 +++
> arch/powerpc/kvm/booke.c            |   15 +++++++-
> arch/powerpc/kvm/booke_interrupts.S |   62 =
+++++++++++++++++++++++++++++++++++
> arch/powerpc/kvm/e500.c             |   45 ++++++++++++++++++++++++-
> 5 files changed, 130 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/powerpc/include/asm/kvm_host.h =
b/arch/powerpc/include/asm/kvm_host.h
> index c376f6b..171cd85 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -195,6 +195,12 @@ struct kvm_vcpu_arch {
> 	u64 fpr[32];
> 	u64 fpscr;
>=20
> +#ifdef CONFIG_SPE
> +	ulong evr[32];
> +	ulong spefscr;
> +	ulong host_spefscr;
> +	u64 acc;
> +#endif
> #ifdef CONFIG_ALTIVEC
> 	vector128 vr[32];
> 	vector128 vscr;
> diff --git a/arch/powerpc/kernel/asm-offsets.c =
b/arch/powerpc/kernel/asm-offsets.c
> index 75b72c7..554f4d6 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -497,6 +497,12 @@ int main(void)
> 	DEFINE(TLBCAM_MAS3, offsetof(struct tlbcam, MAS3));
> 	DEFINE(TLBCAM_MAS7, offsetof(struct tlbcam, MAS7));
> #endif
> +#ifdef CONFIG_SPE
> +	DEFINE(VCPU_EVR, offsetof(struct kvm_vcpu, arch.evr[0]));
> +	DEFINE(VCPU_ACC, offsetof(struct kvm_vcpu, arch.acc));
> +	DEFINE(VCPU_SPEFSCR, offsetof(struct kvm_vcpu, arch.spefscr));
> +	DEFINE(VCPU_HOST_SPEFSCR, offsetof(struct kvm_vcpu, =
arch.host_spefscr));
> +#endif /* CONFIG_SPE */
>=20
> #ifdef CONFIG_KVM_EXIT_TIMING
> 	DEFINE(VCPU_TIMING_EXIT_TBU, offsetof(struct kvm_vcpu,
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index ef76acb..4e9c1a9 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -13,6 +13,7 @@
>  * Foundation, 51 Franklin Street, Fifth Floor, Boston, MA  =
02110-1301, USA.
>  *
>  * Copyright IBM Corp. 2007
> + * Copyright (C) 2010 Freescale Semiconductor, Inc.
>  *
>  * Authors: Hollis Blanchard <hollisb@us.ibm.com>
>  *          Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> @@ -344,10 +345,19 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 		r =3D RESUME_GUEST;
> 		break;
>=20
> -	case BOOKE_INTERRUPT_SPE_UNAVAIL:
> -		kvmppc_booke_queue_irqprio(vcpu, =
BOOKE_IRQPRIO_SPE_UNAVAIL);
> +#ifdef CONFIG_SPE
> +	case BOOKE_INTERRUPT_SPE_UNAVAIL: {

This means that on non-SPE enabled host kernels you'll get a KVM fatal =
error when the guest triggers SPE_UNAVAIL, as the exit simply isn't =
handled and triggers:

        default:
                printk(KERN_EMERG "exit_nr %d\n", exit_nr);
                BUG();


Alex
