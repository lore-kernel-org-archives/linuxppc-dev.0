Return-Path: <anton@samba.org>
Message-Id: <20110725023426.218116288@samba.org>
Date: Mon, 25 Jul 2011 12:33:14 +1000
From: Anton Blanchard <anton@samba.org>
To: mingo@elte.hu,
 peterz@infradead.org,
 benh@kernel.crashing.org
Subject: [PATCH 3/5] powerpc/numa: Increase SD_NODES_PER_DOMAIN to 32.
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

The largest POWER7 boxes have 32 nodes. SD_NODES_PER_DOMAIN groups
nodes into chunks of 16 and adds a global balancing domain
(SD_ALLNODES) above it.

If we bump SD_NODES_PER_DOMAIN to 32, then we avoid this extra
level of balancing on our largest boxes.

Signed-off-by: Anton Blanchard <anton@samba.org> 
---

Index: linux-2.6-work/arch/powerpc/include/asm/topology.h
===================================================================
--- linux-2.6-work.orig/arch/powerpc/include/asm/topology.h	2011-07-25 11:43:24.954093179 +1000
+++ linux-2.6-work/arch/powerpc/include/asm/topology.h	2011-07-25 11:43:31.274205122 +1000
@@ -28,6 +28,12 @@ struct device_node;
  */
 #define RECLAIM_DISTANCE 10
 
+/*
+ * Avoid creating an extra level of balancing (SD_ALLNODES) on the largest
+ * POWER7 boxes which have a maximum of 32 nodes.
+ */
+#define SD_NODES_PER_DOMAIN 32
+
 #include <asm/mmzone.h>
 
 static inline int cpu_to_node(int cpu)
