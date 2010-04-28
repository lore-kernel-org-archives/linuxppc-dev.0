Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id E248FB7D53
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 13:29:40 +1000 (EST)
Date: Wed, 28 Apr 2010 13:29:31 +1000
From: Nick Piggin <npiggin@suse.de>
To: akpm@linux-foundation.org
Subject: Re: [patch 1/1] powerpc: add rcu_read_lock() to gup_fast()
	implementation
Message-ID: <20100428032931.GE5683@laptop>
References: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201004272110.o3RLAl7P019943@imap1.linux-foundation.org>
Cc: riel@redhat.com, paulmck@linux.vnet.ibm.com, a.p.zijlstra@chello.nl,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Apr 27, 2010 at 02:10:47PM -0700, Andrew Morton wrote:
> From: Peter Zijlstra <a.p.zijlstra@chello.nl>
> 
> The powerpc page table freeing relies on the fact that IRQs hold off an
> RCU grace period, this is currently true for all existing RCU
> implementations but is not an assumption Paul wants to support.
> 
> Therefore, also take the RCU read lock along with disabling IRQs to ensure
> the RCU grace period does at least cover these lookups.
> 
> Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> Requested-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Cc: Nick Piggin <npiggin@suse.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Reviewed-by: Rik van Riel <riel@redhat.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

I think I nacked this because the rest of the powerpc code also
assumes irq disables provide an rcu critical section. The plan was
to convert powerpc pagetable code to use call_rcu_sched.

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
