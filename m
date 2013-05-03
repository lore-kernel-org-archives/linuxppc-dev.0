Return-Path: <B07421@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2715C2C00E3
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 04:05:01 +1000 (EST)
Date: Fri, 3 May 2013 13:04:47 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] KVM: PPC: Book3E 64: Fix IRQs warnings and hangs
To: Mihai Caraman <mihai.caraman@freescale.com>
In-Reply-To: <1367597470-22214-1-git-send-email-mihai.caraman@freescale.com>
 (from mihai.caraman@freescale.com on Fri May  3 11:11:10 2013)
Message-ID: <1367604287.19391.2@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Mihai Caraman <mihai.caraman@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/03/2013 11:11:10 AM, Mihai Caraman wrote:
> A change in the generic code highlighted that we were running with =20
> IRQs
> (soft) enabled on Book3E 64-bit when trying to restart interrupts from
> handle_exit(). This is a lesson to configure lockdep often :)
>=20
> There is no reason to exit guest with soft_enabled =3D=3D 1, a =20
> local_irq_enable()
> call will do this for us so get rid of kvmppc_layz_ee() calls. With =20
> this fix
> we eliminate irqs_disabled() warnings and some guest and host hangs =20
> revealed
> under stress tests, but guests still exhibit some unresponsiveness.
>=20
> The unresponsiveness has to do with the fact that =20
> arch_local_irq_restore()
> does not guarantees to hard enable interrupts.

Could you elaborate?  If the saved IRQ state was "enabled", why =20
wouldn't arch_local_irq_restore() hard-enable IRQs?  The last thing it =20
does is __hard_irq_enable().

Where is the arch_local_irq_restore() instance you're talking about?

> To do so replace exception
> function calls like timer_interrupt() with irq_happened flags. The
> local_irq_enable() call takes care of replaying them and lets the =20
> interrupts
> hard enabled.

Not sure what you mean by "lets the interrupts hard enabled"... Do you =20
mean the EE bit in regs->msr, as opposed to the EE bit in the current =20
MSR?

> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>
> ---
>  arch/powerpc/kvm/booke.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 1020119..82f155e 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -673,7 +673,6 @@ int kvmppc_vcpu_run(struct kvm_run *kvm_run, =20
> struct kvm_vcpu *vcpu)
>  		ret =3D s;
>  		goto out;
>  	}
> -	kvmppc_lazy_ee_enable();
>=20
>  	kvm_guest_enter();
>=20
> @@ -789,16 +788,16 @@ static void kvmppc_restart_interrupt(struct =20
> kvm_vcpu *vcpu,
>  	switch (exit_nr) {
>  	case BOOKE_INTERRUPT_EXTERNAL:
>  		kvmppc_fill_pt_regs(&regs);
> -		do_IRQ(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_EE;
>  		break;
>  	case BOOKE_INTERRUPT_DECREMENTER:
>  		kvmppc_fill_pt_regs(&regs);
> -		timer_interrupt(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_DEC;
>  		break;
>  #if defined(CONFIG_PPC_FSL_BOOK3E) || defined(CONFIG_PPC_BOOK3E_64)
>  	case BOOKE_INTERRUPT_DOORBELL:
>  		kvmppc_fill_pt_regs(&regs);
> -		doorbell_exception(&regs);
> +		local_paca->irq_happened |=3D PACA_IRQ_DBELL;
>  		break;
>  #endif

Aren't you breaking 32-bit here?

-Scott=
