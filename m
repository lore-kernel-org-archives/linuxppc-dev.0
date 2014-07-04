Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A3A041A0005
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 16:48:52 +1000 (EST)
Message-ID: <53B64E4D.1010802@suse.de>
Date: Fri, 04 Jul 2014 08:48:45 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [PATCH v2] powerpc/kvm: support to handle sw breakpoint
References: <1404204062-19635-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53B543C5.0@suse.de> <53B62EEE.7010804@linux.vnet.ibm.com>
In-Reply-To: <53B62EEE.7010804@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 04.07.14 06:34, Madhavan Srinivasan wrote:
> On Thursday 03 July 2014 05:21 PM, Alexander Graf wrote:
>> On 01.07.14 10:41, Madhavan Srinivasan wrote:
>>> This patch adds kernel side support for software breakpoint.
>>> Design is that, by using an illegal instruction, we trap to hypervisor
>>> via Emulation Assistance interrupt, where we check for the illegal
>>> instruction
>>> and accordingly we return to Host or Guest. Patch also adds support for
>>> software breakpoint in PR KVM.
>>>
>>> Patch mandates use of "abs" instruction as sw breakpoint instruction
>>> (primary opcode 31 and extended opcode 360). Based on PowerISA v2.01,
>>> ABS instruction has been dropped from the architecture and treated an
>>> illegal instruction.
>>>
>>> Changes v1->v2:
>>>
>>>    Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM
>>> can also share it.
>>>    Added code to use KVM get one reg infrastructure to get debug opcode.
>>>    Updated emulate.c to include emulation of debug instruction incase
>>> of PR_KVM.
>>>    Made changes to commit message.
>>>
>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> ---
>>>    arch/powerpc/include/asm/kvm_book3s.h |    8 ++++++++
>>>    arch/powerpc/include/asm/ppc-opcode.h |    5 +++++
>>>    arch/powerpc/kvm/book3s.c             |    3 ++-
>>>    arch/powerpc/kvm/book3s_hv.c          |    9 +++++++++
>>>    arch/powerpc/kvm/book3s_pr.c          |    3 +++
>>>    arch/powerpc/kvm/emulate.c            |   10 ++++++++++
>>>    6 files changed, 37 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h
>>> b/arch/powerpc/include/asm/kvm_book3s.h
>>> index f52f656..180d549 100644
>>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>>> @@ -24,6 +24,14 @@
>>>    #include <linux/kvm_host.h>
>>>    #include <asm/kvm_book3s_asm.h>
>>>    +/*
>>> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting
>>> Software Breakpoint.
>>> + * Instruction mnemonic is ABS, primary opcode is 31 and extended
>>> opcode is 360.
>>> + * Based on PowerISA v2.01, ABS instruction has been dropped from the
>>> architecture
>>> + * and treated an illegal instruction.
>>> + */
>>> +#define KVMPPC_INST_BOOK3S_DEBUG    0x7c0002d0
>> This will still break with LE guests.
>>
> I am told to try with all 0s opcode. So rewriting the patch.

The problem with "all 0s" is that it's reasonably likely to occur on 
real world code. Hence Segher was proposing something like 0x00dddd00 
which should be the same regardless of endianness, but has a certain 
appeal of intentional placement ;).

>
>>> +
>>>    struct kvmppc_bat {
>>>        u64 raw;
>>>        u32 bepi;
>>> diff --git a/arch/powerpc/include/asm/ppc-opcode.h
>>> b/arch/powerpc/include/asm/ppc-opcode.h
>>> index 3132bb9..3fbb4c1 100644
>>> --- a/arch/powerpc/include/asm/ppc-opcode.h
>>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>>> @@ -111,6 +111,11 @@
>>>    #define OP_31_XOP_LHBRX     790
>>>    #define OP_31_XOP_STHBRX    918
>>>    +/* KVMPPC_INST_BOOK3S_DEBUG -- Software breakpoint Instruction
>>> + * Instruction mnemonic is ABS, primary opcode is 31 and extended
>>> opcode is 360.
>>> + */
>>> +#define OP_31_XOP_ABS        360
>>> +
>>>    #define OP_LWZ  32
>>>    #define OP_LD   58
>>>    #define OP_LWZU 33
>>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>>> index c254c27..b40fe5d 100644
>>> --- a/arch/powerpc/kvm/book3s.c
>>> +++ b/arch/powerpc/kvm/book3s.c
>>> @@ -789,7 +789,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu
>>> *vcpu,
>>>    int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>>                        struct kvm_guest_debug *dbg)
>>>    {
>>> -    return -EINVAL;
>>> +    vcpu->guest_debug = dbg->control;
>>> +    return 0;
>>>    }
>>>      void kvmppc_decrementer_func(unsigned long data)
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
>>> index 7a12edb..402c1ec 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -725,8 +725,14 @@ static int kvmppc_handle_exit_hv(struct kvm_run
>>> *run, struct kvm_vcpu *vcpu,
>>>         * we don't emulate any guest instructions at this stage.
>>>         */
>>>        case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
>>> +    if (kvmppc_get_last_inst(vcpu) == KVMPPC_INST_BOOK3S_DEBUG ) {
>>> +        run->exit_reason = KVM_EXIT_DEBUG;
>>> +        run->debug.arch.address = kvmppc_get_pc(vcpu);
>>> +        r = RESUME_HOST;
>> Phew - why can't we just go into the normal instruction emulator for
>> EMUL_ASSIST?
>>
> IIUC, using the emulation_assist_interrupt function (kernel/trap.c) ?

I was more thinking of kvmppc_emulate_instruction() :).


Alex
