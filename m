Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F2FA21A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 21:19:33 +1100 (AEDT)
Message-ID: <1453889967.10839.2.camel@ellerman.id.au>
Subject: Re: [PATCH v6 1/9] ppc64 (le): prepare for -mprofile-kernel
From: Michael Ellerman <mpe@ellerman.id.au>
To: Torsten Duwe <duwe@lst.de>, Steven Rostedt <rostedt@goodmis.org>, Anton
 Blanchard <anton@samba.org>, amodra@gmail.com
Cc: Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Date: Wed, 27 Jan 2016 21:19:27 +1100
In-Reply-To: <20160125170723.D2CCE692CE@newverein.lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170723.D2CCE692CE@newverein.lst.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Torsten,

On Mon, 2016-01-25 at 16:26 +0100, Torsten Duwe wrote:
> The gcc switch -mprofile-kernel, available for ppc64 on gcc > 4.8.5,
> allows to call _mcount very early in the function, which low-level
> ASM code and code patching functions need to consider.
> Especially the link register and the parameter registers are still
> alive and not yet saved into a new stack frame.
> 
> Signed-off-by: Torsten Duwe <duwe@suse.de>
> ---
>  arch/powerpc/kernel/entry_64.S  | 45 +++++++++++++++++++++++++++++++++++++++--
>  arch/powerpc/kernel/ftrace.c    | 12 +++++++++--
>  arch/powerpc/kernel/module_64.c | 14 +++++++++++++
>  3 files changed, 67 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
> index a94f155..e7cd043 100644
> --- a/arch/powerpc/kernel/entry_64.S
> +++ b/arch/powerpc/kernel/entry_64.S
> @@ -1206,7 +1206,12 @@ _GLOBAL(enter_prom)
>  #ifdef CONFIG_DYNAMIC_FTRACE
>  _GLOBAL(mcount)
>  _GLOBAL(_mcount)
> -	blr
> +	std	r0,LRSAVE(r1) /* gcc6 does this _after_ this call _only_ */
> +	mflr	r0
> +	mtctr	r0
> +	ld	r0,LRSAVE(r1)
> +	mtlr	r0
> +	bctr

Can we use r11 instead? eg:

_GLOBAL(_mcount)
	mflr	r11
	mtctr	r11
	mtlr	r0
	bctr

Otherwise I worry the std/ld is going to cause a load-hit-store. And it's just
plain more instructions too.

I don't quite grok the gcc code enough to tell if that's always safe, GCC does
use r11 sometimes, but I don't think it ever expects it to survive across
_mcount()?


> @@ -1262,13 +1267,28 @@ _GLOBAL(ftrace_stub)
>  
>  #ifdef CONFIG_FUNCTION_GRAPH_TRACER
>  _GLOBAL(ftrace_graph_caller)
> +#ifdef CC_USING_MPROFILE_KERNEL
> +	/* with -mprofile-kernel, parameter regs are still alive at _mcount */
> +	std	r10, 104(r1)
> +	std	r9, 96(r1)
> +	std	r8, 88(r1)
> +	std	r7, 80(r1)
> +	std	r6, 72(r1)
> +	std	r5, 64(r1)
> +	std	r4, 56(r1)
> +	std	r3, 48(r1)
> +	mfctr	r4		/* ftrace_caller has moved local addr here */
> +	std	r4, 40(r1)
> +	mflr	r3		/* ftrace_caller has restored LR from stack */
> +#else
>  	/* load r4 with local address */
>  	ld	r4, 128(r1)
> -	subi	r4, r4, MCOUNT_INSN_SIZE
>  
>  	/* Grab the LR out of the caller stack frame */
>  	ld	r11, 112(r1)
>  	ld	r3, 16(r11)
> +#endif
> +	subi	r4, r4, MCOUNT_INSN_SIZE
>  
>  	bl	prepare_ftrace_return
>  	nop

AFAICS these end up being the only instructions shared between the two
versions. Which I don't think is worth the semantic burden of all the #ifdefs.
So please just write it as two separate functions, one for
CC_USING_MPROFILE_KERNEL and one for not.

> @@ -1277,6 +1297,26 @@ _GLOBAL(ftrace_graph_caller)
>  	 * prepare_ftrace_return gives us the address we divert to.
>  	 * Change the LR in the callers stack frame to this.
>  	 */
> +
> +#ifdef CC_USING_MPROFILE_KERNEL
> +	mtlr	r3
> +
> +	ld	r0, 40(r1)
> +	mtctr	r0
> +	ld	r10, 104(r1)
> +	ld	r9, 96(r1)
> +	ld	r8, 88(r1)
> +	ld	r7, 80(r1)
> +	ld	r6, 72(r1)
> +	ld	r5, 64(r1)
> +	ld	r4, 56(r1)
> +	ld	r3, 48(r1)
> +
> +	addi	r1, r1, 112
> +	mflr	r0
> +	std	r0, LRSAVE(r1)
> +	bctr
> +#else
>  	ld	r11, 112(r1)
>  	std	r3, 16(r11)
>  
> @@ -1284,6 +1324,7 @@ _GLOBAL(ftrace_graph_caller)
>  	mtlr	r0
>  	addi	r1, r1, 112
>  	blr
> +#endif
>  
>  _GLOBAL(return_to_handler)
>  	/* need to save return values */
> diff --git a/arch/powerpc/kernel/ftrace.c b/arch/powerpc/kernel/ftrace.c
> index 44d4d8e..080c525 100644
> --- a/arch/powerpc/kernel/ftrace.c
> +++ b/arch/powerpc/kernel/ftrace.c
> @@ -306,11 +306,19 @@ __ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>  	 * The load offset is different depending on the ABI. For simplicity
>  	 * just mask it out when doing the compare.
>  	 */
> +#ifndef CC_USING_MPROFILE_KERNEL
>  	if ((op[0] != 0x48000008) || ((op[1] & 0xffff0000) != 0xe8410000)) {
> -		pr_err("Unexpected call sequence: %x %x\n", op[0], op[1]);
> +		pr_err("Unexpected call sequence at %p: %x %x\n",
> +		ip, op[0], op[1]);
>  		return -EINVAL;
>  	}
> -
> +#else
> +	/* look for patched "NOP" on ppc64 with -mprofile-kernel */
> +	if (op[0] != 0x60000000) {

That is "PPC_INST_NOP".

> +		pr_err("Unexpected call at %p: %x\n", ip, op[0]);
> +		return -EINVAL;
> +	}
> +#endif

Can you please break that out into a static inline, with separate versions for
the two cases.

We should aim for no #ifdefs inside functions.

> diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
> index 6838451..30f6be1 100644
> --- a/arch/powerpc/kernel/module_64.c
> +++ b/arch/powerpc/kernel/module_64.c
> @@ -475,6 +475,20 @@ static unsigned long stub_for_addr(Elf64_Shdr *sechdrs,
>  static int restore_r2(u32 *instruction, struct module *me)
>  {
>  	if (*instruction != PPC_INST_NOP) {
> +#ifdef CC_USING_MPROFILE_KERNEL
> +		/* -mprofile_kernel sequence starting with
> +		 * mflr r0 and maybe std r0, LRSAVE(r1)
> +		 */
> +		if ((instruction[-3] == 0x7c0802a6 &&
> +		    instruction[-2] == 0xf8010010) ||
> +		    instruction[-2] == 0x7c0802a6) {
> +			/* Nothing to be done here, it's an _mcount
> +			 * call location and r2 will have to be
> +			 * restored in the _mcount function.
> +			 */
> +			return 1;
> +		};
> +#endif

Again I'd rather that was in a helper static inline.

And some #defines for the instructions would also help.

>  		pr_err("%s: Expect noop after relocate, got %08x\n",
>  		       me->name, *instruction);
>  		return 0;


cheers
