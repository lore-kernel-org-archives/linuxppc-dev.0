Return-Path: <mpe@ellerman.id.au>
Received: from [10.61.2.158] (ibmaus65.lnk.telstra.net [165.228.126.9])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 9F4622C00CB
 for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2014 14:38:51 +1100 (EST)
Message-ID: <1393904329.11997.3.camel@concordia>
Subject: Re: [PATCH] powerpc: Check that all cpu features are in the
 possible map
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Date: Tue, 04 Mar 2014 14:38:49 +1100
In-Reply-To: <1393901079-25319-1-git-send-email-mpe@ellerman.id.au>
References: <1393901079-25319-1-git-send-email-mpe@ellerman.id.au>
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

On Tue, 2014-03-04 at 13:44 +1100, Michael Ellerman wrote:
> diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
> index 6c8dd5d..eb31713 100644
> --- a/arch/powerpc/kernel/cputable.c
> +++ b/arch/powerpc/kernel/cputable.c
> @@ -2255,6 +2255,15 @@ static struct cpu_spec * __init setup_cpu_spec(unsigned long offset,
>  	}
>  #endif /* CONFIG_PPC64 || CONFIG_BOOKE */
>  
> +	/*
> +	 * Check that all CPU features are in the possible mask. We don't want
> +	 * to WARN() because we're called very early, and doing so will kill
> +	 * the machine, so just printk() instead.
> +	 */
> +	if (t->cpu_features != (t->cpu_features & CPU_FTRS_POSSIBLE))
> +		printk("WARNING: cpu spec contains impossible features! 0x%lx\n",
> +			(t->cpu_features & ~CPU_FTRS_POSSIBLE));


Actually even this is not safe.

printk() takes the logbuf_lock, but we don't have a paca yet, so our LOCK_TOKEN
will be some random guff in low memory. And although that's OK, we're single
threaded, it's a bit fishy.

What's worse is printk() does local_irq_save(), which will _store_ to our paca
(soft_enabled), and so we risk flipping a value somewhere.

Interestingly lockdep appears to be OK, even though we haven't initialised it
yet. printk() helpfully turns lockdep off before doing any locking.

cheers
