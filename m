Return-Path: <anton@ozlabs.org>
Date: Wed, 18 Feb 2009 16:11:12 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] Enable hashdist by default on PowerPC
Message-ID: <20090218051112.GA32195@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On PowerPC we allocate large boot time hashes on node 0. This leads to
an imbalance in the free memory, for example on a 64GB box (4 x 16GB nodes):

Free memory:
Node 0: 97.03%
Node 1: 98.54%
Node 2: 98.42%
Node 3: 98.53%

If we switch to using vmalloc (like ia64 and x86-64) things are more
balanced:

Free memory:
Node 0: 97.53%
Node 1: 98.35%
Node 2: 98.33%
Node 3: 98.33%

For many HPC applications we are limited by the free available memory on
the smallest node, so even though the same amount of memory is used the
better balancing helps.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 95837bf..c0c63ee 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -145,9 +145,10 @@ extern void *alloc_large_system_hash(const char *tablename,
 #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
 
 /* Only NUMA needs hash distribution.
- * IA64 and x86_64 have sufficient vmalloc space.
+ * IA64, x86_64 and PowerPC have sufficient vmalloc space.
  */
-#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64))
+#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64) || \
+	defined(CONFIG_PPC64))
 #define HASHDIST_DEFAULT 1
 #else
 #define HASHDIST_DEFAULT 0
