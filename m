Return-Path: <nacc@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E5DB267A30
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 09:56:30 +1100 (EST)
Received: from e1.ny.us.ibm.com ([192.168.1.101])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.10) with ESMTP id j12MtBgB006226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 17:55:11 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.12.10/8.12.10) with ESMTP id j12Mt6bs027833
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 17:55:06 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	j12Mt6GL122132
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 17:55:06 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id j12Mt614025021
	for <linuxppc-embedded@ozlabs.org>; Wed, 2 Feb 2005 17:55:06 -0500
Date: Wed, 2 Feb 2005 14:55:04 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: mporter@kernel.crashing.org
Message-ID: <20050202225504.GX2546@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: kernel-janitors@lists.osdl.org, linuxppc-embedded@ozlabs.org
Subject: [PATCH 18/20] ppc/serial_sicc: remove
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

Hello,

Please consider applying.

Description: Remove deprecated interruptible_sleep_on_timeout() function calls
and replace with direct wait-queue usage.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc2-kj-v/arch/ppc/4xx_io/serial_sicc.c	2005-01-24 09:34:02.000000000 -0800
+++ 2.6.11-rc2-kj/arch/ppc/4xx_io/serial_sicc.c	2005-02-02 14:41:49.000000000 -0800
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
