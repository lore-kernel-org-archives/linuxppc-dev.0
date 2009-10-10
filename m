Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 72B81B7B6F
	for <linuxppc-dev@ozlabs.org>; Sun, 11 Oct 2009 03:33:19 +1100 (EST)
Message-Id: <20091010153349.966159859@linutronix.de>
Date: Sat, 10 Oct 2009 15:37:12 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 22/28] macintosh: Remove BKL from ans-lcd
References: <20091010153314.827301943@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <fweisbec@gmail.com>,
	Vincent Sanders <vince@simtec.co.uk>,
	Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	John Kacur <jkacur@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The ans-lcd driver got the cycle_kernel_lock() in anslcd_open() from
the BKL pushdown and it still uses the locked ioctl.

The BKL serialization in this driver is more than obscure and
definitely does not cover all possible corner cases. Protect the
access to the hardware with a local mutex and get rid of BKL and
locked ioctl.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
---
 drivers/macintosh/ans-lcd.c |   45 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

Index: linux-2.6-tip/drivers/macintosh/ans-lcd.c
===================================================================
--- linux-2.6-tip.orig/drivers/macintosh/ans-lcd.c
+++ linux-2.6-tip/drivers/macintosh/ans-lcd.c
@@ -3,7 +3,6 @@
  */
 
 #include <linux/types.h>
-#include <linux/smp_lock.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
 #include <linux/miscdevice.h>
@@ -26,6 +25,7 @@
 static unsigned long anslcd_short_delay = 80;
 static unsigned long anslcd_long_delay = 3280;
 static volatile unsigned char __iomem *anslcd_ptr;
+static DEFINE_MUTEX(anslcd_mutex);
 
 #undef DEBUG
 
@@ -65,26 +65,31 @@ anslcd_write( struct file * file, const 
 
 	if (!access_ok(VERIFY_READ, buf, count))
 		return -EFAULT;
+
+	mutex_lock(&anslcd_mutex);
 	for ( i = *ppos; count > 0; ++i, ++p, --count ) 
 	{
 		char c;
 		__get_user(c, p);
 		anslcd_write_byte_data( c );
 	}
+	mutex_unlock(&anslcd_mutex);
 	*ppos = i;
 	return p - buf;
 }
 
-static int
-anslcd_ioctl( struct inode * inode, struct file * file,
-				unsigned int cmd, unsigned long arg )
+static long
+anslcd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	char ch, __user *temp;
+	long ret = 0;
 
 #ifdef DEBUG
 	printk(KERN_DEBUG "LCD: ioctl(%d,%d)\n",cmd,arg);
 #endif
 
+	mutex_lock(&anslcd_mutex);
+
 	switch ( cmd )
 	{
 	case ANSLCD_CLEAR:
@@ -93,7 +98,7 @@ anslcd_ioctl( struct inode * inode, stru
 		anslcd_write_byte_ctrl ( 0x06 );
 		anslcd_write_byte_ctrl ( 0x01 );
 		anslcd_write_byte_ctrl ( 0x02 );
-		return 0;
+		break;
 	case ANSLCD_SENDCTRL:
 		temp = (char __user *) arg;
 		__get_user(ch, temp);
@@ -101,33 +106,37 @@ anslcd_ioctl( struct inode * inode, stru
 			anslcd_write_byte_ctrl ( ch );
 			__get_user(ch, temp);
 		}
-		return 0;
+		break;
 	case ANSLCD_SETSHORTDELAY:
 		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		anslcd_short_delay=arg;
-		return 0;
+			ret =-EACCES;
+		else
+			anslcd_short_delay=arg;
+		break;
 	case ANSLCD_SETLONGDELAY:
 		if (!capable(CAP_SYS_ADMIN))
-			return -EACCES;
-		anslcd_long_delay=arg;
-		return 0;
+			ret = -EACCES;
+		else
+			anslcd_long_delay=arg;
+		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
+
+	mutex_unlock(&anslcd_mutex);
+	return ret;
 }
 
 static int
 anslcd_open( struct inode * inode, struct file * file )
 {
-	cycle_kernel_lock();
 	return 0;
 }
 
 const struct file_operations anslcd_fops = {
-	.write	= anslcd_write,
-	.ioctl	= anslcd_ioctl,
-	.open	= anslcd_open,
+	.write		= anslcd_write,
+	.unlocked_ioctl	= anslcd_ioctl,
+	.open		= anslcd_open,
 };
 
 static struct miscdevice anslcd_dev = {
@@ -168,6 +177,7 @@ anslcd_init(void)
 	printk(KERN_DEBUG "LCD: init\n");
 #endif
 
+	mutex_lock(&anslcd_mutex);
 	anslcd_write_byte_ctrl ( 0x38 );
 	anslcd_write_byte_ctrl ( 0x0c );
 	anslcd_write_byte_ctrl ( 0x06 );
@@ -176,6 +186,7 @@ anslcd_init(void)
 	for(a=0;a<80;a++) {
 		anslcd_write_byte_data(anslcd_logo[a]);
 	}
+	mutex_unlock(&anslcd_mutex);
 	return 0;
 }
 
