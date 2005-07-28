Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D0D267D71
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Jul 2005 07:56:56 +1000 (EST)
Date: Thu, 28 Jul 2005 06:16:15 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: akpm@osdl.org
Message-ID: <20050728091615.GD6101@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] 8xx: fec: fix interrupt handler prototypes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>

8xx: fec: fix interrupt handler prototypes

Signed-off-by: Aristeu Sergio Rozanski Filho <aris@conectiva.com.br>
Signed-off-by: Marcelo Tosatti <marcelo.tosatti@cyclades.com>

Index: 2.6-8xx/arch/ppc/8xx_io/fec.c
===================================================================
--- 2.6-8xx.orig/arch/ppc/8xx_io/fec.c	2005-07-04 11:45:57.000000000 -0300
+++ 2.6-8xx/arch/ppc/8xx_io/fec.c	2005-07-04 11:45:57.000000000 -0300
@@ -199,7 +199,8 @@
 #ifdef	CONFIG_USE_MDIO
 static void fec_enet_mii(struct net_device *dev);
 #endif	/* CONFIG_USE_MDIO */
-static void fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs);
+static irqreturn_t fec_enet_interrupt(int irq, void * dev_id,
+		       					struct pt_regs * regs);
 #ifdef CONFIG_FEC_PACKETHOOK
 static void  fec_enet_tx(struct net_device *dev, __u32 regval);
 static void  fec_enet_rx(struct net_device *dev, __u32 regval);
@@ -471,7 +472,7 @@
 /* The interrupt handler.
  * This is called from the MPC core interrupt.
  */
-static	void
+static	irqreturn_t
 fec_enet_interrupt(int irq, void * dev_id, struct pt_regs * regs)
 {
 	struct	net_device *dev = dev_id;
@@ -525,6 +526,7 @@
 		}
 
 	}
+	return IRQ_RETVAL(IRQ_HANDLED);
 }
 
 
@@ -1403,11 +1405,11 @@
 
 /* This interrupt occurs when the PHY detects a link change.
 */
-static void
+static
 #ifdef CONFIG_RPXCLASSIC
-mii_link_interrupt(void *dev_id)
+void mii_link_interrupt(void *dev_id)
 #else
-mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
+irqreturn_t mii_link_interrupt(int irq, void * dev_id, struct pt_regs * regs)
 #endif
 {
 #ifdef	CONFIG_USE_MDIO
@@ -1440,6 +1442,9 @@
 printk("%s[%d] %s: unexpected Link interrupt\n", __FILE__,__LINE__,__FUNCTION__);
 #endif	/* CONFIG_USE_MDIO */
 
+#ifndef CONFIG_RPXCLASSIC
+	return IRQ_RETVAL(IRQ_HANDLED);
+#endif	/* CONFIG_RPXCLASSIC */
 }
 
 static int
