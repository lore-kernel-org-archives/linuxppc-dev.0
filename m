Return-Path: <carlos@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 41CEA2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Nov 2013 11:53:14 +1100 (EST)
Message-ID: <528EAAEE.8070300@redhat.com>
Date: Thu, 21 Nov 2013 19:53:02 -0500
From: "Carlos O'Donell" <carlos@redhat.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/signals: Mark VSX not saved with small contexts
References: <1384924734-16722-1-git-send-email-mikey@neuling.org>
 <20131121113333.GB15913@concordia> <528E2EB6.2010003@redhat.com>
 <8900.1385072483@ale.ozlabs.ibm.com>
In-Reply-To: <8900.1385072483@ale.ozlabs.ibm.com>
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

On 11/21/2013 05:21 PM, Michael Neuling wrote:
>>> What about the 64-bit code? I don't know the code but it appears at a glance to
>>> have the same bug.
>>  
>> It doesn't happen with 64-bit code because there the context contains
>> a sigcontext which on ppc64 has vmx_reserve to store the entire VMX
>> state. Therefore 64-bit ppc always has space to store the VMX registers
>> in a userspace context switch. It is only the 32-bit ppc ABI that lacks
>> the space.
> 
> VMX?  I don't understand this at all.  We extended the ucontext to
> handle the extra VSX state, so older code may still be using the small
> ucontext and we already have a bunch of checks in the 64bit case for
> this.
> 
> I agree with Michael, we should add this to the 64 bit case.  If we
> can't put VSX state in, then clear MSR VSX.

Sorry, typo, VSX not VMX.

I had not gone through the historical implementation of the 64-bit
code, I assumed it started with a sufficiently sized context structure,
but on closer review it didn't.

The addition of the *context functions in glibc for 64-bit power
happened in 2003 by glibc commit 609b4783, with the mcontext_t
being expanded to include 

I see that the 64-bit userspace context was extended in 2008 by your 
kernel commit ce48b210.

Thus you're right the check is needed in the 64-bit case.

However, at present the issue doesn't seem to trigger in the
64-bit userspace. Which is odd now that I review the code and 
see that the 64-bit userspace context is smaller than the kernel
context (lacks the `+32' to the vmx_reserve space). It could just
be that the compiler finds no chance to use VSX and therefore
the existing test cases don't trigger the bug. I don't plan to
investigate this further given that we're going to fix the 64-bit case
also.
 
> So how about we make it that simple and put it independent of the other
> if statement?
> 
> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 749778e..f4a7fd4 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -458,6 +458,14 @@ static int save_user_regs(struct pt_regs *regs, struct mcon
>                         return 1;
>                 msr |= MSR_VSX;
>         }
> +       /*
> +        * With a small context structure we can't hold the VSX registers,
> +        * hence clear the MSR value to indicate the state was not saved.
> +        */
> +       if (!ctx_has_vsx_region)
> +               msr &= ~MSR_VSX;
> +
> +
>  #endif /* CONFIG_VSX */
>  #ifdef CONFIG_SPE
>         /* save spe registers */
> 

Looks good to me, along with a similar fix for signal_64.c.

Cheers,
Carlos.
