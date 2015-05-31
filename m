Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id D9DD31A0C98
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:16:59 +1000 (AEST)
Message-Id: <20150531010133.649664851@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:37 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 05/24] char/nvram: Re-order functions to remove forward
 declarations and #ifdefs
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Also give functions more sensible names: nvram_misc_* for misc device ops,
nvram_proc_* for proc file ops and nvram_module_* for init and exit
functions. This makes them distict from nvram_ops members.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 drivers/char/nvram.c |  194 ++++++++++++++++++++++-----------------------------
 1 file changed, 86 insertions(+), 108 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:01.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:05.000000000 +1000
@@ -54,11 +54,6 @@ static int nvram_open_mode;	/* special o
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
-#ifdef CONFIG_PROC_FS
-static void pc_nvram_proc_read(unsigned char *contents, struct seq_file *seq,
-                               void *offset);
-#endif
-
 /*
  * These functions are provided to be called internally or by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -170,7 +165,7 @@ void nvram_set_checksum(void)
  * The are the file operation function for user access to /dev/nvram
  */
 
-static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
+static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 {
 	switch (origin) {
 	case 0:
@@ -189,8 +184,8 @@ static loff_t nvram_llseek(struct file *
 	return (offset >= 0) ? (file->f_pos = offset) : -EINVAL;
 }
 
-static ssize_t nvram_read(struct file *file, char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t nvram_misc_read(struct file *file, char __user *buf,
+                               size_t count, loff_t *ppos)
 {
 	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
@@ -218,8 +213,8 @@ checksum_err:
 	return -EIO;
 }
 
-static ssize_t nvram_write(struct file *file, const char __user *buf,
-						size_t count, loff_t *ppos)
+static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
+                                size_t count, loff_t *ppos)
 {
 	unsigned char contents[NVRAM_BYTES];
 	unsigned i = *ppos;
@@ -257,8 +252,8 @@ checksum_err:
 	return -EIO;
 }
 
-static long nvram_ioctl(struct file *file, unsigned int cmd,
-			unsigned long arg)
+static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
+                             unsigned long arg)
 {
 	int i;
 
@@ -298,7 +293,7 @@ static long nvram_ioctl(struct file *fil
 	}
 }
 
-static int nvram_open(struct inode *inode, struct file *file)
+static int nvram_misc_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
@@ -320,7 +315,7 @@ static int nvram_open(struct inode *inod
 	return 0;
 }
 
-static int nvram_release(struct inode *inode, struct file *file)
+static int nvram_misc_release(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
@@ -337,100 +332,6 @@ static int nvram_release(struct inode *i
 	return 0;
 }
 
-#ifndef CONFIG_PROC_FS
-static int nvram_add_proc_fs(void)
-{
-	return 0;
-}
-
-#else
-
-static int nvram_proc_read(struct seq_file *seq, void *offset)
-{
-	unsigned char contents[NVRAM_BYTES];
-	int i = 0;
-
-	spin_lock_irq(&rtc_lock);
-	for (i = 0; i < NVRAM_BYTES; ++i)
-		contents[i] = __nvram_read_byte(i);
-	spin_unlock_irq(&rtc_lock);
-
-	pc_nvram_proc_read(contents, seq, offset);
-
-	return 0;
-}
-
-static int nvram_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, nvram_proc_read, NULL);
-}
-
-static const struct file_operations nvram_proc_fops = {
-	.owner		= THIS_MODULE,
-	.open		= nvram_proc_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
-static int nvram_add_proc_fs(void)
-{
-	if (!proc_create("driver/nvram", 0, NULL, &nvram_proc_fops))
-		return -ENOMEM;
-	return 0;
-}
-
-#endif /* CONFIG_PROC_FS */
-
-static const struct file_operations nvram_fops = {
-	.owner		= THIS_MODULE,
-	.llseek		= nvram_llseek,
-	.read		= nvram_read,
-	.write		= nvram_write,
-	.unlocked_ioctl	= nvram_ioctl,
-	.open		= nvram_open,
-	.release	= nvram_release,
-};
-
-static struct miscdevice nvram_dev = {
-	NVRAM_MINOR,
-	"nvram",
-	&nvram_fops
-};
-
-static int __init nvram_init(void)
-{
-	int ret;
-
-	ret = misc_register(&nvram_dev);
-	if (ret) {
-		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
-		    NVRAM_MINOR);
-		goto out;
-	}
-	ret = nvram_add_proc_fs();
-	if (ret) {
-		printk(KERN_ERR "nvram: can't create /proc/driver/nvram\n");
-		goto outmisc;
-	}
-	ret = 0;
-	printk(KERN_INFO "Non-volatile memory driver v" NVRAM_VERSION "\n");
-out:
-	return ret;
-outmisc:
-	misc_deregister(&nvram_dev);
-	goto out;
-}
-
-static void __exit nvram_cleanup_module(void)
-{
-	remove_proc_entry("driver/nvram", NULL);
-	misc_deregister(&nvram_dev);
-}
-
-module_init(nvram_init);
-module_exit(nvram_cleanup_module);
-
 #ifdef CONFIG_PROC_FS
 
 static char *floppy_types[] = {
@@ -508,7 +409,84 @@ static void pc_nvram_proc_read(unsigned
 	return;
 }
 
+static int nvram_proc_read(struct seq_file *seq, void *offset)
+{
+	unsigned char contents[NVRAM_BYTES];
+	int i = 0;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		contents[i] = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	pc_nvram_proc_read(contents, seq, offset);
+
+	return 0;
+}
+
+static int nvram_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nvram_proc_read, NULL);
+}
+
+static const struct file_operations nvram_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvram_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 #endif /* CONFIG_PROC_FS */
 
+static const struct file_operations nvram_misc_fops = {
+	.owner		= THIS_MODULE,
+	.llseek		= nvram_misc_llseek,
+	.read		= nvram_misc_read,
+	.write		= nvram_misc_write,
+	.unlocked_ioctl	= nvram_misc_ioctl,
+	.open		= nvram_misc_open,
+	.release	= nvram_misc_release,
+};
+
+static struct miscdevice nvram_misc = {
+	NVRAM_MINOR,
+	"nvram",
+	&nvram_misc_fops,
+};
+
+static int __init nvram_module_init(void)
+{
+	int ret;
+
+	ret = misc_register(&nvram_misc);
+	if (ret) {
+		pr_err("nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
+		return ret;
+	}
+
+#ifdef CONFIG_PROC_FS
+	if (!proc_create("driver/nvram", 0, NULL, &nvram_proc_fops)) {
+		pr_err("nvram: can't create /proc/driver/nvram\n");
+		misc_deregister(&nvram_misc);
+		return -ENOMEM;
+	}
+#endif
+
+	pr_info("Non-volatile memory driver v" NVRAM_VERSION "\n");
+	return 0;
+}
+
+static void __exit nvram_module_exit(void)
+{
+#ifdef CONFIG_PROC_FS
+	remove_proc_entry("driver/nvram", NULL);
+#endif
+	misc_deregister(&nvram_misc);
+}
+
+module_init(nvram_module_init);
+module_exit(nvram_module_exit);
+
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
