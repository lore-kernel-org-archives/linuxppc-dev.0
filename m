Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F5DBB7B7F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 07:28:55 +1100 (EST)
Message-Id: <20091015202758.441681409@linutronix.de>
Date: Thu, 15 Oct 2009 20:28:38 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 2/5] macintosh: Remove BKL from nvram driver
References: <20091015202722.372890083@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>, ALan Cox <alan@lxorguk.ukuu.org.uk>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Drop the bkl from nvram_llseek() as it obviously protects nothing. The
file offset is safe in essence.

The ioctl can be converted to unlocked_ioctl because it just calls
pmac_get_partition() which reads a value from an array which was
initialized at early boot time. No need for serialization.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 drivers/macintosh/nvram.c |   11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

Index: linux-2.6-tip/drivers/macintosh/nvram.c
===================================================================
--- linux-2.6-tip.orig/drivers/macintosh/nvram.c
+++ linux-2.6-tip/drivers/macintosh/nvram.c
@@ -13,7 +13,6 @@
 #include <linux/fcntl.h>
 #include <linux/nvram.h>
 #include <linux/init.h>
-#include <linux/smp_lock.h>
 #include <asm/uaccess.h>
 #include <asm/nvram.h>
 
@@ -21,7 +20,6 @@
 
 static loff_t nvram_llseek(struct file *file, loff_t offset, int origin)
 {
-	lock_kernel();
 	switch (origin) {
 	case 1:
 		offset += file->f_pos;
@@ -30,12 +28,10 @@ static loff_t nvram_llseek(struct file *
 		offset += NVRAM_SIZE;
 		break;
 	}
-	if (offset < 0) {
-		unlock_kernel();
+	if (offset < 0)
 		return -EINVAL;
-	}
+
 	file->f_pos = offset;
-	unlock_kernel();
 	return file->f_pos;
 }
 
@@ -76,8 +72,7 @@ static ssize_t write_nvram(struct file *
 	return p - buf;
 }
 
-static int nvram_ioctl(struct inode *inode, struct file *file,
-	unsigned int cmd, unsigned long arg)
+static long nvram_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	switch(cmd) {
 		case PMAC_NVRAM_GET_OFFSET:
