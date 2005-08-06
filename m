Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id EA2EC67F1F
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:03:04 +1000 (EST)
Date: Sat, 6 Aug 2005 15:03:03 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180303.GV5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: remove rpx_install_isr() from i2c-rpx.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: remove rpx_install_isr(), IRQ handler is installed on i2c-algo-8xx

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6-8xx/drivers/i2c/busses/i2c-rpx.c
===================================================================
--- 2.6-8xx.orig/drivers/i2c/busses/i2c-rpx.c	2005-08-05 17:00:06.000000000 -0300
+++ 2.6-8xx/drivers/i2c/busses/i2c-rpx.c	2005-08-05 17:05:36.000000000 -0300
@@ -55,17 +55,7 @@
 	data->i2c = (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);
 }
 
-static int rpx_install_isr(int irq, void (*func)(void *, void *), void *data)
-{
-	/* install interrupt handler */
-	cpm_install_handler(irq, (void (*)(void *, struct pt_regs *)) func, data);
-
-	return 0;
-}
-
-static struct i2c_algo_8xx_data rpx_data = {
-	.setisr = rpx_install_isr
-};
+static struct i2c_algo_8xx_data rpx_data;
 
 static struct i2c_adapter rpx_ops = {
 	.owner		= THIS_MODULE,
