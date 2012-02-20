Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 53673B6FA4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Feb 2012 00:17:28 +1100 (EST)
Subject: Re: [PATCH 24/30] KVM: PPC: booke: call resched after every exit
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3EDC01.5000400@freescale.com>
Date: Mon, 20 Feb 2012 14:17:22 +0100
Message-Id: <4B831F36-4BEB-4BDF-869D-117617B4EE44@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-25-git-send-email-agraf@suse.de>
 <4F3EDC01.5000400@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 18.02.2012, at 00:00, Scott Wood wrote:

> On 02/17/2012 11:13 AM, Alexander Graf wrote:
>> Instead of checking whether we should reschedule only when we exited
>> due to an interrupt, let's always check before entering the guest =
back
>> again. This gets the target more in line with the other archs.
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/kvm/booke.c |   15 ++++++++++-----
>> 1 files changed, 10 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index bfb2092..de30b6d 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -572,6 +572,7 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>>                        unsigned int exit_nr)
>> {
>> 	int r =3D RESUME_HOST;
>> +	int resched_needed =3D 1;
>>=20
>> 	/* update before a new last_exit_type is rewritten */
>> 	kvmppc_update_timing_stats(vcpu);
>> @@ -602,25 +603,21 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>>=20
>> 	switch (exit_nr) {
>> 	case BOOKE_INTERRUPT_MACHINE_CHECK:
>> -		kvm_resched(vcpu);
>> 		r =3D RESUME_GUEST;
>> 		break;
>>=20
>> 	case BOOKE_INTERRUPT_EXTERNAL:
>> 		kvmppc_account_exit(vcpu, EXT_INTR_EXITS);
>> -		kvm_resched(vcpu);
>> 		r =3D RESUME_GUEST;
>> 		break;
>>=20
>> 	case BOOKE_INTERRUPT_DECREMENTER:
>> 		kvmppc_account_exit(vcpu, DEC_EXITS);
>> -		kvm_resched(vcpu);
>> 		r =3D RESUME_GUEST;
>> 		break;
>>=20
>> 	case BOOKE_INTERRUPT_DOORBELL:
>> 		kvmppc_account_exit(vcpu, DBELL_EXITS);
>> -		kvm_resched(vcpu);
>> 		r =3D RESUME_GUEST;
>> 		break;
>>=20
>> @@ -869,8 +866,16 @@ int kvmppc_handle_exit(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>> 		BUG();
>> 	}
>>=20
>> -	local_irq_disable();
>> +	/* make sure we reschedule if we need to */
>> +	while (resched_needed) {
>> +		local_irq_disable();
>>=20
>> +		resched_needed =3D need_resched();
>> +		if (resched_needed) {
>> +			local_irq_enable();
>> +			cond_resched();
>> +		}
>> +	}
>> 	kvmppc_core_prepare_to_enter(vcpu);
>>=20
>> 	if (!(r & RESUME_HOST)) {
>=20
> kvmppc_core_prepare_to_enter can enable interrupts (and block) if =
guest
> MSR_WE is set.  We may take an interrupt that wants a resched after
> waking but before interrupts are disabled again.
>=20
> We also want to check for a resched in kvmppc_vcpu_run.  So, the =
resched
> check belongs in kvmppc_core_prepare_to_enter, something like:
>=20
> /* Check pending exceptions and deliver one, if possible. */
> void kvmppc_core_prepare_to_enter(struct kvm_vcpu *vcpu)
> {
> 	WARN_ON_ONCE(!irqs_disabled());
>=20
> 	while (true) {
> 		if (signal_pending(current))
> 			break;
>=20
> 		if (need_resched()) {
> 			local_irq_enable();
> 			cond_resched();
> 			local_irq_disable();
> 			continue;
> 		}
>=20
> 		kvmppc_core_check_exceptions(vcpu);
>=20
> 		if (vcpu->arch.shared->msr & MSR_WE) {
> 			local_irq_enable();
> 			kvm_vcpu_block(vcpu);
> 			local_irq_disable();
> =09
> 			kvmppc_set_exit_type(vcpu,
> 				EMULATED_MTMSRWE_EXITS);
> 			continue;
> 		}
>=20
> 		break;
> 	}
> }
>=20
> It would be simpler (both here and in the idle hcall) if we could just
> drop support for CONFIG_PREEMPT=3Dn. :-P

When running with CONFIG_PREEMPT=3Dn we don't have to worry about =
interrupts being enabled though, since we only preempt on known good =
checkpoints, right? While for CONFIG_PREEMPT=3Dy we can always get =
preempted, rendering most of these checks void.

So essentially we could just be lazy and do a "best effort" resched =
check, but not worry about races wrt guest entry/exit, right? And for =
real preemption modes we don't have to worry about any of the resched =
stuff IIUC, correct?


Alex
