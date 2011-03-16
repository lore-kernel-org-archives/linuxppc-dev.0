Return-Path: <vooon341@gmail.com>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id BC188B7004
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 10:46:18 +1100 (EST)
Received: by bwz10 with SMTP id 10so1883133bwz.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 16:46:14 -0700 (PDT)
Subject: [PATCH 2/4] serial: Add initial support for TWR-MPC5125
From: Vladimir Ermakov <vooon341@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 17 Mar 2011 02:33:47 +0300
Message-ID: <1300318427.12970.70.camel@desinto>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adds PSC UART support for MPC5125 SoC.
    
MPC5125 has different registers than in MPC5121.

Signed-off-by: Vladimir Ermakov <vooon341@gmail.com>
---

diff --git a/arch/powerpc/include/asm/mpc52xx_psc.h b/arch/powerpc/include/asm/mpc52xx_psc.h
index 2966df6..7bff52f 100644
--- a/arch/powerpc/include/asm/mpc52xx_psc.h
+++ b/arch/powerpc/include/asm/mpc52xx_psc.h
@@ -150,6 +150,51 @@
 
 /* Structure of the hardware registers */
 struct mpc52xx_psc {
+#ifdef CONFIG_PPC_MPC5125
+	u8		mr1;		/* PSC + 0x00 */
+	u8		reserved0[3];
+	u8		mr2;		/* PSC + 0x04 */
+	u8		reserved1[3];
+	u16		mpc52xx_psc_status; /* PSC + 0x08 */
+	u8		reserved2[2];
+	u8		mpc52xx_psc_clock_select; /* PSC + 0x0c */
+	u8		reserved3[3];
+	u8		command;	/* PSC + 0x10 */
+	u8		reserved4[3];
+	union {				/* PSC + 0x14 */
+		u8	buffer_8;
+		u16	buffer_16;
+		u32	buffer_32;
+	} buffer;
+#define mpc52xx_psc_buffer_8	buffer.buffer_8
+#define mpc52xx_psc_buffer_16	buffer.buffer_16
+#define mpc52xx_psc_buffer_32	buffer.buffer_32
+	u8		mpc52xx_psc_ipcr;	/* PSC + 0x18 */
+	u8		reserved5[3];
+	u8		mpc52xx_psc_acr;	/* PSC + 0x1c */
+	u8		reserved6[3];
+	u16		mpc52xx_psc_isr;	/* PSC + 0x20 */
+	u8		reserved7[2];
+	u16		mpc52xx_psc_imr;	/* PSC + 0x24 */
+	u8		reserved8[2];
+	u8		ctur;			/* PSC + 0x28 */
+	u8		reserved9[3];
+	u8		ctlr;			/* PSC + 0x2c */
+	u8		reserved10[3];
+	u32             ccr;            	/* PSC + 0x30 */
+	u32             ac97slots;      	/* PSC + 0x34 */
+	u32             ac97cmd;        	/* PSC + 0x38 */
+	u32             ac97data;       	/* PSC + 0x3c */
+	u8		reserved11[4];
+	u8		ip;			/* PSC + 0x44 */
+	u8		reserved12[3];
+	u8		op1;			/* PSC + 0x48 */
+	u8		reserved13[3];
+	u8		op0;			/* PSC + 0x4c */
+	u8		reserved14[3];
+	u32		sicr;			/* PSC + 0x50 */
+	u8		reserved15[4];
+#else
 	u8		mode;		/* PSC + 0x00 */
 	u8		reserved0[3];
 	union {				/* PSC + 0x04 */
@@ -212,6 +257,7 @@ struct mpc52xx_psc {
 	u8		reserved16[3];
 	u8		irfdr;		/* PSC + 0x54 */
 	u8		reserved17[3];
+#endif
 };
 
 struct mpc52xx_psc_fifo {
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index a0bcd8a..8e4c6b0 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -128,7 +128,11 @@ static inline void mpc52xx_set_divisor(struct mpc52xx_psc __iomem *psc,
 				       u16 prescaler, unsigned int divisor)
 {
 	/* select prescaler */
+#ifdef CONFIG_PPC_MPC5125
+	out_8(&psc->mpc52xx_psc_clock_select, prescaler >> 8);
+#else
 	out_be16(&psc->mpc52xx_psc_clock_select, prescaler);
+#endif
 	out_8(&psc->ctur, divisor >> 8);
 	out_8(&psc->ctlr, divisor & 0xff);
 }
@@ -345,7 +349,11 @@ static unsigned int psc_fifoc_irq;
 static void mpc512x_psc_fifo_init(struct uart_port *port)
 {
 	/* /32 prescaler */
+#ifdef CONFIG_PPC_MPC5125
+	out_8(&PSC(port)->mpc52xx_psc_clock_select, 0xdd);
+#else
 	out_be16(&PSC(port)->mpc52xx_psc_clock_select, 0xdd00);
+#endif
 
 	out_be32(&FIFO_512x(port)->txcmd, MPC512x_PSC_FIFO_RESET_SLICE);
 	out_be32(&FIFO_512x(port)->txcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
@@ -816,9 +824,14 @@ mpc52xx_uart_set_termios(struct uart_port *port, struct ktermios *new,
 	out_8(&psc->command, MPC52xx_PSC_RST_TX);
 
 	/* Send new mode settings */
+#ifdef CONFIG_PPC_MPC5125
+	out_8(&psc->mr1, mr1);
+	out_8(&psc->mr2, mr2);
+#else
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	out_8(&psc->mode, mr1);
 	out_8(&psc->mode, mr2);
+#endif
 	baud = psc_ops->set_baudrate(port, new, old);
 
 	/* Update the per-port timeout */
@@ -1107,8 +1120,12 @@ mpc52xx_console_get_options(struct uart_port *port,
 	pr_debug("mpc52xx_console_get_options(port=%p)\n", port);
 
 	/* Read the mode registers */
+#ifdef CONFIG_PPC_MPC5125
+	mr1 = in_8(&psc->mr1);
+#else
 	out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
 	mr1 = in_8(&psc->mode);
+#endif
 
 	/* CT{U,L}R are write-only ! */
 	*baud = CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD;
@@ -1296,9 +1313,13 @@ static struct of_device_id mpc52xx_uart_of_match[] = {
 	/* binding used by efika: */
 	{ .compatible = "mpc5200-serial", .data = &mpc52xx_psc_ops, },
 #endif
-#ifdef CONFIG_PPC_MPC512x
+#if defined(CONFIG_PPC_MPC512x) && !defined(CONFIG_PPC_MPC5125)
 	{ .compatible = "fsl,mpc5121-psc-uart", .data = &mpc512x_psc_ops, },
 #endif
+#ifdef CONFIG_PPC_MPC5125
+	{ .compatible = "fsl,mpc5125-psc-uart", .data = &mpc512x_psc_ops, },
+#endif
+
 	{},
 };
 
