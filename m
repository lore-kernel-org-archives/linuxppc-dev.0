Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 15:56:43 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH} powerpc: Increase NODES_SHIFT on 64bit from 4 to 8
Message-ID: <20090922055643.GA19453@kryten>
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


Some System p configurations can already have more than 16 nodes so we
need to increase NODES_SHIFT. I chose 256 to give us some room to grow in the
future, although we can look at something smaller if the memory bloat is
considered too much.

Unless we clamp MAX_ACTIVE_REGIONS we end up with 300kB of extra bloat in
early_node_map in mm/page_alloc.c:

< 6144   early_node_map
> 307200 early_node_map

due to:

    #if MAX_NUMNODES >= 32
      /* If there can be many nodes, allow up to 50 holes per node */
      #define MAX_ACTIVE_REGIONS (MAX_NUMNODES*50)
    #else
      /* By default, allow up to 256 distinct regions */
    #define MAX_ACTIVE_REGIONS 256

Since our memory is mostly contiguous it seems reasonable to keep this
at 256 for now. I also set 32bit to 32 to save space (is there any chance
a 32bit system will have more than 32 discontiguous memory ranges?).

Even with that fixed we have a few data structures that grow:

< 896   bootmem_node_data
> 14336 bootmem_node_data

< 1280  node_devices
> 20480 node_devices

< 25088 kmalloc_caches
> 59648 kmalloc_caches

< 1632  hstates
> 21792 hstates

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux.trees.git/arch/powerpc/Kconfig
===================================================================
--- linux.trees.git.orig/arch/powerpc/Kconfig	2009-09-22 15:25:27.000000000 +1000
+++ linux.trees.git/arch/powerpc/Kconfig	2009-09-22 15:52:16.000000000 +1000
@@ -385,9 +385,15 @@ config NUMA
 
 config NODES_SHIFT
 	int
+	default "8" if PPC64
 	default "4"
 	depends on NEED_MULTIPLE_NODES
 
+config MAX_ACTIVE_REGIONS
+	int
+	default "256" if PPC64
+	default "32"
+
 config ARCH_SELECT_MEMORY_MODEL
 	def_bool y
 	depends on PPC64
