Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3831E67B14
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Apr 2006 00:12:22 +1000 (EST)
Date: Thu, 6 Apr 2006 16:12:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: arndb@arndb.de
Subject: [PATCH] spufs: fix section conflicts
Message-ID: <20060406141217.GA9329@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spufs_init/spufs_exit call various __init/__exit functions so they
need to be marked __init/__exit aswell to not get section conflicts.
Also move the module_init call to where it belongs.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 15:53:42.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 15:56:21.000000000 +0200
@@ -442,7 +442,7 @@
 	.kill_sb = kill_litter_super,
 };
 
-static int spufs_init(void)
+static int __init spufs_init(void)
 {
 	int ret;
 	ret = -ENOMEM;
@@ -470,15 +470,16 @@
 out:
 	return ret;
 }
-module_init(spufs_init);
 
-static void spufs_exit(void)
+static void __exit spufs_exit(void)
 {
 	spu_sched_exit();
 	unregister_spu_syscalls(&spufs_calls);
 	unregister_filesystem(&spufs_type);
 	kmem_cache_destroy(spufs_inode_cache);
 }
+
+module_init(spufs_init);
 module_exit(spufs_exit);
 
 MODULE_LICENSE("GPL");
