Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (unknown [65.200.49.142])
	by ozlabs.org (Postfix) with SMTP id CAE4A67A39
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Mar 2006 07:16:09 +1100 (EST)
From: "Dale Farnsworth" <dale@farnsworth.org>
Date: Fri, 3 Mar 2006 13:09:28 -0700
To: linuxppc-dev@ozlabs.org
Subject: powerpc: set ARCH_KMALLOC_MINALIGN if CONFIG_NOT_COHERENT_CACHE=y
Message-ID: <20060303200928.GA29099@xyzzy.farnsworth.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Dale Farnsworth <dale@farnsworth.org>

Ensure that buffers returned by kmalloc do not share a cache
line with other data when doing non-cache-coherent I/O.

Signed-off-by: Dale Farnsworth <dale@farnsworth.org>

---

Without this patch, when CONFIG_SLAB_DEBUG=y, the buffer
allocated by kmalloc shares a cache line with the redzone1 area.
This can cause false messages of this type:
	slab error in cache_free_debugcheck(): cache `size-2048':
	double free, or memory outside object was overwritten

We could work around it in each driver, but ARCH_KMALLOC_MINALIGN
is provided for this purpose, so use it.

 include/asm-powerpc/cache.h |    4 ++++
 1 file changed, 4 insertions(+)

Index: linux-2.6-mv643xx_enet/include/asm-powerpc/cache.h
===================================================================
--- linux-2.6-mv643xx_enet.orig/include/asm-powerpc/cache.h
+++ linux-2.6-mv643xx_enet/include/asm-powerpc/cache.h
@@ -20,6 +20,10 @@
 
 #define	SMP_CACHE_BYTES		L1_CACHE_BYTES
 
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define ARCH_KMALLOC_MINALIGN	L1_CACHE_BYTES
+#endif
+
 #if defined(__powerpc64__) && !defined(__ASSEMBLY__)
 struct ppc64_caches {
 	u32	dsize;			/* L1 d-cache size */
