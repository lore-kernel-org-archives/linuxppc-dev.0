Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r56fh3PfszDqCm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 19:11:06 +1000 (AEST)
Subject: Re: [PATCH] kvm-pr: manage illegal instructions
To: Alexander Graf <agraf@suse.de>, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
References: <1458073117-24652-1-git-send-email-lvivier@redhat.com>
 <57330AFE.1050209@suse.de> <a2700de4-623a-cae4-028b-8fe0aa82f75c@redhat.com>
 <57331C3F.2000708@suse.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gleb Natapov <gleb@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <e370a7ad-8306-20a9-09e9-99e6a9b0573c@redhat.com>
Date: Thu, 12 May 2016 11:10:27 +0200
MIME-Version: 1.0
In-Reply-To: <57331C3F.2000708@suse.de>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 11/05/2016 13:49, Alexander Graf wrote:
> On 05/11/2016 01:14 PM, Laurent Vivier wrote:
>>
>> On 11/05/2016 12:35, Alexander Graf wrote:
>>> On 03/15/2016 09:18 PM, Laurent Vivier wrote:
>>>> While writing some instruction tests for kvm-unit-tests for powerpc,
>>>> I've found that illegal instructions are not managed correctly with
>>>> kvm-pr,
>>>> while it is fine with kvm-hv.
>>>>
>>>> When an illegal instruction (like ".long 0") is processed by kvm-pr,
>>>> the kernel logs are filled with:
>>>>
>>>>        Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>>>>        kvmppc_handle_exit_pr: emulation at 700 failed (00000000)
>>>>
>>>> While the exception handler receives an interrupt for each instruction
>>>> executed after the illegal instruction.
>>>>
>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>> ---
>>>>    arch/powerpc/kvm/book3s_emulate.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c
>>>> b/arch/powerpc/kvm/book3s_emulate.c
>>>> index 2afdb9c..4ee969d 100644
>>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>>> @@ -99,7 +99,6 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run,
>>>> struct kvm_vcpu *vcpu,
>>>>          switch (get_op(inst)) {
>>>>        case 0:
>>>> -        emulated = EMULATE_FAIL;
>>>>            if ((kvmppc_get_msr(vcpu) & MSR_LE) &&
>>>>                (inst == swab32(inst_sc))) {
>>>>                /*
>>>> @@ -112,6 +111,9 @@ int kvmppc_core_emulate_op_pr(struct kvm_run *run,
>>>> struct kvm_vcpu *vcpu,
>>>>                kvmppc_set_gpr(vcpu, 3, EV_UNIMPLEMENTED);
>>>>                kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
>>>>                emulated = EMULATE_DONE;
>>>> +        } else {
>>>> +            kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>>> But isn't that exactly what the semantic of EMULATE_FAIL is? Fixing it
>>> up in book3s_emulate.c is definitely the wrong spot.
>>>
>>> So what is the problem you're trying to solve? Is the SRR0 at the wrong
>>> spot or are the log messages the problem?
>> No, the problem is the host kernel logs are filled by the message and
>> the execution hangs. And the host becomes unresponsiveness, even after
>> the end of the tests.
>>
>> Please, try to run kvm-unit-tests (the emulator test) on a KVM-PR host,
>> and check the kernel logs (dmesg), then try to ssh to the host...
> 
> Ok, so the log messages are the problem. Please fix the message output
> then - or remove it altogether. Or if you like, create a module
> parameter that allows you to emit them.
> 
> I personally think the best solution would be to just convert the
> message into a trace point.
> 
> While at it, please see whether the guest can trigger similar host log
> output excess in other code paths.

The problem is not really with the log messages: they are consequence of
the bug I try to fix.

What happens is once kvm_pr decodes an invalid instruction all the valid
following instructions trigger a Program exception to the guest (but are
executed correctly). It has no real consequence on big machine like
POWER8, except that the guest become very slow and the log files of the
host are filled with messages (and qemu uses 100% of the CPU). On a
smaller machine like a  PowerMac G5, the machine becomes simply unusable.

Please try kvm-unit-tests to see what happens:

qemu-system-ppc64 -machine pseries,accel=kvm,kvm-type=PR -bios
powerpc/boot_rom.bin -display none -serial stdio -kernel
powerpc/emulator.elf -smp 1 --append "-v"


Thanks,
Laurent
