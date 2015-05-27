Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 121C91A0D69
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2015 16:07:54 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Cc: imunsie@au.ibm.com, linuxppc-dev@ozlabs.org, mikey@neuling.org,
 Daniel Axtens <dja@axtens.net>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com
Subject: [PATCH v3 23/24] cxl: Export file ops for use by API
Date: Wed, 27 May 2015 16:07:17 +1000
Message-Id: <1432706838-20794-24-git-send-email-mikey@neuling.org>
In-Reply-To: <1432706838-20794-1-git-send-email-mikey@neuling.org>
References: <1432706838-20794-1-git-send-email-mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The cxl kernel API will allow drivers other than cxl to export a file
descriptor which has the same userspace API.  These file descriptors will be
able to be used against libcxl.

This exports those file ops for use by other drivers.

Signed-off-by: Michael Neuling <mikey@neuling.org>
Acked-by: Ian Munsie <imunsie@au1.ibm.com>
---
 drivers/misc/cxl/cxl.h  |  9 +++++++++
 drivers/misc/cxl/file.c | 23 ++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index f3b071e..af67c4b 100644
--- a/drivers/misc/cxl/cxl.h
+++ b/drivers/misc/cxl/cxl.h
@@ -18,6 +18,7 @@
 #include <linux/pid.h>
 #include <linux/io.h>
 #include <linux/pci.h>
+#include <linux/fs.h>
 #include <asm/cputable.h>
 #include <asm/mmu.h>
 #include <asm/reg.h>
@@ -670,4 +671,12 @@ void cxl_stop_trace(struct cxl *cxl);
 extern struct pci_driver cxl_pci_driver;
 int afu_allocate_irqs(struct cxl_context *ctx, u32 count);
 
+int afu_open(struct inode *inode, struct file *file);
+int afu_release(struct inode *inode, struct file *file);
+long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg);
+int afu_mmap(struct file *file, struct vm_area_struct *vm);
+unsigned int afu_poll(struct file *file, struct poll_table_struct *poll);
+ssize_t afu_read(struct file *file, char __user *buf, size_t count, loff_t *off);
+extern const struct file_operations afu_fops;
+
 #endif
diff --git a/drivers/misc/cxl/file.c b/drivers/misc/cxl/file.c
index f7653fc..72fe168 100644
--- a/drivers/misc/cxl/file.c
+++ b/drivers/misc/cxl/file.c
@@ -96,7 +96,8 @@ err_put_adapter:
 	put_device(&adapter->dev);
 	return rc;
 }
-static int afu_open(struct inode *inode, struct file *file)
+
+int afu_open(struct inode *inode, struct file *file)
 {
 	return __afu_open(inode, file, false);
 }
@@ -106,7 +107,7 @@ static int afu_master_open(struct inode *inode, struct file *file)
 	return __afu_open(inode, file, true);
 }
 
-static int afu_release(struct inode *inode, struct file *file)
+int afu_release(struct inode *inode, struct file *file)
 {
 	struct cxl_context *ctx = file->private_data;
 
@@ -211,7 +212,7 @@ static long afu_ioctl_process_element(struct cxl_context *ctx,
 	return 0;
 }
 
-static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cxl_context *ctx = file->private_data;
 
@@ -228,13 +229,13 @@ static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	return -EINVAL;
 }
 
-static long afu_compat_ioctl(struct file *file, unsigned int cmd,
+long afu_compat_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
 	return afu_ioctl(file, cmd, arg);
 }
 
-static int afu_mmap(struct file *file, struct vm_area_struct *vm)
+int afu_mmap(struct file *file, struct vm_area_struct *vm)
 {
 	struct cxl_context *ctx = file->private_data;
 
@@ -245,7 +246,7 @@ static int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	return cxl_context_iomap(ctx, vm);
 }
 
-static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
+unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct cxl_context *ctx = file->private_data;
 	int mask = 0;
@@ -277,7 +278,7 @@ static inline int ctx_event_pending(struct cxl_context *ctx)
 	    ctx->pending_afu_err || (ctx->status == CLOSED));
 }
 
-static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
+ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 			loff_t *off)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -358,7 +359,11 @@ out:
 	return rc;
 }
 
-static const struct file_operations afu_fops = {
+/* 
+ * Note: if this is updated, we need to update api.c to patch the new ones in
+ * too
+ */
+const struct file_operations afu_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_open,
 	.poll		= afu_poll,
@@ -369,7 +374,7 @@ static const struct file_operations afu_fops = {
 	.mmap           = afu_mmap,
 };
 
-static const struct file_operations afu_master_fops = {
+const struct file_operations afu_master_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_master_open,
 	.poll		= afu_poll,
-- 
2.1.0
