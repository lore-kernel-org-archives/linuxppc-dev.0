Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tCJlQ209mzDvY6
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Nov 2016 04:07:13 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA7H45OX072413
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 12:07:11 -0500
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26jv0d9gy6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 07 Nov 2016 12:07:11 -0500
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Mon, 7 Nov 2016 17:07:08 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id A19B817D8063
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 17:09:25 +0000 (GMT)
Received: from d06av09.portsmouth.uk.ibm.com (d06av09.portsmouth.uk.ibm.com
 [9.149.37.250])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA7H75QN30212178
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 17:07:05 GMT
Received: from d06av09.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av09.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA7H74U3002929
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Nov 2016 10:07:05 -0700
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
To: imunsie@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] cxl: Fix coredump generation when cxl_get_fd() is used
Date: Mon,  7 Nov 2016 18:07:04 +0100
Message-Id: <20161107170704.17838-1-fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a process dumps core while owning a cxl file descriptor obtained
from an AFU driver (e.g. cxlflash) through the cxl_get_fd() API, the
following error occurs:

[  868.027591] Unable to handle kernel paging request for data at address ...
[  868.027778] Faulting instruction address: 0xc00000000035edb0
cpu 0x8c: Vector: 300 (Data Access) at [c000003c688275e0]
    pc: c00000000035edb0: elf_core_dump+0xd60/0x1300
    lr: c00000000035ed80: elf_core_dump+0xd30/0x1300
    sp: c000003c68827860
   msr: 9000000100009033
   dar: c
dsisr: 40000000
 current = 0xc000003c68780000
 paca    = 0xc000000001b73200   softe: 0        irq_happened: 0x01
    pid   = 46725, comm = hxesurelock
enter ? for help
[c000003c68827a60] c00000000036948c do_coredump+0xcec/0x11e0
[c000003c68827c20] c0000000000ce9e0 get_signal+0x540/0x7b0
[c000003c68827d10] c000000000017354 do_signal+0x54/0x2b0
[c000003c68827e00] c00000000001777c do_notify_resume+0xbc/0xd0
[c000003c68827e30] c000000000009838 ret_from_except_lite+0x64/0x68
--- Exception: 300 (Data Access) at 00003fff98ad2918

The root cause is that the address_space structure for the file
doesn't define a 'host' member.

When cxl allocates a file descriptor, it's using the anonymous inode
to back the file, but allocates a private address_space for each
context. The private address_space allows to track memory allocation
for each context. cxl doesn't define the 'host' member of the address
space, i.e. the inode. We don't want to define it as the anonymous
inode, since there's no longer a 1-to-1 relation between address_space
and inode.

To fix it, instead of using the anonymous inode, we introduce a simple
pseudo filesystem so that cxl can allocate its own inodes. So we now
have one inode for each file and address_space. The pseudo filesystem
is only mounted on the first allocation of a file descriptor by
cxl_get_fd().

Tested with cxlflash.

Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
---
 drivers/misc/cxl/api.c     | 138 +++++++++++++++++++++++++++++++++++++--------
 drivers/misc/cxl/context.c |  17 ++++--
 drivers/misc/cxl/cxl.h     |   6 +-
 drivers/misc/cxl/file.c    |   5 +-
 4 files changed, 135 insertions(+), 31 deletions(-)

diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
index 2e5233b..7640339 100644
--- a/drivers/misc/cxl/api.c
+++ b/drivers/misc/cxl/api.c
@@ -9,18 +9,119 @@
 
 #include <linux/pci.h>
 #include <linux/slab.h>
-#include <linux/anon_inodes.h>
 #include <linux/file.h>
 #include <misc/cxl.h>
-#include <linux/fs.h>
 #include <asm/pnv-pci.h>
 #include <linux/msi.h>
+#include <linux/module.h>
+#include <linux/mount.h>
 
 #include "cxl.h"
 
+/*
+ * Since we want to track memory mappings to be able to force-unmap
+ * when the AFU is no longer reachable, we need an inode. For devices
+ * opened through the cxl user API, this is not a problem, but a
+ * userland process can also get a cxl fd through the cxl_get_fd()
+ * API, which is used by the cxlflash driver.
+ *
+ * Therefore we implement our own simple pseudo-filesystem and inode
+ * allocator. We don't use the anonymous inode, as we need the
+ * meta-data associated with it (address_space) and it is shared by
+ * other drivers/processes, so it could lead to cxl unmapping VMAs
+ * from random processes.
+ */
+
+#define CXL_PSEUDO_FS_MAGIC	0x1697697f
+
+static int cxl_fs_cnt;
+static struct vfsmount *cxl_vfs_mount;
+
+static const struct dentry_operations cxl_fs_dops = {
+	.d_dname	= simple_dname,
+};
+
+static struct dentry *cxl_fs_mount(struct file_system_type *fs_type, int flags,
+				const char *dev_name, void *data)
+{
+	return mount_pseudo(fs_type, "cxl:", NULL, &cxl_fs_dops,
+			CXL_PSEUDO_FS_MAGIC);
+}
+
+static struct file_system_type cxl_fs_type = {
+	.name		= "cxl",
+	.owner		= THIS_MODULE,
+	.mount		= cxl_fs_mount,
+	.kill_sb	= kill_anon_super,
+};
+
+
+void cxl_release_mapping(struct cxl_context *ctx)
+{
+	if (ctx->kernelapi && ctx->mapping)
+		simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
+}
+
+static struct file *cxl_getfile(const char *name,
+				const struct file_operations *fops,
+				void *priv, int flags)
+{
+	struct qstr this;
+	struct path path;
+	struct file *file;
+	struct inode *inode = NULL;
+	int rc;
+
+	/* strongly inspired by anon_inode_getfile() */
+
+	if (fops->owner && !try_module_get(fops->owner))
+		return ERR_PTR(-ENOENT);
+
+	rc = simple_pin_fs(&cxl_fs_type, &cxl_vfs_mount, &cxl_fs_cnt);
+	if (rc < 0) {
+		pr_err("Cannot mount cxl pseudo filesystem: %d\n", rc);
+		file = ERR_PTR(rc);
+		goto err_module;
+	}
+
+	inode = alloc_anon_inode(cxl_vfs_mount->mnt_sb);
+	if (IS_ERR(inode)) {
+		file = ERR_CAST(inode);
+		goto err_fs;
+	}
+
+	file = ERR_PTR(-ENOMEM);
+	this.name = name;
+	this.len = strlen(name);
+	this.hash = 0;
+	path.dentry = d_alloc_pseudo(cxl_vfs_mount->mnt_sb, &this);
+	if (!path.dentry)
+		goto err_inode;
+
+	path.mnt = mntget(cxl_vfs_mount);
+	d_instantiate(path.dentry, inode);
+
+	file = alloc_file(&path, OPEN_FMODE(flags), fops);
+	if (IS_ERR(file))
+		goto err_dput;
+	file->f_flags = flags & (O_ACCMODE | O_NONBLOCK);
+	file->private_data = priv;
+
+	return file;
+
+err_dput:
+	path_put(&path);
+err_inode:
+	iput(inode);
+err_fs:
+	simple_release_fs(&cxl_vfs_mount, &cxl_fs_cnt);
+err_module:
+	module_put(fops->owner);
+	return file;
+}
+
 struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 {
-	struct address_space *mapping;
 	struct cxl_afu *afu;
 	struct cxl_context  *ctx;
 	int rc;
@@ -37,28 +138,13 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
 
 	ctx->kernelapi = true;
 
-	/*
-	 * Make our own address space since we won't have one from the
-	 * filesystem like the user api has, and even if we do associate a file
-	 * with this context we don't want to use the global anonymous inode's
-	 * address space as that can invalidate unrelated users:
-	 */
-	mapping = kmalloc(sizeof(struct address_space), GFP_KERNEL);
-	if (!mapping) {
-		rc = -ENOMEM;
-		goto err_ctx;
-	}
-	address_space_init_once(mapping);
-
 	/* Make it a slave context.  We can promote it later? */
-	rc = cxl_context_init(ctx, afu, false, mapping);
+	rc = cxl_context_init(ctx, afu, false);
 	if (rc)
-		goto err_mapping;
+		goto err_ctx;
 
 	return ctx;
 
-err_mapping:
-	kfree(mapping);
 err_ctx:
 	kfree(ctx);
 err_dev:
@@ -340,6 +426,11 @@ struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
 {
 	struct file *file;
 	int rc, flags, fdtmp;
+	char *name = NULL;
+
+	/* only allow one per context */
+	if (ctx->mapping)
+		return ERR_PTR(-EEXIST);
 
 	flags = O_RDWR | O_CLOEXEC;
 
@@ -363,12 +454,13 @@ struct file *cxl_get_fd(struct cxl_context *ctx, struct file_operations *fops,
 	} else /* use default ops */
 		fops = (struct file_operations *)&afu_fops;
 
-	file = anon_inode_getfile("cxl", fops, ctx, flags);
+	name = kasprintf(GFP_KERNEL, "cxl:%d", ctx->pe);
+	file = cxl_getfile(name, fops, ctx, flags);
+	kfree(name);
 	if (IS_ERR(file))
 		goto err_fd;
 
-	file->f_mapping = ctx->mapping;
-
+	cxl_context_set_mapping(ctx, file->f_mapping);
 	*fd = fdtmp;
 	return file;
 
diff --git a/drivers/misc/cxl/context.c b/drivers/misc/cxl/context.c
index 5e506c1..ff5e7e8 100644
--- a/drivers/misc/cxl/context.c
+++ b/drivers/misc/cxl/context.c
@@ -34,8 +34,7 @@ struct cxl_context *cxl_context_alloc(void)
 /*
  * Initialises a CXL context.
  */
-int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
-		     struct address_space *mapping)
+int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master)
 {
 	int i;
 
@@ -44,7 +43,7 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	ctx->master = master;
 	ctx->pid = ctx->glpid = NULL; /* Set in start work ioctl */
 	mutex_init(&ctx->mapping_lock);
-	ctx->mapping = mapping;
+	ctx->mapping = NULL;
 
 	/*
 	 * Allocate the segment table before we put it in the IDR so that we
@@ -114,6 +113,14 @@ int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
 	return 0;
 }
 
+void cxl_context_set_mapping(struct cxl_context *ctx,
+			struct address_space *mapping)
+{
+	mutex_lock(&ctx->mapping_lock);
+	ctx->mapping = mapping;
+	mutex_unlock(&ctx->mapping_lock);
+}
+
 static int cxl_mmap_fault(struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct cxl_context *ctx = vma->vm_file->private_data;
@@ -300,8 +307,6 @@ static void reclaim_ctx(struct rcu_head *rcu)
 	if (ctx->ff_page)
 		__free_page(ctx->ff_page);
 	ctx->sstp = NULL;
-	if (ctx->kernelapi)
-		kfree(ctx->mapping);
 
 	kfree(ctx->irq_bitmap);
 
@@ -313,6 +318,8 @@ static void reclaim_ctx(struct rcu_head *rcu)
 
 void cxl_context_free(struct cxl_context *ctx)
 {
+	if (ctx->kernelapi && ctx->mapping)
+		cxl_release_mapping(ctx);
 	mutex_lock(&ctx->afu->contexts_lock);
 	idr_remove(&ctx->afu->contexts_idr, ctx->pe);
 	mutex_unlock(&ctx->afu->contexts_lock);
diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index a144073..b24d767 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -817,8 +817,9 @@ void cxl_dump_debug_buffer(void *addr, size_t size);
 void init_cxl_native(void);
 
 struct cxl_context *cxl_context_alloc(void);
-int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master,
-		     struct address_space *mapping);
+int cxl_context_init(struct cxl_context *ctx, struct cxl_afu *afu, bool master);
+void cxl_context_set_mapping(struct cxl_context *ctx,
+			struct address_space *mapping);
 void cxl_context_free(struct cxl_context *ctx);
 int cxl_context_iomap(struct cxl_context *ctx, struct vm_area_struct *vma);
 unsigned int cxl_map_irq(struct cxl *adapter, irq_hw_number_t hwirq,
@@ -877,6 +878,7 @@ void cxl_native_err_irq_dump_regs(struct cxl *adapter);
 void cxl_stop_trace(struct cxl *cxl);
 int cxl_pci_vphb_add(struct cxl_afu *afu);
 void cxl_pci_vphb_remove(struct cxl_afu *afu);
+void cxl_release_mapping(struct cxl_context *ctx);
 
 extern struct pci_driver cxl_pci_driver;
 extern struct platform_driver cxl_of_driver;
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index 77080cc..859959f 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -86,9 +86,12 @@ static int __afu_open(struct inode *inode, struct file *file, bool master)
 		goto err_put_afu;
 	}
 
-	if ((rc = cxl_context_init(ctx, afu, master, inode->i_mapping)))
+	rc = cxl_context_init(ctx, afu, master);
+	if (rc)
 		goto err_put_afu;
 
+	cxl_context_set_mapping(ctx, inode->i_mapping);
+
 	pr_devel("afu_open pe: %i\n", ctx->pe);
 	file->private_data = ctx;
 	cxl_ctx_get();
-- 
2.9.3
