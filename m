Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s1nrG6rbSzDrFk
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jul 2016 00:23:10 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@osdl.org>
Cc: tytso@mit.edu, <linux-kernel@vger.kernel.org>, <linuxppc-dev@ozlabs.org>
Subject: [PATCH] random: Fix crashes with sparse node ids
Date: Sun, 31 Jul 2016 00:23:08 +1000
Message-Id: <1469888588-5918-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On a system with sparse node ids, eg. a powerpc system with 4 nodes
numbered like so:

  node   0: [mem 0x0000000000000000-0x00000007ffffffff]
  node   1: [mem 0x0000000800000000-0x0000000fffffffff]
  node  16: [mem 0x0000001000000000-0x00000017ffffffff]
  node  17: [mem 0x0000001800000000-0x0000001fffffffff]

The code in rand_initialize() will allocate 4 pointers for the pool
array, and initialise them correctly.

However when go to use the pool, in eg. extract_crng(), we use the
numa_node_id() to index into the array. For the higher numbered node ids
this leads to random memory corruption, depending on what was kmalloc'ed
adjacent to the pool array.

Fix it by using nr_node_ids to size the pool array.

Fixes: 1e7f583af67b ("random: make /dev/urandom scalable for silly userspace programs")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 7f0622426b97..ea03dfe2f21c 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -249,6 +249,7 @@
 #include <linux/genhd.h>
 #include <linux/interrupt.h>
 #include <linux/mm.h>
+#include <linux/nodemask.h>
 #include <linux/spinlock.h>
 #include <linux/kthread.h>
 #include <linux/percpu.h>
@@ -1656,7 +1657,6 @@ static int rand_initialize(void)
 {
 #ifdef CONFIG_NUMA
 	int i;
-	int num_nodes = num_possible_nodes();
 	struct crng_state *crng;
 	struct crng_state **pool;
 #endif
@@ -1666,7 +1666,7 @@ static int rand_initialize(void)
 	crng_initialize(&primary_crng);
 
 #ifdef CONFIG_NUMA
-	pool = kmalloc(num_nodes * sizeof(void *),
+	pool = kmalloc(nr_node_ids * sizeof(void *),
 		       GFP_KERNEL|__GFP_NOFAIL|__GFP_ZERO);
 	for_each_online_node(i) {
 		crng = kmalloc_node(sizeof(struct crng_state),
-- 
2.7.4
