Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4B8901A00D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Aug 2014 22:15:50 +1000 (EST)
Message-ID: <53EA0572.1070806@suse.de>
Date: Tue, 12 Aug 2014 14:15:46 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v3] powerpc/kvm: support to handle sw breakpoint
References: <1406868643-26291-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53E87023.6080200@suse.de> <1407747061.4508.75.camel@pasglop>
 <53E889BA.40108@suse.de> <53E9A383.5060009@linux.vnet.ibm.com>
 <53E9F824.9080906@suse.de> <53E9FBF6.5010008@linux.vnet.ibm.com>
In-Reply-To: <53E9FBF6.5010008@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 12.08.14 13:35, Madhavan Srinivasan wrote:
> On Tuesday 12 August 2014 04:49 PM, Alexander Graf wrote:
>> On 12.08.14 07:17, Madhavan Srinivasan wrote:
>>> On Monday 11 August 2014 02:45 PM, Alexander Graf wrote:
>>>> On 11.08.14 10:51, Benjamin Herrenschmidt wrote:
>>>>> On Mon, 2014-08-11 at 09:26 +0200, Alexander Graf wrote:
>>>>>>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>>>>>>> index da86d9b..d95014e 100644
>>>>>>> --- a/arch/powerpc/kvm/emulate.c
>>>>>>> +++ b/arch/powerpc/kvm/emulate.c
>>>>>> This should be book3s_emulate.c.
>>>>> Any reason we can't make that 00dddd00 opcode as breakpoint common to
>>>>> all powerpc variants ?
>>>> I can't think of a good reason. We use a hypercall on booke (which traps
>>>> into an illegal instruction for pr) today, but I don't think it has to
>>>> be that way.
>>>>
>>>> Given that the user space API allows us to change it dynamically, there
>>>> should be nothing blocking us from going with 00dddd00 always.
>>>>
>>> Kindly correct me if i am wrong. So we can still have a common code in
>>> emulate.c to set the env for both HV and pr incase of illegal
>>> instruction (i will rebase latest src). But suggestion here to use
>>> 00dddd00, in that case current path in embed is kvmppc_handle_exit
>>> (booke.c) -> BOOKE_INTERRUPT_HV_PRIV -> emulation_exit ->
>>> kvmppc_emulate_instruction, will change to kvmppc_handle_exit (booke.c)
>>> -> BOOKE_INTERRUPT_PROGRAM -> if debug instr call emulation_exit else
>>> send to guest?
>> I can't follow your description above.
>>
> My bad.
>
>> With the latest git version HV KVM does not include emulate.c anymore.
>>
>> Also, it would make a lot of sense of have the same soft breakpoint
>> instruction across all ppc targets, so it would make sense to change it
>> to 0x00dddd00 for booke as well.
>>
> Got it. Was describing the current control flow with respect to booke
> and where changes needed (for same software breakpoint inst). This is
> for my understanding and wanted verify.
>
> kvmppc_handle_exit(booke.c)
> 	-> BOOKE_INTERRUPT_HV_PRIV
> 		-> emulation_exit
> 			->kvmppc_emulate_instruction
>
> Incase of using the same software breakpoint instruction (0x00dddd00),
> then we need to add code in booke something like this
>
> kvmppc_handle_exit (booke.c)
> 	-> BOOKE_INTERRUPT_PROGRAM
> 		->	if debug instr
> 				->emulation_exit
> 			else
> 				->send to guest?

Bleks. I see your point. I guess you need something like this for booke:

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 074b7fc..1fdeee0 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -876,6 +876,11 @@ int kvmppc_handle_exit(struct kvm_run *run, struct 
kvm_vcpu *vcpu,
      case BOOKE_INTERRUPT_HV_PRIV:
          emulated = kvmppc_get_last_inst(vcpu, false, &last_inst);
          break;
+    case BOOKE_INTERRUPT_PROGRAM:
+        /* SW breakpoints arrive as illegal instructions on HV */
+        if (vcpu->guest_debug & KVM_GUESTDBG_USE_SW_BP)
+            emulated = kvmppc_get_last_inst(vcpu, false, &last_inst);
+        break;
      default:
          break;
      }
@@ -953,7 +958,8 @@ int kvmppc_handle_exit(struct kvm_run *run, struct 
kvm_vcpu *vcpu,
          break;

      case BOOKE_INTERRUPT_PROGRAM:
-        if (vcpu->arch.shared->msr & (MSR_PR | MSR_GS)) {
+        if ((vcpu->arch.shared->msr & (MSR_PR | MSR_GS)) &&
+            (last_inst != KVMPPC_INST_SOFT_BREAKPOINT)) {
              /*
               * Program traps generated by user-level software must
               * be handled by the guest kernel.



> 				
>> Basically you would have handling code in emulate.c and book3s_hv.c at
>> the end of the day.
>>
> Yes. Will resend the patch with updated code.

Thanks,


Alex
