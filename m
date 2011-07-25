Return-Path: <anton@samba.org>
Message-Id: <20110725023426.307093692@samba.org>
Date: Mon, 25 Jul 2011 12:33:15 +1000
From: Anton Blanchard <anton@samba.org>
To: mingo@elte.hu,
 peterz@infradead.org,
 benh@kernel.crashing.org
Subject: [PATCH 4/5] powerpc/numa: Disable NEWIDLE balancing at node level
References: <20110725023311.175792493@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On big POWER7 boxes we see large amounts of CPU time in system
processes like workqueue and watchdog kernel threads.

We currently rebalance the entire machine each time a task goes
idle and this is very expensive on large machines. Disable newidle
balancing at the node level and rely on the scheduler tick to
rebalance across nodes.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6-work/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-2.6-work.orig/arch/powerpc/include/asm/topology.h	2011-07-25 12:14:25.448671947 +1000
+++ linux-2.6-work/arch/powerpc/include/asm/topology.h	2011-07-25 12:14:26.568692651 +1000
@@ -75,7 +75,7 @@ static inline int pcibus_to_node(struct
 	.forkexec_idx		= 0,					\
 									\
 	.flags			= 1*SD_LOAD_BALANCE			\
-				| 1*SD_BALANCE_NEWIDLE			\
+				| 0*SD_BALANCE_NEWIDLE			\
 				| 1*SD_BALANCE_EXEC			\
 				| 1*SD_BALANCE_FORK			\
 				| 0*SD_BALANCE_WAKE			\
