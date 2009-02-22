Return-Path: <anton@ozlabs.org>
Resent-Message-ID: <20090222115855.GJ12006@kryten>
Message-Id: <20090222115332.790376340@samba.org>
References: <20090222114957.213647384@samba.org>
Date: Sun, 22 Feb 2009 22:50:06 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [patch 09/10] powerpc: Increase stack gap on 64bit binaries
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 64bit there is a possibility our stack and mmap randomisation will put
the two close enough such that we can't expand our stack to match the ulimit
specified.

To avoid this, start the upper mmap address at 1GB + 128MB below the top of our
address space, so in the worst case we end up with the same ~128MB hole as in
32bit. This works because we randomise the stack over a 1GB range.

Signed-off-by: Anton Blanchard <anton@samba.org>
---

Index: linux-2.6/arch/powerpc/mm/mmap.c
===================================================================
--- linux-2.6.orig/arch/powerpc/mm/mmap.c	2009-02-21 09:52:23.000000000 +1100
+++ linux-2.6/arch/powerpc/mm/mmap.c	2009-02-21 10:36:36.000000000 +1100
@@ -30,9 +30,16 @@
 /*
  * Top of mmap area (just below the process stack).
  *
- * Leave an at least ~128 MB hole.
+ * Leave at least a ~128 MB hole on 32bit applications.
+ *
+ * On 64bit applications we randomise the stack by 1GB so we need to
+ * space our mmap start address by a further 1GB, otherwise there is a
+ * chance the mmap area will end up closer to the stack than our ulimit
+ * requires.
  */
-#define MIN_GAP (128*1024*1024)
+#define MIN_GAP32 (128*1024*1024)
+#define MIN_GAP64 ((128 + 1024)*1024*1024UL)
+#define MIN_GAP ((is_32bit_task()) ? MIN_GAP32 : MIN_GAP64)
 #define MAX_GAP (TASK_SIZE/6*5)
 
 static inline int mmap_is_legacy(void)

-- 
