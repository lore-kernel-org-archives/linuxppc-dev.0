Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18706.16317.759662.855430@cargo.ozlabs.ibm.com>
Date: Thu, 6 Nov 2008 11:52:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] Fix msr check in compat_sys_swapcontext
In-Reply-To: <jeprlabbi6.fsf@sykes.suse.de>
References: <jeprlabbi6.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> The new context may not be 16-byte aligned, so the real address of the
> mcontext structure should be read from the uc_regs pointer instead of
> directly using the (unaligned) uc_mcontext field.

Good catch, but...

> @@ -941,9 +941,17 @@ long sys_swapcontext(struct ucontext __user *old_ctx,
>  #ifdef CONFIG_PPC64
>  	unsigned long new_msr = 0;
>  
> -	if (new_ctx &&
> -	    get_user(new_msr, &new_ctx->uc_mcontext.mc_gregs[PT_MSR]))
> -		return -EFAULT;
> +	if (new_ctx) {
> +		struct mcontext __user *mcp;
> +		u32 cmcp;
> +
> +		/* Get pointer to the real mcontext. */
> +		if (__get_user(cmcp, &new_ctx->uc_regs))

we need to use get_user, not __get_user, since we haven't done an
access_ok() check on the address.

> +			return -EFAULT;
> +		mcp = (struct mcontext __user *)(u64)cmcp;
> +		if (__get_user(new_msr, &mcp->mc_gregs[PT_MSR]))

ditto here.

Paul.
