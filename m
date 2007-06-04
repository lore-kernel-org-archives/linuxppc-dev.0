Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:38 +1000
Subject: [PATCH 4/21] spufs: Add a "capabilities" file to spu contexts
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051543.7028DDDEB9@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This adds a "capabilities" file to spu contexts consisting of a
list of linefeed separated capability names. The current exposed
capabilities are "sched" (the context is scheduleable) and
"step" (the context supports single stepping).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

This version of that patch includes Christoph Hellwig change to
use seq_file instead of hand-coded macro crap

 arch/powerpc/platforms/cell/spufs/file.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

Index: linux-cell/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/spufs/file.c	2007-06-04 13:20:44.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/spufs/file.c	2007-06-04 14:34:50.000000000 +1000
@@ -28,6 +28,7 @@
 #include <linux/pagemap.h>
 #include <linux/poll.h>
 #include <linux/ptrace.h>
+#include <linux/seq_file.h>
 
 #include <asm/io.h>
 #include <asm/semaphore.h>
@@ -39,6 +40,7 @@
 
 #define SPUFS_MMAP_4K (PAGE_SIZE == 0x1000)
 
+
 static int
 spufs_mem_open(struct inode *inode, struct file *file)
 {
@@ -1796,6 +1798,29 @@ static int spufs_info_open(struct inode 
 	return 0;
 }
 
+static int spufs_caps_show(struct seq_file *s, void *private)
+{
+	struct spu_context *ctx = s->private;
+
+	if (!(ctx->flags & SPU_CREATE_NOSCHED))
+		seq_puts(s, "sched\n");
+	if (!(ctx->flags & SPU_CREATE_ISOLATE))
+		seq_puts(s, "step\n");
+	return 0;
+}
+
+static int spufs_caps_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, spufs_caps_show, SPUFS_I(inode)->i_ctx);
+}
+
+static const struct file_operations spufs_caps_fops = {
+	.open		= spufs_caps_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 static ssize_t __spufs_mbox_info_read(struct spu_context *ctx,
 			char __user *buf, size_t len, loff_t *pos)
 {
@@ -2014,6 +2039,7 @@ static const struct file_operations spuf
 };
 
 struct tree_descr spufs_dir_contents[] = {
+	{ "capabilities", &spufs_caps_fops, 0444, },
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "regs", &spufs_regs_fops,  0666, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
@@ -2049,6 +2075,7 @@ struct tree_descr spufs_dir_contents[] =
 };
 
 struct tree_descr spufs_dir_nosched_contents[] = {
+	{ "capabilities", &spufs_caps_fops, 0444, },
 	{ "mem",  &spufs_mem_fops,  0666, },
 	{ "mbox", &spufs_mbox_fops, 0444, },
 	{ "ibox", &spufs_ibox_fops, 0444, },
