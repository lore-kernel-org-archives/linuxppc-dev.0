Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02173DE00F
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 06:50:30 +1100 (EST)
In-Reply-To: <Pine.LNX.4.64.0612080205420.16331@gate.crashing.org>
References: <20061206215042.GA13675@ld0162-tx32.am.freescale.net>
	<17783.16290.783728.708434@cargo.ozlabs.ibm.com>
	<4CF47E53-356C-49B7-9F8B-9C61CF8103E5@kernel.crashing.org>
	<17784.59774.968517.908414@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.64.0612080205420.16331@gate.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <814DD34A-38B9-4C16-9153-55A663422D65@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH/RFC] Change the program check exception from EXC_XFER_STD
	to EXC_XFER_EE.
Date: Fri, 26 Jan 2007 13:49:18 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 2:07 AM, Kumar Gala wrote:

> On Fri, 8 Dec 2006, Paul Mackerras wrote:
>
>> Kumar Gala writes:
>>
>>> We don't need to rearrange anything, just put the local_irq_enable()
>>> call in do_mathemu().  If we are a debugger than REASON_TRAP will
>>> have to be set and we dont bother with do_mathemu() than.
>>>
>>> Do you think we should also move the local_irq_enable() that exists
>>> in the handler into emulate_instruction().
>>
>> I'd rather have the local_irq_enable() calls in
>> program_check_exception() so they're all in one place, preferably  
>> with
>> a comment explaining why they're there.  Having an unpaired
>> local_irq_enable in do_mathemu() would seem a bit weird to me.
>
> Ok, how about something like this, I'm a bit concerned about what  
> effect
> moving the do_mathemu call will have on things like the 405.
>
> I'll put this in my tree with some other cleanup patches if it  
> looks ok.
>
> - k

We never closed on this.

- k

> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index fde820e..63073f9 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -792,9 +792,12 @@ #ifdef CONFIG_MATH_EMULATION
>   	 * hardware people - not sure if it can happen on any illegal
>   	 * instruction or only on FP instructions, whether there is a
>   	 * pattern to occurences etc. -dgibson 31/Mar/2003 */
> -	if (!(reason & REASON_TRAP) && do_mathemu(regs) == 0) {
> -		emulate_single_step(regs);
> -		return;
> +	if (!(reason & REASON_TRAP)) {
> +		local_irq_enable();
> +		if (do_mathemu(regs) == 0) {
> +			emulate_single_step(regs);
> +			return;
> +		}
>   	}
>   #endif /* CONFIG_MATH_EMULATION */
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
