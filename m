Return-Path: <mpe@ellerman.id.au>
Date: Thu, 21 Nov 2013 22:33:34 +1100
From: Michael Ellerman <mpe@ellerman.id.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] powerpc/signals: Mark VSX not saved with small contexts
Message-ID: <20131121113333.GB15913@concordia>
References: <1384924734-16722-1-git-send-email-mikey@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1384924734-16722-1-git-send-email-mikey@neuling.org>
Cc: Carlos O'Donell <carlos@redhat.com>, Steve Best <sbest@us.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Haren Myneni <haren@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Nov 20, 2013 at 04:18:54PM +1100, Michael Neuling wrote:
> The VSX MSR bit in the user context indicates if the context contains VSX
> state.  Currently we set this when the process has touched VSX at any stage.
> 
> Unfortunately, if the user has not provided enough space to save the VSX state,
> we can't save it but we currently still set the MSR VSX bit.
> 
> This patch changes this to clear the MSR VSX bit when the user doesn't provide
> enough space.  This indicates that there is no valid VSX state in the user
> context.
> 
> This is needed to support get/set/make/swapcontext for applications that use
> VSX but only provide a small context.  For example, getcontext in glibc
> provides a smaller context since the VSX registers don't need to be saved over
> the glibc function call.  But since the program calling getcontext may have
> used VSX, the kernel currently says the VSX state is valid when it's not.  If
> the returned context is then used in setcontext (ie. a small context without
> VSX but with MSR VSX set), the kernel will refuse the context.  This situation
> has been reported by the glibc community.

Broken since forever?

> Tested-by: Haren Myneni <haren@linux.vnet.ibm.com>
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Cc: stable@vger.kernel.org
> ---
>  arch/powerpc/kernel/signal_32.c | 10 +++++++++-

What about the 64-bit code? I don't know the code but it appears at a glance to
have the same bug.


> diff --git a/arch/powerpc/kernel/signal_32.c b/arch/powerpc/kernel/signal_32.c
> index 749778e..1844298 100644
> --- a/arch/powerpc/kernel/signal_32.c
> +++ b/arch/powerpc/kernel/signal_32.c
> @@ -457,7 +457,15 @@ static int save_user_regs(struct pt_regs *regs, struct mcontext __user *frame,
>  		if (copy_vsx_to_user(&frame->mc_vsregs, current))
>  			return 1;
>  		msr |= MSR_VSX;
> -	}
> +	} else if (!ctx_has_vsx_region)
> +		/*
> +		 * With a small context structure we can't hold the VSX
> +		 * registers, hence clear the MSR value to indicate the state
> +		 * was not saved.
> +		 */
> +		msr &= ~MSR_VSX;

I think it'd be clearer if this was just the else case. The full context is:

    if (current->thread.used_vsr && ctx_has_vsx_region) {
            __giveup_vsx(current);
            if (copy_vsx_to_user(&frame->mc_vsregs, current))
                    return 1;
            msr |= MSR_VSX;
+   } else if (!ctx_has_vsx_region)
+           /*
+            * With a small context structure we can't hold the VSX
+            * registers, hence clear the MSR value to indicate the state
+            * was not saved.
+            */
+           msr &= ~MSR_VSX;

Which means if current->thread.user_vsr and ctx_has_vsx_region are both false
we potentially leave MSR_VSX set in msr. I think it should be the case that
MSR_VSX is only ever set if current->thread.used_vsr is true, so it should be
OK in pratice, but it seems unnecessarily fragile.

The logic should be "if we write VSX we set MSR_VSX, else we clear MSR_VSX", ie:

    if (current->thread.used_vsr && ctx_has_vsx_region) {
            __giveup_vsx(current);
            if (copy_vsx_to_user(&frame->mc_vsregs, current))
                    return 1;
            msr |= MSR_VSX;
    } else
            msr &= ~MSR_VSX;

cheers
