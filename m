Return-Path: <aaro.koskinen@iki.fi>
Received: from emh03.mail.saunalahti.fi (emh03.mail.saunalahti.fi
 [62.142.5.109])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r4kFP1tJtzDqD8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 May 2016 03:51:18 +1000 (AEST)
Date: Wed, 11 May 2016 20:51:10 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Khem Raj <raj.khem@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH V2] powerpc/ptrace: Fix out of bounds array access warning
Message-ID: <20160511175110.GC996@raspberrypi.musicnaut.iki.fi>
References: <1461601157-27478-1-git-send-email-raj.khem@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1461601157-27478-1-git-send-email-raj.khem@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Mon, Apr 25, 2016 at 09:19:17AM -0700, Khem Raj wrote:
> gcc-6 correctly warns about a out of bounds access
> 
> arch/powerpc/kernel/ptrace.c:407:24: warning: index 32 denotes an offset greater than size of 'u64[32][1] {aka long long unsigned int[32][1]}' [-Warray-bounds]
>         offsetof(struct thread_fp_state, fpr[32][0]));
>                         ^
> 
> check the end of array instead of beginning of next element to fix this
> 
> Signed-off-by: Khem Raj <raj.khem@gmail.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Segher Boessenkool <segher@kernel.crashing.org>

This patch fixes PPC kernel build failure with GCC 6.1.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

Thanks,

A.


> ---
> Changes from v1 to v2:
> - Check for fpr[32] instead of fpr[31][1]
> 
>  arch/powerpc/kernel/ptrace.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
> index 30a03c0..060b140 100644
> --- a/arch/powerpc/kernel/ptrace.c
> +++ b/arch/powerpc/kernel/ptrace.c
> @@ -377,7 +377,7 @@ static int fpr_get(struct task_struct *target, const struct user_regset *regset,
>  
>  #else
>  	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
> -		     offsetof(struct thread_fp_state, fpr[32][0]));
> +		     offsetof(struct thread_fp_state, fpr[32]));
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>  				   &target->thread.fp_state, 0, -1);
> @@ -405,7 +405,7 @@ static int fpr_set(struct task_struct *target, const struct user_regset *regset,
>  	return 0;
>  #else
>  	BUILD_BUG_ON(offsetof(struct thread_fp_state, fpscr) !=
> -		     offsetof(struct thread_fp_state, fpr[32][0]));
> +		     offsetof(struct thread_fp_state, fpr[32]));
>  
>  	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
>  				  &target->thread.fp_state, 0, -1);
> -- 
> 2.8.0
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
