Return-Path: <DaveLiu@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 4DC90B70B2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 00:30:58 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B1E59DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jun 2009 00:30:55 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n58EUZEB028681
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2009 07:30:46 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n58EUXpu003224
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Jun 2009 09:30:34 -0500 (CDT)
From: Dave Liu <daveliu@freescale.com>
To: linux-serial@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: [PATCH] serial: Fix bug of ucc_uart
Date: Mon,  8 Jun 2009 22:24:36 +0800
Message-Id: <1244471076-25905-1-git-send-email-daveliu@freescale.com>
Cc: timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current ucc_uart driver doesn't work at UART mode,
The TxBD[READY] is not cleared by H/W (RISC engine)
when user send characters to Tx buffer of QE UART.
so, these characters stay on the QE forever, never
go to UART line.

The patch is fixing th bug.

Signed-off-by: Dave Liu <daveliu@freescale.com>
---
 drivers/serial/ucc_uart.c |   19 ++++++++++++++-----
 1 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/serial/ucc_uart.c b/drivers/serial/ucc_uart.c
index 7de66c0..e945e78 100644
--- a/drivers/serial/ucc_uart.c
+++ b/drivers/serial/ucc_uart.c
@@ -681,22 +681,27 @@ static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
 	out_be16(&uccup->rccm, 0xc0ff);
 
 	/* Configure the GUMR registers for UART */
-	if (soft_uart)
+	if (soft_uart) {
 		/* Soft-UART requires a 1X multiplier for TX */
 		clrsetbits_be32(&uccp->gumr_l,
 			UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
 			UCC_SLOW_GUMR_L_RDCR_MASK,
 			UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_1 |
 			UCC_SLOW_GUMR_L_RDCR_16);
-	else
+
+		clrsetbits_be32(&uccp->gumr_h, UCC_SLOW_GUMR_H_RFW,
+			UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX);
+	} else {
 		clrsetbits_be32(&uccp->gumr_l,
 			UCC_SLOW_GUMR_L_MODE_MASK | UCC_SLOW_GUMR_L_TDCR_MASK |
 			UCC_SLOW_GUMR_L_RDCR_MASK,
 			UCC_SLOW_GUMR_L_MODE_UART | UCC_SLOW_GUMR_L_TDCR_16 |
 			UCC_SLOW_GUMR_L_RDCR_16);
 
-	clrsetbits_be32(&uccp->gumr_h, UCC_SLOW_GUMR_H_RFW,
-		UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX);
+		clrsetbits_be32(&uccp->gumr_h,
+			UCC_SLOW_GUMR_H_TRX | UCC_SLOW_GUMR_H_TTX,
+			UCC_SLOW_GUMR_H_RFW);
+	}
 
 #ifdef LOOPBACK
 	clrsetbits_be32(&uccp->gumr_l, UCC_SLOW_GUMR_L_DIAG_MASK,
@@ -706,7 +711,7 @@ static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
 		UCC_SLOW_GUMR_H_CDS);
 #endif
 
-	/* Enable rx interrupts  and clear all pending events.  */
+	/* Disable rx interrupts  and clear all pending events.  */
 	out_be16(&uccp->uccm, 0);
 	out_be16(&uccp->ucce, 0xffff);
 	out_be16(&uccp->udsr, 0x7e7e);
@@ -765,6 +770,10 @@ static void qe_uart_init_ucc(struct uart_qe_port *qe_port)
 		cecr_subblock = ucc_slow_get_qe_cr_subblock(qe_port->ucc_num);
 		qe_issue_cmd(QE_INIT_TX_RX, cecr_subblock,
 			QE_CR_PROTOCOL_UNSPECIFIED, 0);
+	} else {
+		cecr_subblock = ucc_slow_get_qe_cr_subblock(qe_port->ucc_num);
+		qe_issue_cmd(QE_INIT_TX_RX, cecr_subblock,
+			QE_CR_PROTOCOL_UART, 0);
 	}
 }
 
-- 
1.5.4
