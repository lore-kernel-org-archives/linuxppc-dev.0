Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id C01E2DDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 02:27:53 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 7315D2E97BC
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:27:46 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id 4C2862E97AF
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:27:46 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id 4103E1508B
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 16:27:46 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: AW: [PATCH v1] RS485 support for MPC5200x_psc_uart
Date: Mon, 17 Nov 2008 16:27:45 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B8143@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <20081113184218.GA11602@pengutronix.de>
References: <633A55242A59C7488FAAF5A6850929984B813E@SRVEXC01.sts.saurer.vpn>
	<20081113184218.GA11602@pengutronix.de>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Here my rewritten patch for rs485 support for kernel 2.6.24.7

Read/write direction ot differential bus transceiver will be changed by =
/RTS=20
with output port register 0p0 and 0p1;
To switch uart to rs485 mode, a 1 has to be written to=20
/sys/dev/f00000000.soc5200/f0002x000.serial/uartmode.=20
*void private_data in struct uart_port will point t a variable for each =
port to mark
mode.
A uart console can not be switched to rs485 mode

Maybe this is usefull for somebody

Criticism is welcome

cheers


diff -uprN linux-2.6.24.7-el392-rt11-can751_org/drivers/serial/Kconfig =
linux-2.6.24.7-el392-rt11-can751/drivers/serial/Kconfig
--- linux-2.6.24.7-el392-rt11-can751_org/drivers/serial/Kconfig	=
2008-10-16 13:35:31.000000000 +0200
+++ linux-2.6.24.7-el392-rt11-can751/drivers/serial/Kconfig	2008-11-13 =
15:44:19.000000000 +0100
@@ -1123,6 +1123,13 @@ config SERIAL_MPC52xx
 	  for use as console, it must be included in kernel and not as a
 	  module.
=20
+config SERIAL_RS485
+	bool "RS485 support"
+	depends on SERIAL_MPC52xx
+	help
+	  This drivers support serial RS485 ports. If you like=20
+	  to use them, answer Y to this option.
+
 config SERIAL_MPC52xx_CONSOLE
 	bool "Console on a Freescale MPC52xx family PSC serial port"
 	depends on SERIAL_MPC52xx=3Dy
diff -uprN =
linux-2.6.24.7-el392-rt11-can751_org/drivers/serial/mpc52xx_uart.c =
linux-2.6.24.7-el392-rt11-can751/drivers/serial/mpc52xx_uart.c
--- linux-2.6.24.7-el392-rt11-can751_org/drivers/serial/mpc52xx_uart.c	=
2008-10-16 13:40:15.000000000 +0200
+++ linux-2.6.24.7-el392-rt11-can751/drivers/serial/mpc52xx_uart.c	=
2008-11-17 15:55:07.000000000 +0100
@@ -21,11 +21,25 @@
  * Copyright (C) 2004-2006 Sylvain Munaut <tnt@246tNt.com>
  * Copyright (C) 2003 MontaVista, Software, Inc.
  *
+ * RS485 support is written by Hans Lehmann=20
+ *	<hans.Lehmann@ritter-elektronik.de>
+ *
  * This file is licensed under the terms of the GNU General Public =
License
  * version 2. This program is licensed "as is" without any warranty of =
any
  * kind, whether express or implied.
  */
=20
+/* RS485 Usage:
+ * The driver will autmaticly handle a uart port in RS485 mode if you =
set uartmode
+ * in /sys/device/f00000000.soc5200/f0002x000.serial to 1
+ * "echo 1 >  /sys/device/f00000000.soc5200/f0002x000.serial/uartmode
+ * We misuse void pointer private->data in struct uart_port
+ * to determinate handle of port.
+ * RTS bit is used to set direction of differential bus transceiver
+ * Set mpc52xx_psc_op1 asserts output port /RTS: Write
+ * Set mpc52xx_psc_op0 negate output port /RTS: Read
+*/
+
 /* Platform device Usage :
  *
  * Since PSCs can have multiple function, the correct driver for each =
one
@@ -94,6 +108,12 @@
=20
 #define ISR_PASS_LIMIT 256	/* Max number of iteration in the interrupt =
*/
=20
+#define	RS485_SET_RTS		0x01		/* for ouput port 1 bit set */
+#define	RS485_CLR_RTS		RS485_SET_RTS	/* for ouput port 0 bit set */
+
+#define RS485			1
+#define RS232			0
+
=20
 static struct uart_port mpc52xx_uart_ports[MPC52xx_PSC_MAXNUM];
 	/* Rem: - We use the read_status_mask as a shadow of
@@ -132,6 +152,12 @@ static struct of_device_id mpc52xx_uart_
 };
 #endif
=20
+/* Simple variable to set private->data
+ * private data will be used to test, how to handle port
+*/=20
+#ifdef CONFIG_SERIAL_RS485
+int uartmode =3D RS232;
+#endif /* CONFIG_SERIAL_RS485 */
=20
 /* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 /* UART operations                                                      =
    */
@@ -144,6 +170,20 @@ mpc52xx_uart_tx_empty(struct uart_port *
 	return (status & MPC52xx_PSC_SR_TXEMP) ? TIOCSER_TEMT : 0;
 }
=20
+#ifdef CONFIG_SERIAL_RS485
+static void
+mpc52xx_uart_rs485_rts_clear(struct uart_port *port)
+{
+	/* In RS485 mode negate output port /RTS after=20
+	 * TX empty (underrun) IRQ, to be able to receive data, directly
+	*/=20
+	out_8(&PSC(port)->mpc52xx_psc_op0, RS485_SET_RTS);=09
+	port->read_status_mask &=3D ~MPC52xx_PSC_IMR_TXEMP=20
+			       & ~MPC52xx_PSC_IMR_TXRDY;
+	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
+}
+#endif /* CONFIG_SERIAL_RS485 */
+
 static void
 mpc52xx_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
@@ -168,8 +208,18 @@ mpc52xx_uart_stop_tx(struct uart_port *p
 static void
 mpc52xx_uart_start_tx(struct uart_port *port)
 {
-	/* port->lock taken by caller */
-	port->read_status_mask |=3D MPC52xx_PSC_IMR_TXRDY;
+	/* port->lock taken by caller */=09
+#ifdef CONFIG_SERIAL_RS485
+	if (*(int *)port->private_data){
+		/* Set /RTS immidiate before start transaction=20
+	 	 * Make sure tx empty interrupt is on=20
+		*/
+		port->read_status_mask |=3D MPC52xx_PSC_IMR_TXEMP=20
+				       | MPC52xx_PSC_IMR_TXRDY;
+		out_8(&PSC(port)->mpc52xx_psc_op1, RS485_CLR_RTS);
+	} else
+#endif /* CONFIG_SERIAL_RS485 */
+		port->read_status_mask |=3D MPC52xx_PSC_IMR_TXRDY;
 	out_be16(&PSC(port)->mpc52xx_psc_imr,port->read_status_mask);
 }
=20
@@ -513,6 +563,14 @@ mpc52xx_uart_int_tx_chars(struct uart_po
 {
 	struct circ_buf *xmit =3D &port->info->xmit;
=20
+#ifdef CONFIG_SERIAL_RS485
+	/* Tx Empty in RS485 Mode */
+	if (uart_circ_empty(xmit) && mpc52xx_uart_tx_empty(port)){
+		mpc52xx_uart_rs485_rts_clear(port);=09
+		return 0;=09
+	}
+#endif /* CONFIG_SERIAL_RS485 */
+=09
 	/* Process out of band chars */
 	if (port->x_char) {
 		out_8(&PSC(port)->mpc52xx_psc_buffer_8, port->x_char);
@@ -578,6 +636,15 @@ mpc52xx_uart_int(int irq, void *dev_id)
 		if ( status & MPC52xx_PSC_IMR_TXRDY )
 			keepgoing |=3D mpc52xx_uart_int_tx_chars(port);
=20
+#ifdef CONFIG_SERIAL_RS485
+		/* Do we need to send chars in RS485 mode ? */
+		/* For this, TX must be ready, TX and TX empty=20
+		 * interrupt enabled=20
+		*/
+		if ((*(int *)port->private_data) && (status & MPC52xx_PSC_IMR_TXEMP))
+			keepgoing |=3D mpc52xx_uart_int_tx_chars(port);
+#endif /* CONFIG_SERIAL_RS485 */
+
 		/* Limit number of iteration */
 		if ( !(--pass) )
 			keepgoing =3D 0;
@@ -805,6 +872,44 @@ console_initcall(mpc52xx_console_init);
 #define MPC52xx_PSC_CONSOLE NULL
 #endif
=20
+#ifdef CONFIG_SERIAL_RS485
+/* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+/* SYSFS operations                                                     =
    */
+/* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
+
+static ssize_t read_uartmode(struct device *dev,
+			     struct device_attribute *attr,
+			     const char *buf)
+{
+	struct uart_port *port =3D (struct uart_port *) dev_get_drvdata(dev);
+
+	printk("Type ttyPSC%i: %i\n", port->line,*(int *)port->private_data);
+	return strlen(buf)+1;
+}
+
+static ssize_t write_uartmode(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
+{
+	struct uart_port *port =3D (struct uart_port *) dev_get_drvdata(dev);
+
+	uartmode =3D simple_strtoul(buf, NULL, 0);
+=09
+	if (!uart_console(port)){
+		if (uartmode || *(int *)port->private_data)
+			*(int *)port->private_data =3D uartmode;
+		printk("Type ttyPSC%i: %i\n", port->line,
+		*(int *)port->private_data);
+	} else=09
+		printk("ttyPSC%i is console\n",port->line);
+	=09
+	uartmode =3D RS232;
+=09
+	return strlen (buf) + 1;
+}
+
+static DEVICE_ATTR(uartmode, S_IRUGO|S_IWUGO, read_uartmode, =
write_uartmode);
+#endif /* CONFIG_SERIAL_RS485 */
=20
 /* =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
 /* UART Driver                                                          =
    */
@@ -969,6 +1074,19 @@ mpc52xx_uart_of_probe(struct of_device *
 	port->ops	=3D &mpc52xx_uart_ops;
 	port->dev	=3D &op->dev;
=20
+	/* to change uart mode, we need a entry point */
+#ifdef CONFIG_SERIAL_RS485
+	device_create_file(&op->dev, &dev_attr_uartmode);
+
+	/* for each port we have to allocate a variable */
+	port->private_data =3D kmalloc(sizeof(int), GFP_USER);
+	if (!port->private_data)
+		return -ENOMEM;
+
+	*(int *)port->private_data =3D RS232;
+
+#endif /* CONFIG_SERIAL_RS485 */
+
 	/* Search for IRQ and mapbase */
 	if ((ret =3D of_address_to_resource(op->node, 0, &res)) !=3D 0)
 		return ret;
@@ -997,6 +1115,13 @@ mpc52xx_uart_of_remove(struct of_device=20
 {
 	struct uart_port *port =3D dev_get_drvdata(&op->dev);
 	dev_set_drvdata(&op->dev, NULL);
+=09
+#ifdef CONFIG_SERIAL_RS485
+	device_remove_file(&op->dev, &dev_attr_uartmode);
+
+	/* Don't forget to free memory */
+	kfree(port->private_data);
+#endif /* CONFIG_SERIAL_RS485 */
=20
 	if (port) {
 		uart_remove_one_port(&mpc52xx_uart_driver, port);
@@ -1132,6 +1257,7 @@ mpc52xx_uart_init(void)
 		return ret;
 	}
 #else
+
 	ret =3D platform_driver_register(&mpc52xx_uart_platform_driver);
 	if (ret) {
 		printk(KERN_ERR "%s: platform_driver_register failed (%i)\n",
diff -uprN =
linux-2.6.24.7-el392-rt11-can751_org/include/asm-powerpc/mpc52xx_psc.h =
linux-2.6.24.7-el392-rt11-can751/include/asm-powerpc/mpc52xx_psc.h
--- =
linux-2.6.24.7-el392-rt11-can751_org/include/asm-powerpc/mpc52xx_psc.h	=
2008-10-16 13:35:05.000000000 +0200
+++ linux-2.6.24.7-el392-rt11-can751/include/asm-powerpc/mpc52xx_psc.h	=
2008-11-14 11:40:56.000000000 +0100
@@ -27,6 +27,7 @@
 /* Max number of PSCs */
 #define MPC52xx_PSC_MAXNUM	6
=20
+
 /* Programmable Serial Controller (PSC) status register bits */
 #define MPC52xx_PSC_SR_CDE	0x0080
 #define MPC52xx_PSC_SR_RXRDY	0x0100
@@ -64,6 +65,7 @@
 #define MPC52xx_PSC_IMR_TXRDY		0x0100
 #define MPC52xx_PSC_IMR_RXRDY		0x0200
 #define MPC52xx_PSC_IMR_DB		0x0400
+#define MPC52xx_PSC_IMR_TXEMP		MPC52xx_PSC_SR_TXEMP
 #define MPC52xx_PSC_IMR_IPC		0x8000
=20
 /* PSC input port change bit */
@@ -139,8 +141,10 @@ struct mpc52xx_psc {
 	u8		ip;		/* PSC + 0x34 */
 	u8		reserved9[3];
 	u8		op1;		/* PSC + 0x38 */
+#define mpc52xx_psc_op1		op1
 	u8		reserved10[3];
 	u8		op0;		/* PSC + 0x3c */
+#define mpc52xx_psc_op0		op0
 	u8		reserved11[3];
 	u32		sicr;		/* PSC + 0x40 */
 	u8		ircr1;		/* PSC + 0x44 */
=20



Mit freundlichen Gr=FC=DFen

Hans Lehmann
Softwareentwicklung

Telefon	+49 (0)2191-67-2520
Fax 	+49 (0)2191-67-703408
e-mail 	hans.lehmann@ritter-elektronik.de



Ritter Elektronik GmbH
Leverkuser Stra=DFe 65
D-42897 Remscheid
www.ritter-elektronik.de

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg  /  USt-ID DE 814009849


-----Urspr=FCngliche Nachricht-----
Von: Wolfram Sang [mailto:w.sang@pengutronix.de]=20
Gesendet: Donnerstag, 13. November 2008 19:42
An: Lehmann, Hans (Ritter Elektronik)
Cc: linuxppc-dev@ozlabs.org; Grant Likely
Betreff: Re: [PATCH v1] RS485 support for MPC5200x_psc_uart

Hello Hans,

On Thu, Nov 13, 2008 at 04:48:30PM +0100, Lehmann, Hans (Ritter =
Elektronik) wrote:

> Adds rs485 support for MPC52xx_psc_uart

Please be more specific. What exactly was done/modified to have =
RS485-support.

Please also read SubmittingPatches and CodingStyle in the Documentation =
directory and adapt your patch accordingly. For example: Send patches =
inlined, this makes reviewing a lot easier. Don't use magic numbers. Use =
spaces around operators. All this helps maintaining your code in the =
future.

> COM1 is console and not selectable.

COM1 is rarely selectable in Linux ;)

Kind regards,

   Wolfram

--
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de  Pengutronix - =
Linux Solutions for Science and Industry
