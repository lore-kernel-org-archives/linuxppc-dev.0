Return-Path: <paulus@ozlabs.org>
Date: Sat, 18 Jan 2014 21:14:47 +1100
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Make sure "cache" directory is removed when
 offlining cpu
Message-ID: <20140118101447.GA4929@iris.ozlabs.ibm.com>
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

The code in remove_cache_dir() is supposed to remove the "cache"
subdirectory from the sysfs directory for a CPU when that CPU is
being offlined.  It tries to do this by calling kobject_put() on
the kobject for the subdirectory.  However, the subdirectory only
gets removed once the last reference goes away, and the reference
being put here may well not be the last reference.  That means
that the "cache" subdirectory may still exist when the offlining
operation has finished.  If the same CPU subsequently gets onlined,
the code tries to add a new "cache" subdirectory.  If the old
subdirectory has not yet been removed, we get a WARN_ON in the
sysfs code, with stack trace, and an error message printed on the
console.  Further, we ultimately end up with an online cpu with no
"cache" subdirectory.

This fixes it by doing an explicit kobject_del() at the point where
we want the subdirectory to go away.  kobject_del() removes the sysfs
directory even though the object still exists in memory.  The object
will get freed at some point in the future.  A subsequent onlining
operation can create a new sysfs directory, even if the old object
still exists in memory, without causing any problems.

Cc: stable@vger.kernel.org # v3.0+
Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/kernel/cacheinfo.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/cacheinfo.c b/arch/powerpc/kernel/cacheinfo.c
index 6549327..bfb8236 100644
--- a/arch/powerpc/kernel/cacheinfo.c
+++ b/arch/powerpc/kernel/cacheinfo.c
@@ -794,6 +794,9 @@ static void remove_cache_dir(struct cache_dir *cache_dir)
 {
 	remove_index_dirs(cache_dir);
 
+	/* Remove cache dir from sysfs */
+	kobject_del(cache_dir->kobj);
+
 	kobject_put(cache_dir->kobj);
 
 	kfree(cache_dir);
-- 
1.8.5.2
