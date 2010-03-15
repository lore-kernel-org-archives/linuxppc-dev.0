Return-Path: <fweisbec@gmail.com>
Received: from mail-bw0-f211.google.com (mail-bw0-f211.google.com
	[209.85.218.211]) by ozlabs.org (Postfix) with ESMTP id A0D58B7D8A
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Mar 2010 08:05:01 +1100 (EST)
Received: by bwz3 with SMTP id 3so1191640bwz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Mar 2010 14:04:58 -0700 (PDT)
Date: Mon, 15 Mar 2010 22:04:54 +0100
From: Frederic Weisbecker <fweisbec@gmail.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/perf_events: Implement
	perf_arch_fetch_caller_regs for powerpc
Message-ID: <20100315210450.GF5082@nowhere>
References: <20100315054615.GA6245@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100315054615.GA6245@drongo>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, anton@samba.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Mar 15, 2010 at 04:46:15PM +1100, Paul Mackerras wrote:
> This implements a powerpc version of perf_arch_fetch_caller_regs.
> It's implemented in assembly because that way we can be sure there
> isn't a stack frame for perf_arch_fetch_caller_regs.  If it was in
> C, gcc might or might not create a stack frame for it, which would
> affect the number of levels we have to skip.  It's not ifdef'd
> because it is only 14 instructions long.
> 
> With this, we see results from perf record -e lock:lock_acquire like
> this:
> 
> # Samples: 24878
> #
> # Overhead         Command      Shared Object  Symbol
> # ........  ..............  .................  ......
> #
>     14.99%            perf  [kernel.kallsyms]  [k] ._raw_spin_lock
>                       |
>                       --- ._raw_spin_lock
>                          |          
>                          |--25.00%-- .alloc_fd
>                          |          (nil)
>                          |          |          
>                          |          |--50.00%-- .anon_inode_getfd
>                          |          |          .sys_perf_event_open
>                          |          |          syscall_exit
>                          |          |          syscall
>                          |          |          create_counter
>                          |          |          __cmd_record
>                          |          |          run_builtin
>                          |          |          main
>                          |          |          0xfd2e704
>                          |          |          0xfd2e8c0
>                          |          |          (nil)
> 
> ... etc.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>


Cool!



> ---
>  arch/powerpc/include/asm/asm-compat.h |    2 ++
>  arch/powerpc/kernel/misc.S            |   20 ++++++++++++++++++++
>  2 files changed, 22 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/asm-compat.h b/arch/powerpc/include/asm/asm-compat.h
> index c1b475a..a9b91ed 100644
> --- a/arch/powerpc/include/asm/asm-compat.h
> +++ b/arch/powerpc/include/asm/asm-compat.h
> @@ -28,6 +28,7 @@
>  #define PPC_LLARX(t, a, b, eh)	PPC_LDARX(t, a, b, eh)
>  #define PPC_STLCX	stringify_in_c(stdcx.)
>  #define PPC_CNTLZL	stringify_in_c(cntlzd)
> +#define PPC_LR_STKOFF	16
>  
>  /* Move to CR, single-entry optimized version. Only available
>   * on POWER4 and later.
> @@ -51,6 +52,7 @@
>  #define PPC_STLCX	stringify_in_c(stwcx.)
>  #define PPC_CNTLZL	stringify_in_c(cntlzw)
>  #define PPC_MTOCRF	stringify_in_c(mtcrf)
> +#define PPC_LR_STKOFF	4
>  
>  #endif
>  
> diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
> index 2d29752..4459500 100644
> --- a/arch/powerpc/kernel/misc.S
> +++ b/arch/powerpc/kernel/misc.S
> @@ -127,3 +127,23 @@ _GLOBAL(__setup_cpu_power7)
>  _GLOBAL(__restore_cpu_power7)
>  	/* place holder */
>  	blr
> +
> +/*
> + * Get a minimal set of registers for our caller's nth caller.
> + * r3 = regs pointer, r5 = n.
> + */
> +_GLOBAL(perf_arch_fetch_caller_regs)
> +	mr	r6,r1
> +	cmpwi	r5,0
> +	mflr	r4
> +	ble	2f
> +	mtctr	r5
> +1:	PPC_LL	r6,0(r6)
> +	bdnz	1b
> +	PPC_LL	r4,PPC_LR_STKOFF(r6)
> +2:	PPC_LL	r7,0(r6)
> +	PPC_LL	r7,PPC_LR_STKOFF(r7)
> +	PPC_STL	r6,GPR1-STACK_FRAME_OVERHEAD(r3)
> +	PPC_STL	r4,_NIP-STACK_FRAME_OVERHEAD(r3)
> +	PPC_STL	r7,_LINK-STACK_FRAME_OVERHEAD(r3)
> +	blr
