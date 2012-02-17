Return-Path: <B07421@freescale.com>
Received: from DB3EHSOBE002.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9DBC5B6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 08:56:03 +1100 (EST)
Message-ID: <4F3ECCE6.2010503@freescale.com>
Date: Fri, 17 Feb 2012 15:55:50 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 16/30] KVM: PPC: e500mc: Add doorbell emulation support
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-17-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-17-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 11:13 AM, Alexander Graf wrote:
> When one vcpu wants to kick another, it can issue a special IPI instruction
> called msgsnd. This patch emulates this instruction, its clearing counterpart
> and the infrastructure required to actually trigger that interrupt inside
> a guest vcpu.
> 
> With this patch, SMP guests on e500mc work.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/booke.c        |    6 +++
>  arch/powerpc/kvm/e500_emulate.c |   68 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 74 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
> index 3dd200d..ce1599d 100644
> --- a/arch/powerpc/kvm/booke.c
> +++ b/arch/powerpc/kvm/booke.c
> @@ -326,6 +326,9 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
>  		int_class = INT_CLASS_NONCRIT;
>  		break;
>  	case BOOKE_IRQPRIO_CRITICAL:
> +#ifdef CONFIG_KVM_E500MC
> +	case BOOKE_IRQPRIO_DBELL_CRIT:
> +#endif
>  		allowed = vcpu->arch.shared->msr & MSR_CE;
>  		allowed = allowed && !crit;
>  		msr_mask = MSR_GS | MSR_ME;
> @@ -342,6 +345,9 @@ static int kvmppc_booke_irqprio_deliver(struct kvm_vcpu *vcpu,
>  		keep_irq = true;
>  		/* fall through */
>  	case BOOKE_IRQPRIO_EXTERNAL:
> +#ifdef CONFIG_KVM_E500MC
> +	case BOOKE_IRQPRIO_DBELL:
> +#endif

This isn't e500mc specific -- it's in the ISA as "Embedded.Processor
Control".

Any harm in just removing the ifdef (similar to tlbilx)?

>  		allowed = vcpu->arch.shared->msr & MSR_EE;
>  		allowed = allowed && !crit;
>  		msr_mask = MSR_GS | MSR_CE | MSR_ME | MSR_DE;
> diff --git a/arch/powerpc/kvm/e500_emulate.c b/arch/powerpc/kvm/e500_emulate.c
> index 98b6c1c..29d5604 100644
> --- a/arch/powerpc/kvm/e500_emulate.c
> +++ b/arch/powerpc/kvm/e500_emulate.c
> @@ -14,16 +14,74 @@
>  
>  #include <asm/kvm_ppc.h>
>  #include <asm/disassemble.h>
> +#include <asm/dbell.h>
>  
>  #include "booke.h"
>  #include "e500.h"
>  
> +#define XOP_MSGSND  206
> +#define XOP_MSGCLR  238
>  #define XOP_TLBIVAX 786
>  #define XOP_TLBSX   914
>  #define XOP_TLBRE   946
>  #define XOP_TLBWE   978
>  #define XOP_TLBILX  18
>  
> +#ifdef CONFIG_KVM_E500MC
> +static int dbell2prio(ulong param)
> +{
> +	int msg = param & PPC_DBELL_TYPE(-1);

Maybe introduce PPC_DBELL_TYPE_MASK or GET_PPC_DBELL_TYPE?

> +	int prio = -1;
> +
> +	switch (msg) {
> +	case PPC_DBELL_TYPE(PPC_DBELL):
> +		prio = BOOKE_IRQPRIO_DBELL;
> +		break;
> +	case PPC_DBELL_TYPE(PPC_DBELL_CRIT):
> +		prio = BOOKE_IRQPRIO_DBELL_CRIT;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return prio;
> +}
> +
> +static int kvmppc_e500_emul_msgclr(struct kvm_vcpu *vcpu, int rb)
> +{
> +	ulong param = vcpu->arch.gpr[rb];
> +	int prio = dbell2prio(param);
> +
> +	if (prio < 0)
> +		return EMULATE_FAIL;
> +
> +	clear_bit(prio, &vcpu->arch.pending_exceptions);
> +	return EMULATE_DONE;
> +}
> +
> +static int kvmppc_e500_emul_msgsnd(struct kvm_vcpu *vcpu, int rb)
> +{
> +	ulong param = vcpu->arch.gpr[rb];
> +	int prio = dbell2prio(rb);
> +	int pir = param & 0x3fff;

Introduce PPC_DBELL_PIR_MASK or GET_PPC_DBELL_PIR?

> +	int i;
> +	struct kvm_vcpu *cvcpu;
> +
> +	if (prio < 0)
> +		return EMULATE_FAIL;
> +
> +	kvm_for_each_vcpu(i, cvcpu, vcpu->kvm) {
> +		int cpir = cvcpu->arch.shared->pir;
> +		if ((param & PPC_DBELL_MSG_BRDCAST) || (cpir == pir)) {
> +			set_bit(prio, &cvcpu->arch.pending_exceptions);
> +			kvm_vcpu_kick(cvcpu);
> +		}
> +	}

Should this be a kvm_make_request instead (with a separate
pending_doorbell bool in vcpu that msgclr can act on), considering
earlier discussion of phasing out atomics on pending_exceptions, in
favor of requests?

-Scott
