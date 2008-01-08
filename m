Return-Path: <jrigby@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 727EEDDFFB
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:01:42 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m08G1b7I026110
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 09:01:38 -0700 (MST)
Received: from localhost.localdomain (mvp-10-214-72-80.am.freescale.net
	[10.214.72.80])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m08G1XJL004714
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jan 2008 10:01:37 -0600 (CST)
From: John Rigby <jrigby@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 5/7] Separate MPC52xx PSC FIFO registers from rest of PSC
Date: Tue,  8 Jan 2008 09:01:31 -0700
Message-Id: <1199808093-15929-6-git-send-email-jrigby@freescale.com>
In-Reply-To: <1199808093-15929-5-git-send-email-jrigby@freescale.com>
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is in preparation for the addition of MPC512x
PSC support.  The main difference in the 512x is
in the fifo registers.

Signed-off-by: John Rigby <jrigby@freescale.com>
---
 drivers/serial/mpc52xx_uart.c     |   10 ++++++----
 include/asm-powerpc/mpc52xx_psc.h |    3 +++
 include/asm-ppc/mpc52xx_psc.h     |    3 +++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
index ec36ad7..25a91c9 100644
--- a/drivers/serial/mpc52xx_uart.c
+++ b/drivers/serial/mpc52xx_uart.c
@@ -111,6 +111,7 @@ static void mpc52xx_uart_of_enumerate(void);
 #endif
 
 #define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
+#define FIFO(port) ((struct mpc52xx_psc_fifo __iomem *)(PSC(port)+1))
 
 
 /* Forward declaration of the interruption handling routine */
@@ -222,6 +223,7 @@ static int
 mpc52xx_uart_startup(struct uart_port *port)
 {
 	struct mpc52xx_psc __iomem *psc = PSC(port);
+	struct mpc52xx_psc_fifo __iomem *fifo = FIFO(port);
 	int ret;
 
 	/* Request IRQ */
@@ -238,10 +240,10 @@ mpc52xx_uart_startup(struct uart_port *port)
 
 	out_be16(&psc->mpc52xx_psc_clock_select, 0xdd00); /* /16 prescaler on */
 
-	out_8(&psc->rfcntl, 0x00);
-	out_be16(&psc->rfalarm, 0x1ff);
-	out_8(&psc->tfcntl, 0x07);
-	out_be16(&psc->tfalarm, 0x80);
+	out_8(&fifo->rfcntl, 0x00);
+	out_be16(&fifo->rfalarm, 0x1ff);
+	out_8(&fifo->tfcntl, 0x07);
+	out_be16(&fifo->tfalarm, 0x80);
 
 	port->read_status_mask |= MPC52xx_PSC_IMR_RXRDY | MPC52xx_PSC_IMR_TXRDY;
 	out_be16(&psc->mpc52xx_psc_imr,port->read_status_mask);
diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
index 26690d2..bea42b9 100644
--- a/include/asm-powerpc/mpc52xx_psc.h
+++ b/include/asm-powerpc/mpc52xx_psc.h
@@ -153,6 +153,9 @@ struct mpc52xx_psc {
 	u8		reserved16[3];
 	u8		irfdr;		/* PSC + 0x54 */
 	u8		reserved17[3];
+};
+
+struct mpc52xx_psc_fifo {
 	u16		rfnum;		/* PSC + 0x58 */
 	u16		reserved18;
 	u16		tfnum;		/* PSC + 0x5c */
diff --git a/include/asm-ppc/mpc52xx_psc.h b/include/asm-ppc/mpc52xx_psc.h
index c82b8d4..39fcd02 100644
--- a/include/asm-ppc/mpc52xx_psc.h
+++ b/include/asm-ppc/mpc52xx_psc.h
@@ -159,6 +159,9 @@ struct mpc52xx_psc {
 	u8		reserved16[3];
 	u8		irfdr;		/* PSC + 0x54 */
 	u8		reserved17[3];
+};
+
+struct mpc52xx_psc_fifo {
 	u16		rfnum;		/* PSC + 0x58 */
 	u16		reserved18;
 	u16		tfnum;		/* PSC + 0x5c */
-- 
1.5.3.5.726.g41a7a
