Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 948D668415
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Sep 2005 09:42:34 +1000 (EST)
Date: Thu, 29 Sep 2005 00:42:27 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Message-ID: <20050928234227.GN7992@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mv64x60_wdt __user annotations and cleanups
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	* use nonseekable_open() instead of messing with 
	if (*ppos != file->f_pos)
		return -EISPIPE
in ->write() (->read is NULL).
	* trivial __user annotations
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
----
diff -urN RC14-rc2-git6-base/drivers/char/watchdog/mv64x60_wdt.c current/drivers/char/watchdog/mv64x60_wdt.c
--- RC14-rc2-git6-base/drivers/char/watchdog/mv64x60_wdt.c	2005-09-26 00:02:29.000000000 -0400
+++ current/drivers/char/watchdog/mv64x60_wdt.c	2005-09-22 15:08:16.000000000 -0400
@@ -87,6 +87,8 @@
 	mv64x60_wdt_service();
 	mv64x60_wdt_handler_enable();
 
+	nonseekable_open(inode, file);
+
 	return 0;
 }
 
@@ -103,12 +105,9 @@
 	return 0;
 }
 
-static ssize_t mv64x60_wdt_write(struct file *file, const char *data,
+static ssize_t mv64x60_wdt_write(struct file *file, const char __user *data,
 				 size_t len, loff_t * ppos)
 {
-	if (*ppos != file->f_pos)
-		return -ESPIPE;
-
 	if (len)
 		mv64x60_wdt_service();
 
@@ -119,6 +118,7 @@
 			     unsigned int cmd, unsigned long arg)
 {
 	int timeout;
+	void __user *argp = (void __user *)arg;
 	static struct watchdog_info info = {
 		.options = WDIOF_KEEPALIVEPING,
 		.firmware_version = 0,
@@ -127,13 +127,13 @@
 
 	switch (cmd) {
 	case WDIOC_GETSUPPORT:
-		if (copy_to_user((void *)arg, &info, sizeof(info)))
+		if (copy_to_user(argp, &info, sizeof(info)))
 			return -EFAULT;
 		break;
 
 	case WDIOC_GETSTATUS:
 	case WDIOC_GETBOOTSTATUS:
-		if (put_user(wdt_status, (int *)arg))
+		if (put_user(wdt_status, (int __user *)argp))
 			return -EFAULT;
 		wdt_status &= ~WDIOF_KEEPALIVEPING;
 		break;
@@ -154,7 +154,7 @@
 
 	case WDIOC_GETTIMEOUT:
 		timeout = mv64x60_wdt_timeout * HZ;
-		if (put_user(timeout, (int *)arg))
+		if (put_user(timeout, (int __user *)argp))
 			return -EFAULT;
 		break;
 
