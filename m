Return-Path: <anton@ozlabs.org>
Date: Tue, 22 Sep 2009 12:52:35 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, MELGOR@ie.ibm.com
Subject: powerpc: Move 64bit heap above 1TB on machines with 1TB segments
Message-ID: <20090922025235.GD31801@kryten>
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


If we are using 1TB segments and we are allowed to randomise the heap, we can
put it above 1TB so it is backed by a 1TB segment. Otherwise the heap will be
in the bottom 1TB which always uses 256MB segments and this may result in a
performance penalty.

This functionality is disabled when heap randomisation is turned off:

echo 1 > /proc/sys/kernel/randomize_va_space

which may be useful when trying to allocate the maximum amount of 16M or 16G
pages.

On a microbenchmark that repeatedly touches 32GB of memory with a stride of
256MB + 4kB (designed to stress 256MB segments while still mapping nicely into
the L1 cache), we see the improvement:

Force malloc to use heap all the time:
# export MALLOC_MMAP_MAX_=0 MALLOC_TRIM_THRESHOLD_=-1

Disable heap randomization:
# echo 1 > /proc/sys/kernel/randomize_va_space
# time ./test 
12.51s

Enable heap randomization:
# echo 2 > /proc/sys/kernel/randomize_va_space
# time ./test 
1.70s

Signed-off-by: Anton Blanchard <anton@samba.org>
---

I've cc-ed Mel on this one. As you can see it definitely helps the base
page size performance, but I'm a bit worried of the impact of taking away
another of our 1TB slices.

Index: linux.trees.git/arch/powerpc/kernel/process.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/process.c	2009-09-17 15:47:46.000000000 +1000
+++ linux.trees.git/arch/powerpc/kernel/process.c	2009-09-17 15:49:11.000000000 +1000
@@ -1165,7 +1165,22 @@ static inline unsigned long brk_rnd(void
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-	unsigned long ret = PAGE_ALIGN(mm->brk + brk_rnd());
+	unsigned long base = mm->brk;
+	unsigned long ret;
+
+#ifdef CONFIG_PPC64
+	/*
+	 * If we are using 1TB segments and we are allowed to randomise
+	 * the heap, we can put it above 1TB so it is backed by a 1TB
+	 * segment. Otherwise the heap will be in the bottom 1TB
+	 * which always uses 256MB segments and this may result in a
+	 * performance penalty.
+	 */
+	if (!is_32bit_task() && (mmu_highuser_ssize == MMU_SEGSIZE_1T))
+		base = max_t(unsigned long, mm->brk, 1UL << SID_SHIFT_1T);
+#endif
+
+	ret = PAGE_ALIGN(base + brk_rnd());
 
 	if (ret < mm->brk)
 		return mm->brk;
