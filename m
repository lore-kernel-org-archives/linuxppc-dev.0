Return-Path: <carlos@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id DA0A12C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 03:03:18 +1100 (EST)
Message-ID: <528E2EB6.2010003@redhat.com>
Date: Thu, 21 Nov 2013 11:03:02 -0500
From: "Carlos O'Donell" <carlos@redhat.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/signals: Mark VSX not saved with small contexts
References: <1384924734-16722-1-git-send-email-mikey@neuling.org>
 <20131121113333.GB15913@concordia>
In-Reply-To: <20131121113333.GB15913@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Steve Best <sbest@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/21/2013 06:33 AM, Michael Ellerman wrote:
> On Wed, Nov 20, 2013 at 04:18:54PM +1100, Michael Neuling wrote:
>> The VSX MSR bit in the user context indicates if the context contains VSX
>> state.  Currently we set this when the process has touched VSX at any stage.
>>
>> Unfortunately, if the user has not provided enough space to save the VSX state,
>> we can't save it but we currently still set the MSR VSX bit.
>>
>> This patch changes this to clear the MSR VSX bit when the user doesn't provide
>> enough space.  This indicates that there is no valid VSX state in the user
>> context.
>>
>> This is needed to support get/set/make/swapcontext for applications that use
>> VSX but only provide a small context.  For example, getcontext in glibc
>> provides a smaller context since the VSX registers don't need to be saved over
>> the glibc function call.  But since the program calling getcontext may have
>> used VSX, the kernel currently says the VSX state is valid when it's not.  If
>> the returned context is then used in setcontext (ie. a small context without
>> VSX but with MSR VSX set), the kernel will refuse the context.  This situation
>> has been reported by the glibc community.
> 
> Broken since forever?

Yes, broken since forever. At least it was known in glibc 2.18 that this was
broken, but without an active distribution using it the defect wasn't analyzed.

>> Tested-by: Haren Myneni <haren@linux.vnet.ibm.com>
>> Signed-off-by: Michael Neuling <mikey@neuling.org>
>> Cc: stable@vger.kernel.org
>> ---
>>  arch/powerpc/kernel/signal_32.c | 10 +++++++++-
> 
> What about the 64-bit code? I don't know the code but it appears at a glance to
> have the same bug.
 
It doesn't happen with 64-bit code because there the context contains
a sigcontext which on ppc64 has vmx_reserve to store the entire VMX
state. Therefore 64-bit ppc always has space to store the VMX registers
in a userspace context switch. It is only the 32-bit ppc ABI that lacks
the space.
 
>> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
>> index 749778e..1844298 100644
>> --- a/arch/powerpc/kernel/signal_32.c
>> +++ b/arch/powerpc/kernel/signal_32.c
>> @@ -457,7 +457,15 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
>>  		if (copy_vsx_to_user(&frame->mc_vsregs, current))
>>  			return 1;
>>  		msr |= MSR_VSX;
>> -	}
>> +	} else if (!ctx_has_vsx_region)
>> +		/*
>> +		 * With a small context structure we can't hold the VSX
>> +		 * registers, hence clear the MSR value to indicate the state
>> +		 * was not saved.
>> +		 */
>> +		msr &= ~MSR_VSX;
> 
> I think it'd be clearer if this was just the else case. The full context is:
> 
>     if (current->thread.used_vsr && ctx_has_vsx_region) {
>             __giveup_vsx(current);
>             if (copy_vsx_to_user(&frame->mc_vsregs, current))
>                     return 1;
>             msr |= MSR_VSX;
> +   } else if (!ctx_has_vsx_region)
> +           /*
> +            * With a small context structure we can't hold the VSX
> +            * registers, hence clear the MSR value to indicate the state
> +            * was not saved.
> +            */
> +           msr &= ~MSR_VSX;
> 
> Which means if current->thread.user_vsr and ctx_has_vsx_region are both false
> we potentially leave MSR_VSX set in msr. I think it should be the case that
> MSR_VSX is only ever set if current->thread.used_vsr is true, so it should be
> OK in pratice, but it seems unnecessarily fragile.

If current->thread.user_vsr and ctx_has_vsx_region are both false then
!ctx_has_vsx_region is true and we clear MSR_VSX.

Perhaps you mean if current->thread.user_vsr is false, but ctx_has_vsx_region
is true? 

Previously the else clause reset MSR_VSX if:
1. current->thread.used_vsr == 0 && ctx_has_vsx_region == 0
2. current->thread.used_vsr == 1 && ctx_has_vsx_region == 0,

Now it resets MSR_VSX additionally for:
3. current->thread.used_vsr == 0 && ctx_has_vsx_region == 1,

3. is a valid state. The task has not touched the VSX state and the context
is large enough to be saved into. This may be a future state for ppc32 if 
we adjust the ABI to have a large enough context buffer. However at present 
it's not a plausible state. It's also a "don't care" state since there is 
nothing saved in the context, and if nothing was saved in the context then
MSR_VSX is not set.
 
> The logic should be "if we write VSX we set MSR_VSX, else we clear MSR_VSX", ie:
> 
>     if (current->thread.used_vsr && ctx_has_vsx_region) {
>             __giveup_vsx(current);
>             if (copy_vsx_to_user(&frame->mc_vsregs, current))
>                     return 1;
>             msr |= MSR_VSX;
>     } else
>             msr &= ~MSR_VSX;

If anything I dislike this because it might mask a bug in earlier code that
might erroneously set MSR_VSX even though current->thread.user_vsr is not
true. If anything the extra state 3. covered here is a buggy state.

I agree that your suggestion is more robust though since the definition of
robustness is to operate despite failures.

Cheers,
Carlos.
