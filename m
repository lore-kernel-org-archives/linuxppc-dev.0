Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc/spufs: Initialise inode->i_ino in spufs_new_inode()
Date: Wed, 24 Apr 2013 11:13:14 +1000
Message-Id: <1366765994-13486-1-git-send-email-michael@ellerman.id.au>
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, viro@zeniv.linux.org.uk,
 dchinner@redhat.com, Christoph Hellwig <hch@lst.de>,
 Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 85fe402 (fs: do not assign default i_ino in new_inode), the
initialisation of i_ino was removed from new_inode() and pushed down
into the callers. However spufs_new_inode() was not updated.

This exhibits as no files appearing in /spu, because all our dirents
have a zero inode, which readdir() seems to dislike.

Cc: stable@vger.kernel.org
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/spufs/inode.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 3f3bb4c..35f77a4 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -99,6 +99,7 @@ spufs_new_inode(struct super_block *sb, umode_t mode)
 	if (!inode)
 		goto out;
 
+	inode->i_ino = get_next_ino();
 	inode->i_mode = mode;
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
-- 
1.7.10.4
