Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher ADH-CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DB89E2C00CE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 23:02:19 +1100 (EST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.1 \(1827\))
Subject: Re: [RFC PATCH 08/10] KVM: PPC: BOOK3S: PR: Add support for facility
 unavailable interrupt
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <87lhxwjs60.fsf@linux.vnet.ibm.com>
Date: Fri, 31 Jan 2014 13:02:19 +0100
Message-Id: <D1124BDB-BC6A-4822-A7D6-63A19F4E82D6@suse.de>
References: <1390927455-3312-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1390927455-3312-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <52E93BF2.9010500@suse.de> <87lhxwjs60.fsf@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc <kvm-ppc@vger.kernel.org>, kvm-devel <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 31.01.2014, at 12:40, Aneesh Kumar K.V =
<aneesh.kumar@linux.vnet.ibm.com> wrote:

> Alexander Graf <agraf@suse.de> writes:
>=20
>> On 01/28/2014 05:44 PM, Aneesh Kumar K.V wrote:
>>> At this point we allow all the supported facilities except EBB. So
>>> forward the interrupt to guest as illegal instruction.
>>>=20
>>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/kvm_asm.h |  4 +++-
>>>  arch/powerpc/kvm/book3s.c          |  4 ++++
>>>  arch/powerpc/kvm/book3s_emulate.c  | 18 ++++++++++++++++++
>>>  arch/powerpc/kvm/book3s_pr.c       | 17 +++++++++++++++++
>>>  4 files changed, 42 insertions(+), 1 deletion(-)
>>>=20
>>> diff --git a/arch/powerpc/include/asm/kvm_asm.h =
b/arch/powerpc/include/asm/kvm_asm.h
>>> index 1bd92fd43cfb..799244face51 100644
>>> --- a/arch/powerpc/include/asm/kvm_asm.h
>>> +++ b/arch/powerpc/include/asm/kvm_asm.h
>>> @@ -99,6 +99,7 @@
>>>  #define BOOK3S_INTERRUPT_PERFMON	0xf00
>>>  #define BOOK3S_INTERRUPT_ALTIVEC	0xf20
>>>  #define BOOK3S_INTERRUPT_VSX		0xf40
>>> +#define BOOK3S_INTERRUPT_FAC_UNAVAIL    0xf60
>>>=20
>>>  #define BOOK3S_IRQPRIO_SYSTEM_RESET		0
>>>  #define BOOK3S_IRQPRIO_DATA_SEGMENT		1
>>> @@ -117,7 +118,8 @@
>>>  #define BOOK3S_IRQPRIO_DECREMENTER		14
>>>  #define BOOK3S_IRQPRIO_PERFORMANCE_MONITOR	15
>>>  #define BOOK3S_IRQPRIO_EXTERNAL_LEVEL		16
>>> -#define BOOK3S_IRQPRIO_MAX			17
>>> +#define BOOK3S_IRQPRIO_FAC_UNAVAIL		17
>>> +#define BOOK3S_IRQPRIO_MAX			18
>>>=20
>>>  #define BOOK3S_HFLAG_DCBZ32			0x1
>>>  #define BOOK3S_HFLAG_SLB			0x2
>>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>>> index 8912608b7e1b..a9aea28c2677 100644
>>> --- a/arch/powerpc/kvm/book3s.c
>>> +++ b/arch/powerpc/kvm/book3s.c
>>> @@ -143,6 +143,7 @@ static int kvmppc_book3s_vec2irqprio(unsigned =
int vec)
>>>  	case 0xd00: prio =3D BOOK3S_IRQPRIO_DEBUG;		break;
>>>  	case 0xf20: prio =3D BOOK3S_IRQPRIO_ALTIVEC;		break;
>>>  	case 0xf40: prio =3D BOOK3S_IRQPRIO_VSX;			=
break;
>>> +	case 0xf60: prio =3D BOOK3S_IRQPRIO_FAC_UNAVAIL;		=
break;
>>>  	default:    prio =3D BOOK3S_IRQPRIO_MAX;			=
break;
>>>  	}
>>>=20
>>> @@ -273,6 +274,9 @@ int kvmppc_book3s_irqprio_deliver(struct =
kvm_vcpu *vcpu, unsigned int priority)
>>>  	case BOOK3S_IRQPRIO_PERFORMANCE_MONITOR:
>>>  		vec =3D BOOK3S_INTERRUPT_PERFMON;
>>>  		break;
>>> +	case BOOK3S_IRQPRIO_FAC_UNAVAIL:
>>> +		vec =3D BOOK3S_INTERRUPT_FAC_UNAVAIL;
>>> +		break;
>>>  	default:
>>>  		deliver =3D 0;
>>>  		printk(KERN_ERR "KVM: Unknown interrupt: 0x%x\n", =
priority);
>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c =
b/arch/powerpc/kvm/book3s_emulate.c
>>> index 60d0b6b745e7..bf6b11021250 100644
>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>> @@ -481,6 +481,15 @@ int kvmppc_core_emulate_mtspr_pr(struct =
kvm_vcpu *vcpu, int sprn, ulong spr_val)
>>>  		vcpu->arch.shadow_fscr =3D vcpu->arch.fscr & host_fscr;
>>>  		break;
>>>  	}
>>> +	case SPRN_EBBHR:
>>> +		vcpu->arch.ebbhr =3D spr_val;
>>> +		break;
>>> +	case SPRN_EBBRR:
>>> +		vcpu->arch.ebbrr =3D spr_val;
>>> +		break;
>>> +	case SPRN_BESCR:
>>> +		vcpu->arch.bescr =3D spr_val;
>>> +		break;
>>>  unprivileged:
>>>  	default:
>>>  		printk(KERN_INFO "KVM: invalid SPR write: %d\n", sprn);
>>> @@ -607,6 +616,15 @@ int kvmppc_core_emulate_mfspr_pr(struct =
kvm_vcpu *vcpu, int sprn, ulong *spr_val
>>>  	case SPRN_FSCR:
>>>  		*spr_val =3D vcpu->arch.fscr;
>>>  		break;
>>> +	case SPRN_EBBHR:
>>> +		*spr_val =3D vcpu->arch.ebbhr;
>>> +		break;
>>> +	case SPRN_EBBRR:
>>> +		*spr_val =3D vcpu->arch.ebbrr;
>>> +		break;
>>> +	case SPRN_BESCR:
>>> +		*spr_val =3D vcpu->arch.bescr;
>>> +		break;
>>>  	default:
>>>  unprivileged:
>>>  		printk(KERN_INFO "KVM: invalid SPR read: %d\n", sprn);
>>> diff --git a/arch/powerpc/kvm/book3s_pr.c =
b/arch/powerpc/kvm/book3s_pr.c
>>> index 51d469f8c9fd..828056ec208f 100644
>>> --- a/arch/powerpc/kvm/book3s_pr.c
>>> +++ b/arch/powerpc/kvm/book3s_pr.c
>>> @@ -900,6 +900,23 @@ int kvmppc_handle_exit_pr(struct kvm_run *run, =
struct kvm_vcpu *vcpu,
>>>  	case BOOK3S_INTERRUPT_PERFMON:
>>>  		r =3D RESUME_GUEST;
>>>  		break;
>>> +	case BOOK3S_INTERRUPT_FAC_UNAVAIL:
>>> +	{
>>> +		/*
>>> +		 * Check for the facility that need to be emulated
>>> +		 */
>>> +		ulong fscr_ic =3D vcpu->arch.shadow_fscr >> 56;
>>> +		if (fscr_ic !=3D FSCR_EBB_LG) {
>>> +			/*
>>> +			 * We only disable EBB facility.
>>> +			 * So only emulate that.
>>=20
>> I don't understand the comment. We emulate nothing at all here. We =
either
>>     - hit an EBB unavailable in which case we send the guest an =
illegal=20
>> instruction interrupt or we
>>     - hit another facility interrupt in which case we forward the=20
>> interrupt to the guest, but not the interrupt cause (fscr_ic).
>>=20
>=20
> What i wanted to achive was, enable both TAR and DSCR and disable
> EBB. The reason to disable EBB was, we are still not clear how to =
handle
> PMU details in PR. Now with FSCR carrying that value, we would get
> facility unavailable interrupt when we try to mfspr/mtspr few EBB
> related registers. The PR guest kernel do that on context switch
> (_switch). Now what we do here is to fallthrough and handle that via
> emulate mtspr/mfspr.
>=20
> If we get facility unavailable interrupt due to any other reason, that
> means PR guest has explicitly disabled that facility. Hence we forward
> that as facility unavailable interrupt to guest allowing PR guest to
> handle that.=20

Please adjust the comment accordingly. =46rom the code flow that is very =
unclear. "Disable" means we don't allow the guest to access EBB. You do =
want to allow the guest to use a fake version of EBB by emulating the =
facility unavailable interrupt.

if (fscr_ic =3D=3D FSCR_EBB_LG) {
  /*
   * We filtered EBB out of FSCR so that we get traps whenever the guest =
is trying to
   * access EBB registers. Thanks to that we can now emulate these =
instructions and
   * expose a virtual (no-op) ebb facility to the guest
   */
  <call instruction emulation>
} else {
  /* forward interrupt to the guest */
}


Alex

>=20
>=20
>> I think the EBB case should be explicit:
>>=20
>>   /* We don't allow EBB inside the guest, so something must have gone=20=

>> terribly wrong */
>>   if (fscr_ic =3D=3D FSCR_EBB_LG)
>>     BUG();
>>=20
>=20
> Instead of BUG, we do handle few mfspr/mtspr via emulate which we are
> mostly ignoring. For event based branch instruction, the emulation =
will
> fail and we will send 0x700(interrupt program) to PR guest right ?
>=20
>=20
>>   vcpu->arch.fscr &=3D ~FSCR_IC_MASK;
>>   vcpu->arch.fscr |=3D vcpu->arch.shadow_fscr & FSCR_IC_MASK;
>>   kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
>>   r =3D RESUME_GUEST;
>>   break;
>>=20
>=20
> -aneesh
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe kvm-ppc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
