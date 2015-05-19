Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 326331A06E9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2015 21:23:26 +1000 (AEST)
From: Michael Neuling <mikey@neuling.org>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org
Subject: [PATCH 18/19] cxl: Export file ops for use by API
Date: Tue, 19 May 2015 21:22:35 +1000
Message-Id: <1432034556-32400-19-git-send-email-mikey@neuling.org>
In-Reply-To: <1432034556-32400-1-git-send-email-mikey@neuling.org>
References: <1432034556-32400-1-git-send-email-mikey@neuling.org>
Cc: mikey@neuling.org, "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, brking@linux.vnet.ibm.com,
 Daniel Axtens <dja@axtens.net>
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
---
 drivers/misc/cxl/cxl.h  |  9 +++++++++
 drivers/misc/cxl/file.c | 23 ++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/misc/cxl/cxl.h b/drivers/misc/cxl/cxl.h
index bc88823..7c5c014 100644
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
index 5377c8b..6a9fd72 100644
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
 
@@ -212,7 +213,7 @@ static long afu_ioctl_process_element(struct cxl_context *ctx,
 	return 0;
 }
 
-static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct cxl_context *ctx = file->private_data;
 
@@ -229,13 +230,13 @@ static long afu_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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
 
@@ -246,7 +247,7 @@ static int afu_mmap(struct file *file, struct vm_area_struct *vm)
 	return cxl_context_iomap(ctx, vm);
 }
 
-static unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
+unsigned int afu_poll(struct file *file, struct poll_table_struct *poll)
 {
 	struct cxl_context *ctx = file->private_data;
 	int mask = 0;
@@ -278,7 +279,7 @@ static inline int ctx_event_pending(struct cxl_context *ctx)
 	    ctx->pending_afu_err || (ctx->status == CLOSED));
 }
 
-static ssize_t afu_read(struct file *file, char __user *buf, size_t count,
+ssize_t afu_read(struct file *file, char __user *buf, size_t count,
 			loff_t *off)
 {
 	struct cxl_context *ctx = file->private_data;
@@ -359,7 +360,11 @@ out:
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
@@ -370,7 +375,7 @@ static const struct file_operations afu_fops = {
 	.mmap           = afu_mmap,
 };
 
-static const struct file_operations afu_master_fops = {
+const struct file_operations afu_master_fops = {
 	.owner		= THIS_MODULE,
 	.open           = afu_master_open,
 	.poll		= afu_poll,
-- 
2.1.0
