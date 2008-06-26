Return-Path: <madhvesh.s@ap.sony.com>
Received: from WA4EHSOBE002.bigfish.com (outbound-wa4.frontbridge.com
	[216.32.181.16]) by ozlabs.org (Postfix) with ESMTP id BB17BDDEFD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 18:08:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Subject: RE: [PATCH 2/2] powerpc/booke: Add kprobes support for booke style
	processors
Date: Thu, 26 Jun 2008 13:37:30 +0530
Message-ID: <7B7EF7F090B9804A830ACC82F2CDE95D2E419B@insardxms01.ap.sony.com>
From: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
To: "Kumar Gala" <galak@kernel.crashing.org>, <linuxppc-dev@ozlabs.org>
Cc: "Sulibhavi, Madhvesh" <madhvesh.s@ap.sony.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Kumar,

I confirmed these updated patches and found no issues
with my test. I acknowledge these patches for powerpc
kprobes booke support.

-Madhvesh

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]=20
> Sent: Thursday, June 26, 2008 12:36 PM
> To: linuxppc-dev@ozlabs.org
> Cc: Sulibhavi, Madhvesh
> Subject: [PATCH 2/2] powerpc/booke: Add kprobes support for=20
> booke style processors
>=20
> This patch is based on work done by Madhvesh. R. Sulibhavi back in
> March 2007.
>=20
> We refactor some of the single step handling since it differs between
> "classic" and "booke" powerpc cores.
>=20
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
>  Documentation/kprobes.txt     |    1 +
>  arch/powerpc/kernel/kprobes.c |   25 +++++++++++++++++++------
>  arch/powerpc/kernel/traps.c   |   26 +++++++++++++++++---------
>  3 files changed, 37 insertions(+), 15 deletions(-)
>=20
> diff --git a/Documentation/kprobes.txt b/Documentation/kprobes.txt
> index 6877e71..a79633d 100644
> --- a/Documentation/kprobes.txt
> +++ b/Documentation/kprobes.txt
> @@ -172,6 +172,7 @@ architectures:
>  - ia64 (Does not support probes on instruction slot1.)
>  - sparc64 (Return probes not yet implemented.)
>  - arm
> +- ppc
>=20
>  3. Configuring Kprobes
>=20
> diff --git a/arch/powerpc/kernel/kprobes.c=20
> b/arch/powerpc/kernel/kprobes.c
> index 74693d9..4ba2af1 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -34,6 +34,13 @@
>  #include <asm/cacheflush.h>
>  #include <asm/sstep.h>
>  #include <asm/uaccess.h>
> +#include <asm/system.h>
> +
> +#ifdef CONFIG_BOOKE
> +#define MSR_SINGLESTEP	(MSR_DE)
> +#else
> +#define MSR_SINGLESTEP	(MSR_SE)
> +#endif
>=20
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) =3D NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> @@ -53,7 +60,8 @@ int __kprobes arch_prepare_kprobe(struct kprobe *p)
>  		ret =3D -EINVAL;
>  	}
>=20
> -	/* insn must be on a special executable page on ppc64 */
> +	/* insn must be on a special executable page on ppc64.  This is
> +	 * not explicitly required on ppc32 (right now), but it=20
> doesn't hurt */
>  	if (!ret) {
>  		p->ainsn.insn =3D get_insn_slot();
>  		if (!p->ainsn.insn)
> @@ -100,7 +108,11 @@ static void __kprobes=20
> prepare_singlestep(struct kprobe *p, struct pt_regs *regs)
>  	 * possible we'd get the single step reported for an=20
> exception handler
>  	 * like Decrementer or External Interrupt */
>  	regs->msr &=3D ~MSR_EE;
> -	regs->msr |=3D MSR_SE;
> +	regs->msr |=3D MSR_SINGLESTEP;
> +#ifdef CONFIG_BOOKE
> +	regs->msr &=3D ~MSR_CE;
> +	mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) | DBCR0_IC | DBCR0_IDM);
> +#endif
>=20
>  	/*
>  	 * On powerpc we should single step on the original
> @@ -163,7 +175,8 @@ static int __kprobes=20
> kprobe_handler(struct pt_regs *regs)
>  			kprobe_opcode_t insn =3D *p->ainsn.insn;
>  			if (kcb->kprobe_status =3D=3D KPROBE_HIT_SS &&
>  					is_trap(insn)) {
> -				regs->msr &=3D ~MSR_SE;
> +				/* Turn off 'trace' bits */
> +				regs->msr &=3D ~MSR_SINGLESTEP;
>  				regs->msr |=3D kcb->kprobe_saved_msr;
>  				goto no_kprobe;
>  			}
> @@ -404,10 +417,10 @@ out:
>=20
>  	/*
>  	 * if somebody else is singlestepping across a probe point, msr
> -	 * will have SE set, in which case, continue the=20
> remaining processing
> +	 * will have DE/SE set, in which case, continue the=20
> remaining processing
>  	 * of do_debug, as if this is not a probe hit.
>  	 */
> -	if (regs->msr & MSR_SE)
> +	if (regs->msr & MSR_SINGLESTEP)
>  		return 0;
>=20
>  	return 1;
> @@ -430,7 +443,7 @@ int __kprobes kprobe_fault_handler(struct=20
> pt_regs *regs, int trapnr)
>  		 * normal page fault.
>  		 */
>  		regs->nip =3D (unsigned long)cur->addr;
> -		regs->msr &=3D ~MSR_SE;
> +		regs->msr &=3D ~MSR_SINGLESTEP; /* Turn off=20
> 'trace' bits */
>  		regs->msr |=3D kcb->kprobe_saved_msr;
>  		if (kcb->kprobe_status =3D=3D KPROBE_REENTER)
>  			restore_previous_kprobe(kcb);
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 4b5b7ff..b463d48 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -1030,21 +1030,29 @@ void SoftwareEmulation(struct pt_regs *regs)
>=20
>  #if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
>=20
> -void DebugException(struct pt_regs *regs, unsigned long debug_status)
> +void __kprobes DebugException(struct pt_regs *regs, unsigned=20
> long debug_status)
>  {
>  	if (debug_status & DBSR_IC) {	/* instruction completion */
>  		regs->msr &=3D ~MSR_DE;
> +
> +		/* Disable instruction completion */
> +		mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) & ~DBCR0_IC);
> +		/* Clear the instruction completion event */
> +		mtspr(SPRN_DBSR, DBSR_IC);
> +
> +		if (notify_die(DIE_SSTEP, "single_step", regs, 5,
> +			       5, SIGTRAP) =3D=3D NOTIFY_STOP) {
> +			return;
> +		}
> +
> +		if (debugger_sstep(regs))
> +			return;
> +
>  		if (user_mode(regs)) {
>  			current->thread.dbcr0 &=3D ~DBCR0_IC;
> -		} else {
> -			/* Disable instruction completion */
> -			mtspr(SPRN_DBCR0, mfspr(SPRN_DBCR0) &=20
> ~DBCR0_IC);
> -			/* Clear the instruction completion event */
> -			mtspr(SPRN_DBSR, DBSR_IC);
> -			if (debugger_sstep(regs))
> -				return;
>  		}
> -		_exception(SIGTRAP, regs, TRAP_TRACE, 0);
> +
> +		_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
>  	}
>  }
>  #endif /* CONFIG_4xx || CONFIG_BOOKE */
> --=20
> 1.5.5.1
>=20
>=20
>=20


-------------------------------------------------------------------
This email is confidential and intended only for the use of the =
individual or entity named above and may contain information that is =
privileged. If you are not the intended recipient, you are notified that =
any dissemination, distribution or copying of this email is strictly =
prohibited. If you have received this email in error, please notify us =
immediately by return email or telephone and destroy the original =
message. - This mail is sent via Sony Asia Pacific Mail Gateway.
-------------------------------------------------------------------
