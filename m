Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 68B27DE024
	for <linuxppc-dev@ozlabs.org>; Fri, 23 May 2008 15:12:32 +1000 (EST)
Date: Fri, 23 May 2008 15:12:23 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] viotape: use unlocked_ioctl
Message-Id: <20080523151223.387c4c0a.sfr@canb.auug.org.au>
In-Reply-To: <20080523130442.54034a2f.sfr@au1.ibm.com>
References: <20080522222012.3a07bd57@core>
	<20080523130442.54034a2f.sfr@au1.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This pushes the BKL down into the driver.  Based on a patch by Alan Cox.

We need to do it this way for now as the inode parameter of viotap_ioctl
is used internally as a flag.  We should do a further cleanup patch.

Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/char/viotape.c |   24 ++++++++++++++++++------
 1 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
index 58aad63..0dda915 100644
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -46,6 +46,7 @@
 #include <linux/completion.h>
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
+#include <linux/smp_lock.h>
 
 #include <asm/uaccess.h>
 #include <asm/ioctls.h>
@@ -677,6 +678,17 @@ free_op:
 	return ret;
 }
 
+static long viotap_unlocked_ioctl(struct file *file,
+		unsigned int cmd, unsigned long arg)
+{
+	long rc;
+
+	lock_kernel();
+	rc = viotap_ioctl(file->f_path.dentry->d_inode, file, cmd, arg);
+	unlock_kernel();
+	return rc;
+}
+
 static int viotap_open(struct inode *inode, struct file *file)
 {
 	HvLpEvent_Rc hvrc;
@@ -783,12 +795,12 @@ free_op:
 }
 
 const struct file_operations viotap_fops = {
-	.owner =	THIS_MODULE,
-	.read =		viotap_read,
-	.write =	viotap_write,
-	.ioctl =	viotap_ioctl,
-	.open =		viotap_open,
-	.release =	viotap_release,
+	.owner =		THIS_MODULE,
+	.read =			viotap_read,
+	.write =		viotap_write,
+	.unlocked_ioctl =	viotap_unlocked_ioctl,
+	.open =			viotap_open,
+	.release =		viotap_release,
 };
 
 /* Handle interrupt events for tape */
-- 
1.5.5.1


-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
