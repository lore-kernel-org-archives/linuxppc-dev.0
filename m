Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc/spufs: remove double check for non-negative dentry
Date: Wed, 13 May 2009 17:58:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200905131758.57327.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Jan Blunck <jblunck@suse.de>,
	Jeremy Kerr <jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan Blunck <jblunck@suse.de>

This patch removes an unnecessary double check if the dentry returned by
lookup_create() is actually non-negative. Since lookup_create() itself returns
an error in this case just remove the check.

Signed-off-by: Jan Blunck <jblunck@suse.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/cell/spufs/inode.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 706eb5c..36b6700 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -631,10 +631,6 @@ long spufs_create(struct nameidata *nd, unsigned int flags, mode_t mode,
 	if (IS_ERR(dentry))
 		goto out_dir;
 
-	ret = -EEXIST;
-	if (dentry->d_inode)
-		goto out_dput;
-
 	mode &= ~current_umask();
 
 	if (flags & SPU_CREATE_GANG)
-- 
1.5.6.3
