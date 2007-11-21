Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E499ADDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Nov 2007 01:22:32 +1100 (EST)
Message-Id: <7D40FA9E-A972-4995-85AE-3CE2551BB195@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Date: Wed, 21 Nov 2007 08:22:24 -0600
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
	<B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
	<Pine.LNX.4.62.0711211407260.12720@pademelon.sonytel.be>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 21, 2007, at 7:09 AM, Geert Uytterhoeven wrote:

> On Tue, 20 Nov 2007, Kumar Gala wrote:
>> On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:
>>> On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
>>>> isel (Integer Select) is a new user space instruction in the
>>>> PowerISA 2.04 spec.  Not all processors implement it so lets  
>>>> emulate
>>>> to ensure code built with isel will run everywhere.
>>>
>>> Given that the instruction is meant to be a performance enhancement,
>>> we should probably warn the first few times it's emulated, so the  
>>> user
>>> knows they should change their toolchain setup if possible.
>>
>> The same is true of mcrxr, popcntb, and possibly string ld/st.
>>
>> Feel free to submit a patch that warns about their usage.
>
> Something like this?
>
> Probably we also want it for:
>
>  - arch/powerpc/kernel/align.c
>      o emulate_dcbz()
>      o emulate_multiple()
>      o emulate_fp_pair()
>      o emulate_spe()
>
>  - arch/powerpc/kernel/softemu8xx.c
>      o Soft_emulate_8xx()
>
>  - arch/powerpc/kernel/traps.c
>      o SoftwareEmulation()

You missed math_emu.

>   - arch/powerpc/kernel/vecemu.c
>      o emulate_altivec()

I'm not sure I would concern this one emulation, there isn't much you  
can do about the denorm fixup.

How about some per processor counters in sysfs under the processor.

> Question: do we want it for emulate_single_step(), too?

What do you mean, we should could the emulation, the emulate single  
step just is for handling if you are doing debug while hitting an  
emulated insn.

> So far my Debian userland didn't trigger any of them on the PS3, I  
> had to
> write an explicit test ;-)
> ---
> arch/powerpc/kernel/traps.c |   19 +++++++++++++++++--
> 1 files changed, 17 insertions(+), 2 deletions(-)
>
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -707,6 +707,14 @@ static int emulate_popcntb_inst(struct p
> 	return 0;
> }
>
> +#define WARN_EMULATE(type)						\
> +	do {								\
> +	    static unsigned int count;					\
> +	    if (count++ < 10)						\
> +		    pr_warning("%s used emulated %s instruction\n",	\
> +			       current->comm, type);			\
> +	} while (0)
> +
> static int emulate_instruction(struct pt_regs *regs)
> {
> 	u32 instword;
> @@ -721,31 +729,38 @@ static int emulate_instruction(struct pt
>
> 	/* Emulate the mfspr rD, PVR. */
> 	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
> +		WARN_EMULATE("mfpvr");
> 		rd = (instword >> 21) & 0x1f;
> 		regs->gpr[rd] = mfspr(SPRN_PVR);
> 		return 0;
> 	}
>
> 	/* Emulating the dcba insn is just a no-op.  */
> -	if ((instword & INST_DCBA_MASK) == INST_DCBA)
> +	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
> +		WARN_EMULATE("dcba");
> 		return 0;
> +	}
>
> 	/* Emulate the mcrxr insn.  */
> 	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
> 		int shift = (instword >> 21) & 0x1c;
> 		unsigned long msk = 0xf0000000UL >> shift;
>
> +		WARN_EMULATE("mcrxr");
> 		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
> 		regs->xer &= ~0xf0000000UL;
> 		return 0;
> 	}
>
> 	/* Emulate load/store string insn. */
> -	if ((instword & INST_STRING_GEN_MASK) == INST_STRING)
> +	if ((instword & INST_STRING_GEN_MASK) == INST_STRING) {
> +		WARN_EMULATE("string");
> 		return emulate_string_inst(regs, instword);
> +	}
>
> 	/* Emulate the popcntb (Population Count Bytes) instruction. */
> 	if ((instword & INST_POPCNTB_MASK) == INST_POPCNTB) {
> +		WARN_EMULATE("popcntb");
> 		return emulate_popcntb_inst(regs, instword);
> 	}
>

This looks good as a start.

- k
