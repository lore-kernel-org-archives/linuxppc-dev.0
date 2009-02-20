Return-Path: <anton@ozlabs.org>
Date: Fri, 20 Feb 2009 16:19:56 +1100
From: Anton Blanchard <anton@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Enable hashdist by default on PowerPC
Message-ID: <20090220051956.GE32195@kryten>
References: <20090218051112.GA32195@kryten>
	<20090218.011924.07030610.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090218.011924.07030610.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi David,

> I should probably do this on sparc64 too.
> 
> Why don't we just change this thing to CONFIG_64BIT?

I agree. How does this look?

Anton
--

On PowerPC we allocate large boot time hashes on node 0. This leads to
an imbalance in the free memory, for example on a 64GB box (4 x 16GB
nodes):

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

Since all 64bit NUMA capable architectures should have sufficient
vmalloc space, it makes sense to enable it via CONFIG_64BIT.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

diff --git a/include/linux/bootmem.h b/include/linux/bootmem.h
index 95837bf..aa861d5 100644
--- a/include/linux/bootmem.h
+++ b/include/linux/bootmem.h
@@ -144,10 +144,10 @@ extern void *alloc_large_system_hash(const char *tablename,
 
 #define HASH_EARLY	0x00000001	/* Allocating during early boot? */
 
-/* Only NUMA needs hash distribution.
- * IA64 and x86_64 have sufficient vmalloc space.
+/* Only NUMA needs hash distribution. 64bit NUMA architectures have
+ * sufficient vmalloc space.
  */
-#if defined(CONFIG_NUMA) && (defined(CONFIG_IA64) || defined(CONFIG_X86_64))
+#if defined(CONFIG_64BIT)
 #define HASHDIST_DEFAULT 1
 #else
 #define HASHDIST_DEFAULT 0
