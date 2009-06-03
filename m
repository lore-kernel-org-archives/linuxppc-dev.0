Return-Path: <sfr@canb.auug.org.au>
Date: Wed, 3 Jun 2009 14:00:51 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: [PATCH] powerpc/spufs: remove unused error path
Message-Id: <20090603140051.b531ae79.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Jan Blunck <jblunck@suse.de>,
	cbe-oss-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Commit 45db9240890d9343c934db1fe82d6e68ac2d28da ("powerpc/spufs: Remove
double check for non-negative dentry") removed the only user of the
out_dput label, so remove it and the code following it.

Gets rid of this warning:

arch/powerpc/platforms/cell/spufs/inode.c: In function 'spufs_create':
arch/powerpc/platforms/cell/spufs/inode.c:647: warning: label 'out_dput' defined but not used

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/cell/spufs/inode.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 36b6700..24b30b6 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -644,8 +644,6 @@ long spufs_create(struct nameidata *nd, unsigned int flags, mode_t mode,
 		fsnotify_mkdir(nd->path.dentry->d_inode, dentry);
 	return ret;
 
-out_dput:
-	dput(dentry);
 out_dir:
 	mutex_unlock(&nd->path.dentry->d_inode->i_mutex);
 out:
-- 
1.6.3.1

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
