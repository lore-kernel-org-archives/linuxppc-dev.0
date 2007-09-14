Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 07/25] spufs: remove asmlinkage from spufs_calls
Message-Id: <1189751574.102962.249599192155.7.gpush@pokey>
In-Reply-To: <1189751574.98527.127994196313.1.gpush@pokey>
To: <linuxppc-dev@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
Date: Fri, 14 Sep 2007 16:32:54 +1000
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

spu_create and spu_run are wrapped by the cell syscall layer, so
we don't need the asmlinkage.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 include/asm-powerpc/spu.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-powerpc/spu.h b/include/asm-powerpc/spu.h
index 383ecfd..eb1159c 100644
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -239,10 +239,10 @@ extern long spu_sys_callback(struct spu_syscall_block *s);
 /* syscalls implemented in spufs */
 struct file;
 struct spufs_calls {
-	asmlinkage long (*create_thread)(const char __user *name,
+	long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode,
 					struct file *neighbor);
-	asmlinkage long (*spu_run)(struct file *filp, __u32 __user *unpc,
+	long (*spu_run)(struct file *filp, __u32 __user *unpc,
 						__u32 __user *ustatus);
 	struct module *owner;
 };
