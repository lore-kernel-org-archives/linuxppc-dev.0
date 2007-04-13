Return-Path: <jk@ozlabs.org>
To: <cbe-oss-dev@ozlabs.org>,
	<linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 13 Apr 2007 11:48:59 +1000
Subject: [PATCH 3/4] cell: fix initialisation on systems with no SPEs
Message-Id: <1176428939.367182.371199141244.qpush@pokey>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This change fixes the case where spu_base and spufs are initialised on a
system with no SPEs - unconditionally create the spu_lists so spu_alloc
doesn't explode, and check for spu_management ops before starting spufs.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

 arch/powerpc/platforms/cell/spu_base.c    |    7 ++++---
 arch/powerpc/platforms/cell/spufs/inode.c |    5 +++++
 2 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spu_base.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spu_base.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spu_base.c
@@ -43,6 +43,7 @@ static LIST_HEAD(spu_full_list);
 static DEFINE_MUTEX(spu_mutex);
 static spinlock_t spu_list_lock = SPIN_LOCK_UNLOCKED;
 
+EXPORT_SYMBOL_GPL(spu_management_ops);
 EXPORT_SYMBOL_GPL(spu_priv1_ops);
 
 void spu_invalidate_slbs(struct spu *spu)
@@ -723,6 +724,9 @@ static int __init init_spu_base(void)
 {
 	int i, ret;
 
+	for (i = 0; i < MAX_NUMNODES; i++)
+		INIT_LIST_HEAD(&spu_list[i]);
+
 	if (!spu_management_ops)
 		return 0;
 
@@ -731,9 +735,6 @@ static int __init init_spu_base(void)
 	if (ret)
 		return ret;
 
-	for (i = 0; i < MAX_NUMNODES; i++)
-		INIT_LIST_HEAD(&spu_list[i]);
-
 	ret = spu_enumerate_spus(create_spu);
 
 	if (ret) {
Index: linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6-spufs.orig/arch/powerpc/platforms/cell/spufs/inode.c
+++ linux-2.6-spufs/arch/powerpc/platforms/cell/spufs/inode.c
@@ -36,6 +36,7 @@
 #include <asm/prom.h>
 #include <asm/semaphore.h>
 #include <asm/spu.h>
+#include <asm/spu_priv1.h>
 #include <asm/uaccess.h>
 
 #include "spufs.h"
@@ -653,6 +654,10 @@ static int __init spufs_init(void)
 {
 	int ret;
 
+	ret = -ENODEV;
+	if (!spu_management_ops)
+		goto out;
+
 	ret = -ENOMEM;
 	spufs_inode_cache = kmem_cache_create("spufs_inode_cache",
 			sizeof(struct spufs_inode_info), 0,
