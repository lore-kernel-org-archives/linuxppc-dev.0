Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8rfk1tH7zDqCJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 20:54:06 +1000 (AEST)
Subject: Re: [PATCH] kvm-pr: manage illegal instructions
To: Laurent Vivier <lvivier@redhat.com>, Alexander Graf <agraf@suse.de>
References: <1458073117-24652-1-git-send-email-lvivier@redhat.com>
 <57330AFE.1050209@suse.de> <a2700de4-623a-cae4-028b-8fe0aa82f75c@redhat.com>
 <57331C3F.2000708@suse.de> <e370a7ad-8306-20a9-09e9-99e6a9b0573c@redhat.com>
 <57344C7E.5010202@suse.de> <374d3217-cf6c-fa2e-d24a-e9ee8b1f4534@redhat.com>
 <3f99bce1-6fb7-b81d-26ca-24f1ca426c3e@redhat.com> <573AD836.4090006@suse.de>
 <ab2e59a1-fb2d-287a-e974-864a44ffe652@redhat.com>
 <573C4165.4080909@redhat.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gleb Natapov <gleb@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Paolo Bonzini <pbonzini@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
From: Thomas Huth <thuth@redhat.com>
Message-ID: <573C49C7.1060804@redhat.com>
Date: Wed, 18 May 2016 12:53:59 +0200
MIME-Version: 1.0
In-Reply-To: <573C4165.4080909@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 18.05.2016 12:18, Thomas Huth wrote:
> On 17.05.2016 19:49, Laurent Vivier wrote:
>>
>>
>> On 17/05/2016 10:37, Alexander Graf wrote:
>>> On 05/17/2016 10:35 AM, Laurent Vivier wrote:
>>>>
>>>> On 12/05/2016 16:23, Laurent Vivier wrote:
>>>>>
>>>>> On 12/05/2016 11:27, Alexander Graf wrote:
>>>>>> On 05/12/2016 11:10 AM, Laurent Vivier wrote:
>>>>>>> On 11/05/2016 13:49, Alexander Graf wrote:
>>>>>>>> On 05/11/2016 01:14 PM, Laurent Vivier wrote:
>>>>>>>>> On 11/05/2016 12:35, Alexander Graf wrote:
>>>>>>>>>> On 03/15/2016 09:18 PM, Laurent Vivier wrote:
>>>>>>>>>>> While writing some instruction tests for kvm-unit-tests for
>>>>>>>>>>> powerpc,
>>>>>>>>>>> I've found that illegal instructions are not managed correctly
>>>>>>>>>>> with
>>>>>>>>>>> kvm-pr,
>>>>>>>>>>> while it is fine with kvm-hv.
>>>>>>>>>>>
>>>>>>>>>>> When an illegal instruction (like ".long 0") is processed by
>>>>>>>>>>> kvm-pr,
>>>>>>>>>>> the kernel logs are filled with:
>>>>>>>>>>>
>>>>>>>>>>>          Couldn't emulate instruction 0x00000000 (op 0 xop 0)
>>>>>>>>>>>          kvmppc_handle_exit_pr: emulation at 700 failed (00000000)
>>>>>>>>>>>
>>>>>>>>>>> While the exception handler receives an interrupt for each
>>>>>>>>>>> instruction
>>>>>>>>>>> executed after the illegal instruction.
>>>>>>>>>>>
>>>>>>>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>      arch/powerpc/kvm/book3s_emulate.c | 4 +++-
>>>>>>>>>>>      1 file changed, 3 insertions(+), 1 deletion(-)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/arch/powerpc/kvm/book3s_emulate.c
>>>>>>>>>>> b/arch/powerpc/kvm/book3s_emulate.c
>>>>>>>>>>> index 2afdb9c..4ee969d 100644
>>>>>>>>>>> --- a/arch/powerpc/kvm/book3s_emulate.c
>>>>>>>>>>> +++ b/arch/powerpc/kvm/book3s_emulate.c
>>>>>>>>>>> @@ -99,7 +99,6 @@ int kvmppc_core_emulate_op_pr(struct kvm_run
>>>>>>>>>>> *run,
>>>>>>>>>>> struct kvm_vcpu *vcpu,
>>>>>>>>>>>            switch (get_op(inst)) {
>>>>>>>>>>>          case 0:
>>>>>>>>>>> -        emulated = EMULATE_FAIL;
>>>>>>>>>>>              if ((kvmppc_get_msr(vcpu) & MSR_LE) &&
>>>>>>>>>>>                  (inst == swab32(inst_sc))) {
>>>>>>>>>>>                  /*
>>>>>>>>>>> @@ -112,6 +111,9 @@ int kvmppc_core_emulate_op_pr(struct kvm_run
>>>>>>>>>>> *run,
>>>>>>>>>>> struct kvm_vcpu *vcpu,
>>>>>>>>>>>                  kvmppc_set_gpr(vcpu, 3, EV_UNIMPLEMENTED);
>>>>>>>>>>>                  kvmppc_set_pc(vcpu, kvmppc_get_pc(vcpu) + 4);
>>>>>>>>>>>                  emulated = EMULATE_DONE;
>>>>>>>>>>> +        } else {
>>>>>>>>>>> +            kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>>>>>>>>>> But isn't that exactly what the semantic of EMULATE_FAIL is?
>>>>>>>>>> Fixing it
>>>>>>>>>> up in book3s_emulate.c is definitely the wrong spot.
>>>>>>>>>>
>>>>>>>>>> So what is the problem you're trying to solve? Is the SRR0 at the
>>>>>>>>>> wrong
>>>>>>>>>> spot or are the log messages the problem?
>>>>>>>>> No, the problem is the host kernel logs are filled by the message
>>>>>>>>> and
>>>>>>>>> the execution hangs. And the host becomes unresponsiveness, even
>>>>>>>>> after
>>>>>>>>> the end of the tests.
>>>>>>>>>
>>>>>>>>> Please, try to run kvm-unit-tests (the emulator test) on a KVM-PR
>>>>>>>>> host,
>>>>>>>>> and check the kernel logs (dmesg), then try to ssh to the host...
>>>>>>>> Ok, so the log messages are the problem. Please fix the message
>>>>>>>> output
>>>>>>>> then - or remove it altogether. Or if you like, create a module
>>>>>>>> parameter that allows you to emit them.
>>>>>>>>
>>>>>>>> I personally think the best solution would be to just convert the
>>>>>>>> message into a trace point.
>>>>>>>>
>>>>>>>> While at it, please see whether the guest can trigger similar host
>>>>>>>> log
>>>>>>>> output excess in other code paths.
>>>>>>> The problem is not really with the log messages: they are
>>>>>>> consequence of
>>>>>>> the bug I try to fix.
>>>>>>>
>>>>>>> What happens is once kvm_pr decodes an invalid instruction all the
>>>>>>> valid
>>>>>>> following instructions trigger a Program exception to the guest
>>>>>>> (but are
>>>>>>> executed correctly). It has no real consequence on big machine like
>>>>>>> POWER8, except that the guest become very slow and the log files of
>>>>>>> the
>>>>>>> host are filled with messages (and qemu uses 100% of the CPU). On a
>>>>>>> smaller machine like a  PowerMac G5, the machine becomes simply
>>>>>>> unusable.
>>>>>> It's probably more related to your verbosity level of kernel messages.
>>>>>> If you pass loglevel=0 (or quiet) to you kernel cmdline you won't get
>>>>>> the messages printed to serial which is what's slowing you down.
>>>>>>
>>>>>> The other problem sounds pretty severe, but the only thing your patch
>>>>>> does any different from the current code flow would be the patch below.
>>>>>> Or did I miss anything?
>>>>>>
>>>>>> diff --git a/arch/powerpc/kvm/emulate.c b/arch/powerpc/kvm/emulate.c
>>>>>> index 5cc2e7a..4672bc2 100644
>>>>>> --- a/arch/powerpc/kvm/emulate.c
>>>>>> +++ b/arch/powerpc/kvm/emulate.c
>>>>>> @@ -302,7 +302,11 @@ int kvmppc_emulate_instruction(struct kvm_run
>>>>>> *run,
>>>>>> struct kvm_vcpu *vcpu)
>>>>>>                          advance = 0;
>>>>>>                          printk(KERN_ERR "Couldn't emulate instruction
>>>>>> 0x%08x "
>>>>>>                                 "(op %d xop %d)\n", inst, get_op(inst),
>>>>>> get_xop(inst));
>>>>>> +#ifdef CONFIG_PPC_BOOK3S
>>>>>> +                       kvmppc_core_queue_program(vcpu, SRR1_PROGILL);
>>>>>> +#else
>>>>>>                          kvmppc_core_queue_program(vcpu, 0);
>>>>>> +#endif
>>>>>>                  }
>>>>>>          }
>>>>>>
>>>> Do you want I send an updated patch with your changes?
>>>
>>> Well, you reported the issue and narrowed it down, so feel free to send
>>> it under your name :). I merely simplified your patch a bit.
>>
>> Well, while I was trying to update the patch, I've re-tested this... and
>> it fails. I don't know what I'm doing bad now or what I did bad before
>> but it seems it doesn't work. :(
>>
>> Thomas, could try the patch from Alex?
> 
> The patch from Alex also does not work for me.

I've now had a closer look at the code, and I think the endless loop is
caused by the fact that we try to inject a program interrupt twice here.

In kvmppc_handle_exit_pr(), the code flow looks like this:

	case BOOK3S_INTERRUPT_H_EMUL_ASSIST:
	{
		...
		er = kvmppc_emulate_instruction(run, vcpu);
		switch (er) {
			...
		case EMULATE_FAIL:
			printk(KERN_CRIT "%s: emulation at %lx failed (%08x)\n",
			       __func__, kvmppc_get_pc(vcpu), last_inst);
			kvmppc_core_queue_program(vcpu, flags);
			printk(KERN_CRIT "%s: pc = %lx \n",
			       __func__, kvmppc_get_pc(vcpu));
			r = RESUME_GUEST;
			break;
		...
	}

But when you look at the end of kvmppc_emulate_instruction(), you
can see that the interrupt has also already been injected there:

	if (emulated == EMULATE_FAIL) {
		emulated = vcpu->kvm->arch.kvm_ops->emulate_op(run, vcpu, inst,
							       &advance);
		if (emulated == EMULATE_AGAIN) {
			advance = 0;
		} else if (emulated == EMULATE_FAIL) {
			advance = 0;
			printk(KERN_ERR "Couldn't emulate instruction 0x%08x "
			       "(op %d xop %d)\n", inst, get_op(inst), get_xop(inst));
			kvmppc_core_queue_program(vcpu, 0);
		}
	}

Injecting the program interrupt twice of course destroys the
return address in SRR0, causing this strange behavior.
If I comment out the kvmppc_core_queue_program() in
kvmppc_emulate_instruction(), the endless loop is gone.

 Thomas
