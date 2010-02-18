Return-Path: <anton@ozlabs.org>
Date: Fri, 19 Feb 2010 09:29:23 +1100
From: Anton Blanchard <anton@samba.org>
To: mel@csn.ul.ie, benh@kernel.crashing.org, cl@linux-foundation.org
Subject: [PATCH] powerpc: Set a smaller value for RECLAIM_DISTANCE to
	enable zone reclaim
Message-ID: <20100218222923.GC31681@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


I noticed /proc/sys/vm/zone_reclaim_mode was 0 on a ppc64 NUMA box. It gets
enabled via this:

        /*
         * If another node is sufficiently far away then it is better
         * to reclaim pages in a zone before going off node.
         */
        if (distance > RECLAIM_DISTANCE)
                zone_reclaim_mode = 1;

Since we use the default value of 20 for REMOTE_DISTANCE and 20 for
RECLAIM_DISTANCE it never kicks in.

The local to remote bandwidth ratios can be quite large on System p
machines so it makes sense for us to reclaim clean pagecache locally before
going off node.

The patch below sets a smaller value for RECLAIM_DISTANCE and thus enables
zone reclaim.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: powerpc.git/arch/powerpc/include/asm/topology.h
===================================================================
--- powerpc.git.orig/arch/powerpc/include/asm/topology.h	2010-02-18 14:26:45.736821967 +1100
+++ powerpc.git/arch/powerpc/include/asm/topology.h	2010-02-18 14:51:24.793071748 +1100
@@ -8,6 +8,16 @@ struct device_node;
 
 #ifdef CONFIG_NUMA
 
+/*
+ * Before going off node we want the VM to try and reclaim from the local
+ * node. It does this if the remote distance is larger than RECLAIM_DISTANCE.
+ * With the default REMOTE_DISTANCE of 20 and the default RECLAIM_DISTANCE of
+ * 20, we never reclaim and go off node straight away.
+ *
+ * To fix this we choose a smaller value of RECLAIM_DISTANCE.
+ */
+#define RECLAIM_DISTANCE 10
+
 #include <asm/mmzone.h>
 
 static inline int cpu_to_node(int cpu)
