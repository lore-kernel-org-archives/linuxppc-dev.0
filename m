Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 87A9FDDE1A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 15:18:19 +1000 (EST)
Date: Thu, 10 May 2007 00:13:51 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull powerpc.git for_paulus branch
Message-ID: <Pine.LNX.4.64.0705100012370.27791@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for_paulus' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_paulus

to receive the following updates:

 arch/powerpc/boot/dts/mpc832x_mds.dts      |    2
 arch/powerpc/boot/dts/mpc834x_mds.dts      |    4
 arch/powerpc/lib/Makefile                  |    2
 arch/powerpc/lib/rheap.c                   |  117 ++--
 arch/powerpc/platforms/83xx/mpc8313_rdb.c  |    2
 arch/powerpc/platforms/83xx/mpc832x_rdb.c  |    2
 arch/powerpc/platforms/83xx/mpc834x_itx.c  |    2
 arch/powerpc/platforms/83xx/mpc834x_mds.c  |    2
 arch/powerpc/platforms/86xx/mpc86xx_hpcn.c |    7
 arch/powerpc/sysdev/commproc.c             |   20
 arch/powerpc/sysdev/cpm2_common.c          |   21
 arch/powerpc/sysdev/qe_lib/qe.c            |   29 -
 arch/powerpc/sysdev/qe_lib/ucc_fast.c      |    5
 arch/powerpc/sysdev/qe_lib/ucc_slow.c      |    7
 arch/ppc/8xx_io/commproc.c                 |   22
 arch/ppc/lib/Makefile                      |    3
 arch/ppc/lib/rheap.c                       |  692 -----------------------------
 arch/ppc/syslib/cpm2_common.c              |   23
 drivers/net/fs_enet/mac-scc.c              |    2
 drivers/net/ucc_geth.c                     |   30 -
 drivers/serial/cpm_uart/cpm_uart.h         |    2
 drivers/serial/cpm_uart/cpm_uart_core.c    |    3
 drivers/serial/cpm_uart/cpm_uart_cpm1.c    |    6
 drivers/serial/cpm_uart/cpm_uart_cpm2.c    |    6
 include/asm-powerpc/qe.h                   |   13
 include/asm-powerpc/reg_booke.h            |  469 +++++++++++++++++++
 include/asm-powerpc/rheap.h                |   89 +++
 include/asm-ppc/commproc.h                 |   13
 include/asm-ppc/cpm2.h                     |   13
 include/asm-ppc/rheap.h                    |   89 ---
 30 files changed, 742 insertions(+), 955 deletions(-)

Becky Bruce (1):
      [POWERPC] Move reg_booke.h to include/asm-powerpc

Jason Jin (1):
      [POWERPC] 86xx: Enable the AC97 interface on 8641D board.

Kumar Gala (3):
      [POWERPC] 83xx: Suppress warning when CONFIG_ options aren't defined
      [POWERPC] User rheap from arch/powerpc/lib
      [POWERPC] CPM_UART: Removed __init from cpm_uart_init_portdesc to fix warning

Li Yang (1):
      [POWERPC] 83xx: Suppress warning when CONFIG_PCI is not defined

Scott Wood (3):
      [POWERPC] CPM_UART: cpm_uart_set_termios should take ktermios, not termios
      [POWERPC] 83xx: Fix the PCI ranges in the MPC832x_MDS device tree.
      [POWERPC] 83xx: Fix the PCI ranges in the MPC834x_MDS device tree.

Timur Tabi (1):
      [POWERPC] Change rheap functions to use ulongs instead of pointers

diff --git a/arch/powerpc/boot/dts/mpc832x_mds.dts b/arch/powerpc/boot/dts/mpc832x_mds.dts
index 93b7606..112dd51 100644
--- a/arch/powerpc/boot/dts/mpc832x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc832x_mds.dts
@@ -146,7 +146,7 @@
 			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 90000000 0 10000000
+			ranges = <02000000 0 90000000 90000000 0 10000000
 			          42000000 0 80000000 80000000 0 10000000
 			          01000000 0 00000000 d0000000 0 00100000>;
 			clock-frequency = <0>;
diff --git a/arch/powerpc/boot/dts/mpc834x_mds.dts b/arch/powerpc/boot/dts/mpc834x_mds.dts
index 07bcc51..df773fa 100644
--- a/arch/powerpc/boot/dts/mpc834x_mds.dts
+++ b/arch/powerpc/boot/dts/mpc834x_mds.dts
@@ -223,7 +223,7 @@
 			interrupt-parent = < &ipic >;
 			interrupts = <42 8>;
 			bus-range = <0 0>;
-			ranges = <02000000 0 a0000000 a0000000 0 10000000
+			ranges = <02000000 0 90000000 90000000 0 10000000
 				  42000000 0 80000000 80000000 0 10000000
 				  01000000 0 00000000 e2000000 0 00100000>;
 			clock-frequency = <3f940aa>;
@@ -284,7 +284,7 @@
 			interrupts = <42 8>;
 			bus-range = <0 0>;
 			ranges = <02000000 0 b0000000 b0000000 0 10000000
-				  42000000 0 90000000 90000000 0 10000000
+				  42000000 0 a0000000 a0000000 0 10000000
 				  01000000 0 00000000 e2100000 0 00100000>;
 			clock-frequency = <3f940aa>;
 			#interrupt-cells = <1>;
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 450258d..0a486d4 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -23,7 +23,5 @@ obj-$(CONFIG_SMP)	+= locks.o
 endif

 # Temporary hack until we have migrated to asm-powerpc
-ifeq ($(CONFIG_PPC_MERGE),y)
 obj-$(CONFIG_8xx)	+= rheap.o
 obj-$(CONFIG_CPM2)	+= rheap.o
-endif
diff --git a/arch/powerpc/lib/rheap.c b/arch/powerpc/lib/rheap.c
index 6c5c5dd..b2f6dcc 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/arch/powerpc/lib/rheap.c
@@ -133,7 +133,7 @@ static rh_block_t *get_slot(rh_info_t * info)
 	info->empty_slots--;

 	/* Initialize */
-	blk->start = NULL;
+	blk->start = 0;
 	blk->size = 0;
 	blk->owner = NULL;

@@ -158,7 +158,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)

 	/* We assume that they are aligned properly */
 	size = blkn->size;
-	s = (unsigned long)blkn->start;
+	s = blkn->start;
 	e = s + size;

 	/* Find the blocks immediately before and after the given one
@@ -170,7 +170,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);

-		bs = (unsigned long)blk->start;
+		bs = blk->start;
 		be = bs + blk->size;

 		if (next == NULL && s >= bs)
@@ -188,10 +188,10 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
 	}

 	/* Now check if they are really adjacent */
-	if (before != NULL && s != (unsigned long)before->start + before->size)
+	if (before && s != (before->start + before->size))
 		before = NULL;

-	if (after != NULL && e != (unsigned long)after->start)
+	if (after && e != after->start)
 		after = NULL;

 	/* No coalescing; list insert and return */
@@ -216,7 +216,7 @@ static void attach_free_block(rh_info_t * info, rh_block_t * blkn)

 	/* Grow the after block backwards */
 	if (before == NULL && after != NULL) {
-		after->start = (int8_t *)after->start - size;
+		after->start -= size;
 		after->size += size;
 		return;
 	}
@@ -321,14 +321,14 @@ void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
 }

 /* Attach a free memory region, coalesces regions if adjuscent */
-int rh_attach_region(rh_info_t * info, void *start, int size)
+int rh_attach_region(rh_info_t * info, unsigned long start, int size)
 {
 	rh_block_t *blk;
 	unsigned long s, e, m;
 	int r;

 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;

@@ -338,9 +338,12 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 	/* Round end down */
 	e = e & ~m;

+	if (IS_ERR_VALUE(e) || (e < s))
+		return -ERANGE;
+
 	/* Take final values */
-	start = (void *)s;
-	size = (int)(e - s);
+	start = s;
+	size = e - s;

 	/* Grow the blocks, if needed */
 	r = assure_empty(info, 1);
@@ -358,7 +361,7 @@ int rh_attach_region(rh_info_t * info, void *start, int size)
 }

 /* Detatch given address range, splits free block if needed. */
-void *rh_detach_region(rh_info_t * info, void *start, int size)
+unsigned long rh_detach_region(rh_info_t * info, unsigned long start, int size)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk;
@@ -366,10 +369,10 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)

 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return (unsigned long) -EINVAL;

 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;

@@ -380,34 +383,34 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)
 	e = e & ~m;

 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 		blk = NULL;
 	}

 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	/* Perfect fit */
 	if (bs == s && be == e) {
 		/* Delete from free list, release slot */
 		list_del(&blk->list);
 		release_slot(info, blk);
-		return (void *)s;
+		return s;
 	}

 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;

 	} else {
@@ -416,25 +419,29 @@ void *rh_detach_region(rh_info_t * info, void *start, int size)

 		/* the back free fragment */
 		newblk = get_slot(info);
-		newblk->start = (void *)e;
+		newblk->start = e;
 		newblk->size = be - e;

 		list_add(&newblk->list, &blk->list);
 	}

-	return (void *)s;
+	return s;
 }

-void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
+/* Allocate a block of memory at the specified alignment.  The value returned
+ * is an offset into the buffer initialized by rh_init(), or a negative number
+ * if there is an error.
+ */
+unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk;
 	rh_block_t *newblk;
-	void *start;
+	unsigned long start;

-	/* Validate size, (must be power of two) */
+	/* Validate size, and alignment must be power of two */
 	if (size <= 0 || (alignment & (alignment - 1)) != 0)
-		return ERR_PTR(-EINVAL);
+		return (unsigned long) -EINVAL;

 	/* given alignment larger that default rheap alignment */
 	if (alignment > info->alignment)
@@ -444,7 +451,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);

 	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	blk = NULL;
 	list_for_each(l, &info->free_list) {
@@ -455,7 +462,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	}

 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	/* Just fits */
 	if (blk->size == size) {
@@ -475,7 +482,7 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	newblk->owner = owner;

 	/* blk still in free list, with updated start, size */
-	blk->start = (int8_t *)blk->start + size;
+	blk->start += size;
 	blk->size -= size;

 	start = newblk->start;
@@ -486,19 +493,25 @@ void *rh_alloc_align(rh_info_t * info, int size, int alignment, const char *owne
 	/* this is no problem with the deallocator since */
 	/* we scan for pointers that lie in the blocks   */
 	if (alignment > info->alignment)
-		start = (void *)(((unsigned long)start + alignment - 1) &
-				~(alignment - 1));
+		start = (start + alignment - 1) & ~(alignment - 1);

 	return start;
 }

-void *rh_alloc(rh_info_t * info, int size, const char *owner)
+/* Allocate a block of memory at the default alignment.  The value returned is
+ * an offset into the buffer initialized by rh_init(), or a negative number if
+ * there is an error.
+ */
+unsigned long rh_alloc(rh_info_t * info, int size, const char *owner)
 {
 	return rh_alloc_align(info, size, info->alignment, owner);
 }

-/* allocate at precisely the given address */
-void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
+/* Allocate a block of memory at the given offset, rounded up to the default
+ * alignment.  The value returned is an offset into the buffer initialized by
+ * rh_init(), or a negative number if there is an error.
+ */
+unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size, const char *owner)
 {
 	struct list_head *l;
 	rh_block_t *blk, *newblk1, *newblk2;
@@ -506,10 +519,10 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)

 	/* Validate size */
 	if (size <= 0)
-		return ERR_PTR(-EINVAL);
+		return (unsigned long) -EINVAL;

 	/* The region must be aligned */
-	s = (unsigned long)start;
+	s = start;
 	e = s + size;
 	m = info->alignment - 1;

@@ -520,20 +533,20 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	e = e & ~m;

 	if (assure_empty(info, 2) < 0)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	blk = NULL;
 	list_for_each(l, &info->free_list) {
 		blk = list_entry(l, rh_block_t, list);
 		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
+		bs = blk->start;
+		be = blk->start + blk->size;
 		if (s >= bs && e <= be)
 			break;
 	}

 	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
+		return (unsigned long) -ENOMEM;

 	/* Perfect fit */
 	if (bs == s && be == e) {
@@ -551,7 +564,7 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	/* blk still in free list, with updated start and/or size */
 	if (bs == s || be == e) {
 		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
+			blk->start += size;
 		blk->size -= size;

 	} else {
@@ -560,14 +573,14 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)

 		/* The back free fragment */
 		newblk2 = get_slot(info);
-		newblk2->start = (void *)e;
+		newblk2->start = e;
 		newblk2->size = be - e;

 		list_add(&newblk2->list, &blk->list);
 	}

 	newblk1 = get_slot(info);
-	newblk1->start = (void *)s;
+	newblk1->start = s;
 	newblk1->size = e - s;
 	newblk1->owner = owner;

@@ -577,7 +590,11 @@ void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
 	return start;
 }

-int rh_free(rh_info_t * info, void *start)
+/* Deallocate the memory previously allocated by one of the rh_alloc functions.
+ * The return value is the size of the deallocated block, or a negative number
+ * if there is an error.
+ */
+int rh_free(rh_info_t * info, unsigned long start)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -642,7 +659,7 @@ int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
 	return nr;
 }

-int rh_set_owner(rh_info_t * info, void *start, const char *owner)
+int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner)
 {
 	rh_block_t *blk, *blk2;
 	struct list_head *l;
@@ -684,8 +701,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u)\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u)\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size);
 	printk(KERN_INFO "\n");

@@ -695,8 +712,8 @@ void rh_dump(rh_info_t * info)
 		nr = maxnr;
 	for (i = 0; i < nr; i++)
 		printk(KERN_INFO
-		       "    0x%p-0x%p (%u) %s\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
+		       "    0x%lx-0x%lx (%u) %s\n",
+		       st[i].start, st[i].start + st[i].size,
 		       st[i].size, st[i].owner != NULL ? st[i].owner : "");
 	printk(KERN_INFO "\n");
 }
@@ -704,6 +721,6 @@ void rh_dump(rh_info_t * info)
 void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
 {
 	printk(KERN_INFO
-	       "blk @0x%p: 0x%p-0x%p (%u)\n",
-	       blk, blk->start, (int8_t *) blk->start + blk->size, blk->size);
+	       "blk @0x%p: 0x%lx-0x%lx (%u)\n",
+	       blk, blk->start, blk->start + blk->size, blk->size);
 }
diff --git a/arch/powerpc/platforms/83xx/mpc8313_rdb.c b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
index 32e9e94..96970ac 100644
--- a/arch/powerpc/platforms/83xx/mpc8313_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc8313_rdb.c
@@ -40,7 +40,9 @@ unsigned long isa_mem_base = 0;
  */
 static void __init mpc8313_rdb_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif

 	if (ppc_md.progress)
 		ppc_md.progress("mpc8313_rdb_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index b0b22bb..3db68b7 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -44,7 +44,9 @@ unsigned long isa_mem_base = 0;
  */
 static void __init mpc832x_rdb_setup_arch(void)
 {
+#if defined(CONFIG_PCI) || defined(CONFIG_QUICC_ENGINE)
 	struct device_node *np;
+#endif

 	if (ppc_md.progress)
 		ppc_md.progress("mpc832x_rdb_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/83xx/mpc834x_itx.c b/arch/powerpc/platforms/83xx/mpc834x_itx.c
index 3c009f6..40a0194 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_itx.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_itx.c
@@ -50,7 +50,9 @@ unsigned long isa_mem_base = 0;
  */
 static void __init mpc834x_itx_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif

 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_itx_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/83xx/mpc834x_mds.c b/arch/powerpc/platforms/83xx/mpc834x_mds.c
index 8aa9a93..10394b2 100644
--- a/arch/powerpc/platforms/83xx/mpc834x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc834x_mds.c
@@ -120,7 +120,9 @@ static int mpc834x_usb_cfg(void)
  */
 static void __init mpc834x_mds_setup_arch(void)
 {
+#ifdef CONFIG_PCI
 	struct device_node *np;
+#endif

 	if (ppc_md.progress)
 		ppc_md.progress("mpc834x_mds_setup_arch()", 0);
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
index 9087756..1051702 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
+++ b/arch/powerpc/platforms/86xx/mpc86xx_hpcn.c
@@ -168,7 +168,7 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 {
 	unsigned short temp;
 	struct pci_controller *hose = pci_bus_to_host(dev->bus);
-	unsigned char irq2pin[16];
+	unsigned char irq2pin[16], c;
 	unsigned long pirq_map_word = 0;
 	u32 irq;
 	int i;
@@ -288,6 +288,11 @@ static void __devinit quirk_uli1575(struct pci_dev *dev)
 	outb(0x1e, 0x4d1);

 #undef ULI1575_SET_DEV_IRQ
+
+	/* Disable the HD interface and enable the AC97 interface. */
+	pci_read_config_byte(dev, 0xb8, &c);
+	c &= 0x7f;
+	pci_write_config_byte(dev, 0xb8, c);
 }

 static void __devinit quirk_uli5288(struct pci_dev *dev)
diff --git a/arch/powerpc/sysdev/commproc.c b/arch/powerpc/sysdev/commproc.c
index 9b4fafd..4f67b89 100644
--- a/arch/powerpc/sysdev/commproc.c
+++ b/arch/powerpc/sysdev/commproc.c
@@ -330,7 +330,7 @@ void m8xx_cpm_dpinit(void)
 	 * with the processor and the microcode patches applied / activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }

 /*
@@ -338,9 +338,9 @@ void m8xx_cpm_dpinit(void)
  * This function returns an offset into the DPRAM area.
  * Use cpm_dpram_addr() to get the virtual address of the area.
  */
-uint cpm_dpalloc(uint size, uint align)
+unsigned long cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -352,30 +352,30 @@ uint cpm_dpalloc(uint size, uint align)
 }
 EXPORT_SYMBOL(cpm_dpalloc);

-int cpm_dpfree(uint offset)
+int cpm_dpfree(unsigned long offset)
 {
 	int ret;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

 	return ret;
 }
 EXPORT_SYMBOL(cpm_dpfree);

-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc_fixed);

@@ -385,7 +385,7 @@ void cpm_dpdump(void)
 }
 EXPORT_SYMBOL(cpm_dpdump);

-void *cpm_dpram_addr(uint offset)
+void *cpm_dpram_addr(unsigned long offset)
 {
 	return (void *)(dpram_vbase + offset);
 }
diff --git a/arch/powerpc/sysdev/cpm2_common.c b/arch/powerpc/sysdev/cpm2_common.c
index ec26599..9244129 100644
--- a/arch/powerpc/sysdev/cpm2_common.c
+++ b/arch/powerpc/sysdev/cpm2_common.c
@@ -248,15 +248,14 @@ static void cpm2_dpinit(void)
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
-			CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }

 /* This function returns an index into the DPRAM area.
  */
-uint cpm_dpalloc(uint size, uint align)
+unsigned long cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -268,13 +267,13 @@ uint cpm_dpalloc(uint size, uint align)
 }
 EXPORT_SYMBOL(cpm_dpalloc);

-int cpm_dpfree(uint offset)
+int cpm_dpfree(unsigned long offset)
 {
 	int ret;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

 	return ret;
@@ -282,17 +281,17 @@ int cpm_dpfree(uint offset)
 EXPORT_SYMBOL(cpm_dpfree);

 /* not sure if this is ever needed */
-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc_fixed);

@@ -302,7 +301,7 @@ void cpm_dpdump(void)
 }
 EXPORT_SYMBOL(cpm_dpdump);

-void *cpm_dpram_addr(uint offset)
+void *cpm_dpram_addr(unsigned long offset)
 {
 	return (void *)(im_dprambase + offset);
 }
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/arch/powerpc/sysdev/qe_lib/qe.c
index 7f4c075..90f8740 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/arch/powerpc/sysdev/qe_lib/qe.c
@@ -244,7 +244,7 @@ EXPORT_SYMBOL(qe_put_snum);
 static int qe_sdma_init(void)
 {
 	struct sdma *sdma = &qe_immr->sdma;
-	u32 sdma_buf_offset;
+	unsigned long sdma_buf_offset;

 	if (!sdma)
 		return -ENODEV;
@@ -252,10 +252,10 @@ static int qe_sdma_init(void)
 	/* allocate 2 internal temporary buffers (512 bytes size each) for
 	 * the SDMA */
  	sdma_buf_offset = qe_muram_alloc(512 * 2, 4096);
-	if (IS_MURAM_ERR(sdma_buf_offset))
+	if (IS_ERR_VALUE(sdma_buf_offset))
 		return -ENOMEM;

-	out_be32(&sdma->sdebcr, sdma_buf_offset & QE_SDEBCR_BA_MASK);
+	out_be32(&sdma->sdebcr, (u32) sdma_buf_offset & QE_SDEBCR_BA_MASK);
  	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK |
  					(0x1 << QE_SDMR_CEN_SHIFT)));

@@ -291,33 +291,32 @@ static void qe_muram_init(void)
 	if ((np = of_find_node_by_name(NULL, "data-only")) != NULL) {
 		address = *of_get_address(np, 0, &size, &flags);
 		of_node_put(np);
-		rh_attach_region(&qe_muram_info,
-			(void *)address, (int)size);
+		rh_attach_region(&qe_muram_info, address, (int) size);
 	}
 }

 /* This function returns an index into the MURAM area.
  */
-u32 qe_muram_alloc(u32 size, u32 align)
+unsigned long qe_muram_alloc(int size, int align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&qe_muram_lock, flags);
 	start = rh_alloc_align(&qe_muram_info, size, align, "QE");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);

-	return (u32) start;
+	return start;
 }
 EXPORT_SYMBOL(qe_muram_alloc);

-int qe_muram_free(u32 offset)
+int qe_muram_free(unsigned long offset)
 {
 	int ret;
 	unsigned long flags;

 	spin_lock_irqsave(&qe_muram_lock, flags);
-	ret = rh_free(&qe_muram_info, (void *)offset);
+	ret = rh_free(&qe_muram_info, offset);
 	spin_unlock_irqrestore(&qe_muram_lock, flags);

 	return ret;
@@ -325,16 +324,16 @@ int qe_muram_free(u32 offset)
 EXPORT_SYMBOL(qe_muram_free);

 /* not sure if this is ever needed */
-u32 qe_muram_alloc_fixed(u32 offset, u32 size)
+unsigned long qe_muram_alloc_fixed(unsigned long offset, int size)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&qe_muram_lock, flags);
-	start = rh_alloc_fixed(&qe_muram_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&qe_muram_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&qe_muram_lock, flags);

-	return (u32) start;
+	return start;
 }
 EXPORT_SYMBOL(qe_muram_alloc_fixed);

@@ -344,7 +343,7 @@ void qe_muram_dump(void)
 }
 EXPORT_SYMBOL(qe_muram_dump);

-void *qe_muram_addr(u32 offset)
+void *qe_muram_addr(unsigned long offset)
 {
 	return (void *)&qe_immr->muram[offset];
 }
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
index 66137bf..9143236 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_fast.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
+#include <linux/err.h>

 #include <asm/io.h>
 #include <asm/immap_qe.h>
@@ -268,7 +269,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 	/* Allocate memory for Tx Virtual Fifo */
 	uccf->ucc_fast_tx_virtual_fifo_base_offset =
 	    qe_muram_alloc(uf_info->utfs, UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_MURAM_ERR(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
+	if (IS_ERR_VALUE(uccf->ucc_fast_tx_virtual_fifo_base_offset)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for TX FIFO", __FUNCTION__);
 		uccf->ucc_fast_tx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
@@ -280,7 +281,7 @@ int ucc_fast_init(struct ucc_fast_info * uf_info, struct ucc_fast_private ** ucc
 		qe_muram_alloc(uf_info->urfs +
 			   UCC_FAST_RECEIVE_VIRTUAL_FIFO_SIZE_FUDGE_FACTOR,
 			   UCC_FAST_VIRT_FIFO_REGS_ALIGNMENT);
-	if (IS_MURAM_ERR(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
+	if (IS_ERR_VALUE(uccf->ucc_fast_rx_virtual_fifo_base_offset)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for RX FIFO", __FUNCTION__);
 		uccf->ucc_fast_rx_virtual_fifo_base_offset = 0;
 		ucc_fast_free(uccf);
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
index b930d68..1f65c26 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/arch/powerpc/sysdev/qe_lib/ucc_slow.c
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/stddef.h>
 #include <linux/interrupt.h>
+#include <linux/err.h>

 #include <asm/io.h>
 #include <asm/immap_qe.h>
@@ -175,7 +176,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	/* Get PRAM base */
 	uccs->us_pram_offset =
 		qe_muram_alloc(UCC_SLOW_PRAM_SIZE, ALIGNMENT_OF_UCC_SLOW_PRAM);
-	if (IS_MURAM_ERR(uccs->us_pram_offset)) {
+	if (IS_ERR_VALUE(uccs->us_pram_offset)) {
 		printk(KERN_ERR "%s: cannot allocate MURAM for PRAM", __FUNCTION__);
 		ucc_slow_free(uccs);
 		return -ENOMEM;
@@ -210,7 +211,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	uccs->rx_base_offset =
 		qe_muram_alloc(us_info->rx_bd_ring_len * sizeof(struct qe_bd),
 				QE_ALIGNMENT_OF_BD);
-	if (IS_MURAM_ERR(uccs->rx_base_offset)) {
+	if (IS_ERR_VALUE(uccs->rx_base_offset)) {
 		printk(KERN_ERR "%s: cannot allocate RX BDs", __FUNCTION__);
 		uccs->rx_base_offset = 0;
 		ucc_slow_free(uccs);
@@ -220,7 +221,7 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
 	uccs->tx_base_offset =
 		qe_muram_alloc(us_info->tx_bd_ring_len * sizeof(struct qe_bd),
 			QE_ALIGNMENT_OF_BD);
-	if (IS_MURAM_ERR(uccs->tx_base_offset)) {
+	if (IS_ERR_VALUE(uccs->tx_base_offset)) {
 		printk(KERN_ERR "%s: cannot allocate TX BDs", __FUNCTION__);
 		uccs->tx_base_offset = 0;
 		ucc_slow_free(uccs);
diff --git a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
index 7a8722b..e2c6210 100644
--- a/arch/ppc/8xx_io/commproc.c
+++ b/arch/ppc/8xx_io/commproc.c
@@ -402,7 +402,7 @@ void m8xx_cpm_dpinit(void)
 	 * with the processor and the microcode patches applied / activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }

 /*
@@ -410,9 +410,9 @@ void m8xx_cpm_dpinit(void)
  * This function returns an offset into the DPRAM area.
  * Use cpm_dpram_addr() to get the virtual address of the area.
  */
-uint cpm_dpalloc(uint size, uint align)
+unsigned long cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -420,34 +420,34 @@ uint cpm_dpalloc(uint size, uint align)
 	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc);

-int cpm_dpfree(uint offset)
+int cpm_dpfree(unsigned long offset)
 {
 	int ret;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

 	return ret;
 }
 EXPORT_SYMBOL(cpm_dpfree);

-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc_fixed);

@@ -457,7 +457,7 @@ void cpm_dpdump(void)
 }
 EXPORT_SYMBOL(cpm_dpdump);

-void *cpm_dpram_addr(uint offset)
+void *cpm_dpram_addr(unsigned long offset)
 {
 	return ((immap_t *)IMAP_ADDR)->im_cpm.cp_dpmem + offset;
 }
diff --git a/arch/ppc/lib/Makefile b/arch/ppc/lib/Makefile
index 422bef9..095e661 100644
--- a/arch/ppc/lib/Makefile
+++ b/arch/ppc/lib/Makefile
@@ -3,6 +3,3 @@
 #

 obj-y			:= checksum.o string.o div64.o
-
-obj-$(CONFIG_8xx)	+= rheap.o
-obj-$(CONFIG_CPM2)	+= rheap.o
diff --git a/arch/ppc/lib/rheap.c b/arch/ppc/lib/rheap.c
deleted file mode 100644
index d407007..0000000
--- a/arch/ppc/lib/rheap.c
+++ /dev/null
@@ -1,692 +0,0 @@
-/*
- * A Remote Heap.  Remote means that we don't touch the memory that the
- * heap points to. Normal heap implementations use the memory they manage
- * to place their list. We cannot do that because the memory we manage may
- * have special properties, for example it is uncachable or of different
- * endianess.
- *
- * Author: Pantelis Antoniou <panto@intracom.gr>
- *
- * 2004 (c) INTRACOM S.A. Greece. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/slab.h>
-
-#include <asm/rheap.h>
-
-/*
- * Fixup a list_head, needed when copying lists.  If the pointers fall
- * between s and e, apply the delta.  This assumes that
- * sizeof(struct list_head *) == sizeof(unsigned long *).
- */
-static inline void fixup(unsigned long s, unsigned long e, int d,
-			 struct list_head *l)
-{
-	unsigned long *pp;
-
-	pp = (unsigned long *)&l->next;
-	if (*pp >= s && *pp < e)
-		*pp += d;
-
-	pp = (unsigned long *)&l->prev;
-	if (*pp >= s && *pp < e)
-		*pp += d;
-}
-
-/* Grow the allocated blocks */
-static int grow(rh_info_t * info, int max_blocks)
-{
-	rh_block_t *block, *blk;
-	int i, new_blocks;
-	int delta;
-	unsigned long blks, blke;
-
-	if (max_blocks <= info->max_blocks)
-		return -EINVAL;
-
-	new_blocks = max_blocks - info->max_blocks;
-
-	block = kmalloc(sizeof(rh_block_t) * max_blocks, GFP_KERNEL);
-	if (block == NULL)
-		return -ENOMEM;
-
-	if (info->max_blocks > 0) {
-
-		/* copy old block area */
-		memcpy(block, info->block,
-		       sizeof(rh_block_t) * info->max_blocks);
-
-		delta = (char *)block - (char *)info->block;
-
-		/* and fixup list pointers */
-		blks = (unsigned long)info->block;
-		blke = (unsigned long)(info->block + info->max_blocks);
-
-		for (i = 0, blk = block; i < info->max_blocks; i++, blk++)
-			fixup(blks, blke, delta, &blk->list);
-
-		fixup(blks, blke, delta, &info->empty_list);
-		fixup(blks, blke, delta, &info->free_list);
-		fixup(blks, blke, delta, &info->taken_list);
-
-		/* free the old allocated memory */
-		if ((info->flags & RHIF_STATIC_BLOCK) == 0)
-			kfree(info->block);
-	}
-
-	info->block = block;
-	info->empty_slots += new_blocks;
-	info->max_blocks = max_blocks;
-	info->flags &= ~RHIF_STATIC_BLOCK;
-
-	/* add all new blocks to the free list */
-	for (i = 0, blk = block + info->max_blocks; i < new_blocks; i++, blk++)
-		list_add(&blk->list, &info->empty_list);
-
-	return 0;
-}
-
-/*
- * Assure at least the required amount of empty slots.  If this function
- * causes a grow in the block area then all pointers kept to the block
- * area are invalid!
- */
-static int assure_empty(rh_info_t * info, int slots)
-{
-	int max_blocks;
-
-	/* This function is not meant to be used to grow uncontrollably */
-	if (slots >= 4)
-		return -EINVAL;
-
-	/* Enough space */
-	if (info->empty_slots >= slots)
-		return 0;
-
-	/* Next 16 sized block */
-	max_blocks = ((info->max_blocks + slots) + 15) & ~15;
-
-	return grow(info, max_blocks);
-}
-
-static rh_block_t *get_slot(rh_info_t * info)
-{
-	rh_block_t *blk;
-
-	/* If no more free slots, and failure to extend. */
-	/* XXX: You should have called assure_empty before */
-	if (info->empty_slots == 0) {
-		printk(KERN_ERR "rh: out of slots; crash is imminent.\n");
-		return NULL;
-	}
-
-	/* Get empty slot to use */
-	blk = list_entry(info->empty_list.next, rh_block_t, list);
-	list_del_init(&blk->list);
-	info->empty_slots--;
-
-	/* Initialize */
-	blk->start = NULL;
-	blk->size = 0;
-	blk->owner = NULL;
-
-	return blk;
-}
-
-static inline void release_slot(rh_info_t * info, rh_block_t * blk)
-{
-	list_add(&blk->list, &info->empty_list);
-	info->empty_slots++;
-}
-
-static void attach_free_block(rh_info_t * info, rh_block_t * blkn)
-{
-	rh_block_t *blk;
-	rh_block_t *before;
-	rh_block_t *after;
-	rh_block_t *next;
-	int size;
-	unsigned long s, e, bs, be;
-	struct list_head *l;
-
-	/* We assume that they are aligned properly */
-	size = blkn->size;
-	s = (unsigned long)blkn->start;
-	e = s + size;
-
-	/* Find the blocks immediately before and after the given one
-	 * (if any) */
-	before = NULL;
-	after = NULL;
-	next = NULL;
-
-	list_for_each(l, &info->free_list) {
-		blk = list_entry(l, rh_block_t, list);
-
-		bs = (unsigned long)blk->start;
-		be = bs + blk->size;
-
-		if (next == NULL && s >= bs)
-			next = blk;
-
-		if (be == s)
-			before = blk;
-
-		if (e == bs)
-			after = blk;
-
-		/* If both are not null, break now */
-		if (before != NULL && after != NULL)
-			break;
-	}
-
-	/* Now check if they are really adjacent */
-	if (before != NULL && s != (unsigned long)before->start + before->size)
-		before = NULL;
-
-	if (after != NULL && e != (unsigned long)after->start)
-		after = NULL;
-
-	/* No coalescing; list insert and return */
-	if (before == NULL && after == NULL) {
-
-		if (next != NULL)
-			list_add(&blkn->list, &next->list);
-		else
-			list_add(&blkn->list, &info->free_list);
-
-		return;
-	}
-
-	/* We don't need it anymore */
-	release_slot(info, blkn);
-
-	/* Grow the before block */
-	if (before != NULL && after == NULL) {
-		before->size += size;
-		return;
-	}
-
-	/* Grow the after block backwards */
-	if (before == NULL && after != NULL) {
-		after->start = (int8_t *)after->start - size;
-		after->size += size;
-		return;
-	}
-
-	/* Grow the before block, and release the after block */
-	before->size += size + after->size;
-	list_del(&after->list);
-	release_slot(info, after);
-}
-
-static void attach_taken_block(rh_info_t * info, rh_block_t * blkn)
-{
-	rh_block_t *blk;
-	struct list_head *l;
-
-	/* Find the block immediately before the given one (if any) */
-	list_for_each(l, &info->taken_list) {
-		blk = list_entry(l, rh_block_t, list);
-		if (blk->start > blkn->start) {
-			list_add_tail(&blkn->list, &blk->list);
-			return;
-		}
-	}
-
-	list_add_tail(&blkn->list, &info->taken_list);
-}
-
-/*
- * Create a remote heap dynamically.  Note that no memory for the blocks
- * are allocated.  It will upon the first allocation
- */
-rh_info_t *rh_create(unsigned int alignment)
-{
-	rh_info_t *info;
-
-	/* Alignment must be a power of two */
-	if ((alignment & (alignment - 1)) != 0)
-		return ERR_PTR(-EINVAL);
-
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (info == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	info->alignment = alignment;
-
-	/* Initially everything as empty */
-	info->block = NULL;
-	info->max_blocks = 0;
-	info->empty_slots = 0;
-	info->flags = 0;
-
-	INIT_LIST_HEAD(&info->empty_list);
-	INIT_LIST_HEAD(&info->free_list);
-	INIT_LIST_HEAD(&info->taken_list);
-
-	return info;
-}
-
-/*
- * Destroy a dynamically created remote heap.  Deallocate only if the areas
- * are not static
- */
-void rh_destroy(rh_info_t * info)
-{
-	if ((info->flags & RHIF_STATIC_BLOCK) == 0 && info->block != NULL)
-		kfree(info->block);
-
-	if ((info->flags & RHIF_STATIC_INFO) == 0)
-		kfree(info);
-}
-
-/*
- * Initialize in place a remote heap info block.  This is needed to support
- * operation very early in the startup of the kernel, when it is not yet safe
- * to call kmalloc.
- */
-void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
-	     rh_block_t * block)
-{
-	int i;
-	rh_block_t *blk;
-
-	/* Alignment must be a power of two */
-	if ((alignment & (alignment - 1)) != 0)
-		return;
-
-	info->alignment = alignment;
-
-	/* Initially everything as empty */
-	info->block = block;
-	info->max_blocks = max_blocks;
-	info->empty_slots = max_blocks;
-	info->flags = RHIF_STATIC_INFO | RHIF_STATIC_BLOCK;
-
-	INIT_LIST_HEAD(&info->empty_list);
-	INIT_LIST_HEAD(&info->free_list);
-	INIT_LIST_HEAD(&info->taken_list);
-
-	/* Add all new blocks to the free list */
-	for (i = 0, blk = block; i < max_blocks; i++, blk++)
-		list_add(&blk->list, &info->empty_list);
-}
-
-/* Attach a free memory region, coalesces regions if adjuscent */
-int rh_attach_region(rh_info_t * info, void *start, int size)
-{
-	rh_block_t *blk;
-	unsigned long s, e, m;
-	int r;
-
-	/* The region must be aligned */
-	s = (unsigned long)start;
-	e = s + size;
-	m = info->alignment - 1;
-
-	/* Round start up */
-	s = (s + m) & ~m;
-
-	/* Round end down */
-	e = e & ~m;
-
-	/* Take final values */
-	start = (void *)s;
-	size = (int)(e - s);
-
-	/* Grow the blocks, if needed */
-	r = assure_empty(info, 1);
-	if (r < 0)
-		return r;
-
-	blk = get_slot(info);
-	blk->start = start;
-	blk->size = size;
-	blk->owner = NULL;
-
-	attach_free_block(info, blk);
-
-	return 0;
-}
-
-/* Detatch given address range, splits free block if needed. */
-void *rh_detach_region(rh_info_t * info, void *start, int size)
-{
-	struct list_head *l;
-	rh_block_t *blk, *newblk;
-	unsigned long s, e, m, bs, be;
-
-	/* Validate size */
-	if (size <= 0)
-		return ERR_PTR(-EINVAL);
-
-	/* The region must be aligned */
-	s = (unsigned long)start;
-	e = s + size;
-	m = info->alignment - 1;
-
-	/* Round start up */
-	s = (s + m) & ~m;
-
-	/* Round end down */
-	e = e & ~m;
-
-	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
-
-	blk = NULL;
-	list_for_each(l, &info->free_list) {
-		blk = list_entry(l, rh_block_t, list);
-		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
-		if (s >= bs && e <= be)
-			break;
-		blk = NULL;
-	}
-
-	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	/* Perfect fit */
-	if (bs == s && be == e) {
-		/* Delete from free list, release slot */
-		list_del(&blk->list);
-		release_slot(info, blk);
-		return (void *)s;
-	}
-
-	/* blk still in free list, with updated start and/or size */
-	if (bs == s || be == e) {
-		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
-		blk->size -= size;
-
-	} else {
-		/* The front free fragment */
-		blk->size = s - bs;
-
-		/* the back free fragment */
-		newblk = get_slot(info);
-		newblk->start = (void *)e;
-		newblk->size = be - e;
-
-		list_add(&newblk->list, &blk->list);
-	}
-
-	return (void *)s;
-}
-
-void *rh_alloc(rh_info_t * info, int size, const char *owner)
-{
-	struct list_head *l;
-	rh_block_t *blk;
-	rh_block_t *newblk;
-	void *start;
-
-	/* Validate size */
-	if (size <= 0)
-		return ERR_PTR(-EINVAL);
-
-	/* Align to configured alignment */
-	size = (size + (info->alignment - 1)) & ~(info->alignment - 1);
-
-	if (assure_empty(info, 1) < 0)
-		return ERR_PTR(-ENOMEM);
-
-	blk = NULL;
-	list_for_each(l, &info->free_list) {
-		blk = list_entry(l, rh_block_t, list);
-		if (size <= blk->size)
-			break;
-		blk = NULL;
-	}
-
-	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	/* Just fits */
-	if (blk->size == size) {
-		/* Move from free list to taken list */
-		list_del(&blk->list);
-		blk->owner = owner;
-		start = blk->start;
-
-		attach_taken_block(info, blk);
-
-		return start;
-	}
-
-	newblk = get_slot(info);
-	newblk->start = blk->start;
-	newblk->size = size;
-	newblk->owner = owner;
-
-	/* blk still in free list, with updated start, size */
-	blk->start = (int8_t *)blk->start + size;
-	blk->size -= size;
-
-	start = newblk->start;
-
-	attach_taken_block(info, newblk);
-
-	return start;
-}
-
-/* allocate at precisely the given address */
-void *rh_alloc_fixed(rh_info_t * info, void *start, int size, const char *owner)
-{
-	struct list_head *l;
-	rh_block_t *blk, *newblk1, *newblk2;
-	unsigned long s, e, m, bs, be;
-
-	/* Validate size */
-	if (size <= 0)
-		return ERR_PTR(-EINVAL);
-
-	/* The region must be aligned */
-	s = (unsigned long)start;
-	e = s + size;
-	m = info->alignment - 1;
-
-	/* Round start up */
-	s = (s + m) & ~m;
-
-	/* Round end down */
-	e = e & ~m;
-
-	if (assure_empty(info, 2) < 0)
-		return ERR_PTR(-ENOMEM);
-
-	blk = NULL;
-	list_for_each(l, &info->free_list) {
-		blk = list_entry(l, rh_block_t, list);
-		/* The range must lie entirely inside one free block */
-		bs = (unsigned long)blk->start;
-		be = (unsigned long)blk->start + blk->size;
-		if (s >= bs && e <= be)
-			break;
-	}
-
-	if (blk == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	/* Perfect fit */
-	if (bs == s && be == e) {
-		/* Move from free list to taken list */
-		list_del(&blk->list);
-		blk->owner = owner;
-
-		start = blk->start;
-		attach_taken_block(info, blk);
-
-		return start;
-
-	}
-
-	/* blk still in free list, with updated start and/or size */
-	if (bs == s || be == e) {
-		if (bs == s)
-			blk->start = (int8_t *)blk->start + size;
-		blk->size -= size;
-
-	} else {
-		/* The front free fragment */
-		blk->size = s - bs;
-
-		/* The back free fragment */
-		newblk2 = get_slot(info);
-		newblk2->start = (void *)e;
-		newblk2->size = be - e;
-
-		list_add(&newblk2->list, &blk->list);
-	}
-
-	newblk1 = get_slot(info);
-	newblk1->start = (void *)s;
-	newblk1->size = e - s;
-	newblk1->owner = owner;
-
-	start = newblk1->start;
-	attach_taken_block(info, newblk1);
-
-	return start;
-}
-
-int rh_free(rh_info_t * info, void *start)
-{
-	rh_block_t *blk, *blk2;
-	struct list_head *l;
-	int size;
-
-	/* Linear search for block */
-	blk = NULL;
-	list_for_each(l, &info->taken_list) {
-		blk2 = list_entry(l, rh_block_t, list);
-		if (start < blk2->start)
-			break;
-		blk = blk2;
-	}
-
-	if (blk == NULL || start > (blk->start + blk->size))
-		return -EINVAL;
-
-	/* Remove from taken list */
-	list_del(&blk->list);
-
-	/* Get size of freed block */
-	size = blk->size;
-	attach_free_block(info, blk);
-
-	return size;
-}
-
-int rh_get_stats(rh_info_t * info, int what, int max_stats, rh_stats_t * stats)
-{
-	rh_block_t *blk;
-	struct list_head *l;
-	struct list_head *h;
-	int nr;
-
-	switch (what) {
-
-	case RHGS_FREE:
-		h = &info->free_list;
-		break;
-
-	case RHGS_TAKEN:
-		h = &info->taken_list;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	/* Linear search for block */
-	nr = 0;
-	list_for_each(l, h) {
-		blk = list_entry(l, rh_block_t, list);
-		if (stats != NULL && nr < max_stats) {
-			stats->start = blk->start;
-			stats->size = blk->size;
-			stats->owner = blk->owner;
-			stats++;
-		}
-		nr++;
-	}
-
-	return nr;
-}
-
-int rh_set_owner(rh_info_t * info, void *start, const char *owner)
-{
-	rh_block_t *blk, *blk2;
-	struct list_head *l;
-	int size;
-
-	/* Linear search for block */
-	blk = NULL;
-	list_for_each(l, &info->taken_list) {
-		blk2 = list_entry(l, rh_block_t, list);
-		if (start < blk2->start)
-			break;
-		blk = blk2;
-	}
-
-	if (blk == NULL || start > (blk->start + blk->size))
-		return -EINVAL;
-
-	blk->owner = owner;
-	size = blk->size;
-
-	return size;
-}
-
-void rh_dump(rh_info_t * info)
-{
-	static rh_stats_t st[32];	/* XXX maximum 32 blocks */
-	int maxnr;
-	int i, nr;
-
-	maxnr = ARRAY_SIZE(st);
-
-	printk(KERN_INFO
-	       "info @0x%p (%d slots empty / %d max)\n",
-	       info, info->empty_slots, info->max_blocks);
-
-	printk(KERN_INFO "  Free:\n");
-	nr = rh_get_stats(info, RHGS_FREE, maxnr, st);
-	if (nr > maxnr)
-		nr = maxnr;
-	for (i = 0; i < nr; i++)
-		printk(KERN_INFO
-		       "    0x%p-0x%p (%u)\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
-		       st[i].size);
-	printk(KERN_INFO "\n");
-
-	printk(KERN_INFO "  Taken:\n");
-	nr = rh_get_stats(info, RHGS_TAKEN, maxnr, st);
-	if (nr > maxnr)
-		nr = maxnr;
-	for (i = 0; i < nr; i++)
-		printk(KERN_INFO
-		       "    0x%p-0x%p (%u) %s\n",
-		       st[i].start, (int8_t *) st[i].start + st[i].size,
-		       st[i].size, st[i].owner != NULL ? st[i].owner : "");
-	printk(KERN_INFO "\n");
-}
-
-void rh_dump_blk(rh_info_t * info, rh_block_t * blk)
-{
-	printk(KERN_INFO
-	       "blk @0x%p: 0x%p-0x%p (%u)\n",
-	       blk, blk->start, (int8_t *) blk->start + blk->size, blk->size);
-}
diff --git a/arch/ppc/syslib/cpm2_common.c b/arch/ppc/syslib/cpm2_common.c
index cbac44b..6cd859d 100644
--- a/arch/ppc/syslib/cpm2_common.c
+++ b/arch/ppc/syslib/cpm2_common.c
@@ -136,15 +136,14 @@ static void cpm2_dpinit(void)
 	 * varies with the processor and the microcode patches activated.
 	 * But the following should be at least safe.
 	 */
-	rh_attach_region(&cpm_dpmem_info, (void *)CPM_DATAONLY_BASE,
-			CPM_DATAONLY_SIZE);
+	rh_attach_region(&cpm_dpmem_info, CPM_DATAONLY_BASE, CPM_DATAONLY_SIZE);
 }

 /* This function returns an index into the DPRAM area.
  */
-uint cpm_dpalloc(uint size, uint align)
+unsigned long cpm_dpalloc(uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
@@ -152,17 +151,17 @@ uint cpm_dpalloc(uint size, uint align)
 	start = rh_alloc(&cpm_dpmem_info, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc);

-int cpm_dpfree(uint offset)
+int cpm_dpfree(unsigned long offset)
 {
 	int ret;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
-	ret = rh_free(&cpm_dpmem_info, (void *)offset);
+	ret = rh_free(&cpm_dpmem_info, offset);
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

 	return ret;
@@ -170,17 +169,17 @@ int cpm_dpfree(uint offset)
 EXPORT_SYMBOL(cpm_dpfree);

 /* not sure if this is ever needed */
-uint cpm_dpalloc_fixed(uint offset, uint size, uint align)
+unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align)
 {
-	void *start;
+	unsigned long start;
 	unsigned long flags;

 	spin_lock_irqsave(&cpm_dpmem_lock, flags);
 	cpm_dpmem_info.alignment = align;
-	start = rh_alloc_fixed(&cpm_dpmem_info, (void *)offset, size, "commproc");
+	start = rh_alloc_fixed(&cpm_dpmem_info, offset, size, "commproc");
 	spin_unlock_irqrestore(&cpm_dpmem_lock, flags);

-	return (uint)start;
+	return start;
 }
 EXPORT_SYMBOL(cpm_dpalloc_fixed);

@@ -190,7 +189,7 @@ void cpm_dpdump(void)
 }
 EXPORT_SYMBOL(cpm_dpdump);

-void *cpm_dpram_addr(uint offset)
+void *cpm_dpram_addr(unsigned long offset)
 {
 	return (void *)&cpm2_immr->im_dprambase[offset];
 }
diff --git a/drivers/net/fs_enet/mac-scc.c b/drivers/net/fs_enet/mac-scc.c
index d0f2898..7540966 100644
--- a/drivers/net/fs_enet/mac-scc.c
+++ b/drivers/net/fs_enet/mac-scc.c
@@ -167,7 +167,7 @@ static int allocate_bd(struct net_device *dev)

 	fep->ring_mem_addr = cpm_dpalloc((fpi->tx_ring + fpi->rx_ring) *
 					 sizeof(cbd_t), 8);
-	if (IS_DPERR(fep->ring_mem_addr))
+	if (IS_ERR_VALUE(fep->ring_mem_addr))
 		return -ENOMEM;

 	fep->ring_base = cpm_dpram_addr(fep->ring_mem_addr);
diff --git a/drivers/net/ucc_geth.c b/drivers/net/ucc_geth.c
index d7aff81..0f66765 100644
--- a/drivers/net/ucc_geth.c
+++ b/drivers/net/ucc_geth.c
@@ -293,7 +293,7 @@ static int fill_init_enet_entries(struct ucc_geth_private *ugeth,
 		else {
 			init_enet_offset =
 			    qe_muram_alloc(thread_size, thread_alignment);
-			if (IS_MURAM_ERR(init_enet_offset)) {
+			if (IS_ERR_VALUE(init_enet_offset)) {
 				ugeth_err
 		("fill_init_enet_entries: Can not allocate DPRAM memory.");
 				qe_put_snum((u8) snum);
@@ -2594,7 +2594,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			ugeth->tx_bd_ring_offset[j] =
 			    qe_muram_alloc(length,
 					   UCC_GETH_TX_BD_RING_ALIGNMENT);
-			if (!IS_MURAM_ERR(ugeth->tx_bd_ring_offset[j]))
+			if (!IS_ERR_VALUE(ugeth->tx_bd_ring_offset[j]))
 				ugeth->p_tx_bd_ring[j] =
 				    (u8 *) qe_muram_addr(ugeth->
 							 tx_bd_ring_offset[j]);
@@ -2629,7 +2629,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			ugeth->rx_bd_ring_offset[j] =
 			    qe_muram_alloc(length,
 					   UCC_GETH_RX_BD_RING_ALIGNMENT);
-			if (!IS_MURAM_ERR(ugeth->rx_bd_ring_offset[j]))
+			if (!IS_ERR_VALUE(ugeth->rx_bd_ring_offset[j]))
 				ugeth->p_rx_bd_ring[j] =
 				    (u8 *) qe_muram_addr(ugeth->
 							 rx_bd_ring_offset[j]);
@@ -2713,7 +2713,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	ugeth->tx_glbl_pram_offset =
 	    qe_muram_alloc(sizeof(struct ucc_geth_tx_global_pram),
 			   UCC_GETH_TX_GLOBAL_PRAM_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->tx_glbl_pram_offset)) {
+	if (IS_ERR_VALUE(ugeth->tx_glbl_pram_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_tx_glbl_pram.",
 		     __FUNCTION__);
@@ -2735,7 +2735,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			   sizeof(struct ucc_geth_thread_data_tx) +
 			   32 * (numThreadsTxNumerical == 1),
 			   UCC_GETH_THREAD_DATA_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->thread_dat_tx_offset)) {
+	if (IS_ERR_VALUE(ugeth->thread_dat_tx_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_thread_data_tx.",
 		     __FUNCTION__);
@@ -2763,7 +2763,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	    qe_muram_alloc(ug_info->numQueuesTx *
 			   sizeof(struct ucc_geth_send_queue_qd),
 			   UCC_GETH_SEND_QUEUE_QUEUE_DESCRIPTOR_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->send_q_mem_reg_offset)) {
+	if (IS_ERR_VALUE(ugeth->send_q_mem_reg_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_send_q_mem_reg.",
 		     __FUNCTION__);
@@ -2806,7 +2806,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		ugeth->scheduler_offset =
 		    qe_muram_alloc(sizeof(struct ucc_geth_scheduler),
 				   UCC_GETH_SCHEDULER_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->scheduler_offset)) {
+		if (IS_ERR_VALUE(ugeth->scheduler_offset)) {
 			ugeth_err
 			 ("%s: Can not allocate DPRAM memory for p_scheduler.",
 			     __FUNCTION__);
@@ -2854,7 +2854,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		    qe_muram_alloc(sizeof
 				   (struct ucc_geth_tx_firmware_statistics_pram),
 				   UCC_GETH_TX_STATISTICS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->tx_fw_statistics_pram_offset)) {
+		if (IS_ERR_VALUE(ugeth->tx_fw_statistics_pram_offset)) {
 			ugeth_err
 			    ("%s: Can not allocate DPRAM memory for"
 				" p_tx_fw_statistics_pram.", __FUNCTION__);
@@ -2893,7 +2893,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	ugeth->rx_glbl_pram_offset =
 	    qe_muram_alloc(sizeof(struct ucc_geth_rx_global_pram),
 			   UCC_GETH_RX_GLOBAL_PRAM_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_glbl_pram_offset)) {
+	if (IS_ERR_VALUE(ugeth->rx_glbl_pram_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_rx_glbl_pram.",
 		     __FUNCTION__);
@@ -2914,7 +2914,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	    qe_muram_alloc(numThreadsRxNumerical *
 			   sizeof(struct ucc_geth_thread_data_rx),
 			   UCC_GETH_THREAD_DATA_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->thread_dat_rx_offset)) {
+	if (IS_ERR_VALUE(ugeth->thread_dat_rx_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_thread_data_rx.",
 		     __FUNCTION__);
@@ -2937,7 +2937,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		    qe_muram_alloc(sizeof
 				   (struct ucc_geth_rx_firmware_statistics_pram),
 				   UCC_GETH_RX_STATISTICS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->rx_fw_statistics_pram_offset)) {
+		if (IS_ERR_VALUE(ugeth->rx_fw_statistics_pram_offset)) {
 			ugeth_err
 				("%s: Can not allocate DPRAM memory for"
 				" p_rx_fw_statistics_pram.", __FUNCTION__);
@@ -2959,7 +2959,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 	    qe_muram_alloc(ug_info->numQueuesRx *
 			   sizeof(struct ucc_geth_rx_interrupt_coalescing_entry)
 			   + 4, UCC_GETH_RX_INTERRUPT_COALESCING_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_irq_coalescing_tbl_offset)) {
+	if (IS_ERR_VALUE(ugeth->rx_irq_coalescing_tbl_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for"
 			" p_rx_irq_coalescing_tbl.", __FUNCTION__);
@@ -3027,7 +3027,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 			   (sizeof(struct ucc_geth_rx_bd_queues_entry) +
 			    sizeof(struct ucc_geth_rx_prefetched_bds)),
 			   UCC_GETH_RX_BD_QUEUES_ALIGNMENT);
-	if (IS_MURAM_ERR(ugeth->rx_bd_qs_tbl_offset)) {
+	if (IS_ERR_VALUE(ugeth->rx_bd_qs_tbl_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_rx_bd_qs_tbl.",
 		     __FUNCTION__);
@@ -3116,7 +3116,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)
 		ugeth->exf_glbl_param_offset =
 		    qe_muram_alloc(sizeof(struct ucc_geth_exf_global_pram),
 		UCC_GETH_RX_EXTENDED_FILTERING_GLOBAL_PARAMETERS_ALIGNMENT);
-		if (IS_MURAM_ERR(ugeth->exf_glbl_param_offset)) {
+		if (IS_ERR_VALUE(ugeth->exf_glbl_param_offset)) {
 			ugeth_err
 				("%s: Can not allocate DPRAM memory for"
 				" p_exf_glbl_param.", __FUNCTION__);
@@ -3258,7 +3258,7 @@ static int ucc_geth_startup(struct ucc_geth_private *ugeth)

 	/* Allocate InitEnet command parameter structure */
 	init_enet_pram_offset = qe_muram_alloc(sizeof(struct ucc_geth_init_pram), 4);
-	if (IS_MURAM_ERR(init_enet_pram_offset)) {
+	if (IS_ERR_VALUE(init_enet_pram_offset)) {
 		ugeth_err
 		    ("%s: Can not allocate DPRAM memory for p_init_enet_pram.",
 		     __FUNCTION__);
diff --git a/drivers/serial/cpm_uart/cpm_uart.h b/drivers/serial/cpm_uart/cpm_uart.h
index 69715e5..a8f894c 100644
--- a/drivers/serial/cpm_uart/cpm_uart.h
+++ b/drivers/serial/cpm_uart/cpm_uart.h
@@ -88,7 +88,7 @@ extern struct uart_cpm_port cpm_uart_ports[UART_NR];

 /* these are located in their respective files */
 void cpm_line_cr_cmd(int line, int cmd);
-int __init cpm_uart_init_portdesc(void);
+int cpm_uart_init_portdesc(void);
 int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con);
 void cpm_uart_freebuf(struct uart_cpm_port *pinfo);

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_uart/cpm_uart_core.c
index f23972b..b63ff8d 100644
--- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -482,7 +482,8 @@ static void cpm_uart_shutdown(struct uart_port *port)
 }

 static void cpm_uart_set_termios(struct uart_port *port,
-				 struct termios *termios, struct termios *old)
+                                 struct ktermios *termios,
+                                 struct ktermios *old)
 {
 	int baud;
 	unsigned long flags;
diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm1.c b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
index 925fb60..8c6324e 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm1.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm1.c
@@ -125,7 +125,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
 	u8 *dp_mem;
-	uint dp_offset;
+	unsigned long dp_offset;
 	u8 *mem_addr;
 	dma_addr_t dma_addr = 0;

@@ -133,7 +133,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)

 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_DPERR(dp_offset)) {
+	if (IS_ERR_VALUE(dp_offset)) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm1.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
@@ -185,7 +185,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 }

 /* Setup any dynamic params in the uart desc */
-int __init cpm_uart_init_portdesc(void)
+int cpm_uart_init_portdesc(void)
 {
 	pr_debug("CPM uart[-]:init portdesc\n");

diff --git a/drivers/serial/cpm_uart/cpm_uart_cpm2.c b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
index fa45599..7b61d80 100644
--- a/drivers/serial/cpm_uart/cpm_uart_cpm2.c
+++ b/drivers/serial/cpm_uart/cpm_uart_cpm2.c
@@ -222,7 +222,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)
 {
 	int dpmemsz, memsz;
 	u8 *dp_mem;
-	uint dp_offset;
+	unsigned long dp_offset;
 	u8 *mem_addr;
 	dma_addr_t dma_addr = 0;

@@ -230,7 +230,7 @@ int cpm_uart_allocbuf(struct uart_cpm_port *pinfo, unsigned int is_con)

 	dpmemsz = sizeof(cbd_t) * (pinfo->rx_nrfifos + pinfo->tx_nrfifos);
 	dp_offset = cpm_dpalloc(dpmemsz, 8);
-	if (IS_DPERR(dp_offset)) {
+	if (IS_ERR_VALUE(dp_offset)) {
 		printk(KERN_ERR
 		       "cpm_uart_cpm.c: could not allocate buffer descriptors\n");
 		return -ENOMEM;
@@ -282,7 +282,7 @@ void cpm_uart_freebuf(struct uart_cpm_port *pinfo)
 }

 /* Setup any dynamic params in the uart desc */
-int __init cpm_uart_init_portdesc(void)
+int cpm_uart_init_portdesc(void)
 {
 #if defined(CONFIG_SERIAL_CPM_SMC1) || defined(CONFIG_SERIAL_CPM_SMC2)
 	u16 *addr;
diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
index a62168e..9d304b1 100644
--- a/include/asm-powerpc/qe.h
+++ b/include/asm-powerpc/qe.h
@@ -38,11 +38,11 @@ int qe_issue_cmd(u32 cmd, u32 device, u8 mcn_protocol, u32 cmd_input);
 void qe_setbrg(u32 brg, u32 rate);
 int qe_get_snum(void);
 void qe_put_snum(u8 snum);
-u32 qe_muram_alloc(u32 size, u32 align);
-int qe_muram_free(u32 offset);
-u32 qe_muram_alloc_fixed(u32 offset, u32 size);
+unsigned long qe_muram_alloc(int size, int align);
+int qe_muram_free(unsigned long offset);
+unsigned long qe_muram_alloc_fixed(unsigned long offset, int size);
 void qe_muram_dump(void);
-void *qe_muram_addr(u32 offset);
+void *qe_muram_addr(unsigned long offset);

 /* Buffer descriptors */
 struct qe_bd {
@@ -448,10 +448,5 @@ struct ucc_slow_pram {
 #define UCC_FAST_FUNCTION_CODE_DTB_LCL	0x02
 #define UCC_FAST_FUNCTION_CODE_BDB_LCL	0x01

-static inline long IS_MURAM_ERR(const u32 offset)
-{
-	return offset > (u32) - 1000L;
-}
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_QE_H */
diff --git a/include/asm-powerpc/reg_booke.h b/include/asm-powerpc/reg_booke.h
new file mode 100644
index 0000000..064405c
--- /dev/null
+++ b/include/asm-powerpc/reg_booke.h
@@ -0,0 +1,469 @@
+/*
+ * Contains register definitions common to the Book E PowerPC
+ * specification.  Notice that while the IBM-40x series of CPUs
+ * are not true Book E PowerPCs, they borrowed a number of features
+ * before Book E was finalized, and are included here as well.  Unfortunatly,
+ * they sometimes used different locations than true Book E CPUs did.
+ */
+#ifdef __KERNEL__
+#ifndef __ASM_POWERPC_REG_BOOKE_H__
+#define __ASM_POWERPC_REG_BOOKE_H__
+
+#ifndef __ASSEMBLY__
+/* Performance Monitor Registers */
+#define mfpmr(rn)	({unsigned int rval; \
+			asm volatile("mfpmr %0," __stringify(rn) \
+				     : "=r" (rval)); rval;})
+#define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
+#endif /* __ASSEMBLY__ */
+
+/* Freescale Book E Performance Monitor APU Registers */
+#define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
+#define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
+#define PMRN_PMC2	0x012	/* Performance Monitor Counter 1 */
+#define PMRN_PMC3	0x013	/* Performance Monitor Counter 1 */
+#define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
+#define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
+#define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
+#define PMRN_PMLCA3	0x093	/* PM Local Control A3 */
+
+#define PMLCA_FC	0x80000000	/* Freeze Counter */
+#define PMLCA_FCS	0x40000000	/* Freeze in Supervisor */
+#define PMLCA_FCU	0x20000000	/* Freeze in User */
+#define PMLCA_FCM1	0x10000000	/* Freeze when PMM==1 */
+#define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
+#define PMLCA_CE	0x04000000	/* Condition Enable */
+
+#define PMLCA_EVENT_MASK 0x007f0000	/* Event field */
+#define PMLCA_EVENT_SHIFT	16
+
+#define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
+#define PMRN_PMLCB1	0x111	/* PM Local Control B1 */
+#define PMRN_PMLCB2	0x112	/* PM Local Control B2 */
+#define PMRN_PMLCB3	0x113	/* PM Local Control B3 */
+
+#define PMLCB_THRESHMUL_MASK	0x0700	/* Threshhold Multiple Field */
+#define PMLCB_THRESHMUL_SHIFT	8
+
+#define PMLCB_THRESHOLD_MASK	0x003f	/* Threshold Field */
+#define PMLCB_THRESHOLD_SHIFT	0
+
+#define PMRN_PMGC0	0x190	/* PM Global Control 0 */
+
+#define PMGC0_FAC	0x80000000	/* Freeze all Counters */
+#define PMGC0_PMIE	0x40000000	/* Interrupt Enable */
+#define PMGC0_FCECE	0x20000000	/* Freeze countes on
+					   Enabled Condition or
+					   Event */
+
+#define PMRN_UPMC0	0x000	/* User Performance Monitor Counter 0 */
+#define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
+#define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
+#define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
+#define PMRN_UPMLCA3	0x083	/* User PM Local Control A3 */
+#define PMRN_UPMLCB0	0x100	/* User PM Local Control B0 */
+#define PMRN_UPMLCB1	0x101	/* User PM Local Control B1 */
+#define PMRN_UPMLCB2	0x102	/* User PM Local Control B2 */
+#define PMRN_UPMLCB3	0x103	/* User PM Local Control B3 */
+#define PMRN_UPMGC0	0x180	/* User PM Global Control 0 */
+
+
+/* Machine State Register (MSR) Fields */
+#define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
+#define MSR_SPE		(1<<25)	/* Enable SPE */
+#define MSR_DWE		(1<<10)	/* Debug Wait Enable */
+#define MSR_UBLE	(1<<10)	/* BTB lock enable (e500) */
+#define MSR_IS		MSR_IR	/* Instruction Space */
+#define MSR_DS		MSR_DR	/* Data Space */
+#define MSR_PMM		(1<<2)	/* Performance monitor mark bit */
+
+/* Default MSR for kernel mode. */
+#if defined (CONFIG_40x)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_IR|MSR_DR|MSR_CE)
+#elif defined(CONFIG_BOOKE)
+#define MSR_KERNEL	(MSR_ME|MSR_RI|MSR_CE)
+#endif
+
+/* Special Purpose Registers (SPRNs)*/
+#define SPRN_DECAR	0x036	/* Decrementer Auto Reload Register */
+#define SPRN_IVPR	0x03F	/* Interrupt Vector Prefix Register */
+#define SPRN_USPRG0	0x100	/* User Special Purpose Register General 0 */
+#define SPRN_SPRG4R	0x104	/* Special Purpose Register General 4 Read */
+#define SPRN_SPRG5R	0x105	/* Special Purpose Register General 5 Read */
+#define SPRN_SPRG6R	0x106	/* Special Purpose Register General 6 Read */
+#define SPRN_SPRG7R	0x107	/* Special Purpose Register General 7 Read */
+#define SPRN_SPRG4W	0x114	/* Special Purpose Register General 4 Write */
+#define SPRN_SPRG5W	0x115	/* Special Purpose Register General 5 Write */
+#define SPRN_SPRG6W	0x116	/* Special Purpose Register General 6 Write */
+#define SPRN_SPRG7W	0x117	/* Special Purpose Register General 7 Write */
+#define SPRN_DBCR2	0x136	/* Debug Control Register 2 */
+#define SPRN_IAC3	0x13A	/* Instruction Address Compare 3 */
+#define SPRN_IAC4	0x13B	/* Instruction Address Compare 4 */
+#define SPRN_DVC1	0x13E	/* Data Value Compare Register 1 */
+#define SPRN_DVC2	0x13F	/* Data Value Compare Register 2 */
+#define SPRN_IVOR0	0x190	/* Interrupt Vector Offset Register 0 */
+#define SPRN_IVOR1	0x191	/* Interrupt Vector Offset Register 1 */
+#define SPRN_IVOR2	0x192	/* Interrupt Vector Offset Register 2 */
+#define SPRN_IVOR3	0x193	/* Interrupt Vector Offset Register 3 */
+#define SPRN_IVOR4	0x194	/* Interrupt Vector Offset Register 4 */
+#define SPRN_IVOR5	0x195	/* Interrupt Vector Offset Register 5 */
+#define SPRN_IVOR6	0x196	/* Interrupt Vector Offset Register 6 */
+#define SPRN_IVOR7	0x197	/* Interrupt Vector Offset Register 7 */
+#define SPRN_IVOR8	0x198	/* Interrupt Vector Offset Register 8 */
+#define SPRN_IVOR9	0x199	/* Interrupt Vector Offset Register 9 */
+#define SPRN_IVOR10	0x19A	/* Interrupt Vector Offset Register 10 */
+#define SPRN_IVOR11	0x19B	/* Interrupt Vector Offset Register 11 */
+#define SPRN_IVOR12	0x19C	/* Interrupt Vector Offset Register 12 */
+#define SPRN_IVOR13	0x19D	/* Interrupt Vector Offset Register 13 */
+#define SPRN_IVOR14	0x19E	/* Interrupt Vector Offset Register 14 */
+#define SPRN_IVOR15	0x19F	/* Interrupt Vector Offset Register 15 */
+#define SPRN_SPEFSCR	0x200	/* SPE & Embedded FP Status & Control */
+#define SPRN_BBEAR	0x201	/* Branch Buffer Entry Address Register */
+#define SPRN_BBTAR	0x202	/* Branch Buffer Target Address Register */
+#define SPRN_IVOR32	0x210	/* Interrupt Vector Offset Register 32 */
+#define SPRN_IVOR33	0x211	/* Interrupt Vector Offset Register 33 */
+#define SPRN_IVOR34	0x212	/* Interrupt Vector Offset Register 34 */
+#define SPRN_IVOR35	0x213	/* Interrupt Vector Offset Register 35 */
+#define SPRN_MCSRR0	0x23A	/* Machine Check Save and Restore Register 0 */
+#define SPRN_MCSRR1	0x23B	/* Machine Check Save and Restore Register 1 */
+#define SPRN_MCSR	0x23C	/* Machine Check Status Register */
+#define SPRN_MCAR	0x23D	/* Machine Check Address Register */
+#define SPRN_DSRR0	0x23E	/* Debug Save and Restore Register 0 */
+#define SPRN_DSRR1	0x23F	/* Debug Save and Restore Register 1 */
+#define SPRN_MAS0	0x270	/* MMU Assist Register 0 */
+#define SPRN_MAS1	0x271	/* MMU Assist Register 1 */
+#define SPRN_MAS2	0x272	/* MMU Assist Register 2 */
+#define SPRN_MAS3	0x273	/* MMU Assist Register 3 */
+#define SPRN_MAS4	0x274	/* MMU Assist Register 4 */
+#define SPRN_MAS5	0x275	/* MMU Assist Register 5 */
+#define SPRN_MAS6	0x276	/* MMU Assist Register 6 */
+#define SPRN_MAS7	0x3b0	/* MMU Assist Register 7 */
+#define SPRN_PID1	0x279	/* Process ID Register 1 */
+#define SPRN_PID2	0x27A	/* Process ID Register 2 */
+#define SPRN_TLB0CFG	0x2B0	/* TLB 0 Config Register */
+#define SPRN_TLB1CFG	0x2B1	/* TLB 1 Config Register */
+#define SPRN_CCR1	0x378	/* Core Configuration Register 1 */
+#define SPRN_ZPR	0x3B0	/* Zone Protection Register (40x) */
+#define SPRN_MMUCR	0x3B2	/* MMU Control Register */
+#define SPRN_CCR0	0x3B3	/* Core Configuration Register 0 */
+#define SPRN_SGR	0x3B9	/* Storage Guarded Register */
+#define SPRN_DCWR	0x3BA	/* Data Cache Write-thru Register */
+#define SPRN_SLER	0x3BB	/* Little-endian real mode */
+#define SPRN_SU0R	0x3BC	/* "User 0" real mode (40x) */
+#define SPRN_DCMP	0x3D1	/* Data TLB Compare Register */
+#define SPRN_ICDBDR	0x3D3	/* Instruction Cache Debug Data Register */
+#define SPRN_EVPR	0x3D6	/* Exception Vector Prefix Register */
+#define SPRN_L1CSR0	0x3F2	/* L1 Cache Control and Status Register 0 */
+#define SPRN_L1CSR1	0x3F3	/* L1 Cache Control and Status Register 1 */
+#define SPRN_PIT	0x3DB	/* Programmable Interval Timer */
+#define SPRN_DCCR	0x3FA	/* Data Cache Cacheability Register */
+#define SPRN_ICCR	0x3FB	/* Instruction Cache Cacheability Register */
+#define SPRN_SVR	0x3FF	/* System Version Register */
+
+/*
+ * SPRs which have conflicting definitions on true Book E versus classic,
+ * or IBM 40x.
+ */
+#ifdef CONFIG_BOOKE
+#define SPRN_PID	0x030	/* Process ID */
+#define SPRN_PID0	SPRN_PID/* Process ID Register 0 */
+#define SPRN_CSRR0	0x03A	/* Critical Save and Restore Register 0 */
+#define SPRN_CSRR1	0x03B	/* Critical Save and Restore Register 1 */
+#define SPRN_DEAR	0x03D	/* Data Error Address Register */
+#define SPRN_ESR	0x03E	/* Exception Syndrome Register */
+#define SPRN_PIR	0x11E	/* Processor Identification Register */
+#define SPRN_DBSR	0x130	/* Debug Status Register */
+#define SPRN_DBCR0	0x134	/* Debug Control Register 0 */
+#define SPRN_DBCR1	0x135	/* Debug Control Register 1 */
+#define SPRN_IAC1	0x138	/* Instruction Address Compare 1 */
+#define SPRN_IAC2	0x139	/* Instruction Address Compare 2 */
+#define SPRN_DAC1	0x13C	/* Data Address Compare 1 */
+#define SPRN_DAC2	0x13D	/* Data Address Compare 2 */
+#define SPRN_TSR	0x150	/* Timer Status Register */
+#define SPRN_TCR	0x154	/* Timer Control Register */
+#endif /* Book E */
+#ifdef CONFIG_40x
+#define SPRN_PID	0x3B1	/* Process ID */
+#define SPRN_DBCR1	0x3BD	/* Debug Control Register 1 */
+#define SPRN_ESR	0x3D4	/* Exception Syndrome Register */
+#define SPRN_DEAR	0x3D5	/* Data Error Address Register */
+#define SPRN_TSR	0x3D8	/* Timer Status Register */
+#define SPRN_TCR	0x3DA	/* Timer Control Register */
+#define SPRN_SRR2	0x3DE	/* Save/Restore Register 2 */
+#define SPRN_SRR3	0x3DF	/* Save/Restore Register 3 */
+#define SPRN_DBSR	0x3F0	/* Debug Status Register */
+#define SPRN_DBCR0	0x3F2	/* Debug Control Register 0 */
+#define SPRN_DAC1	0x3F6	/* Data Address Compare 1 */
+#define SPRN_DAC2	0x3F7	/* Data Address Compare 2 */
+#define SPRN_CSRR0	SPRN_SRR2 /* Critical Save and Restore Register 0 */
+#define SPRN_CSRR1	SPRN_SRR3 /* Critical Save and Restore Register 1 */
+#endif
+
+/* Bit definitions for CCR1. */
+#define	CCR1_DPC	0x00000100 /* Disable L1 I-Cache/D-Cache parity checking */
+#define	CCR1_TCS	0x00000080 /* Timer Clock Select */
+
+/* Bit definitions for the MCSR. */
+#ifdef CONFIG_440A
+#define MCSR_MCS	0x80000000 /* Machine Check Summary */
+#define MCSR_IB		0x40000000 /* Instruction PLB Error */
+#define MCSR_DRB	0x20000000 /* Data Read PLB Error */
+#define MCSR_DWB	0x10000000 /* Data Write PLB Error */
+#define MCSR_TLBP	0x08000000 /* TLB Parity Error */
+#define MCSR_ICP	0x04000000 /* I-Cache Parity Error */
+#define MCSR_DCSP	0x02000000 /* D-Cache Search Parity Error */
+#define MCSR_DCFP	0x01000000 /* D-Cache Flush Parity Error */
+#define MCSR_IMPE	0x00800000 /* Imprecise Machine Check Exception */
+#endif
+#ifdef CONFIG_E500
+#define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
+#define MCSR_ICPERR 	0x40000000UL /* I-Cache Parity Error */
+#define MCSR_DCP_PERR 	0x20000000UL /* D-Cache Push Parity Error */
+#define MCSR_DCPERR 	0x10000000UL /* D-Cache Parity Error */
+#define MCSR_GL_CI 	0x00010000UL /* Guarded Load or Cache-Inhibited stwcx. */
+#define MCSR_BUS_IAERR 	0x00000080UL /* Instruction Address Error */
+#define MCSR_BUS_RAERR 	0x00000040UL /* Read Address Error */
+#define MCSR_BUS_WAERR 	0x00000020UL /* Write Address Error */
+#define MCSR_BUS_IBERR 	0x00000010UL /* Instruction Data Error */
+#define MCSR_BUS_RBERR 	0x00000008UL /* Read Data Bus Error */
+#define MCSR_BUS_WBERR 	0x00000004UL /* Write Data Bus Error */
+#define MCSR_BUS_IPERR 	0x00000002UL /* Instruction parity Error */
+#define MCSR_BUS_RPERR 	0x00000001UL /* Read parity Error */
+#endif
+#ifdef CONFIG_E200
+#define MCSR_MCP 	0x80000000UL /* Machine Check Input Pin */
+#define MCSR_CP_PERR 	0x20000000UL /* Cache Push Parity Error */
+#define MCSR_CPERR 	0x10000000UL /* Cache Parity Error */
+#define MCSR_EXCP_ERR 	0x08000000UL /* ISI, ITLB, or Bus Error on 1st insn
+					fetch for an exception handler */
+#define MCSR_BUS_IRERR 	0x00000010UL /* Read Bus Error on instruction fetch*/
+#define MCSR_BUS_DRERR 	0x00000008UL /* Read Bus Error on data load */
+#define MCSR_BUS_WRERR 	0x00000004UL /* Write Bus Error on buffered
+					store or cache line push */
+#endif
+
+/* Bit definitions for the DBSR. */
+/*
+ * DBSR bits which have conflicting definitions on true Book E versus IBM 40x.
+ */
+#ifdef CONFIG_BOOKE
+#define DBSR_IC		0x08000000	/* Instruction Completion */
+#define DBSR_BT		0x04000000	/* Branch Taken */
+#define DBSR_TIE	0x01000000	/* Trap Instruction Event */
+#define DBSR_IAC1	0x00800000	/* Instr Address Compare 1 Event */
+#define DBSR_IAC2	0x00400000	/* Instr Address Compare 2 Event */
+#define DBSR_IAC3	0x00200000	/* Instr Address Compare 3 Event */
+#define DBSR_IAC4	0x00100000	/* Instr Address Compare 4 Event */
+#define DBSR_DAC1R	0x00080000	/* Data Addr Compare 1 Read Event */
+#define DBSR_DAC1W	0x00040000	/* Data Addr Compare 1 Write Event */
+#define DBSR_DAC2R	0x00020000	/* Data Addr Compare 2 Read Event */
+#define DBSR_DAC2W	0x00010000	/* Data Addr Compare 2 Write Event */
+#endif
+#ifdef CONFIG_40x
+#define DBSR_IC		0x80000000	/* Instruction Completion */
+#define DBSR_BT		0x40000000	/* Branch taken */
+#define DBSR_TIE	0x10000000	/* Trap Instruction debug Event */
+#define DBSR_IAC1	0x04000000	/* Instruction Address Compare 1 Event */
+#define DBSR_IAC2	0x02000000	/* Instruction Address Compare 2 Event */
+#define DBSR_IAC3	0x00080000	/* Instruction Address Compare 3 Event */
+#define DBSR_IAC4	0x00040000	/* Instruction Address Compare 4 Event */
+#define DBSR_DAC1R	0x01000000	/* Data Address Compare 1 Read Event */
+#define DBSR_DAC1W	0x00800000	/* Data Address Compare 1 Write Event */
+#define DBSR_DAC2R	0x00400000	/* Data Address Compare 2 Read Event */
+#define DBSR_DAC2W	0x00200000	/* Data Address Compare 2 Write Event */
+#endif
+
+/* Bit definitions related to the ESR. */
+#define ESR_MCI		0x80000000	/* Machine Check - Instruction */
+#define ESR_IMCP	0x80000000	/* Instr. Machine Check - Protection */
+#define ESR_IMCN	0x40000000	/* Instr. Machine Check - Non-config */
+#define ESR_IMCB	0x20000000	/* Instr. Machine Check - Bus error */
+#define ESR_IMCT	0x10000000	/* Instr. Machine Check - Timeout */
+#define ESR_PIL		0x08000000	/* Program Exception - Illegal */
+#define ESR_PPR		0x04000000	/* Program Exception - Priveleged */
+#define ESR_PTR		0x02000000	/* Program Exception - Trap */
+#define ESR_FP		0x01000000	/* Floating Point Operation */
+#define ESR_DST		0x00800000	/* Storage Exception - Data miss */
+#define ESR_DIZ		0x00400000	/* Storage Exception - Zone fault */
+#define ESR_ST		0x00800000	/* Store Operation */
+#define ESR_DLK		0x00200000	/* Data Cache Locking */
+#define ESR_ILK		0x00100000	/* Instr. Cache Locking */
+#define ESR_PUO		0x00040000	/* Unimplemented Operation exception */
+#define ESR_BO		0x00020000	/* Byte Ordering */
+
+/* Bit definitions related to the DBCR0. */
+#define DBCR0_EDM	0x80000000	/* External Debug Mode */
+#define DBCR0_IDM	0x40000000	/* Internal Debug Mode */
+#define DBCR0_RST	0x30000000	/* all the bits in the RST field */
+#define DBCR0_RST_SYSTEM 0x30000000	/* System Reset */
+#define DBCR0_RST_CHIP	0x20000000	/* Chip Reset */
+#define DBCR0_RST_CORE	0x10000000	/* Core Reset */
+#define DBCR0_RST_NONE	0x00000000	/* No Reset */
+#define DBCR0_IC	0x08000000	/* Instruction Completion */
+#define DBCR0_BT	0x04000000	/* Branch Taken */
+#define DBCR0_EDE	0x02000000	/* Exception Debug Event */
+#define DBCR0_TDE	0x01000000	/* TRAP Debug Event */
+#define DBCR0_IA1	0x00800000	/* Instr Addr compare 1 enable */
+#define DBCR0_IA2	0x00400000	/* Instr Addr compare 2 enable */
+#define DBCR0_IA12	0x00200000	/* Instr Addr 1-2 range enable */
+#define DBCR0_IA12X	0x00100000	/* Instr Addr 1-2 range eXclusive */
+#define DBCR0_IA3	0x00080000	/* Instr Addr compare 3 enable */
+#define DBCR0_IA4	0x00040000	/* Instr Addr compare 4 enable */
+#define DBCR0_IA34	0x00020000	/* Instr Addr 3-4 range Enable */
+#define DBCR0_IA34X	0x00010000	/* Instr Addr 3-4 range eXclusive */
+#define DBCR0_IA12T	0x00008000	/* Instr Addr 1-2 range Toggle */
+#define DBCR0_IA34T	0x00004000	/* Instr Addr 3-4 range Toggle */
+#define DBCR0_FT	0x00000001	/* Freeze Timers on debug event */
+
+/* Bit definitions related to the TCR. */
+#define TCR_WP(x)	(((x)&0x3)<<30)	/* WDT Period */
+#define TCR_WP_MASK	TCR_WP(3)
+#define WP_2_17		0		/* 2^17 clocks */
+#define WP_2_21		1		/* 2^21 clocks */
+#define WP_2_25		2		/* 2^25 clocks */
+#define WP_2_29		3		/* 2^29 clocks */
+#define TCR_WRC(x)	(((x)&0x3)<<28)	/* WDT Reset Control */
+#define TCR_WRC_MASK	TCR_WRC(3)
+#define WRC_NONE	0		/* No reset will occur */
+#define WRC_CORE	1		/* Core reset will occur */
+#define WRC_CHIP	2		/* Chip reset will occur */
+#define WRC_SYSTEM	3		/* System reset will occur */
+#define TCR_WIE		0x08000000	/* WDT Interrupt Enable */
+#define TCR_PIE		0x04000000	/* PIT Interrupt Enable */
+#define TCR_DIE		TCR_PIE		/* DEC Interrupt Enable */
+#define TCR_FP(x)	(((x)&0x3)<<24)	/* FIT Period */
+#define TCR_FP_MASK	TCR_FP(3)
+#define FP_2_9		0		/* 2^9 clocks */
+#define FP_2_13		1		/* 2^13 clocks */
+#define FP_2_17		2		/* 2^17 clocks */
+#define FP_2_21		3		/* 2^21 clocks */
+#define TCR_FIE		0x00800000	/* FIT Interrupt Enable */
+#define TCR_ARE		0x00400000	/* Auto Reload Enable */
+
+/* Bit definitions for the TSR. */
+#define TSR_ENW		0x80000000	/* Enable Next Watchdog */
+#define TSR_WIS		0x40000000	/* WDT Interrupt Status */
+#define TSR_WRS(x)	(((x)&0x3)<<28)	/* WDT Reset Status */
+#define WRS_NONE	0		/* No WDT reset occurred */
+#define WRS_CORE	1		/* WDT forced core reset */
+#define WRS_CHIP	2		/* WDT forced chip reset */
+#define WRS_SYSTEM	3		/* WDT forced system reset */
+#define TSR_PIS		0x08000000	/* PIT Interrupt Status */
+#define TSR_DIS		TSR_PIS		/* DEC Interrupt Status */
+#define TSR_FIS		0x04000000	/* FIT Interrupt Status */
+
+/* Bit definitions for the DCCR. */
+#define DCCR_NOCACHE	0		/* Noncacheable */
+#define DCCR_CACHE	1		/* Cacheable */
+
+/* Bit definitions for DCWR. */
+#define DCWR_COPY	0		/* Copy-back */
+#define DCWR_WRITE	1		/* Write-through */
+
+/* Bit definitions for ICCR. */
+#define ICCR_NOCACHE	0		/* Noncacheable */
+#define ICCR_CACHE	1		/* Cacheable */
+
+/* Bit definitions for L1CSR0. */
+#define L1CSR0_CLFC	0x00000100	/* Cache Lock Bits Flash Clear */
+#define L1CSR0_DCFI	0x00000002	/* Data Cache Flash Invalidate */
+#define L1CSR0_CFI	0x00000002	/* Cache Flash Invalidate */
+#define L1CSR0_DCE	0x00000001	/* Data Cache Enable */
+
+/* Bit definitions for L1CSR1. */
+#define L1CSR1_ICLFR	0x00000100	/* Instr Cache Lock Bits Flash Reset */
+#define L1CSR1_ICFI	0x00000002	/* Instr Cache Flash Invalidate */
+#define L1CSR1_ICE	0x00000001	/* Instr Cache Enable */
+
+/* Bit definitions for SGR. */
+#define SGR_NORMAL	0		/* Speculative fetching allowed. */
+#define SGR_GUARDED	1		/* Speculative fetching disallowed. */
+
+/* Bit definitions for SPEFSCR. */
+#define SPEFSCR_SOVH	0x80000000	/* Summary integer overflow high */
+#define SPEFSCR_OVH	0x40000000	/* Integer overflow high */
+#define SPEFSCR_FGH	0x20000000	/* Embedded FP guard bit high */
+#define SPEFSCR_FXH	0x10000000	/* Embedded FP sticky bit high */
+#define SPEFSCR_FINVH	0x08000000	/* Embedded FP invalid operation high */
+#define SPEFSCR_FDBZH	0x04000000	/* Embedded FP div by zero high */
+#define SPEFSCR_FUNFH	0x02000000	/* Embedded FP underflow high */
+#define SPEFSCR_FOVFH	0x01000000	/* Embedded FP overflow high */
+#define SPEFSCR_FINXS	0x00200000	/* Embedded FP inexact sticky */
+#define SPEFSCR_FINVS	0x00100000	/* Embedded FP invalid op. sticky */
+#define SPEFSCR_FDBZS	0x00080000	/* Embedded FP div by zero sticky */
+#define SPEFSCR_FUNFS	0x00040000	/* Embedded FP underflow sticky */
+#define SPEFSCR_FOVFS	0x00020000	/* Embedded FP overflow sticky */
+#define SPEFSCR_MODE	0x00010000	/* Embedded FP mode */
+#define SPEFSCR_SOV	0x00008000	/* Integer summary overflow */
+#define SPEFSCR_OV	0x00004000	/* Integer overflow */
+#define SPEFSCR_FG	0x00002000	/* Embedded FP guard bit */
+#define SPEFSCR_FX	0x00001000	/* Embedded FP sticky bit */
+#define SPEFSCR_FINV	0x00000800	/* Embedded FP invalid operation */
+#define SPEFSCR_FDBZ	0x00000400	/* Embedded FP div by zero */
+#define SPEFSCR_FUNF	0x00000200	/* Embedded FP underflow */
+#define SPEFSCR_FOVF	0x00000100	/* Embedded FP overflow */
+#define SPEFSCR_FINXE	0x00000040	/* Embedded FP inexact enable */
+#define SPEFSCR_FINVE	0x00000020	/* Embedded FP invalid op. enable */
+#define SPEFSCR_FDBZE	0x00000010	/* Embedded FP div by zero enable */
+#define SPEFSCR_FUNFE	0x00000008	/* Embedded FP underflow enable */
+#define SPEFSCR_FOVFE	0x00000004	/* Embedded FP overflow enable */
+#define SPEFSCR_FRMC 	0x00000003	/* Embedded FP rounding mode control */
+
+/*
+ * The IBM-403 is an even more odd special case, as it is much
+ * older than the IBM-405 series.  We put these down here incase someone
+ * wishes to support these machines again.
+ */
+#ifdef CONFIG_403GCX
+/* Special Purpose Registers (SPRNs)*/
+#define SPRN_TBHU	0x3CC	/* Time Base High User-mode */
+#define SPRN_TBLU	0x3CD	/* Time Base Low User-mode */
+#define SPRN_CDBCR	0x3D7	/* Cache Debug Control Register */
+#define SPRN_TBHI	0x3DC	/* Time Base High */
+#define SPRN_TBLO	0x3DD	/* Time Base Low */
+#define SPRN_DBCR	0x3F2	/* Debug Control Regsiter */
+#define SPRN_PBL1	0x3FC	/* Protection Bound Lower 1 */
+#define SPRN_PBL2	0x3FE	/* Protection Bound Lower 2 */
+#define SPRN_PBU1	0x3FD	/* Protection Bound Upper 1 */
+#define SPRN_PBU2	0x3FF	/* Protection Bound Upper 2 */
+
+
+/* Bit definitions for the DBCR. */
+#define DBCR_EDM	DBCR0_EDM
+#define DBCR_IDM	DBCR0_IDM
+#define DBCR_RST(x)	(((x) & 0x3) << 28)
+#define DBCR_RST_NONE	0
+#define DBCR_RST_CORE	1
+#define DBCR_RST_CHIP	2
+#define DBCR_RST_SYSTEM	3
+#define DBCR_IC		DBCR0_IC	/* Instruction Completion Debug Evnt */
+#define DBCR_BT		DBCR0_BT	/* Branch Taken Debug Event */
+#define DBCR_EDE	DBCR0_EDE	/* Exception Debug Event */
+#define DBCR_TDE	DBCR0_TDE	/* TRAP Debug Event */
+#define DBCR_FER	0x00F80000	/* First Events Remaining Mask */
+#define DBCR_FT		0x00040000	/* Freeze Timers on Debug Event */
+#define DBCR_IA1	0x00020000	/* Instr. Addr. Compare 1 Enable */
+#define DBCR_IA2	0x00010000	/* Instr. Addr. Compare 2 Enable */
+#define DBCR_D1R	0x00008000	/* Data Addr. Compare 1 Read Enable */
+#define DBCR_D1W	0x00004000	/* Data Addr. Compare 1 Write Enable */
+#define DBCR_D1S(x)	(((x) & 0x3) << 12)	/* Data Adrr. Compare 1 Size */
+#define DAC_BYTE	0
+#define DAC_HALF	1
+#define DAC_WORD	2
+#define DAC_QUAD	3
+#define DBCR_D2R	0x00000800	/* Data Addr. Compare 2 Read Enable */
+#define DBCR_D2W	0x00000400	/* Data Addr. Compare 2 Write Enable */
+#define DBCR_D2S(x)	(((x) & 0x3) << 8)	/* Data Addr. Compare 2 Size */
+#define DBCR_SBT	0x00000040	/* Second Branch Taken Debug Event */
+#define DBCR_SED	0x00000020	/* Second Exception Debug Event */
+#define DBCR_STD	0x00000010	/* Second Trap Debug Event */
+#define DBCR_SIA	0x00000008	/* Second IAC Enable */
+#define DBCR_SDA	0x00000004	/* Second DAC Enable */
+#define DBCR_JOI	0x00000002	/* JTAG Serial Outbound Int. Enable */
+#define DBCR_JII	0x00000001	/* JTAG Serial Inbound Int. Enable */
+#endif /* 403GCX */
+#endif /* __ASM_POWERPC_REG_BOOKE_H__ */
+#endif /* __KERNEL__ */
diff --git a/include/asm-powerpc/rheap.h b/include/asm-powerpc/rheap.h
new file mode 100644
index 0000000..1723817
--- /dev/null
+++ b/include/asm-powerpc/rheap.h
@@ -0,0 +1,89 @@
+/*
+ * include/asm-ppc/rheap.h
+ *
+ * Header file for the implementation of a remote heap.
+ *
+ * Author: Pantelis Antoniou <panto@intracom.gr>
+ *
+ * 2004 (c) INTRACOM S.A. Greece. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef __ASM_PPC_RHEAP_H__
+#define __ASM_PPC_RHEAP_H__
+
+#include <linux/list.h>
+
+typedef struct _rh_block {
+	struct list_head list;
+	unsigned long start;
+	int size;
+	const char *owner;
+} rh_block_t;
+
+typedef struct _rh_info {
+	unsigned int alignment;
+	int max_blocks;
+	int empty_slots;
+	rh_block_t *block;
+	struct list_head empty_list;
+	struct list_head free_list;
+	struct list_head taken_list;
+	unsigned int flags;
+} rh_info_t;
+
+#define RHIF_STATIC_INFO	0x1
+#define RHIF_STATIC_BLOCK	0x2
+
+typedef struct _rh_stats {
+	unsigned long start;
+	int size;
+	const char *owner;
+} rh_stats_t;
+
+#define RHGS_FREE	0
+#define RHGS_TAKEN	1
+
+/* Create a remote heap dynamically */
+extern rh_info_t *rh_create(unsigned int alignment);
+
+/* Destroy a remote heap, created by rh_create() */
+extern void rh_destroy(rh_info_t * info);
+
+/* Initialize in place a remote info block */
+extern void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
+		    rh_block_t * block);
+
+/* Attach a free region to manage */
+extern int rh_attach_region(rh_info_t * info, unsigned long start, int size);
+
+/* Detach a free region */
+extern unsigned long rh_detach_region(rh_info_t * info, unsigned long start, int size);
+
+/* Allocate the given size from the remote heap (with alignment) */
+extern unsigned long rh_alloc_align(rh_info_t * info, int size, int alignment,
+		const char *owner);
+
+/* Allocate the given size from the remote heap */
+extern unsigned long rh_alloc(rh_info_t * info, int size, const char *owner);
+
+/* Allocate the given size from the given address */
+extern unsigned long rh_alloc_fixed(rh_info_t * info, unsigned long start, int size,
+			    const char *owner);
+
+/* Free the allocated area */
+extern int rh_free(rh_info_t * info, unsigned long start);
+
+/* Get stats for debugging purposes */
+extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
+			rh_stats_t * stats);
+
+/* Simple dump of remote heap info */
+extern void rh_dump(rh_info_t * info);
+
+/* Set owner of taken block */
+extern int rh_set_owner(rh_info_t * info, unsigned long start, const char *owner);
+
+#endif				/* __ASM_PPC_RHEAP_H__ */
diff --git a/include/asm-ppc/commproc.h b/include/asm-ppc/commproc.h
index 4f99df1..3972487 100644
--- a/include/asm-ppc/commproc.h
+++ b/include/asm-ppc/commproc.h
@@ -63,20 +63,15 @@
 #define CPM_DATAONLY_SIZE	((uint)0x0700)
 #define CPM_DP_NOSPACE		((uint)0x7fffffff)

-static inline long IS_DPERR(const uint offset)
-{
-	return (uint)offset > (uint)-1000L;
-}
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
 extern	cpm8xx_t	*cpmp;		/* Pointer to comm processor */
-extern uint cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(uint offset);
-extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
+extern unsigned long cpm_dpalloc(uint size, uint align);
+extern int cpm_dpfree(unsigned long offset);
+extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
 extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(uint offset);
+extern void *cpm_dpram_addr(unsigned long offset);
 extern uint cpm_dpram_phys(u8* addr);
 extern void cpm_setbrg(uint brg, uint rate);

diff --git a/include/asm-ppc/cpm2.h b/include/asm-ppc/cpm2.h
index 220cc2d..12a2860 100644
--- a/include/asm-ppc/cpm2.h
+++ b/include/asm-ppc/cpm2.h
@@ -104,21 +104,16 @@
  */
 #define NUM_CPM_HOST_PAGES	2

-static inline long IS_DPERR(const uint offset)
-{
-	return (uint)offset > (uint)-1000L;
-}
-
 /* Export the base address of the communication processor registers
  * and dual port ram.
  */
 extern		cpm_cpm2_t	*cpmp;	 /* Pointer to comm processor */

-extern uint cpm_dpalloc(uint size, uint align);
-extern int cpm_dpfree(uint offset);
-extern uint cpm_dpalloc_fixed(uint offset, uint size, uint align);
+extern unsigned long cpm_dpalloc(uint size, uint align);
+extern int cpm_dpfree(unsigned long offset);
+extern unsigned long cpm_dpalloc_fixed(unsigned long offset, uint size, uint align);
 extern void cpm_dpdump(void);
-extern void *cpm_dpram_addr(uint offset);
+extern void *cpm_dpram_addr(unsigned long offset);
 extern void cpm_setbrg(uint brg, uint rate);
 extern void cpm2_fastbrg(uint brg, uint rate, int div16);
 extern void cpm2_reset(void);
diff --git a/include/asm-ppc/rheap.h b/include/asm-ppc/rheap.h
deleted file mode 100644
index 39a10d8..0000000
--- a/include/asm-ppc/rheap.h
+++ /dev/null
@@ -1,89 +0,0 @@
-/*
- * include/asm-ppc/rheap.h
- *
- * Header file for the implementation of a remote heap.
- *
- * Author: Pantelis Antoniou <panto@intracom.gr>
- *
- * 2004 (c) INTRACOM S.A. Greece. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#ifndef __ASM_PPC_RHEAP_H__
-#define __ASM_PPC_RHEAP_H__
-
-#include <linux/list.h>
-
-typedef struct _rh_block {
-	struct list_head list;
-	void *start;
-	int size;
-	const char *owner;
-} rh_block_t;
-
-typedef struct _rh_info {
-	unsigned int alignment;
-	int max_blocks;
-	int empty_slots;
-	rh_block_t *block;
-	struct list_head empty_list;
-	struct list_head free_list;
-	struct list_head taken_list;
-	unsigned int flags;
-} rh_info_t;
-
-#define RHIF_STATIC_INFO	0x1
-#define RHIF_STATIC_BLOCK	0x2
-
-typedef struct rh_stats_t {
-	void *start;
-	int size;
-	const char *owner;
-} rh_stats_t;
-
-#define RHGS_FREE	0
-#define RHGS_TAKEN	1
-
-/* Create a remote heap dynamically */
-extern rh_info_t *rh_create(unsigned int alignment);
-
-/* Destroy a remote heap, created by rh_create() */
-extern void rh_destroy(rh_info_t * info);
-
-/* Initialize in place a remote info block */
-extern void rh_init(rh_info_t * info, unsigned int alignment, int max_blocks,
-		    rh_block_t * block);
-
-/* Attach a free region to manage */
-extern int rh_attach_region(rh_info_t * info, void *start, int size);
-
-/* Detach a free region */
-extern void *rh_detach_region(rh_info_t * info, void *start, int size);
-
-/* Allocate the given size from the remote heap (with alignment) */
-extern void *rh_alloc_align(rh_info_t * info, int size, int alignment,
-		const char *owner);
-
-/* Allocate the given size from the remote heap */
-extern void *rh_alloc(rh_info_t * info, int size, const char *owner);
-
-/* Allocate the given size from the given address */
-extern void *rh_alloc_fixed(rh_info_t * info, void *start, int size,
-			    const char *owner);
-
-/* Free the allocated area */
-extern int rh_free(rh_info_t * info, void *start);
-
-/* Get stats for debugging purposes */
-extern int rh_get_stats(rh_info_t * info, int what, int max_stats,
-			rh_stats_t * stats);
-
-/* Simple dump of remote heap info */
-extern void rh_dump(rh_info_t * info);
-
-/* Set owner of taken block */
-extern int rh_set_owner(rh_info_t * info, void *start, const char *owner);
-
-#endif				/* __ASM_PPC_RHEAP_H__ */
