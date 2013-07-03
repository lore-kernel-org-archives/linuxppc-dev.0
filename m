Return-Path: <Waiman.Long@hp.com>
From: Waiman Long <Waiman.Long@hp.com>
To: 
Subject: [PATCH v3 04/25] powerpc: Change how dentry's d_lock field is accessed
Date: Wed,  3 Jul 2013 16:19:57 -0400
Message-Id: <1372882797-22614-1-git-send-email-Waiman.Long@hp.com>
To: Alexander Viro <viro@zeniv.linux.org.uk> , Jeff Layton <jlayton@redhat.com>,
 Miklos Szeredi <mszeredi@suse.cz>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: cbe-oss-dev@lists.ozlabs.org, Waiman Long <Waiman.Long@hp.com>,
 Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 "Chandramouleeswaran, Aswin" <aswin@hp.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andi Kleen <andi@firstfloor.org>, Paul Mackerras <paulus@samba.org>,
 Jeremy Kerr <jk@ozlabs.org>, "Norton, Scott J" <scott.norton@hp.com>,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Because of the changes made in dcache.h header file, files that
use the d_lock field of the dentry structure need to be changed
accordingly. All the d_lock's spin_lock() and spin_unlock() calls
are replaced by the corresponding d_lock() and d_unlock() calls.
There is no change in logic and everything should just work.

Signed-off-by: Waiman Long <Waiman.Long@hp.com>
---
 arch/powerpc/platforms/cell/spufs/inode.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 35f77a4..3597c4b 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -165,18 +165,18 @@ static void spufs_prune_dir(struct dentry *dir)
 
 	mutex_lock(&dir->d_inode->i_mutex);
 	list_for_each_entry_safe(dentry, tmp, &dir->d_subdirs, d_u.d_child) {
-		spin_lock(&dentry->d_lock);
+		d_lock(dentry);
 		if (!(d_unhashed(dentry)) && dentry->d_inode) {
 			dget_dlock(dentry);
 			__d_drop(dentry);
-			spin_unlock(&dentry->d_lock);
+			d_unlock(dentry);
 			simple_unlink(dir->d_inode, dentry);
 			/* XXX: what was dcache_lock protecting here? Other
 			 * filesystems (IB, configfs) release dcache_lock
 			 * before unlink */
 			dput(dentry);
 		} else {
-			spin_unlock(&dentry->d_lock);
+			d_unlock(dentry);
 		}
 	}
 	shrink_dcache_parent(dir);
-- 
1.7.1
