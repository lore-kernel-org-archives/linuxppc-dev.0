Return-Path: <nacc@us.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D3CD767A5D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 10:05:21 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j12N5HXB003561
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 18:05:17 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j12N5HcP273606
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 18:05:17 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12N5H6Q025537
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 18:05:17 -0500
Date: Wed, 2 Feb 2005 15:05:15 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: mporter@kernel.crashing.org
Message-ID: <20050202230515.GZ2546@us.ibm.com>
References: <20050202225504.GX2546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050202225504.GX2546@us.ibm.com>
Cc: kernel-janitors@lists.osdl.org, linuxppc-embedded@ozlabs.org
Subject: [UPDATE PATCH 18/20] ppc/serial_sicc: remove
	interruptible_sleep_on_timeout() usage
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 02, 2005 at 02:55:04PM -0800, Nishanth Aravamudan wrote:
> Hello,
> 
> Please consider applying.

Sorry, for the noise, but the patch was incomplete, as there was another call to
sleep_on() in the same file. Fixed below, please consider applying.

Description: Remove deprecated interruptible_sleep_on_timeout() function calls
and replace with direct wait-queue usage.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/arch/ppc/4xx_io/serial_sicc.c	2005-01-24 09:34:02.000000000 -0800
+++ 2.6.11-rc2-kj/arch/ppc/4xx_io/serial_sicc.c	2005-02-02 15:04:20.000000000 -0800
@@ -52,6 +52,7 @@
 #include <linux/console.h>
 #include <linux/sysrq.h>
 #include <linux/bitops.h>
+#include <linux/wait.h>
 
 #include <asm/system.h>
 #include <asm/io.h>
@@ -1561,8 +1562,11 @@ static int block_til_ready(struct tty_st
      */
     if (tty_hung_up_p(filp) ||
         (info->flags & ASYNC_CLOSING)) {
-        if (info->flags & ASYNC_CLOSING)
-            interruptible_sleep_on(&info->close_wait);
+        if (info->flags & ASYNC_CLOSING) {
+            prepare_to_wait(&info->close_wait, &wait, TASK_INTERRUPTIBLE);
+            schedule();
+            finish_wait(&info->close_wait, &wait);
+        }
         return (info->flags & ASYNC_HUP_NOTIFY) ?
             -EAGAIN : -ERESTARTSYS;
     }
@@ -1664,6 +1668,7 @@ static struct SICC_info *siccuart_get(in
 
 static int siccuart_open(struct tty_struct *tty, struct file *filp)
 {
+    DEFINE_WAIT(wait);
     struct SICC_info *info;
     int retval, line = tty->index;
 
@@ -1699,8 +1704,11 @@ static int siccuart_open(struct tty_stru
      */
     if (tty_hung_up_p(filp) ||
         (info->flags & ASYNC_CLOSING)) {
-        if (info->flags & ASYNC_CLOSING)
-            interruptible_sleep_on(&info->close_wait);
+        if (info->flags & ASYNC_CLOSING) {
+            prepare_to_wait(&info->close_wait, &wait, TASK_INTERRUPTIBLE);
+            schedule();
+            finish_wait(&info->close_wait, &wait);
+        }
         return -EAGAIN;
     }
 
