Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 190C1B7D86
	for <linuxppc-dev@ozlabs.org>; Wed, 19 May 2010 03:56:11 +1000 (EST)
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by e4.ny.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4IHhSQi028107
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 13:43:28 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o4IHu4ZQ2236642
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 13:56:05 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o4IHu3Ya017011
	for <linuxppc-dev@ozlabs.org>; Tue, 18 May 2010 13:56:04 -0400
Date: Tue, 18 May 2010 10:56:03 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: remove all rcu head initializations
Message-ID: <20100518175603.GA6098@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

Would you guys like to carry this patch, or should I push it up
-tip?  If I don't hear otherwise from you, I will push it up -tip.
The INIT_RCU_HEAD() primitive is going away in favor of debugobjects.

							Thanx, Paul

------------------------------------------------------------------------

powerpc: remove all rcu head initializations

Remove all rcu head inits. We don't care about the RCU head state before
passing it to call_rcu() anyway. Only leave the "on_stack" variants so
debugobjects can keep track of objects on stack.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
index ebc2f38..2c7e801 100644
--- a/arch/powerpc/mm/pgtable.c
+++ b/arch/powerpc/mm/pgtable.c
@@ -92,7 +92,6 @@ static void pte_free_rcu_callback(struct rcu_head *head)
 
 static void pte_free_submit(struct pte_freelist_batch *batch)
 {
-	INIT_RCU_HEAD(&batch->rcu);
 	call_rcu(&batch->rcu, pte_free_rcu_callback);
 }
 
