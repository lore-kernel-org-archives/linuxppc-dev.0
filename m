Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C5FCC2C00C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jan 2014 04:35:52 +1100 (EST)
Message-ID: <52E93BF2.9010500@suse.de>
Date: Wed, 29 Jan 2014 18:35:46 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 08/10] KVM: PPC: BOOK3S: PR: Add support for facility
 unavailable interrupt
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1390927455-3312-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
> At this point we allow all the supported facilities except EBB. So
> forward the interrupt to guest as illegal instruction.
>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> ---
>   arch/powerpc/include/asm/kvm_asm.h |  4 +++-
>   arch/powerpc/kvm/book3s.c          |  4 ++++
>   arch/powerpc/kvm/book3s_emulate.c  | 18 ++++++++++++++++++
>   arch/powerpc/kvm/book3s_pr.c       | 17 +++++++++++++++++
>   4 files changed, 42 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_asm.h b/arch/powerpc/include/asm/kvm_asm.h
> index 1bd92fd43cfb..799244face51 100644
> --- a/arch/powerpc/include/asm/kvm_asm.h
> +++ b/arch/powerpc/include/asm/kvm_asm.h
> @@ -99,6 +99,7 @@
>   #define BOOK3S_INTERRUPT_PERFMON	0xf00
>   #define BOOK3S_INTERRUPT_ALTIVEC	0xf20
>   #define BOOK3S_INTERRUPT_VSX		0xf40
> +#define BOOK3S_INTERRUPT_FAC_UNAVAIL    0xf60
>   
>   #define BOOK3S_IRQPRIO_SYSTEM_RESET		0
>   #define BOOK3S_IRQPRIO_DATA_SEGMENT		1
> @@ -117,7 +118,8 @@
>   #define BOOK3S_IRQPRIO_DECREMENTER		14
>   #define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	15
>   #define BOOK3S_IRQPRIO_EXTERNAL_LEVEL		16
> -#define BOOK3S_IRQPRIO_MAX			17
> +#define BOOK3S_IRQPRIO_FAC_UNAVAIL		17
> +#define BOOK3S_IRQPRIO_MAX			18
>   
>   #define BOOK3S_HFLAG_DCBZ32			0x1
>   #define BOOK3S_HFLAG_SLB			0x2
> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
> index 8912608b7e1b..a9aea28c2677 100644
> --- a/arch/powerpc/kvm/book3s.c
> +++ b/arch/powerpc/kvm/book3s.c
> @@ -143,6 +143,7 @@ static int kvmppc_book3s_vec2irqprio(unsigned int vec)
>   	case 0xd00: prio = BOOK3S_IRQPRIO_DEBUG;		break;
>   	case 0xf20: prio = BOOK3S_IRQPRIO_ALTIVEC;		break;
>   	case 0xf40: prio = BOOK3S_IRQPRIO_VSX;			break;
> +	case 0xf60: prio = BOOK3S_IRQPRIO_FAC_UNAVAIL;		break;
>   	default:    prio = BOOK3S_IRQPRIO_MAX;			break;
>   	}
>   
> @@ -273,6 +274,9 @@ int kvmppc_book3s_irqprio_deliver(struct kvm_vcpu *vcpu, unsigned int priority)
>   	case BOOK3S_IRQPRIO_PERFORMANCE_MONITOR:
>   		vec = BOOK3S_INTERRUPT_PERFMON;
>   		break;
> +	case BOOK3S_IRQPRIO_FAC_UNAVAIL:
> +		vec = BOOK3S_INTERRUPT_FAC_UNAVAIL;
> +		break;
>   	default:
>   		deliver = 0;
>   		printk(KERN_ERR "KVM: Unknown interrupt: 0x%x\n", priority);
> diff --git a/arch/powerpc/kvm/book3s_emulate.c b/arch/powerpc/kvm/book3s_emulate.c
> index 60d0b6b745e7..bf6b11021250 100644
> --- a/arch/powerpc/kvm/book3s_emulate.c
> +++ b/arch/powerpc/kvm/book3s_emulate.c
> @@ -481,6 +481,15 @@ int kvmppc_core_emulate_mtspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong spr_val)
>   		vcpu->arch.shadow_fscr = vcpu->arch.fscr & host_fscr;
>   		break;
>   	}
> +	case SPRN_EBBHR:
> +		vcpu->arch.ebbhr = spr_val;
> +		break;
> +	case SPRN_EBBRR:
> +		vcpu->arch.ebbrr = spr_val;
> +		break;
> +	case SPRN_BESCR:
> +		vcpu->arch.bescr = spr_val;
> +		break;
>   unprivileged:
>   	default:
>   		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
> @@ -607,6 +616,15 @@ int kvmppc_core_emulate_mfspr_pr(struct kvm_vcpu *vcpu, int sprn, ulong *spr_val
>   	case SPRN_FSCR:
>   		*spr_val = vcpu->arch.fscr;
>   		break;
> +	case SPRN_EBBHR:
> +		*spr_val = vcpu->arch.ebbhr;
> +		break;
> +	case SPRN_EBBRR:
> +		*spr_val = vcpu->arch.ebbrr;
> +		break;
> +	case SPRN_BESCR:
> +		*spr_val = vcpu->arch.bescr;
> +		break;
>   	default:
>   unprivileged:
>   		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
> index 51d469f8c9fd..828056ec208f 100644
> --- a/arch/powerpc/kvm/book3s_pr.c
> +++ b/arch/powerpc/kvm/book3s_pr.c
> @@ -900,6 +900,23 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>   	case BOOK3S_INTERRUPT_PERFMON:
>   		r = RESUME_GUEST;
>   		break;
> +	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
> +	{
> +		/*
> +		 * Check for the facility that need to be emulated
> +		 */
> +		ulong fscr_ic = vcpu->arch.shadow_fscr >> 56;
> +		if (fscr_ic != FSCR_EBB_LG) {
> +			/*
> +			 * We only disable EBB facility.
> +			 * So only emulate that.

I don't understand the comment. We emulate nothing at all here. We either
     - hit an EBB unavailable in which case we send the guest an illegal 
instruction interrupt or we
     - hit another facility interrupt in which case we forward the 
interrupt to the guest, but not the interrupt cause (fscr_ic).

I think the EBB case should be explicit:

   /* We don't allow EBB inside the guest, so something must have gone 
terribly wrong */
   if (fscr_ic == FSCR_EBB_LG)
     BUG();

   vcpu->arch.fscr &= ~FSCR_IC_MASK;
   vcpu->arch.fscr |= vcpu->arch.shadow_fscr & FSCR_IC_MASK;
   kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
   r = RESUME_GUEST;
   break;


Alex

> +			 */
> +			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
> +			r = RESUME_GUEST;
> +			break;
> +		}
> +		/* Fall through */
> +	}
>   	case BOOK3S_INTERRUPT_PROGRAM:
>   	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
>   	{
