Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 942E4B6F98
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Feb 2012 22:49:52 +1100 (EST)
Subject: Re: [PATCH 16/30] KVM: PPC: e500mc: Add doorbell emulation support
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <4F3ECCE6.2010503@freescale.com>
Date: Mon, 20 Feb 2012 12:49:46 +0100
Message-Id: <6925C0C5-A8BD-4252-9B92-0612D52BBDDA@suse.de>
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-17-git-send-email-agraf@suse.de>
 <4F3ECCE6.2010503@freescale.com>
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


On 17.02.2012, at 22:55, Scott Wood wrote:

> On 02/17/2012 11:13 AM, Alexander Graf wrote:
>> When one vcpu wants to kick another, it can issue a special IPI =
instruction
>> called msgsnd. This patch emulates this instruction, its clearing =
counterpart
>> and the infrastructure required to actually trigger that interrupt =
inside
>> a guest vcpu.
>>=20
>> With this patch, SMP guests on e500mc work.
>>=20
>> Signed-off-by: Alexander Graf <agraf@suse.de>
>> ---
>> arch/powerpc/kvm/booke.c        |    6 +++
>> arch/powerpc/kvm/e500_emulate.c |   68 =
+++++++++++++++++++++++++++++++++++++++
>> 2 files changed, 74 insertions(+), 0 deletions(-)
>>=20
>> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
>> index 3dd200d..ce1599d 100644
>> --- a/arch/powerpc/kvm/booke.c
>> +++ b/arch/powerpc/kvm/booke.c
>> @@ -326,6 +326,9 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
>> 		int_class =3D INT_CLASS_NONCRIT;
>> 		break;
>> 	case BOOKE_IRQPRIO_CRITICAL:
>> +#ifdef CONFIG_KVM_E500MC
>> +	case BOOKE_IRQPRIO_DBELL_CRIT:
>> +#endif
>> 		allowed =3D vcpu->arch.shared->msr & MSR_CE;
>> 		allowed =3D allowed && !crit;
>> 		msr_mask =3D MSR_GS | MSR_ME;
>> @@ -342,6 +345,9 @@ static int kvmppc_booke_irqprio_deliver(struct =
kvm_vcpu *vcpu,
>> 		keep_irq =3D true;
>> 		/* fall through */
>> 	case BOOKE_IRQPRIO_EXTERNAL:
>> +#ifdef CONFIG_KVM_E500MC
>> +	case BOOKE_IRQPRIO_DBELL:
>> +#endif
>=20
> This isn't e500mc specific -- it's in the ISA as "Embedded.Processor
> Control".
>=20
> Any harm in just removing the ifdef (similar to tlbilx)?

Well, to me this is more of an indication "this should become a runtime =
check one day" in case we want to combine the two targets. On e500v2, we =
don't know what a doorbell interrupt is, so we really shouldn't be =
delivering one either.

>=20
>> 		allowed =3D vcpu->arch.shared->msr & MSR_EE;
>> 		allowed =3D allowed && !crit;
>> 		msr_mask =3D MSR_GS | MSR_CE | MSR_ME | MSR_DE;
>> diff --git a/arch/powerpc/kvm/e500_emulate.c =
b/arch/powerpc/kvm/e500_emulate.c
>> index 98b6c1c..29d5604 100644
>> --- a/arch/powerpc/kvm/e500_emulate.c
>> +++ b/arch/powerpc/kvm/e500_emulate.c
>> @@ -14,16 +14,74 @@
>>=20
>> #include <asm/kvm_ppc.h>
>> #include <asm/disassemble.h>
>> +#include <asm/dbell.h>
>>=20
>> #include "booke.h"
>> #include "e500.h"
>>=20
>> +#define XOP_MSGSND  206
>> +#define XOP_MSGCLR  238
>> #define XOP_TLBIVAX 786
>> #define XOP_TLBSX   914
>> #define XOP_TLBRE   946
>> #define XOP_TLBWE   978
>> #define XOP_TLBILX  18
>>=20
>> +#ifdef CONFIG_KVM_E500MC
>> +static int dbell2prio(ulong param)
>> +{
>> +	int msg =3D param & PPC_DBELL_TYPE(-1);
>=20
> Maybe introduce PPC_DBELL_TYPE_MASK or GET_PPC_DBELL_TYPE?

TYPE_MASK I'd say.

>=20
>> +	int prio =3D -1;
>> +
>> +	switch (msg) {
>> +	case PPC_DBELL_TYPE(PPC_DBELL):
>> +		prio =3D BOOKE_IRQPRIO_DBELL;
>> +		break;
>> +	case PPC_DBELL_TYPE(PPC_DBELL_CRIT):
>> +		prio =3D BOOKE_IRQPRIO_DBELL_CRIT;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +
>> +	return prio;
>> +}
>> +
>> +static int kvmppc_e500_emul_msgclr(struct kvm_vcpu *vcpu, int rb)
>> +{
>> +	ulong param =3D vcpu->arch.gpr[rb];
>> +	int prio =3D dbell2prio(param);
>> +
>> +	if (prio < 0)
>> +		return EMULATE_FAIL;
>> +
>> +	clear_bit(prio, &vcpu->arch.pending_exceptions);
>> +	return EMULATE_DONE;
>> +}
>> +
>> +static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
>> +{
>> +	ulong param =3D vcpu->arch.gpr[rb];
>> +	int prio =3D dbell2prio(rb);
>> +	int pir =3D param & 0x3fff;
>=20
> Introduce PPC_DBELL_PIR_MASK or GET_PPC_DBELL_PIR?

Good point :)

>=20
>> +	int i;
>> +	struct kvm_vcpu *cvcpu;
>> +
>> +	if (prio < 0)
>> +		return EMULATE_FAIL;
>> +
>> +	kvm_for_each_vcpu(i, cvcpu, vcpu->kvm) {
>> +		int cpir =3D cvcpu->arch.shared->pir;
>> +		if ((param & PPC_DBELL_MSG_BRDCAST) || (cpir =3D=3D =
pir)) {
>> +			set_bit(prio, &cvcpu->arch.pending_exceptions);
>> +			kvm_vcpu_kick(cvcpu);
>> +		}
>> +	}
>=20
> Should this be a kvm_make_request instead (with a separate
> pending_doorbell bool in vcpu that msgclr can act on), considering
> earlier discussion of phasing out atomics on pending_exceptions, in
> favor of requests?

Yeah, I was thinking about that too, but right now we already have some =
direct use of pending_exceptions in different places around the code. So =
today, that is our public interface.

I'd rather go in and clean up the whole thing to make pending_exceptions =
private in a separate cleanup round, rather than having it part of =
e500mc support.


Alex
