Return-Path: <anton@ozlabs.org>
Date: Mon, 8 Feb 2010 10:23:30 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc: reformat SD_NODE_INIT to match x86
Message-ID: <20100207232330.GH32246@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: mingo@elte.hu, efault@gmx.de, linuxppc-dev@lists.ozlabs.org,
	a.p.zijlstra@chello.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Clean up SD_NODE_INITS so we can easily compare it to x86. Similar to the
work in 47734f89be0614b5acbd6a532390f9c72f019648 (sched: Clean up topology.h)

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/include/asm/topology.h
===================================================================
--- linux.trees.git.orig/arch/powerpc/include/asm/topology.h	2010-01-22 11:35:07.000000000 +1100
+++ linux.trees.git/arch/powerpc/include/asm/topology.h	2010-01-22 11:37:29.000000000 +1100
@@ -38,27 +38,33 @@ static inline int pcibus_to_node(struct 
 				 cpumask_of_node(pcibus_to_node(bus)))
 
 /* sched_domains SD_NODE_INIT for PPC64 machines */
-#define SD_NODE_INIT (struct sched_domain) {		\
-	.parent			= NULL,			\
-	.child			= NULL,			\
-	.groups			= NULL,			\
-	.min_interval		= 8,			\
-	.max_interval		= 32,			\
-	.busy_factor		= 32,			\
-	.imbalance_pct		= 125,			\
-	.cache_nice_tries	= 1,			\
-	.busy_idx		= 3,			\
-	.idle_idx		= 1,			\
-	.newidle_idx		= 0,			\
-	.wake_idx		= 0,			\
-	.flags			= SD_LOAD_BALANCE	\
-				| SD_BALANCE_EXEC	\
-				| SD_BALANCE_FORK	\
-				| SD_BALANCE_NEWIDLE	\
-				| SD_SERIALIZE,		\
-	.last_balance		= jiffies,		\
-	.balance_interval	= 1,			\
-	.nr_balance_failed	= 0,			\
+#define SD_NODE_INIT (struct sched_domain) {				\
+	.min_interval		= 8,					\
+	.max_interval		= 32,					\
+	.busy_factor		= 32,					\
+	.imbalance_pct		= 125,					\
+	.cache_nice_tries	= 1,					\
+	.busy_idx		= 3,					\
+	.idle_idx		= 1,					\
+	.newidle_idx		= 0,					\
+	.wake_idx		= 0,					\
+	.forkexec_idx		= 0,					\
+									\
+	.flags			= 1*SD_LOAD_BALANCE			\
+				| 1*SD_BALANCE_NEWIDLE			\
+				| 1*SD_BALANCE_EXEC			\
+				| 1*SD_BALANCE_FORK			\
+				| 0*SD_BALANCE_WAKE			\
+				| 0*SD_WAKE_AFFINE			\
+				| 0*SD_PREFER_LOCAL			\
+				| 0*SD_SHARE_CPUPOWER			\
+				| 0*SD_POWERSAVINGS_BALANCE		\
+				| 0*SD_SHARE_PKG_RESOURCES		\
+				| 1*SD_SERIALIZE			\
+				| 0*SD_PREFER_SIBLING			\
+				,					\
+	.last_balance		= jiffies,				\
+	.balance_interval	= 1,					\
 }
 
 extern void __init dump_numa_cpu_topology(void);
