Return-Path: <lvivier@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yrZ8W0srbzDrbY
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Dec 2017 19:06:51 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/xive: store server for masked interrupt in
 kvmppc_xive_set_xive()
To: Paul Mackerras <paulus@ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Sam Bobroff <sbobroff@redhat.com>
References: <20171123090633.873-1-lvivier@redhat.com>
 <1511469493.2466.47.camel@kernel.crashing.org>
 <20171205030512.daghjczlensy7252@rohan>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <04b2c33d-f080-83d0-229c-77bb70eced4a@redhat.com>
Date: Tue, 5 Dec 2017 09:06:46 +0100
MIME-Version: 1.0
In-Reply-To: <20171205030512.daghjczlensy7252@rohan>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/12/2017 04:05, Paul Mackerras wrote:
> On Fri, Nov 24, 2017 at 07:38:13AM +1100, Benjamin Herrenschmidt wrote:
>> On Thu, 2017-11-23 at 10:06 +0100, Laurent Vivier wrote:
>>> This is needed to map kvmppc_xive_set_xive() behavior
>>> to kvmppc_xics_set_xive().
>>>
>>> As we store the server, kvmppc_xive_get_xive() can return
>>> the good value and we can also allow kvmppc_xive_int_on().
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>> ---
>>>  arch/powerpc/kvm/book3s_xive.c | 20 ++++++++------------
>>>  1 file changed, 8 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
>>> index bf457843e032..2781b8733038 100644
>>> --- a/arch/powerpc/kvm/book3s_xive.c
>>> +++ b/arch/powerpc/kvm/book3s_xive.c
>>> @@ -584,10 +584,14 @@ int kvmppc_xive_set_xive(struct kvm *kvm, u32 irq, u32 server,
>>>  	 *       we could initialize interrupts with valid default
>>>  	 */
>>>  
>>> -	if (new_act_prio != MASKED &&
>>> -	    (state->act_server != server ||
>>> -	     state->act_priority != new_act_prio))
>>> -		rc = xive_target_interrupt(kvm, state, server, new_act_prio);
>>> +	if (state->act_server != server ||
>>> +	    state->act_priority != new_act_prio) {
>>> +		if (new_act_prio != MASKED)
>>> +			rc = xive_target_interrupt(kvm, state, server,
>>> +						   new_act_prio);
>>> +		if (!rc)
>>> +			state->act_server = server;
>>> +	}
>>
>> That leads to another problem with this code. My current implementation
>> is such that is a target queue is full, it will pick another target.
>> But here, we still update act_server to the passed-in server and
>> not the actual target...
> 
> So does that amount to a NAK?
> 
>>>  	/*
>>>  	 * Perform the final unmasking of the interrupt source
>>> @@ -646,14 +650,6 @@ int kvmppc_xive_int_on(struct kvm *kvm, u32 irq)
>>>  
>>>  	pr_devel("int_on(irq=0x%x)\n", irq);
>>>  
>>> -	/*
>>> -	 * Check if interrupt was not targetted
>>> -	 */
>>> -	if (state->act_priority == MASKED) {
>>> -		pr_devel("int_on on untargetted interrupt\n");
>>> -		return -EINVAL;
>>> -	}
>>> -
>>
>> So my thinking here was that act_priority was never going to be MASKED
>> except if the interrupt had never been targetted anywhere at machine
>> startup time. Thus if act_priority is masked, the act_server field
>> cannot be trusted.
>>
>>>  	/* If saved_priority is 0xff, do nothing */
>>>  	if (state->saved_priority == MASKED)
>>>  		return 0;
> 
> How do you think this should be fixed?
> 
> Laurent, are you reworking the patch at the moment?

Not for the moment.

The easy way is to forbid to set interrupt value to the MASKED one with
xive_set_xive. I think it's allowed by the specs.

I've got another bug in the XICS emulation: when we migrate a guest
under stress, the pending interrupt is lost and the guest hangs on the
destination side. I'm trying to understand why.

Thanks,
Laurent
