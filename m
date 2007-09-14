Return-Path: <jk@ozlabs.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Subject: [PATCH 06/25] cell: unify spufs syscall path
Message-Id: <1189751574.102306.950311485995.6.gpush@pokey>
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

At present, a built-in spufs will not use the spufs_calls callbacks, but
directly call sys_spu_create. This saves us an indirect branch, but
means we have duplicated functions - one for CONFIG_SPU_FS=y and one for
=m.

This change unifies the spufs syscall path, and provides access to the
spufs_calls structure through a get/put pair. At present, the only user
of the spufs_calls structure is spu_syscalls.c, but this will facilitate
adding the coredump calls later. We also add a mutex to protect the
spufs_calls struct, so that accesses to the calls don't race with
{,un}register_spu_calls.

Everyone likes numbers, right? Here's a before/after comparison with
CONFIG_SPU_FS=y, doing spu_create(); close(); 64k times.

Before:
	[jk@cell ~]$ time ./spu_create
	performing 65536 spu_create calls

	real    0m24.075s
	user    0m0.146s
	sys     0m23.925s

After:
	[jk@cell ~]$ time ./spu_create
	performing 65536 spu_create calls

	real    0m24.777s
	user    0m0.141s
	sys     0m24.631s

So, we're adding around 11us per syscall, at the benefit of having
only one syscall path.

Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

---
 arch/powerpc/platforms/cell/Makefile         |    4 
 arch/powerpc/platforms/cell/spu_syscalls.c   |  117 +++++++++++++++++----------
 arch/powerpc/platforms/cell/spufs/spufs.h    |    1 
 arch/powerpc/platforms/cell/spufs/syscalls.c |   42 ---------
 include/asm-powerpc/spu.h                    |   14 ---
 5 files changed, 78 insertions(+), 100 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index f88a7c7..40f78e9 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -13,15 +13,13 @@ obj-$(CONFIG_PPC_CELL_NATIVE)		+= smp.o
 endif
 
 # needed only when building loadable spufs.ko
-spufs-modular-$(CONFIG_SPU_FS)		+= spu_syscalls.o
 spu-priv1-$(CONFIG_PPC_CELL_NATIVE)	+= spu_priv1_mmio.o
 
 spu-manage-$(CONFIG_PPC_CELLEB)		+= spu_manage.o
 spu-manage-$(CONFIG_PPC_CELL_NATIVE)	+= spu_manage.o
 
 obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
-					   spu_coredump.o \
-					   $(spufs-modular-m) \
+					   spu_coredump.o spu_syscalls.o \
 					   $(spu-priv1-y) \
 					   $(spu-manage-y) \
 					   spufs/
diff --git a/arch/powerpc/platforms/cell/spu_syscalls.c b/arch/powerpc/platforms/cell/spu_syscalls.c
index 027ac32..76815c5 100644
--- a/arch/powerpc/platforms/cell/spu_syscalls.c
+++ b/arch/powerpc/platforms/cell/spu_syscalls.c
@@ -22,42 +22,67 @@
 #include <linux/file.h>
 #include <linux/module.h>
 #include <linux/syscalls.h>
+#include <linux/mutex.h>
 
 #include <asm/spu.h>
 
-struct spufs_calls spufs_calls = {
-	.owner = NULL,
-};
+static struct spufs_calls *spufs_calls;
+DEFINE_MUTEX(spufs_calls_mutex);
 
-/* These stub syscalls are needed to have the actual implementation
- * within a loadable module. When spufs is built into the kernel,
- * this file is not used and the syscalls directly enter the fs code */
+#ifdef CONFIG_SPU_FS_MODULE
+
+static inline struct spufs_calls *spufs_calls_get(void)
+{
+	struct spufs_calls *calls = NULL;
+
+	mutex_lock(&spufs_calls_mutex);
+	if (spufs_calls && try_module_get(spufs_calls->owner))
+		calls = spufs_calls;
+	mutex_unlock(&spufs_calls_mutex);
+
+	return calls;
+}
+
+static inline void spufs_calls_put(struct spufs_calls *calls)
+{
+	BUG_ON(calls != spufs_calls);
+	module_put(calls->owner);
+}
+
+#else /* !defined CONFIG_SPU_FS_MODULE */
+
+static inline struct spufs_calls *spufs_calls_get(void)
+{
+	return spufs_calls;
+}
+
+static inline void spufs_calls_put(struct spufs_calls *calls) { }
+
+#endif /* CONFIG_SPU_FS_MODULE */
 
 asmlinkage long sys_spu_create(const char __user *name,
 		unsigned int flags, mode_t mode, int neighbor_fd)
 {
 	long ret;
-	struct module *owner = spufs_calls.owner;
 	struct file *neighbor;
 	int fput_needed;
+	struct spufs_calls *calls;
 
-	ret = -ENOSYS;
-	if (owner && try_module_get(owner)) {
-		if (flags & SPU_CREATE_AFFINITY_SPU) {
-			neighbor = fget_light(neighbor_fd, &fput_needed);
-			ret = -EBADF;
-			if (neighbor) {
-				ret = spufs_calls.create_thread(name, flags,
-								mode, neighbor);
-				fput_light(neighbor, fput_needed);
-			}
-		}
-		else {
-			ret = spufs_calls.create_thread(name, flags,
-							mode, NULL);
+	calls = spufs_calls_get();
+	if (!calls)
+		return -ENOSYS;
+
+	if (flags & SPU_CREATE_AFFINITY_SPU) {
+		ret = -EBADF;
+		neighbor = fget_light(neighbor_fd, &fput_needed);
+		if (neighbor) {
+			ret = calls->create_thread(name, flags, mode, neighbor);
+			fput_light(neighbor, fput_needed);
 		}
-		module_put(owner);
-	}
+	} else
+		ret = calls->create_thread(name, flags, mode, NULL);
+
+	spufs_calls_put(calls);
 	return ret;
 }
 
@@ -66,37 +91,43 @@ asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
 	long ret;
 	struct file *filp;
 	int fput_needed;
-	struct module *owner = spufs_calls.owner;
+	struct spufs_calls *calls;
 
-	ret = -ENOSYS;
-	if (owner && try_module_get(owner)) {
-		ret = -EBADF;
-		filp = fget_light(fd, &fput_needed);
-		if (filp) {
-			ret = spufs_calls.spu_run(filp, unpc, ustatus);
-			fput_light(filp, fput_needed);
-		}
-		module_put(owner);
+	calls = spufs_calls_get();
+	if (!calls)
+		return -ENOSYS;
+
+	ret = -EBADF;
+	filp = fget_light(fd, &fput_needed);
+	if (filp) {
+		ret = calls->spu_run(filp, unpc, ustatus);
+		fput_light(filp, fput_needed);
 	}
+
+	spufs_calls_put(calls);
 	return ret;
 }
 
 int register_spu_syscalls(struct spufs_calls *calls)
 {
-	if (spufs_calls.owner)
-		return -EBUSY;
-
-	spufs_calls.create_thread = calls->create_thread;
-	spufs_calls.spu_run = calls->spu_run;
-	smp_mb();
-	spufs_calls.owner = calls->owner;
-	return 0;
+	int ret = 0;
+
+	mutex_lock(&spufs_calls_mutex);
+	if (!spufs_calls)
+		spufs_calls = calls;
+	else
+		ret = -EBUSY;
+	mutex_unlock(&spufs_calls_mutex);
+
+	return ret;
 }
 EXPORT_SYMBOL_GPL(register_spu_syscalls);
 
 void unregister_spu_syscalls(struct spufs_calls *calls)
 {
-	BUG_ON(spufs_calls.owner != calls->owner);
-	spufs_calls.owner = NULL;
+	mutex_lock(&spufs_calls_mutex);
+	BUG_ON(spufs_calls->owner != calls->owner);
+	spufs_calls = NULL;
+	mutex_unlock(&spufs_calls_mutex);
 }
 EXPORT_SYMBOL_GPL(unregister_spu_syscalls);
diff --git a/arch/powerpc/platforms/cell/spufs/spufs.h b/arch/powerpc/platforms/cell/spufs/spufs.h
index 2bfdeb8..3dbffeb 100644
--- a/arch/powerpc/platforms/cell/spufs/spufs.h
+++ b/arch/powerpc/platforms/cell/spufs/spufs.h
@@ -200,6 +200,7 @@ extern struct tree_descr spufs_dir_contents[];
 extern struct tree_descr spufs_dir_nosched_contents[];
 
 /* system call implementation */
+extern struct spufs_calls spufs_calls;
 long spufs_run_spu(struct spu_context *ctx, u32 *npc, u32 *status);
 long spufs_create(struct nameidata *nd, unsigned int flags,
 			mode_t mode, struct file *filp);
diff --git a/arch/powerpc/platforms/cell/spufs/syscalls.c b/arch/powerpc/platforms/cell/spufs/syscalls.c
index 936e0a8..22b138d 100644
--- a/arch/powerpc/platforms/cell/spufs/syscalls.c
+++ b/arch/powerpc/platforms/cell/spufs/syscalls.c
@@ -58,24 +58,6 @@ out:
 	return ret;
 }
 
-#ifndef MODULE
-asmlinkage long sys_spu_run(int fd, __u32 __user *unpc, __u32 __user *ustatus)
-{
-	int fput_needed;
-	struct file *filp;
-	long ret;
-
-	ret = -EBADF;
-	filp = fget_light(fd, &fput_needed);
-	if (filp) {
-		ret = do_spu_run(filp, unpc, ustatus);
-		fput_light(filp, fput_needed);
-	}
-
-	return ret;
-}
-#endif
-
 static long do_spu_create(const char __user *pathname, unsigned int flags,
 		mode_t mode, struct file *neighbor)
 {
@@ -99,30 +81,6 @@ static long do_spu_create(const char __user *pathname, unsigned int flags,
 	return ret;
 }
 
-#ifndef MODULE
-asmlinkage long sys_spu_create(const char __user *pathname, unsigned int flags,
-				mode_t mode, int neighbor_fd)
-{
-	int fput_needed;
-	struct file *neighbor;
-	long ret;
-
-	if (flags & SPU_CREATE_AFFINITY_SPU) {
-		ret = -EBADF;
-		neighbor = fget_light(neighbor_fd, &fput_needed);
-		if (neighbor) {
-			ret = do_spu_create(pathname, flags, mode, neighbor);
-			fput_light(neighbor, fput_needed);
-		}
-	}
-	else {
-		ret = do_spu_create(pathname, flags, mode, NULL);
-	}
-
-	return ret;
-}
-#endif
-
 struct spufs_calls spufs_calls = {
 	.create_thread = do_spu_create,
 	.spu_run = do_spu_run,
diff --git a/include/asm-powerpc/spu.h b/include/asm-powerpc/spu.h
index 5bde398..383ecfd 100644
--- a/include/asm-powerpc/spu.h
+++ b/include/asm-powerpc/spu.h
@@ -238,14 +238,14 @@ extern long spu_sys_callback(struct spu_syscall_block *s);
 
 /* syscalls implemented in spufs */
 struct file;
-extern struct spufs_calls {
+struct spufs_calls {
 	asmlinkage long (*create_thread)(const char __user *name,
 					unsigned int flags, mode_t mode,
 					struct file *neighbor);
 	asmlinkage long (*spu_run)(struct file *filp, __u32 __user *unpc,
 						__u32 __user *ustatus);
 	struct module *owner;
-} spufs_calls;
+};
 
 /* coredump calls implemented in spufs */
 struct spu_coredump_calls {
@@ -274,18 +274,8 @@ struct spu_coredump_calls {
 #define SPU_CREATE_FLAG_ALL		0x003f /* mask of all valid flags */
 
 
-#ifdef CONFIG_SPU_FS_MODULE
 int register_spu_syscalls(struct spufs_calls *calls);
 void unregister_spu_syscalls(struct spufs_calls *calls);
-#else
-static inline int register_spu_syscalls(struct spufs_calls *calls)
-{
-	return 0;
-}
-static inline void unregister_spu_syscalls(struct spufs_calls *calls)
-{
-}
-#endif /* MODULE */
 
 int register_arch_coredump_calls(struct spu_coredump_calls *calls);
 void unregister_arch_coredump_calls(struct spu_coredump_calls *calls);
