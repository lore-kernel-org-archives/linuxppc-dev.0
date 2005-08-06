Return-Path: <aris@cathedrallabs.org>
Received: from panda.sul.com.br (panda.sul.com.br [200.219.150.4])
	by ozlabs.org (Postfix) with ESMTP id B7E2967F2C
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  7 Aug 2005 04:05:00 +1000 (EST)
Date: Sat, 6 Aug 2005 15:04:58 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050806180458.GX5210@cathedrallabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH] 8xx: i2c_rpx: use cpm_get_cpmp()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

8xx: use cpm_get_cpmp() in i2c-rpx

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

Index: 2.6-8xx/drivers/i2c/busses/i2c-rpx.c
===================================================================
--- 2.6-8xx.orig/drivers/i2c/busses/i2c-rpx.c	2005-08-05 17:05:36.000000000 -0300
+++ 2.6-8xx/drivers/i2c/busses/i2c-rpx.c	2005-08-05 17:15:20.000000000 -0300
@@ -27,7 +27,7 @@
 	volatile cpm8xx_t *cp;
 	volatile immap_t *immap;
 
-	cp = cpmp;	/* Get pointer to Communication Processor */
+	cp = cpm_get_cpmp();	/* Get pointer to Communication Processor */
 	immap = (immap_t *)IMAP_ADDR;	/* and to internal registers */
 
 	data->iip = (iic_t *)&cp->cp_dparam[PROFF_IIC];
