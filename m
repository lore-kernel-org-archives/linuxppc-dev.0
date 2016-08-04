Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s4dxc3mdDzDqf4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Aug 2016 15:37:40 +1000 (AEST)
Date: Thu, 4 Aug 2016 08:37:03 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Jeremy Kerr <jk@ozlabs.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 kernel-janitors@vger.kernel.org
Subject: [patch] ppc/cell: missing error code in spufs_mkgang()
Message-ID: <20160804053703.GN775@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We should return -ENOMEM if alloc_spu_gang() fails.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 5be15cf..2975754 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -496,8 +496,10 @@ spufs_mkgang(struct inode *dir, struct dentry *dentry, umode_t mode)
 	gang = alloc_spu_gang();
 	SPUFS_I(inode)->i_ctx = NULL;
 	SPUFS_I(inode)->i_gang = gang;
-	if (!gang)
+	if (!gang) {
+		ret = -ENOMEM;
 		goto out_iput;
+	}
 
 	inode->i_op = &simple_dir_inode_operations;
 	inode->i_fop = &simple_dir_operations;
