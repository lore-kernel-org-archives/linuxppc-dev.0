Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 93D92B7D5B
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 14:26:38 +1000 (EST)
Subject: Re: [patch 1/1] powerpc: add rcu_read_lock() to gup_fast()
	implementation
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
References: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Apr 2010 14:26:18 +1000
Message-ID: <1272428778.24542.71.camel@pasglop>
Mime-Version: 1.0
Cc: npiggin@suse.de, linuxppc-dev@ozlabs.org, riel@redhat.com,
	paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-27 at 14:10 -0700, akpm@linux-foundation.org wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> The powerpc page table freeing relies on the fact that IRQs hold off an
> RCU grace period, this is currently true for all existing RCU
> implementations but is not an assumption Paul wants to support.
> 
> Therefore, also take the RCU read lock along with disabling IRQs to ensure
> the RCU grace period does at least cover these lookups.

Nah, that's not right. The right fix is to use call_rcu_sched() from
the powerpc page table freeing code. Please drop.

Cheers,
Ben.

> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Requested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Nick Piggin <npiggin@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Rik van Riel <riel@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  arch/powerpc/mm/gup.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff -puN arch/powerpc/mm/gup.c~powerpc-add-rcu_read_lock-to-gup_fast-implementation arch/powerpc/mm/gup.c
> --- a/arch/powerpc/mm/gup.c~powerpc-add-rcu_read_lock-to-gup_fast-implementation
> +++ a/arch/powerpc/mm/gup.c
> @@ -142,6 +142,7 @@ int get_user_pages_fast(unsigned long st
>  	 * So long as we atomically load page table pointers versus teardown,
>  	 * we can follow the address down to the the page and take a ref on it.
>  	 */
> +	rcu_read_lock();
>  	local_irq_disable();
>  
>  	pgdp = pgd_offset(mm, addr);
> @@ -162,6 +163,7 @@ int get_user_pages_fast(unsigned long st
>  	} while (pgdp++, addr = next, addr != end);
>  
>  	local_irq_enable();
> +	rcu_read_unlock();
>  
>  	VM_BUG_ON(nr != (end - start) >> PAGE_SHIFT);
>  	return nr;
> @@ -171,6 +173,7 @@ int get_user_pages_fast(unsigned long st
>  
>  slow:
>  		local_irq_enable();
> +		rcu_read_unlock();
>  slow_irqon:
>  		pr_devel("  slow path ! nr = %d\n", nr);
>  
> _
