Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94E6E67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Apr 2005 14:17:32 +1000 (EST)
Date: Sun, 3 Apr 2005 21:17:28 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: linuxppc-embedded@ozlabs.org
Message-ID: <20050404041728.GB9575@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ADZbWkCsHQ7r3kzd"
Subject: [PATCH] ppc32: ppc4xx_pic - add acknowledge when enabling
	level-sensitive IRQ
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Andrew,

this patch adds interrupt acknowledge to the PPC4xx PIC enable_irq 
implementation for level-sensitive IRQ sources. This helps in cases 
when enable/disable_irq is used in interrupt handlers for hardware, 
which requires IRQ acknowledge to be issued from non-interrupt context 
(e.g. when actual ACK in device needs an I2C transaction). For such 
strange hardware, interrupt handler disables IRQ and defers actual ACK 
to some other context. When this happens, IRQ is enabled again. For 
level-sensitive sources we get spurious triggering right after IRQ 
is enabled. This patch fixes this.
Suggested by Tolunay Orkun <listmember@orkun.us>.

Signed-off-by: Eugene Surovegin <ebs@ebshome.net>

--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ppc4xx_pic_ack_on_enable.diff"

===== arch/ppc/syslib/ppc4xx_pic.c 1.15 vs edited =====
--- 1.15/arch/ppc/syslib/ppc4xx_pic.c	2005-03-04 22:41:17 -08:00
+++ edited/arch/ppc/syslib/ppc4xx_pic.c	2005-04-03 12:00:55 -07:00
@@ -41,7 +41,10 @@
 #define UIC_HANDLERS(n)							\
 static void ppc4xx_uic##n##_enable(unsigned int irq)			\
 {									\
-	ppc_cached_irq_mask[n] |= IRQ_MASK_UIC##n(irq);			\
+	u32 mask = IRQ_MASK_UIC##n(irq);				\
+	if (irq_desc[irq].status & IRQ_LEVEL)				\
+		mtdcr(DCRN_UIC_SR(UIC##n), mask);			\
+	ppc_cached_irq_mask[n] |= mask;					\
 	mtdcr(DCRN_UIC_ER(UIC##n), ppc_cached_irq_mask[n]);		\
 }									\
 									\

--ADZbWkCsHQ7r3kzd--
