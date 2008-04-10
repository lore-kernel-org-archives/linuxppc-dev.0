Return-Path: <benh@ozlabs.org>
To: <linux-kernel@vger.kernel.org>
From: Benjamin Herrenschmidt <benh@ozlabs.org>
Date: Fri, 11 Apr 2008 09:36:40 +1000
Subject: [PATCH 2/2] [POWERPC] Fix kernel stack allocation alignment
Message-Id: <20080410233741.A50A5DE39A@ozlabs.org>
Cc: Linux-Arch <linux-arch@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	takata@linux-m32r.org, linux-m32r@ml.linux-m32r.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The powerpc kernel stacks need to be naturally aligned, as they
contain the thread info at the bottom, which is obtained by
clearing the low bits of the stack pointer.

However, when using 64K pages (the stack is smaller than a page),
we use kmalloc to allocate it, which doesn't provide that guarantee.

It appeared to work so far... until one enables SLUB debugging
which then returns unaligned pointers. Ooops...

This patch fixes it by using a slab cache with enforced alignment
for those. It replies on my previous patch that adds a
thread_info_cache_init() callback.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
Note that m32r seems to also have this problem.

 arch/powerpc/kernel/process.c     |   31 +++++++++++++++++++++++++++++++
 include/asm-powerpc/thread_info.h |   10 ++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

--- linux-work.orig/arch/powerpc/kernel/process.c	2008-04-10 13:11:05.000000000 +1000
+++ linux-work/arch/powerpc/kernel/process.c	2008-04-10 13:14:29.000000000 +1000
@@ -1052,3 +1052,34 @@ void ppc64_runlatch_off(void)
 	}
 }
 #endif
+
+#if THREAD_SHIFT < PAGE_SHIFT
+
+static struct kmem_cache *thread_info_cache;
+
+struct thread_info *alloc_thread_info(struct task_struct *tsk)
+{
+	struct thread_info *ti;
+
+	ti = kmem_cache_alloc(thread_info_cache, GFP_KERNEL);
+	if (unlikely(ti == NULL))
+		return NULL;
+#ifdef CONFIG_DEBUG_STACK_USAGE
+	memset(ti, 0, THREAD_SIZE);
+#endif
+	return ti;
+}
+
+void free_thread_info(struct thread_info *ti)
+{
+	kmem_cache_free(thread_info_cache, ti);
+}
+
+void thread_info_cache_init(void)
+{
+	thread_info_cache = kmem_cache_create("thread_info", THREAD_SIZE,
+					      THREAD_SIZE, 0, NULL);
+	BUG_ON(thread_info_cache == NULL);
+}
+
+#endif /* THREAD_SHIFT < PAGE_SHIFT */
Index: linux-work/include/asm-powerpc/thread_info.h
===================================================================
--- linux-work.orig/include/asm-powerpc/thread_info.h	2008-04-10 13:11:05.000000000 +1000
+++ linux-work/include/asm-powerpc/thread_info.h	2008-04-10 13:14:47.000000000 +1000
@@ -80,12 +80,10 @@ struct thread_info {
 
 #else /* THREAD_SHIFT < PAGE_SHIFT */
 
-#ifdef CONFIG_DEBUG_STACK_USAGE
-#define alloc_thread_info(tsk)	kzalloc(THREAD_SIZE, GFP_KERNEL)
-#else
-#define alloc_thread_info(tsk)	kmalloc(THREAD_SIZE, GFP_KERNEL)
-#endif
-#define free_thread_info(ti)	kfree(ti)
+extern struct thread_info *alloc_thread_info(struct task_struct *tsk);
+extern void free_thread_info(struct thread_info *ti);
+extern void thread_info_cache_init(void);
+#define thread_info_cache_init thread_info_cache_init
 
 #endif /* THREAD_SHIFT < PAGE_SHIFT */
 
