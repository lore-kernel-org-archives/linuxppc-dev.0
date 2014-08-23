Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 427D71A003C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Aug 2014 22:24:21 +1000 (EST)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v4] powerpc/kvm: support to handle sw breakpoint
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <53F86A4A.6080303@linux.vnet.ibm.com>
Date: Sat, 23 Aug 2014 14:24:13 +0200
Message-Id: <A4C9CB9E-F3FA-453B-ABC9-5070F9A6B8CA@suse.de>
References: <1408513929-5267-1-git-send-email-maddy@linux.vnet.ibm.com>
 <53F5B77D.3000007@suse.de> <53F86A4A.6080303@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "paulus@samba.org" <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> Am 23.08.2014 um 12:17 schrieb Madhavan Srinivasan <maddy@linux.vnet.ibm.c=
om>:
>=20
>> On Thursday 21 August 2014 02:40 PM, Alexander Graf wrote:
>>=20
>>=20
>>> On 20.08.14 07:52, Madhavan Srinivasan wrote:
>>> This patch adds kernel side support for software breakpoint.
>>> Design is that, by using an illegal instruction, we trap to hypervisor
>>> via Emulation Assistance interrupt, where we check for the illegal instr=
uction
>>> and accordingly we return to Host or Guest. Patch also adds support for
>>> software breakpoint in PR KVM.
>>>=20
>>> Changes v3->v4:
>>> Made changes to code comments and removed #define of zero opcode
>>> Added a new function to handle the debug instruction emulation in book3s=
_hv
>>> Rebased the code to latest upstream source.
>>>=20
>>> Changes v2->v3:
>>> Changed the debug instructions. Using the all zero opcode in the instruc=
tion word
>>>  as illegal instruction as mentioned in Power ISA instead of ABS
>>> Removed reg updated in emulation assist and added a call to
>>>  kvmppc_emulate_instruction for reg update.
>>>=20
>>> Changes v1->v2:
>>>=20
>>> Moved the debug instruction #def to kvm_book3s.h. This way PR_KVM can al=
so share it.
>>> Added code to use KVM get one reg infrastructure to get debug opcode.
>>> Updated emulate.c to include emulation of debug instruction incase of PR=
_KVM.
>>> Made changes to commit message.
>>>=20
>>> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
>>> ---
>>> arch/powerpc/include/asm/kvm_book3s.h |  7 +++++++
>>> arch/powerpc/kvm/book3s.c             |  3 ++-
>>> arch/powerpc/kvm/book3s_hv.c          | 32 +++++++++++++++++++++++++++++=
+--
>>> arch/powerpc/kvm/book3s_pr.c          |  3 +++
>>> arch/powerpc/kvm/emulate.c            | 11 +++++++++++
>>> 5 files changed, 53 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/arch/powerpc/include/asm/kvm_book3s.h b/arch/powerpc/includ=
e/asm/kvm_book3s.h
>>> index 6acf0c2..a1944f8 100644
>>> --- a/arch/powerpc/include/asm/kvm_book3s.h
>>> +++ b/arch/powerpc/include/asm/kvm_book3s.h
>>> @@ -24,6 +24,13 @@
>>> #include <linux/kvm_host.h>
>>> #include <asm/kvm_book3s_asm.h>
>>>=20
>>> +/*
>>> + * KVMPPC_INST_BOOK3S_DEBUG is debug Instruction for supporting Softwar=
e Breakpoint.
>>> + * Based on PowerISA v2.07, Instruction with primary opcode 0 will be t=
reated as illegal
>>> + * instruction.
>>> + */
>>> +#define KVMPPC_INST_BOOK3S_DEBUG    0x00dddd00
>>=20
>> Please change the BookE version of this as well, put the define in a
>> common header and use a non book specific name.
>=20
> I first wanted to get the server side in and then take up this, but i
> can do it with this, just concerned incase of booke testing :(

I can test, no problem. You can at least do compile tests on your side alrea=
dy ;)

>=20
>>> +
>>> struct kvmppc_bat {
>>>    u64 raw;
>>>    u32 bepi;
>>> diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
>>> index dd03f6b..00e9c9f 100644
>>> --- a/arch/powerpc/kvm/book3s.c
>>> +++ b/arch/powerpc/kvm/book3s.c
>>> @@ -778,7 +778,8 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *v=
cpu,
>>> int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
>>>                    struct kvm_guest_debug *dbg)
>>> {
>>> -    return -EINVAL;
>>> +    vcpu->guest_debug =3D dbg->control;
>>> +    return 0;
>>> }
>>>=20
>>> void kvmppc_decrementer_func(unsigned long data)
>>> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c=

>>> index 27cced9..0a92e45 100644
>>> --- a/arch/powerpc/kvm/book3s_hv.c
>>> +++ b/arch/powerpc/kvm/book3s_hv.c
>>> @@ -725,6 +725,14 @@ static int kvmppc_hcall_impl_hv(unsigned long cmd)
>>>    return kvmppc_hcall_impl_hv_realmode(cmd);
>>> }
>>>=20
>>> +static int kvmppc_emulate_debug_instruction_hv(struct kvm_run *run,
>>> +                    struct kvm_vcpu *vcpu)
>>> +{
>>> +    run->exit_reason =3D KVM_EXIT_DEBUG;
>>> +    run->debug.arch.address =3D kvmppc_get_pc(vcpu);
>>> +    return 0;
>>> +}
>>> +
>>> static int kvmppc_handle_exit_hv(struct kvm_run *run, struct kvm_vcpu *v=
cpu,
>>>                 struct task_struct *tsk)
>>> {
>>> @@ -811,9 +819,26 @@ static int kvmppc_handle_exit_hv(struct kvm_run *ru=
n, struct kvm_vcpu *vcpu,
>>>     * we don't emulate any guest instructions at this stage.
>>=20
>> This comment is no longer true, it should get changed.
>=20
> Will change it.
>=20
>>>     */
>>>    case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
>>> -        kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>>> -        r =3D RESUME_GUEST;
>>> +    {
>>> +        u32 last_inst;
>>> +        if(kvmppc_get_last_inst(vcpu, INST_GENERIC, &last_inst) !=3D
>>> +                    EMULATE_DONE) {
>>=20
>> Please only do this if debugging is active.
>=20
> Ok sure. But i will add in the else part of the check. Since we do the
> instruction check there.

We should only fetch the instruction if sw breakpoint debugging is active.

Alex
