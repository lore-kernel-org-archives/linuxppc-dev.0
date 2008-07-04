Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18542.1169.106972.172938@cargo.ozlabs.ibm.com>
Date: Fri, 4 Jul 2008 21:08:01 +1000
From: Paul Mackerras <paulus@samba.org>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: powerpc: fix swapcontext backwards compatibility due to VSX
	ucontext changes
In-Reply-To: <31609.1215159925@neuling.org>
References: <31609.1215159925@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling writes:

> +	    /*
> +	     * If userspace doesn't provide enough room for VSX data,
> +	     * but current thread has used VSX, we don't have anywhere
> +	     * to store the full context back into.
> +	     */
> +		((ctx_size < sizeof(struct ucontext)) &&
> +		 (regs->msr & MSR_VSX) && old_ctx) ||

I think we need to check current->thread.used_vsr rather than
regs->msr here (in both instances of this code).

Paul.
