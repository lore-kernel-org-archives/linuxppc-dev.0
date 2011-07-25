Return-Path: <anton@samba.org>
Message-Id: <20110725023426.037449739@samba.org>
Date: Mon, 25 Jul 2011 12:33:12 +1000
From: Anton Blanchard <anton@samba.org>
To: mingo@elte.hu,
 peterz@infradead.org,
 benh@kernel.crashing.org
Subject: [PATCH 1/5] powerpc/numa: Enable SD_WAKE_AFFINE in node definition
References: <20110725023311.175792493@samba.org>
Cc: fenghua.yu@intel.com, tony.luck@intel.com, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org, cmetcalf@tilera.com,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When chasing a performance issue on ppc64, I noticed tasks
communicating via a pipe would often end up on different nodes.

It turns out SD_WAKE_AFFINE is not set in our node defition. Commit
9fcd18c9e63e (sched: re-tune balancing) enabled SD_WAKE_AFFINE
in the node definition for x86 and we need a similar change for
ppc64.

I used lmbench lat_ctx and perf bench pipe to verify this fix. Each
benchmark was run 10 times and the average taken.


lmbench lat_ctx:

before:  66565 ops/sec
after:  204700 ops/sec

3.1x faster


perf bench pipe:

before: 5.6570 usecs
after:  1.3470 usecs

4.2x faster


Signed-off-by: Anton Blanchard <anton@samba.org>
---

Cc-ing arch maintainers who might need to look at their SD_NODE_INIT
definitions

Index: linux-2.6-work/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-2.6-work.orig/arch/powerpc/include/asm/topology.h	2011-07-18 16:24:55.639949552 +1000
+++ linux-2.6-work/arch/powerpc/include/asm/topology.h	2011-07-18 16:25:02.630074557 +1000
@@ -73,7 +73,7 @@ static inline int pcibus_to_node(struct
 				| 1*SD_BALANCE_EXEC			\
 				| 1*SD_BALANCE_FORK			\
 				| 0*SD_BALANCE_WAKE			\
-				| 0*SD_WAKE_AFFINE			\
+				| 1*SD_WAKE_AFFINE			\
 				| 0*SD_PREFER_LOCAL			\
 				| 0*SD_SHARE_CPUPOWER			\
 				| 0*SD_POWERSAVINGS_BALANCE		\
