Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ED03DB6F95
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 May 2011 07:31:17 +1000 (EST)
Received: from d01relay05.pok.ibm.com (d01relay05.pok.ibm.com [9.56.227.237])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p4PL74Bg026509
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 17:07:04 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay05.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p4PLVERb112528
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 17:31:14 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p4PLVD0U025286
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 May 2011 17:31:14 -0400
Date: Wed, 25 May 2011 14:31:12 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 7/8] powerpc irq: protect irq_radix_revmap_lookup
	against irq_free_virt
Message-ID: <20110525213112.GL2341@linux.vnet.ibm.com>
References: <more-irq-cleanups@mdm.bga.com>
	<rcu-lock-radix-lookup-ppc@mdm.bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <rcu-lock-radix-lookup-ppc@mdm.bga.com>
Cc: linuxppc-dev@lists.ozlabs.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 25, 2011 at 01:34:18AM -0500, Milton Miller wrote:
> The radix-tree code uses call_rcu when freeing internal elements.
> We must protect against the elements being freed while we traverse
> the tree, even if the returned pointer will still be valid.
> 
> While preparing a patch to expand the context in which
> irq_radix_revmap_lookup will be called, I realized that the
> radix tree was not locked.
> 
> When asked
> 
>     For a normal call_rcu usage, is it allowed to read the structure in
>     irq_enter / irq_exit, without additional rcu_read_lock?  Could an
>     element freed with call_rcu advance with the cpu still between
>     irq_enter/irq_exit (and irq_disabled())?
> 
> Paul McKenney replied:
> 
>     Absolutely illegal to do so. OK for call_rcu_sched(), but a
>     flaming bug for call_rcu().
> 
>     And thank you very much for finding this!!!
> 
> Further analysis:
> 
> In the current CONFIG_TREE_RCU implementation. CONFIG_TREE_PREEMPT_RCU
> (and CONFIG_TINY_PREEMPT_RCU) uses explicit counters.
> 
> These counters are reflected from per-CPU to global in the
> scheduling-clock-interrupt handler, so disabling irq does prevent the
> grace period from completing. But there are real-time implementations
> (such as the one use by the Concurrent guys) where disabling irq
> does -not- prevent the grace period from completing.
> 
> 
> While an alternative fix would be to switch radix-tree to rcu_sched, I
> don't want to audit the other users of radix trees (nor put alternative
> freeing in the library).  The normal overhead for rcu_read_lock and
> unlock are a local counter increment and decrement.
> 
> This does not show up in the rcu lockdep because in 2.6.34 commit
> 2676a58c98 (radix-tree: Disable RCU lockdep checking in radix tree)
> deemed it too hard to pass the condition of the protecting lock
> to the library.

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> Signed-off-by: Milton Miller <miltonm@bga.com>
> 
> Index: work.git/arch/powerpc/kernel/irq.c
> ===================================================================
> --- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-24 21:14:30.860096118 -0500
> +++ work.git/arch/powerpc/kernel/irq.c	2011-05-24 21:15:55.350096024 -0500
> @@ -893,10 +893,13 @@ unsigned int irq_radix_revmap_lookup(str
>  		return irq_find_mapping(host, hwirq);
> 
>  	/*
> -	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
> -	 * as it's referencing an entry in the static irq_map table.
> +	 * The ptr returned references the static global irq_map.
> +	 * but freeing an irq can delete nodes along the path to
> +	 * do the lookup via call_rcu.
>  	 */
> +	rcu_read_lock();
>  	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
> +	rcu_read_unlock();
> 
>  	/*
>  	 * If found in radix tree, then fine.
