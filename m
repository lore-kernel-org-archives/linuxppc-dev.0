Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 47A762C00DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 02:24:18 +1000 (EST)
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
Date: Fri, 3 May 2013 18:24:08 +0200
Message-Id: <981DB739-E50F-488F-B2D8-916FDC2E1749@suse.de>
References: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "kvm@vger.kernel.org VIRTUAL MA..." <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.05.2013, at 18:11, Mihai Caraman wrote:

> A change in the generic code highlighted that we were running with =
IRQs
> (soft) enabled on Book3E 64-bit when trying to restart interrupts from
> handle_exit(). This is a lesson to configure lockdep often :)
>=20
> There is no reason to exit guest with soft_enabled =3D=3D 1, a =
local_irq_enable()
> call will do this for us so get rid of kvmppc_layz_ee() calls. With =
this fix
> we eliminate irqs_disabled() warnings and some guest and host hangs =
revealed
> under stress tests, but guests still exhibit some unresponsiveness.
>=20
> The unresponsiveness has to do with the fact that =
arch_local_irq_restore()
> does not guarantees to hard enable interrupts. To do so replace =
exception
> function calls like timer_interrupt() with irq_happened flags. The
> local_irq_enable() call takes care of replaying them and lets the =
interrupts
> hard enabled.
>=20
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Ben, could you please review?


Alex

> ---
> arch/powerpc/kvm/booke.c |    9 +++------
> 1 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..82f155e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -673,7 +673,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =
struct kvm_vcpu *vcpu)
> 		ret =3D s;
> 		goto out;
> 	}
> -	kvmppc_lazy_ee_enable();
>=20
> 	kvm_guest_enter();
>=20
> @@ -789,16 +788,16 @@ static void kvmppc_restart_interrupt(struct =
kvm_vcpu *vcpu,
> 	switch (exit_nr) {
> 	case BOOKE_INTERRUPT_EXTERNAL:
> 		kvmppc_fill_pt_regs(&regs);
> -		do_IRQ(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_EE;
> 		break;
> 	case BOOKE_INTERRUPT_DECREMENTER:
> 		kvmppc_fill_pt_regs(&regs);
> -		timer_interrupt(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_DEC;
> 		break;
> #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
> 	case BOOKE_INTERRUPT_DOORBELL:
> 		kvmppc_fill_pt_regs(&regs);
> -		doorbell_exception(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_DBELL;
> 		break;
> #endif
> 	case BOOKE_INTERRUPT_MACHINE_CHECK:
> @@ -1148,8 +1147,6 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
> 		if (s <=3D 0) {
> 			local_irq_enable();
> 			r =3D (s << 2) | RESUME_HOST | (r & =
RESUME_FLAG_NV);
> -		} else {
> -			kvmppc_lazy_ee_enable();
> 		}
> 	}
>=20
> --=20
> 1.7.4.1
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
