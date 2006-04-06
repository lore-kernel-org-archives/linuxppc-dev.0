Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 77BE367A77
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 23:58:43 +1000 (EST)
Received: from verein.lst.de (localhost [127.0.0.1])
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id k36DqiRT008890
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Apr 2006 15:52:44 +0200
Received: (from hch@localhost)
	by verein.lst.de (8.12.3/8.12.3/Debian-6.6) id k36Dqi02008888
	for linuxppc-dev@ozlabs.org; Thu, 6 Apr 2006 15:52:44 +0200
Resent-Message-Id: <200604061352.k36Dqi02008888@verein.lst.de>
Date: Thu, 6 Apr 2006 15:50:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: arndb@arndb.de
Subject: [PATCH] spufs: const fops
Message-ID: <20060406135023.GC8552@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

file_operations are const post-2.6.16, fix spufs_new_file to propagate
that properly.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 11:48:33.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 11:49:53.000000000 +0200
@@ -103,7 +103,7 @@
 
 static int
 spufs_new_file(struct super_block *sb, struct dentry *dentry,
-		struct file_operations *fops, int mode,
+		const struct file_operations *fops, int mode,
 		struct spu_context *ctx)
 {
 	static struct inode_operations spufs_file_iops = {
