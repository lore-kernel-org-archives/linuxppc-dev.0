Return-Path: <B21989@freescale.com>
Received: from DB3EHSOBE005.bigfish.com (db3ehsobe005.messaging.microsoft.com
	[213.199.154.143])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EE80DB70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 18:59:48 +1100 (EST)
Received: from mail73-db3 (localhost.localdomain [127.0.0.1])	by
	mail73-db3-R.bigfish.com (Postfix) with ESMTP id A48CFD403F6	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2010 07:44:35 +0000 (UTC)
Received: from DB3EHSMHS007.bigfish.com (unknown [10.3.81.242])	by
	mail73-db3.bigfish.com (Postfix) with ESMTP id 0D8186F0046	for
	<linuxppc-dev@lists.ozlabs.org>; Fri, 29 Oct 2010 07:44:35 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by de01egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o9T7iWsI010603	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 00:44:33 -0700 (MST)
Received: from zmy16exm20.fsl.freescale.net (zmy16exm20.ap.freescale.net
	[10.211.3.23])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9T7iVX9004418	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 29 Oct 2010 02:44:32 -0500 (CDT)
From: Shaohui Xie <b21989@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/4][v2] rapidio,
	powerpc/85xx: Error interrupt handler for sRIO.
Date: Fri, 29 Oct 2010 15:14:22 +0800
Message-ID: <1288336462-11805-1-git-send-email-b21989@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Alexandre Bounine <alexandre.bounine@idt.com>,
	Kumar Gala <kumar.gala@freescale.com>, Shaohui Xie <b21989@freescale.com>
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
 arch/powerpc/sysdev/fsl_rio.c |   86 +++++++++++++++++++++++++++++++++++++---
 1 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index a9bc1e8..8de86a8 100644
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
@@ -47,10 +47,36 @@
 #define IRQ_RIO_RX(m)		(((struct rio_priv *)(m->priv))->rxirq)
 #define IRQ_RIO_PW(m)		(((struct rio_priv *)(m->priv))->pwirq)
 
+/* EPWISR Error match value */
+#define EPWISR_ERR_PINT1	0x80000000
+#define EPWISR_ERR_PINT2	0x40000000
+#define EPWISR_ERR_MU		0x2
+#define EPWISR_ERR_PW		0x1
+
+#define IPWMR_CLEAR_QUEUE      0x00000002
+#define IPWSR_CLEAR		0x98
+#define OMSR_CLEAR		0x1cb3
+#define IMSR_CLEAR		0x491
+#define IDSR_CLEAR		0x91
+#define ODSR_CLEAR		0x1c00
+#define LTLEECSR_ENABLE_ALL	0xFFC000FC
+#define ESCSR_CLEAR		0x07120204
+
+#define RIO_EDCSR		0x0640
+#define PORT2_RIO_EDCSR	0x0680
+#define RIO_IECSR		0x10130
+#define PORT2_RIO_IECSR	0x101B0
+#define RIO_IM0SR		0x13064
+#define RIO_IM1SR		0x13164
+#define RIO_OM0SR		0x13004
+#define RIO_OM1SR		0x13104
+
+#define RIO_EPWISR_OFFSET	0x10010
 #define RIO_ATMU_REGS_OFFSET	0x10c00
 #define RIO_P_MSG_REGS_OFFSET	0x11000
 #define RIO_S_MSG_REGS_OFFSET	0x13000
 #define RIO_ESCSR		0x158
+#define PORT2_RIO_ESCSR	0x178
 #define RIO_CCSR		0x15c
 #define RIO_LTLEDCSR		0x0608
 #define  RIO_LTLEDCSR_IER	0x80000000
@@ -1003,6 +1029,40 @@ fsl_rio_dbell_handler(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
+static void port_error_handler(struct rio_mport *port, int offset)
+{
+	/*XXX: Error recovery is not implemented, we just clear errors */
+	out_be32((u32 *)(rio_regs_win + RIO_LTLEDCSR), 0);
+
+	if (offset == 0) {
+		out_be32((u32 *)(rio_regs_win + RIO_EDCSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + RIO_ESCSR), ESCSR_CLEAR);
+	} else {
+		out_be32((u32 *)(rio_regs_win + PORT2_RIO_EDCSR), 0);
+		out_be32((u32 *)(rio_regs_win + PORT2_RIO_IECSR), 0);
+		out_be32((u32 *)(rio_regs_win + PORT2_RIO_ESCSR), ESCSR_CLEAR);
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
  * fsl_rio_doorbell_init - MPC85xx doorbell interface init
  * @mport: Master port implementing the inbound doorbell unit
@@ -1082,14 +1142,24 @@ fsl_rio_port_write_handler(int irq, void *dev_instance)
 	ipwsr = in_be32(&priv->msg_regs->pwsr);
 
 	epwisr = in_be32(priv->regs_win + RIO_EPWISR);
-	if (epwisr & 0x80000000) {
+	if (epwisr & EPWISR_ERR_PINT1) {
 		tmp = in_be32(priv->regs_win + RIO_LTLEDCSR);
 		pr_info("RIO_LTLEDCSR = 0x%x\n", tmp);
-		out_be32(priv->regs_win + RIO_LTLEDCSR, 0);
+		port_error_handler(port, 0);
+	}
+
+	if (epwisr & EPWISR_ERR_PINT2) {
+		pr_info("RIO: port2 error\n");
+		port_error_handler(port, 1);
+	}
+
+	if (epwisr & EPWISR_ERR_MU) {
+		pr_info("RIO: message unit error\n");
+		msg_unit_error_handler(port);
 	}
 
-	if (!(epwisr & 0x00000001))
-		return IRQ_HANDLED;
+	if (!(epwisr & EPWISR_ERR_PW))
+		return IRQ_NONE;
 
 #ifdef DEBUG_PW
 	pr_debug("PW Int->IPWMR: 0x%08x IPWSR: 0x%08x (", ipwmr, ipwsr);
@@ -1249,12 +1319,14 @@ static int fsl_rio_port_write_init(struct rio_mport *mport)
 
 
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
