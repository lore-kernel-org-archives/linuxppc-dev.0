Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E678767A77
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 23:58:45 +1000 (EST)
Date: Thu, 6 Apr 2006 15:48:10 +0200
From: Christoph Hellwig <hch@lst.de>
To: arndb@arndb.de
Subject: [PATCH] spufs: fix compile
Message-ID: <20060406134810.GB8552@lst.de>
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

The current tree isn't exctly sure about the arguments to
alloc_spu_context, let it agree on the no-arguments version.


Signed-off-by: Christoph Hellwig <hch@lst.de>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 10:28:08.000000000 +0200
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/inode.c	2006-04-06 15:45:36.000000000 +0200
@@ -241,7 +241,7 @@
 		inode->i_gid = dir->i_gid;
 		inode->i_mode &= S_ISGID;
 	}
-	ctx = alloc_spu_context(inode->i_mapping);
+	ctx = alloc_spu_context();
 	SPUFS_I(inode)->i_ctx = ctx;
 	if (!ctx)
 		goto out_iput;
