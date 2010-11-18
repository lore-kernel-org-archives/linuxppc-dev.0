Return-Path: <B21989@freescale.com>
Received: from VA3EHSOBE004.bigfish.com (va3ehsobe004.messaging.microsoft.com
	[216.32.180.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F20DB71B4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 18:31:43 +1100 (EST)
Received: from mail52-va3 (localhost.localdomain [127.0.0.1])	by
	mail52-va3-R.bigfish.com (Postfix) with ESMTP id 0368112B8346	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 07:28:08 +0000 (UTC)
Received: from VA3EHSMHS003.bigfish.com (unknown [10.7.14.247])	by
	mail52-va3.bigfish.com (Postfix) with ESMTP id 7A4B21A8053	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 07:28:07 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	oAI7VZhd011234	for
	<linuxppc-dev@lists.ozlabs.org>; Thu, 18 Nov 2010 00:31:35 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oAI7ltDu029964	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 01:47:56 -0600 (CST)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2][v3] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Thu, 18 Nov 2010 14:57:53 +0800
Message-ID: <1290063473-20950-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Shaohui Xie <b21989@freescale.com>, Kumar Gala <kumar.gala@freescale.com>,
	Alexandre Bounine <alexandre.bounine@idt.com>, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The sRIO controller reports errors to the core with one signal, it uses
register EPWISR to provides the core quick access to where the error occurred.
The EPWISR indicates that there are 4 interrupts sources, port1, port2, message
unit and port write receive, but the sRIO driver does not support port2
for now, still the handler takes care of port2.
Currently the handler only clear error status without any recovery.

Signed-off-by: Shaohui Xie <b21989@freescale.com>
Cc: Li Yang <leoli@freescale.com>
Cc: Kumar Gala <kumar.gala@freescale.com>
Cc: Roy Zang <tie-fei.zang@freescale.com>
Cc: Alexandre Bounine <alexandre.bounine@idt.com>
---
updated to 37-rc2
 arch/powerpc/sysdev/fsl_rio.c |   85 +++++++++++++++++++++++++++++++++++++----
 1 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index ddbcd16..d036df9 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -10,7 +10,7 @@
  * - Added Port-Write message handling
  * - Added Machine Check exception handling
  *
- * Copyright (C) 2007, 2008 Freescale Semiconductor, Inc.
+ * Copyright (C) 2007, 2008, 2010 Freescale Semiconductor, Inc.
  * Zhang Wei <wei.zhang@freescale.com>
  *
  * Copyright 2005 MontaVista Software, Inc.
@@ -47,15 +47,33 @@
 #define IRQ_RIO_RX(m)		(((struct rio_priv *)(m->priv))->rxirq)
 #define IRQ_RIO_PW(m)		(((struct rio_priv *)(m->priv))->pwirq)
 
+#define IPWSR_CLEAR		0x98
+#define OMSR_CLEAR		0x1cb3
+#define IMSR_CLEAR		0x491
+#define IDSR_CLEAR		0x91
+#define ODSR_CLEAR		0x1c00
+#define LTLEECSR_ENABLE_ALL	0xFFC000FC
+#define ESCSR_CLEAR		0x07120204
+
+#define RIO_PORT1_EDCSR		0x0640
+#define RIO_PORT2_EDCSR		0x0680
+#define RIO_PORT1_IECSR		0x10130
+#define RIO_PORT2_IECSR		0x101B0
+#define RIO_IM0SR		0x13064
+#define RIO_IM1SR		0x13164
+#define RIO_OM0SR		0x13004
+#define RIO_OM1SR		0x13104
+
 #define RIO_ATMU_REGS_OFFSET	0x10c00
 #define RIO_P_MSG_REGS_OFFSET	0x11000
 #define RIO_S_MSG_REGS_OFFSET	0x13000
 #define RIO_GCCSR		0x13c
 #define RIO_ESCSR		0x158
+#define RIO_PORT2_ESCSR		0x178
 #define RIO_CCSR		0x15c
 #define RIO_LTLEDCSR		0x0608
-#define  RIO_LTLEDCSR_IER	0x80000000
-#define  RIO_LTLEDCSR_PRT	0x01000000
+#define RIO_LTLEDCSR_IER	0x80000000
+#define RIO_LTLEDCSR_PRT	0x01000000
 #define RIO_LTLEECSR		0x060c
 #define RIO_EPWISR		0x10010
 #define RIO_ISR_AACR		0x10120
@@ -88,7 +106,10 @@
 #define RIO_IPWSR_PWD		0x00000008
 #define RIO_IPWSR_PWB		0x00000004
 
-#define RIO_EPWISR_PINT		0x80000000
+/* EPWISR Error match value */
+#define RIO_EPWISR_PINT1	0x80000000
+#define RIO_EPWISR_PINT2	0x40000000
+#define RIO_EPWISR_MU		0x00000002
 #define RIO_EPWISR_PW		0x00000001
 
 #define RIO_MSG_DESC_SIZE	32
@@ -1066,6 +1087,40 @@ static int fsl_rio_doorbell_init(struct rio_mport *mport)
 	return rc;
 }
 
+static void port_error_handler(struct rio_mport *port, int offset)
+{
+	/*XXX: Error recovery is not implemented, we just clear errors */
+	out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR), 0);
+
+	if (offset == 0) {
+		out_be32((u32 *)(rio_regs_win + RIO_PORT1_EDCSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT1_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
+	} else {
+		out_be32((u32 *)(rio_regs_win + RIO_PORT2_EDCSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT2_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_PORT2_ESCSR), ESCSR_CLEAR);
+	}
+}
+
+static void msg_unit_error_handler(struct rio_mport *port)
+{
+	struct rio_priv *priv = port->priv;
+
+	/*XXX: Error recovery is not implemented, we just clear errors */
+	out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR), 0);
+
+	out_be32((u32 *)(rio_regs_win + RIO_IM0SR), IMSR_CLEAR);
+	out_be32((u32 *)(rio_regs_win + RIO_IM1SR), IMSR_CLEAR);
+	out_be32((u32 *)(rio_regs_win + RIO_OM0SR), OMSR_CLEAR);
+	out_be32((u32 *)(rio_regs_win + RIO_OM1SR), OMSR_CLEAR);
+
+	out_be32(&priv->msg_regs->odsr, ODSR_CLEAR);
+	out_be32(&priv->msg_regs->dsr, IDSR_CLEAR);
+
+	out_be32(&priv->msg_regs->pwsr, IPWSR_CLEAR);
+}
+
 /**
  * fsl_rio_port_write_handler - MPC85xx port write interrupt handler
  * @irq: Linux interrupt number
@@ -1146,10 +1201,22 @@ fsl_rio_port_write_handler(int irq, void *dev_instance)
 	}
 
 pw_done:
-	if (epwisr & RIO_EPWISR_PINT) {
+	if (epwisr & RIO_EPWISR_PINT1) {
+		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
+		pr_debug("RIO_LTLEDCSR = 0x%x\n", tmp);
+		port_error_handler(port, 0);
+	}
+
+	if (epwisr & RIO_EPWISR_PINT2) {
+		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
+		pr_debug("RIO_LTLEDCSR = 0x%x\n", tmp);
+		port_error_handler(port, 1);
+	}
+
+	if (epwisr & RIO_EPWISR_MU) {
 		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
 		pr_debug("RIO_LTLEDCSR = 0x%x\n", tmp);
-		out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
+		msg_unit_error_handler(port);
 	}
 
 	return IRQ_HANDLED;
@@ -1260,12 +1327,14 @@ static int fsl_rio_port_write_init(struct rio_mport *mport)
 
 
 	/* Hook up port-write handler */
-	rc = request_irq(IRQ_RIO_PW(mport), fsl_rio_port_write_handler, 0,
-			 "port-write", (void *)mport);
+	rc = request_irq(IRQ_RIO_PW(mport), fsl_rio_port_write_handler,
+			IRQF_SHARED, "port-write", (void *)mport);
 	if (rc < 0) {
 		pr_err("MPC85xx RIO: unable to request inbound doorbell irq");
 		goto err_out;
 	}
+	/* Enable Error Interrupt */
+	out_be32((u32 *)(rio_regs_win + RIO_LTLEECSR), LTLEECSR_ENABLE_ALL);
 
 	INIT_WORK(&priv->pw_work, fsl_pw_dpc);
 	spin_lock_init(&priv->pw_fifo_lock);
-- 
1.6.4
