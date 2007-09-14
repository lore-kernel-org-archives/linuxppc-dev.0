Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 01/25] spufs: staticify file-internal functions & variables
Message-Id: <1189751574.98527.127994196313.1.gpush@pokey>
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

From: Sebastian Siewior <cbe-oss-dev@ml.breakpoint.cc>

There are a few symbols used only in one file within spufs; this change
makes them static where suitable.

Signed-off-by: Sebastian Siewior <sebastian@breakpoint.cc>
Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/spu_base.c       |    2 +-
 arch/powerpc/platforms/cell/spu_callbacks.c  |    2 +-
 arch/powerpc/platforms/cell/spufs/file.c     |    6 +++---
 arch/powerpc/platforms/cell/spufs/run.c      |    4 ++--
 arch/powerpc/platforms/cell/spufs/syscalls.c |    4 ++--
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spu_base.c b/arch/powerpc/platforms/cell/spu_base.c
index 106d292..b5a2117 100644
--- a/arch/powerpc/platforms/cell/spu_base.c
+++ b/arch/powerpc/platforms/cell/spu_base.c
@@ -458,7 +458,7 @@ static int spu_shutdown(struct sys_device *sysdev)
 	return 0;
 }
 
-struct sysdev_class spu_sysdev_class = {
+static struct sysdev_class spu_sysdev_class = {
 	set_kset_name("spu"),
 	.shutdown = spu_shutdown,
 };
diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index 47ec3be..ab39e22 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -33,7 +33,7 @@
  *	mbind, mq_open, ipc, ...
  */
 
-void *spu_syscall_table[] = {
+static void *spu_syscall_table[] = {
 #define SYSCALL(func)		sys_ni_syscall,
 #define COMPAT_SYS(func)	sys_ni_syscall,
 #define PPC_SYS(func)		sys_ni_syscall,
diff --git a/arch/powerpc/platforms/cell/spufs/file.c b/arch/powerpc/platforms/cell/spufs/file.c
index 4100ddc..a4a8770 100644
--- a/arch/powerpc/platforms/cell/spufs/file.c
+++ b/arch/powerpc/platforms/cell/spufs/file.c
@@ -199,9 +199,9 @@ static int spufs_mem_mmap(struct file *file, struct vm_area_struct *vma)
 }
 
 #ifdef CONFIG_SPU_FS_64K_LS
-unsigned long spufs_get_unmapped_area(struct file *file, unsigned long addr,
-				      unsigned long len, unsigned long pgoff,
-				      unsigned long flags)
+static unsigned long spufs_get_unmapped_area(struct file *file,
+		unsigned long addr, unsigned long len, unsigned long pgoff,
+		unsigned long flags)
 {
 	struct spu_context	*ctx = file->private_data;
 	struct spu_state	*csa = &ctx->csa;
diff --git a/arch/powerpc/platforms/cell/spufs/run.c b/arch/powerpc/platforms/cell/spufs/run.c
index 958f10e..1ce5e22 100644
--- a/arch/powerpc/platforms/cell/spufs/run.c
+++ b/arch/powerpc/platforms/cell/spufs/run.c
@@ -205,7 +205,7 @@ static int spu_reacquire_runnable(struct spu_context *ctx, u32 *npc,
  * This means we can only do a very rough approximation of POSIX
  * signal semantics.
  */
-int spu_handle_restartsys(struct spu_context *ctx, long *spu_ret,
+static int spu_handle_restartsys(struct spu_context *ctx, long *spu_ret,
 			  unsigned int *npc)
 {
 	int ret;
@@ -241,7 +241,7 @@ int spu_handle_restartsys(struct spu_context *ctx, long *spu_ret,
 	return ret;
 }
 
-int spu_process_callback(struct spu_context *ctx)
+static int spu_process_callback(struct spu_context *ctx)
 {
 	struct spu_syscall_block s;
 	u32 ls_pointer, npc;
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index 43f0fb8..3d8c328 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -76,8 +76,8 @@ asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
 }
 #endif
 
-asmlinkage long do_spu_create(const char __user *pathname, unsigned int flags,
-				mode_t mode, struct file *neighbor)
+static asmlinkage long do_spu_create(const char __user *pathname,
+		unsigned int flags, mode_t mode, struct file *neighbor)
 {
 	char *tmp;
 	int ret;
