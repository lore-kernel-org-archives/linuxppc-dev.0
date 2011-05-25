Return-Path: <miltonm@bga.com>
Received: from mail4.comsite.net (mail4.comsite.net [205.238.176.238])
	by ozlabs.org (Postfix) with ESMTP id 95401B7411
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 May 2011 16:34:37 +1000 (EST)
Subject: [PATCH 7/8] powerpc irq: protect irq_radix_revmap_lookup against
	irq_free_virt
From: Milton Miller <miltonm@bga.com>
Message-Id: <rcu-lock-radix-lookup-ppc@mdm.bga.com>
In-Reply-To: <more-irq-cleanups@mdm.bga.com>
References: <more-irq-cleanups@mdm.bga.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 25 May 2011 01:34:18 -0500
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The radix-tree code uses call_rcu when freeing internal elements.
We must protect against the elements being freed while we traverse
the tree, even if the returned pointer will still be valid.

While preparing a patch to expand the context in which
irq_radix_revmap_lookup will be called, I realized that the
radix tree was not locked.

When asked

    For a normal call_rcu usage, is it allowed to read the structure in
    irq_enter / irq_exit, without additional rcu_read_lock?  Could an
    element freed with call_rcu advance with the cpu still between
    irq_enter/irq_exit (and irq_disabled())?

Paul McKenney replied:

    Absolutely illegal to do so. OK for call_rcu_sched(), but a
    flaming bug for call_rcu().

    And thank you very much for finding this!!!

Further analysis:

In the current CONFIG_TREE_RCU implementation. CONFIG_TREE_PREEMPT_RCU
(and CONFIG_TINY_PREEMPT_RCU) uses explicit counters.

These counters are reflected from per-CPU to global in the
scheduling-clock-interrupt handler, so disabling irq does prevent the
grace period from completing. But there are real-time implementations
(such as the one use by the Concurrent guys) where disabling irq
does -not- prevent the grace period from completing.


While an alternative fix would be to switch radix-tree to rcu_sched, I
don't want to audit the other users of radix trees (nor put alternative
freeing in the library).  The normal overhead for rcu_read_lock and
unlock are a local counter increment and decrement.

This does not show up in the rcu lockdep because in 2.6.34 commit
2676a58c98 (radix-tree: Disable RCU lockdep checking in radix tree)
deemed it too hard to pass the condition of the protecting lock
to the library.

Signed-off-by: Milton Miller <miltonm@bga.com>

Index: work.git/arch/powerpc/kernel/irq.c
===================================================================
--- work.git.orig/arch/powerpc/kernel/irq.c	2011-05-24 21:14:30.860096118 -0500
+++ work.git/arch/powerpc/kernel/irq.c	2011-05-24 21:15:55.350096024 -0500
@@ -893,10 +893,13 @@ unsigned int irq_radix_revmap_lookup(str
 		return irq_find_mapping(host, hwirq);
 
 	/*
-	 * No rcu_read_lock(ing) needed, the ptr returned can't go under us
-	 * as it's referencing an entry in the static irq_map table.
+	 * The ptr returned references the static global irq_map.
+	 * but freeing an irq can delete nodes along the path to
+	 * do the lookup via call_rcu.
 	 */
+	rcu_read_lock();
 	ptr = radix_tree_lookup(&host->revmap_data.tree, hwirq);
+	rcu_read_unlock();
 
 	/*
 	 * If found in radix tree, then fine.
