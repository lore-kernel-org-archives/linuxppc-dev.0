Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 7CD23DDEEF
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Mar 2007 20:50:15 +1100 (EST)
Date: Tue, 6 Mar 2007 10:50:11 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH] mpc52xx_pic: fix main interrupt masking
Message-ID: <20070306095011.GY4397@moe.telargo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fix main interrupt masking.
Tested with RTC and GPIO_WKUP interrupts.


Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
===================================================================
--- grant.git.orig/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ grant.git/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -128,7 +128,7 @@ static void mpc52xx_main_mask(unsigned i
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
-	io_be_setbit(&intr->main_mask, 15 - l2irq);
+	io_be_setbit(&intr->main_mask, 16 - l2irq);
 }
 
 static void mpc52xx_main_unmask(unsigned int virq)
@@ -141,7 +141,7 @@ static void mpc52xx_main_unmask(unsigned
 
 	pr_debug("%s: irq=%x. l2=%d\n", __func__, irq, l2irq);
 
-	io_be_clrbit(&intr->main_mask, 15 - l2irq);
+	io_be_clrbit(&intr->main_mask, 16 - l2irq);
 }
 
 static struct irq_chip mpc52xx_main_irqchip = {
