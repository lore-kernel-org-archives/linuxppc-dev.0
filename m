Return-Path: <thuth@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhBLR6NwGzDq6v
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Apr 2016 17:44:31 +1000 (AEST)
Subject: Re: [PATCH] kvm-pr: manage single-step mode
To: Laurent Vivier <lvivier@redhat.com>, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
References: <1458658428-19566-1-git-send-email-lvivier@redhat.com>
 <57074E45.4040204@redhat.com> <5707569B.1000704@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@suse.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, dgibson@redhat.com
From: Thomas Huth <thuth@redhat.com>
Message-ID: <57076159.70504@redhat.com>
Date: Fri, 8 Apr 2016 09:44:25 +0200
MIME-Version: 1.0
In-Reply-To: <5707569B.1000704@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08.04.2016 08:58, Laurent Vivier wrote:
> 
> 
> On 08/04/2016 08:23, Thomas Huth wrote:
>> On 22.03.2016 15:53, Laurent Vivier wrote:
>>> Until now, when we connect gdb to the QEMU gdb-server, the
>>> single-step mode is not managed.
>>>
>>> This patch adds this, only for kvm-pr:
>>>
>>> If KVM_GUESTDBG_SINGLESTEP is set, we enable single-step trace bit in the
>>> MSR (MSR_SE) just before the __kvmppc_vcpu_run(), and disable it just after.
>>> In kvmppc_handle_exit_pr, instead of routing the interrupt to
>>> the guest, we return to host, with KVM_EXIT_DEBUG reason.
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  arch/powerpc/kvm/book3s_pr.c | 31 +++++++++++++++++++++++++++++--
>>>  1 file changed, 29 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
>>> index 95bceca..e6896f4 100644
>>> --- a/arch/powerpc/kvm/book3s_pr.c
>>> +++ b/arch/powerpc/kvm/book3s_pr.c
>>> @@ -882,6 +882,24 @@ void kvmppc_set_fscr(struct kvm_vcpu *vcpu, u64 fscr)
>>>  }
>>>  #endif
>>>  
>>> +static void kvmppc_setup_debug(struct kvm_vcpu *vcpu)
>>> +{
>>> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
>>> +		u64 msr = kvmppc_get_msr(vcpu);
>>> +
>>> +		kvmppc_set_msr(vcpu, msr | MSR_SE);
>>> +	}
>>> +}
>>> +
>>> +static void kvmppc_clear_debug(struct kvm_vcpu *vcpu)
>>> +{
>>> +	if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
>>> +		u64 msr = kvmppc_get_msr(vcpu);
>>> +
>>> +		kvmppc_set_msr(vcpu, msr & ~MSR_SE);
>>> +	}
>>> +}
>>> +
>>>  int kvmppc_handle_exit_pr(struct kvm_run *run, struct kvm_vcpu *vcpu,
>>>  			  unsigned int exit_nr)
>>>  {
>>> @@ -1208,8 +1226,13 @@ program_interrupt:
>>>  #endif
>>>  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
>>>  	case BOOK3S_INTERRUPT_TRACE:
>>> -		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
>>> -		r = RESUME_GUEST;
>>> +		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
>>> +			run->exit_reason = KVM_EXIT_DEBUG;
>>> +			r = RESUME_HOST;
>>> +		} else {
>>> +			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
>>> +			r = RESUME_GUEST;
>>> +		}
>>
>> Should the new code rather be limited to the BOOK3S_INTERRUPT_TRACE case
>> only? I mean, this way, you never can deliver a machine check interrupt
>> to the guest if singlestep debugging is enabled on the host, can you?
> 
> You're right but it adds complexity and it would be only useful to
> single-step the single-step mode of the guest.
> 
> It's hard to imagine a developer single-stepping the guest kernel while
> he is single-stepping a user application in the guest.

Hmm, not sure whether you've got me right ;-) I rather meant: What
happens when a machine check is supposed to happen in the guest while
single stepping is enabled at the host level? IMHO it would be better to
shape the code like this:

  	case BOOK3S_INTERRUPT_MACHINE_CHECK:
		kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
		r = RESUME_GUEST;
		break;
	case BOOK3S_INTERRUPT_TRACE:
		if (vcpu->guest_debug & KVM_GUESTDBG_SINGLESTEP) {
			run->exit_reason = KVM_EXIT_DEBUG;
			r = RESUME_HOST;
		} else {
			kvmppc_book3s_queue_irqprio(vcpu, exit_nr);
			r = RESUME_GUEST;
		}

That means, split the two cases, to keep the old behavior for the
MACHINE_CHECK case. That's also not too much of additional complexity,
is it?

 Thomas
