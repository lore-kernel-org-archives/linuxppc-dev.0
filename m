Return-Path: <arnd@arndb.de>
Message-Id: <20061004161506.496172000@arndb.de>
References: <20061004152610.151599000@dyn-9-152-242-103.boeblingen.de.ibm.com>
Date: Wed, 04 Oct 2006 17:26:19 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 09/14] spufs: add support for read/write on cntl
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linuxppc-dev@ozlabs.org,
	cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Writing to cntl can be used to stop execution on the
spu and to restart it, reading from cntl gives the
contents of the current status register.

The access is always in ascii, as for most other files.

This was always meant to be there, but we had a little
problem with writing to runctl so it was left out so
far.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -211,37 +211,43 @@ static int spufs_cntl_mmap(struct file *
 #define spufs_cntl_mmap NULL
 #endif /* !SPUFS_MMAP_4K */
 
-static int spufs_cntl_open(struct inode *inode, struct file *file)
+static u64 spufs_cntl_get(void *data)
 {
-	struct spufs_inode_info *i = SPUFS_I(inode);
-	struct spu_context *ctx = i->i_ctx;
+	struct spu_context *ctx = data;
+	u64 val;
 
-	file->private_data = ctx;
-	file->f_mapping = inode->i_mapping;
-	ctx->cntl = inode->i_mapping;
-	return 0;
+	spu_acquire(ctx);
+	val = ctx->ops->status_read(ctx);
+	spu_release(ctx);
+
+	return val;
 }
 
-static ssize_t
-spufs_cntl_read(struct file *file, char __user *buffer,
-		size_t size, loff_t *pos)
+static void spufs_cntl_set(void *data, u64 val)
 {
-	/* FIXME: read from spu status */
-	return -EINVAL;
+	struct spu_context *ctx = data;
+
+	spu_acquire(ctx);
+	ctx->ops->runcntl_write(ctx, val);
+	spu_release(ctx);
 }
 
-static ssize_t
-spufs_cntl_write(struct file *file, const char __user *buffer,
-		 size_t size, loff_t *pos)
+static int spufs_cntl_open(struct inode *inode, struct file *file)
 {
-	/* FIXME: write to runctl bit */
-	return -EINVAL;
+	struct spufs_inode_info *i = SPUFS_I(inode);
+	struct spu_context *ctx = i->i_ctx;
+
+	file->private_data = ctx;
+	file->f_mapping = inode->i_mapping;
+	ctx->cntl = inode->i_mapping;
+	return simple_attr_open(inode, file, spufs_cntl_get,
+					spufs_cntl_set, "0x%08lx");
 }
 
 static struct file_operations spufs_cntl_fops = {
 	.open = spufs_cntl_open,
-	.read = spufs_cntl_read,
-	.write = spufs_cntl_write,
+	.read = simple_attr_read,
+	.write = simple_attr_write,
 	.mmap = spufs_cntl_mmap,
 };
 

--
