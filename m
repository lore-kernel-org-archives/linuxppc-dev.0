Return-Path: <viro@www.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 837D067B22
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Apr 2005 11:10:29 +1000 (EST)
To: torvalds@osdl.org
Message-Id: <E1DQEb0-0007qT-UN@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 26 Apr 2005 02:10:38 +0100
Cc: linuxppc-dev@ozlabs.org
Subject: [PATCH] ppc annotations: i2c-mpc 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

	Usual iomem annotations and NULL noise removal.
Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC12-rc3-mpsc/drivers/i2c/busses/i2c-mpc.c RC12-rc3-i2c-mpc/drivers/i2c/busses/i2c-mpc.c
--- RC12-rc3-mpsc/drivers/i2c/busses/i2c-mpc.c	Wed Apr 20 21:25:33 2005
+++ RC12-rc3-i2c-mpc/drivers/i2c/busses/i2c-mpc.c	Mon Apr 25 19:53:08 2005
@@ -55,7 +55,7 @@
 #define CSR_RXAK 0x01
 
 struct mpc_i2c {
-	char *base;
+	void __iomem *base;
 	u32 interrupt;
 	wait_queue_head_t queue;
 	struct i2c_adapter adap;
@@ -444,7 +444,7 @@
 
       fail_add:
 	if (i2c->irq != 0)
-		free_irq(i2c->irq, 0);
+		free_irq(i2c->irq, NULL);
       fail_irq:
 	iounmap(i2c->base);
       fail_map:
