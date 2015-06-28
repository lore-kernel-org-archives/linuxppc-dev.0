Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 702141A05FB
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jun 2015 11:50:45 +1000 (AEST)
Message-Id: <20150628014201.432590485@telegraphics.com.au>
Date: Sun, 28 Jun 2015 11:42:06 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC v3 07/24] char/nvram: Allow the set_checksum and initialize
 ioctls to be omitted
References: <20150628014159.732792697@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The drivers/char/nvram module has previously only supported RTC "CMOS"
NVRAM, for which it provides appropriate checksum ioctls. Make these
ioctls optional so the module can be re-used with other kinds of NVRAM.

The ops struct methods that implement the ioctls now return error
codes so that a multi-platform kernel binary can do the right thing when
running on hardware without suitable NVRAM.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

Changed since v1:
- Don't bother acquiring the mutex for unimplemented ioctls.

---
 drivers/char/nvram.c  |   71 ++++++++++++++++++++++++++++----------------------
 include/linux/nvram.h |    2 +
 2 files changed, 43 insertions(+), 30 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-06-28 11:41:34.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-06-28 11:41:36.000000000 +1000
@@ -153,16 +153,25 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
 }
 
-#if 0
-void nvram_set_checksum(void)
+static long nvram_set_checksum(void)
 {
-	unsigned long flags;
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static long nvram_initialize(void)
+{
+	ssize_t i;
 
-	spin_lock_irqsave(&rtc_lock, flags);
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		__nvram_write_byte(0, i);
 	__nvram_set_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
+	spin_unlock_irq(&rtc_lock);
+	return 0;
 }
-#endif  /*  0  */
 
 static ssize_t nvram_get_size(void)
 {
@@ -173,6 +182,8 @@ const struct nvram_ops arch_nvram_ops =
 	.read_byte      = nvram_read_byte,
 	.write_byte     = nvram_write_byte,
 	.get_size       = nvram_get_size,
+	.set_checksum   = nvram_set_checksum,
+	.initialize     = nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
@@ -272,51 +283,51 @@ checksum_err:
 static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
                              unsigned long arg)
 {
-	int i;
+	long ret = -ENOTTY;
 
 	switch (cmd) {
-
 	case NVRAM_INIT:
 		/* initialize NVRAM contents and checksum */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		mutex_lock(&nvram_mutex);
-		spin_lock_irq(&rtc_lock);
-
-		for (i = 0; i < NVRAM_BYTES; ++i)
-			__nvram_write_byte(0, i);
-		__nvram_set_checksum();
-
-		spin_unlock_irq(&rtc_lock);
-		mutex_unlock(&nvram_mutex);
-		return 0;
-
+		if (arch_nvram_ops.initialize != NULL) {
+			mutex_lock(&nvram_mutex);
+			ret = arch_nvram_ops.initialize();
+			mutex_unlock(&nvram_mutex);
+		}
+		break;
 	case NVRAM_SETCKS:
 		/* just set checksum, contents unchanged (maybe useful after
 		 * checksum garbaged somehow...) */
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 
-		mutex_lock(&nvram_mutex);
-		spin_lock_irq(&rtc_lock);
-		__nvram_set_checksum();
-		spin_unlock_irq(&rtc_lock);
-		mutex_unlock(&nvram_mutex);
-		return 0;
-
-	default:
-		return -ENOTTY;
+		if (arch_nvram_ops.set_checksum != NULL) {
+			mutex_lock(&nvram_mutex);
+			ret = arch_nvram_ops.set_checksum();
+			mutex_unlock(&nvram_mutex);
+		}
+		break;
 	}
+	return ret;
 }
 
 static int nvram_misc_open(struct inode *inode, struct file *file)
 {
 	spin_lock(&nvram_state_lock);
 
+	/* Prevent multiple readers/writers if desired. */
 	if ((nvram_open_cnt && (file->f_flags & O_EXCL)) ||
-	    (nvram_open_mode & NVRAM_EXCL) ||
-	    ((file->f_mode & FMODE_WRITE) && (nvram_open_mode & NVRAM_WRITE))) {
+	    (nvram_open_mode & NVRAM_EXCL)) {
+		spin_unlock(&nvram_state_lock);
+		return -EBUSY;
+	}
+
+	/* Prevent multiple writers if the set_checksum ioctl is implemented. */
+	if ((arch_nvram_ops.set_checksum != NULL) &&
+	    (file->f_mode & FMODE_WRITE) &&
+	    (nvram_open_mode & NVRAM_WRITE)) {
 		spin_unlock(&nvram_state_lock);
 		return -EBUSY;
 	}
Index: linux/include/linux/nvram.h
===================================================================
--- linux.orig/include/linux/nvram.h	2015-06-28 11:41:34.000000000 +1000
+++ linux/include/linux/nvram.h	2015-06-28 11:41:36.000000000 +1000
@@ -17,6 +17,8 @@ struct nvram_ops {
 	unsigned char   (*read_byte)(int);
 	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
+	long            (*set_checksum)(void);
+	long            (*initialize)(void);
 };
 
 extern const struct nvram_ops arch_nvram_ops;
