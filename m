Return-Path: <dbolcsfoldi@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by ozlabs.org (Postfix) with ESMTP id EBF9667BC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 09:48:42 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id t32so2093702pyc
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 Oct 2006 16:48:41 -0700 (PDT)
Message-ID: <609d5c8e0610151648x41b0c49cj4d0cda0e3b5bf1e@mail.gmail.com>
Date: Sun, 15 Oct 2006 16:48:41 -0700
From: "David Bolcsfoldi" <dbolcsfoldi@gmail.com>
To: "Peter Korsgaard" <jacmet@sunsite.dk>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
In-Reply-To: <87ac40vgeo.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
	<87ac40vgeo.fsf@sleipner.barco.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 10/13/06, Peter Korsgaard <jacmet@sunsite.dk> wrote:

> Could you make it relative to my driver so the changes are easier to
> see?
>

Done and done. Look at the end of this e-mail.

> The PPC is big endian - Did you remember to add 3 to your base
> address?
>

I don't see how reading a single byte would be affected by the
endianess of the platform.
I think it has more to do with the fact that the status and control
registers are both 4 byte wide and when you add 3 to your offset you
read only the LSB. I also suspect that the RX and TX registers are 4
byte wide too, even though this is not stated explicitly in the
documentation I think it would be prudent to access these two as
4-byte wide registers as well.

I guess it is OK to read and write bytes as long as the bitflags don't
change location. But I believe it is stated in the documentation that
the OPB UART Lite device is a big endian device, in my opinion it
would better to honor this and do big endian access of register width.

The patch below is not identical to the one I posted in previously.
This one has some preprocessor hackery in it to have the uartlites as
separate platform devices (VIRTEX_UARTLITE_0 ... VIRTEX_UARTLITE_3) if
they are available. In theory the only thing you'd need to have the
uartlites available would be to edit your xparameters.h with the
correct uartlite info, enable the driver in your config and compile
your kernel.

diff -urN uartlite/arch/ppc/boot/common/misc-common.c
uartlite-mod/arch/ppc/boot/common/misc-common.c
--- uartlite/arch/ppc/boot/common/misc-common.c	2006-10-15
14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/boot/common/misc-common.c	2006-10-15
13:58:51.000000000 -0700
@@ -57,7 +57,8 @@

 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 extern unsigned long com_port;

 extern int serial_tstc(unsigned long com_port);
@@ -80,7 +81,8 @@
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -95,7 +97,8 @@
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -112,7 +115,8 @@

 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -161,7 +165,8 @@
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
diff -urN uartlite/arch/ppc/boot/simple/Makefile
uartlite-mod/arch/ppc/boot/simple/Makefile
--- uartlite/arch/ppc/boot/simple/Makefile	2006-10-15 14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/boot/simple/Makefile	2006-10-15
13:58:51.000000000 -0700
@@ -205,6 +205,7 @@
 endif
 boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
 boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
+boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o

 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
 ifeq ($(CONFIG_PPC_PREP),y)
diff -urN uartlite/arch/ppc/boot/simple/misc.c
uartlite-mod/arch/ppc/boot/simple/misc.c
--- uartlite/arch/ppc/boot/simple/misc.c	2006-10-15 14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/boot/simple/misc.c	2006-10-15 13:58:51.000000000 -0700
@@ -48,7 +48,8 @@
 #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_VGA_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)) \
 	&& !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
 #endif
diff -urN uartlite/arch/ppc/boot/simple/uartlite_tty.c
uartlite-mod/arch/ppc/boot/simple/uartlite_tty.c
--- uartlite/arch/ppc/boot/simple/uartlite_tty.c	1969-12-31
16:00:00.000000000 -0800
+++ uartlite-mod/arch/ppc/boot/simple/uartlite_tty.c	2006-10-15
13:58:51.000000000 -0700
@@ -0,0 +1,69 @@
+/*
+ * Xilinx UART Lite support.
+ * Right now it only works over UART0 and none other.
+ *
+ * Copyright (C) 2006 David Bolcsfoldi <dbolcsfoldi@gmail.com>
+ *
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include <asm/io.h>
+#include <linux/serial_uartlite.h>
+#include <platforms/4xx/xparameters/xparameters.h>
+
+static inline int is_xmit_full(unsigned int address)
+{
+	return ((in_be32((volatile unsigned *) (address + ULITE_STATUS)) &
ULITE_STATUS_TXFULL) == ULITE_STATUS_TXFULL);
+}
+
+static inline int is_recv_empty(unsigned int address)
+{
+	return ((in_be32((volatile unsigned *) (address + ULITE_STATUS)) &
ULITE_STATUS_RXVALID) != ULITE_STATUS_RXVALID);
+}
+
+unsigned long serial_init(int chan, void *ignored)
+{
+	switch (chan)  {
+	#ifdef XPAR_XUL_UART_0_BASEADDR
+		case 0:
+			return XPAR_XUL_UART_0_BASEADDR;
+	#endif
+	#ifdef XPAR_XUL_UART_1_BASEADDR
+		case 1:		
+			return XPAR_XUL_UART_1_BASEADDR;
+	#endif
+	#ifdef XPAR_XUL_UART_2_BASEADDR
+		case 2:
+			return XPAR_XUL_UART_2_BASEADDR;
+	#endif
+	#ifdef XPAR_XUL_UART_3_BASEADDR
+		case 3:
+			return XPAR_XUL_UART_3_BASEADDR;
+	#endif
+		default:
+			goto out;
+	}
+	
+out:
+	return -1;
+}
+
+void serial_putc(unsigned long com_port, unsigned char c)
+{
+	while(is_xmit_full(XPAR_XUL_UART_0_BASEADDR));
+	out_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + ULITE_TX), c);
+}
+
+unsigned char serial_getc(unsigned long com_port)
+{
+	while(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
+	return in_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + ULITE_RX));
+}
+
+int serial_tstc(unsigned long com_port)
+{
+	return !(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
+}
+
Binary files uartlite/arch/ppc/boot/simple/.uartlite_tty.c.swp and
uartlite-mod/arch/ppc/boot/simple/.uartlite_tty.c.swp differ
diff -urN uartlite/arch/ppc/platforms/4xx/virtex.c
uartlite-mod/arch/ppc/platforms/4xx/virtex.c
--- uartlite/arch/ppc/platforms/4xx/virtex.c	2006-10-15 14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/platforms/4xx/virtex.c	2006-10-15
13:58:52.000000000 -0700
@@ -46,11 +46,91 @@
 	{ }, /* terminated by empty record */
 };

+#define XPAR_UARTLITE(num) { \
+		.uartclk = XPAR_PLB_CLOCK_FREQ_HZ / 16, \
+		.baud	 = XPAR_XUL_UART_##num##_BAUDRATE, \
+		.bits	 = XPAR_XUL_UART_##num##_DATA_BITS, \
+		.parity	 = XPAR_XUL_UART_##num##_USE_PARITY, \
+		.odd_parity = XPAR_XUL_UART_##num##_ODD_PARITY, \
+}
+
+#define UARTLITE_PDEV(num) { \
+	.name = "uartlite", \
+	.id = num, \
+	.dev.platform_data = &uartlite_platform_data[num], \
+	.num_resources = 2, \
+	.resource = (struct resource[]) { \
+		{ \
+			.start = XPAR_XUL_UART_##num##_BASEADDR, \
+			.end = XPAR_XUL_UART_##num##_HIGHADDR, \
+			.flags = IORESOURCE_MEM, \
+		}, \
+		{ \
+			.start = XPAR_INTC_0_XUL_UART_##num##_VEC_ID, \
+			.end = XPAR_INTC_0_XUL_UART_##num##_VEC_ID, \
+			.flags = IORESOURCE_IRQ, \
+		}, \
+	} \
+}
+	
+struct plat_uartlite_data uartlite_platform_data[] = {
+#ifdef XPAR_XUL_UART_0_BASEADDR
+	XPAR_UARTLITE(0),
+#endif
+#ifdef XPAR_XUL_UART_1_BASEADDR
+	XPAR_UARTLITE(1),
+#endif
+#ifdef XPAR_XUL_UART_2_BASEADDR
+	XPAR_UARTLITE(2),
+#endif
+#ifdef XPAR_XUL_UART_3_BASEADDR
+	XPAR_UARTLITE(3),
+#endif
+	{ }, /* terminated by empty record */
+};
+
 struct platform_device ppc_sys_platform_devices[] = {
 	[VIRTEX_UART] = {
 		.name		= "serial8250",
 		.id		= 0,
 		.dev.platform_data = serial_platform_data,
 	},
+
+#ifdef XPAR_XUL_UART_0_BASEADDR
+	[VIRTEX_UARTLITE_0] = UARTLITE_PDEV(0),
+#else
+	[VIRTEX_UARTLITE_0] = { .id = - 1, },
+#endif /* XPAR_XUL_UART_0_BASEADDR */
+
+#ifdef XPAR_XUL_UART_1_BASEADDR
+	[VIRTEX_UARTLITE_1] = UARTLITE_PDEV(1),
+#else
+	[VIRTEX_UARTLITE_1] = { .id = - 1, },
+#endif /* XPAR_XUL_UART_1_BASEADDR */
+
+#ifdef XPAR_XUL_UART_2_BASEADDR
+	[VIRTEX_UARTLITE_2] = UARTLITE_PDEV(2),
+#else
+	[VIRTEX_UARTLITE_2] = { .id = - 1, },
+#endif /* XPAR_XUL_UART_2_BASEADDR */
+
+#ifdef XPAR_XUL_UART_3_BASEADDR
+	[VIRTEX_UARTLITE_3] = UARTLITE_PDEV(3),
+#else
+	[VIRTEX_UARTLITE_3] = { .id = - 1, },
+#endif /* XPAR_XUL_UART_3_BASEADDR */
 };

+/* For early console on the uartlite serial port some way of
+ * getting to the platform_device is needed */
+
+struct platform_device* early_uart_get_pdev(int dev)
+{
+	if (dev < 0 ||
+		dev >= NUM_PPC_SYS_DEVS) {
+		return NULL;
+	}
+
+	return &ppc_sys_platform_devices[dev];
+}
+
diff -urN uartlite/arch/ppc/platforms/4xx/virtex.h
uartlite-mod/arch/ppc/platforms/4xx/virtex.h
--- uartlite/arch/ppc/platforms/4xx/virtex.h	2006-10-15 14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/platforms/4xx/virtex.h	2006-10-15
13:58:52.000000000 -0700
@@ -27,8 +27,22 @@
 /* Device type enumeration for platform bus definitions */
 #ifndef __ASSEMBLY__
 enum ppc_sys_devices {
-	VIRTEX_UART, NUM_PPC_SYS_DEVS,
+	VIRTEX_UART,
+	VIRTEX_UARTLITE_0,
+	VIRTEX_UARTLITE_1,
+	VIRTEX_UARTLITE_2,
+	VIRTEX_UARTLITE_3,
+	NUM_PPC_SYS_DEVS,
 };
+
+struct plat_uartlite_data {
+	unsigned int uartclk;
+	unsigned int baud;
+	unsigned char bits;
+	unsigned char parity;
+	unsigned char odd_parity;
+};
+
 #endif

 #endif				/* __ASM_VIRTEX_H__ */
diff -urN uartlite/arch/ppc/platforms/4xx/xilinx_ml403.c
uartlite-mod/arch/ppc/platforms/4xx/xilinx_ml403.c
--- uartlite/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-15
14:09:47.000000000 -0700
+++ uartlite-mod/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-15
13:58:52.000000000 -0700
@@ -57,6 +57,10 @@
  *          ppc4xx_pic_init			arch/ppc/syslib/xilinx_pic.c
  */

+#ifndef XPAR_XUARTLITE_NUM_INSTANCES
+#define XPAR_XUARTLITE_NUM_INSTANCES 0
+#endif
+
 /* Board specifications structures */
 struct ppc_sys_spec *cur_ppc_sys_spec;
 struct ppc_sys_spec ppc_sys_specs[] = {
@@ -65,10 +69,22 @@
 		.ppc_sys_name	= "Xilinx ML403 Reference Design",
 		.mask 		= 0x00000000,
 		.value 		= 0x00000000,
-		.num_devices	= 1,
+		.num_devices	= 1 + XPAR_XUARTLITE_NUM_INSTANCES,
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			VIRTEX_UART,
+#ifdef XPAR_XUL_UART_0_BASEADDR
+			VIRTEX_UARTLITE_0,
+#endif
+#ifdef XPAR_XUL_UART_1_BASEADDR
+			VIRTEX_UARTLITE_1,
+#endif
+#ifdef XPAR_XUL_UART_2_BASEADDR
+			VIRTEX_UARTLITE_2,
+#endif
+#ifdef XPAR_XUL_UART_3_BASEADDR
+			VIRTEX_UARTLITE_3,
+#endif
 		},
 	},
 };
Binary files uartlite/arch/ppc/platforms/4xx/xparameters/.xparameters_ml403.h.swp
and uartlite-mod/arch/ppc/platforms/4xx/xparameters/.xparameters_ml403.h.swp
differ
diff -urN uartlite/drivers/serial/uartlite.c
uartlite-mod/drivers/serial/uartlite.c
--- uartlite/drivers/serial/uartlite.c	2006-10-15 14:13:30.000000000 -0700
+++ uartlite-mod/drivers/serial/uartlite.c	2006-10-15 13:58:59.000000000 -0700
@@ -17,37 +17,21 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <asm/io.h>
+#include <linux/serial_uartlite.h>

 #define ULITE_MAJOR		204
 #define ULITE_MINOR		187
 #define ULITE_NR_UARTS		4

-/* For register details see datasheet:
-   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
-*/
-#define ULITE_RX		0x00
-#define ULITE_TX		0x04
-#define ULITE_STATUS		0x08
-#define ULITE_CONTROL		0x0c
-
-#define ULITE_REGION		16
-
-#define ULITE_STATUS_RXVALID	0x01
-#define ULITE_STATUS_RXFULL	0x02
-#define ULITE_STATUS_TXEMPTY	0x04
-#define ULITE_STATUS_TXFULL	0x08
-#define ULITE_STATUS_IE		0x10
-#define ULITE_STATUS_OVERRUN	0x20
-#define ULITE_STATUS_FRAME	0x40
-#define ULITE_STATUS_PARITY	0x80
-
-#define ULITE_CONTROL_RST_TX	0x01
-#define ULITE_CONTROL_RST_RX	0x02
-#define ULITE_CONTROL_IE	0x10
-
-
 static struct uart_port ports[ULITE_NR_UARTS];

+/* Place-holder for board-specific stuff */
+struct platform_device* __attribute__ ((weak)) __init
+early_uart_get_pdev(int index)
+{
+	return NULL;
+}
+
 static int ulite_receive(struct uart_port *port, int stat)
 {
 	struct tty_struct *tty = port->info->tty;
@@ -61,7 +45,7 @@
 	/* stats */
 	if (stat & ULITE_STATUS_RXVALID) {
 		port->icount.rx++;
-		ch = readb(port->membase + ULITE_RX);
+		ch = in_be32((unsigned volatile *) (port->membase + ULITE_RX));

 		if (stat & ULITE_STATUS_PARITY)
 			port->icount.parity++;
@@ -106,7 +90,7 @@
 		return 0;

 	if (port->x_char) {
-		writeb(port->x_char, port->membase + ULITE_TX);
+		out_be32((unsigned volatile *) (port->membase + ULITE_TX), port->x_char);
 		port->x_char = 0;
 		port->icount.tx++;
 		return 1;
@@ -115,7 +99,7 @@
 	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
 		return 0;

-	writeb(xmit->buf[xmit->tail], port->membase + ULITE_TX);
+	out_be32((unsigned volatile *) (port->membase + ULITE_TX),
xmit->buf[xmit->tail]);
 	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
 	port->icount.tx++;

@@ -131,12 +115,16 @@
 	struct uart_port *port = (struct uart_port *)dev_id;
 	int busy;

+	spin_lock(&port->lock); /* Lock the port in case of printk */
+	
 	do {
-		int stat = readb(port->membase + ULITE_STATUS);
+		int stat = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS));
 		busy  = ulite_receive(port, stat);
 		busy |= ulite_transmit(port, stat);
 	} while (busy);

+	spin_unlock(&port->lock);
+	
 	tty_flip_buffer_push(port->info->tty);

 	return IRQ_HANDLED;
@@ -148,7 +136,7 @@
 	unsigned int ret;

 	spin_lock_irqsave(&port->lock, flags);
-	ret = readb(port->membase + ULITE_STATUS);
+	ret = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS));
 	spin_unlock_irqrestore(&port->lock, flags);

 	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
@@ -171,7 +159,7 @@

 static void ulite_start_tx(struct uart_port *port)
 {
-	ulite_transmit(port, readb(port->membase + ULITE_STATUS));
+	ulite_transmit(port, in_be32((unsigned volatile *) (port->membase +
ULITE_STATUS)));
 }

 static void ulite_stop_rx(struct uart_port *port)
@@ -200,9 +188,8 @@
 	if (ret)
 		return ret;

-	writeb(ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX,
-	       port->membase + ULITE_CONTROL);
-	writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
+	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
ULITE_CONTROL_IE);

 	return 0;
 }
@@ -216,6 +203,7 @@
 static void ulite_set_termios(struct uart_port *port, struct termios *termios,
 			      struct termios *old)
 {
+	struct plat_uartlite_data *udata;
 	unsigned long flags;
 	unsigned int baud;

@@ -240,7 +228,9 @@
 			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;

 	/* update timeout */
-	baud = uart_get_baud_rate(port, termios, old, 0, 460800);
+	udata = port->dev->platform_data;
+	
+	baud = uart_get_baud_rate(port, termios, old, udata->baud, udata->baud);
 	uart_update_timeout(port, termios->c_cflag, baud);

 	spin_unlock_irqrestore(&port->lock, flags);
@@ -265,7 +255,10 @@
 		return -EBUSY;
 	}

-	port->membase = ioremap(port->mapbase, ULITE_REGION);
+	if (port->flags & UPF_IOREMAP) {
+		port->membase = ioremap(port->mapbase, ULITE_REGION);
+	}
+	
 	if (!port->membase) {
 		dev_err(port->dev, "Unable to map registers\n");
 		release_mem_region(port->mapbase, ULITE_REGION);
@@ -306,6 +299,35 @@
 	.verify_port	= ulite_verify_port
 };

+static inline int ulite_init_port(struct uart_port *port, struct
platform_device *pdev)
+{
+	struct resource *res;
+	struct plat_uartlite_data *udata = pdev->dev.platform_data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->mapbase = res->start;
+
+	res = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
+	if (!res)
+		return -ENODEV;
+
+	port->irq = res->start;
+	port->uartclk = udata->uartclk;
+	port->membase = 0;
+	port->fifosize = 16;
+	port->regshift = 2;
+	port->iobase = 1; /* Mark port in use */
+	port->iotype = UPIO_MEM;
+	port->flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP;
+	port->ops = &ulite_ops;
+	port->type = PORT_UNKNOWN;
+
+	return 0;
+}
+
 #ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
 static void ulite_console_wait_tx(struct uart_port *port)
 {
@@ -313,7 +335,7 @@

 	/* wait up to 10ms for the character(s) to be sent */
 	for (i=0; i<10000; i++) {
-		if (readb(port->membase + ULITE_STATUS) & ULITE_STATUS_TXEMPTY)
+		if (in_be32((unsigned volatile *) (port->membase + ULITE_STATUS)) &
ULITE_STATUS_TXEMPTY)
 			break;
 		udelay(1);
 	}
@@ -322,7 +344,7 @@
 static void ulite_console_putchar(struct uart_port *port, int ch)
 {
 	ulite_console_wait_tx(port);
-	writeb(ch, port->membase + ULITE_TX);
+	out_be32((unsigned volatile *) (port->membase + ULITE_TX), ch);
 }

 static void ulite_console_write(struct console *co, const char *s,
@@ -339,16 +361,18 @@
 		spin_lock_irqsave(&port->lock, flags);

 	/* save and disable interrupt */
-	ier = readb(port->membase + ULITE_STATUS) & ULITE_STATUS_IE;
-	writeb(0, port->membase + ULITE_CONTROL);
-
+	ier = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS))
& ULITE_STATUS_IE;
+	
+	//writeb(0, port->membase + ULITE_CONTROL);
+	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL), 0);
+	
 	uart_console_write(port, s, count, ulite_console_putchar);

 	ulite_console_wait_tx(port);

 	/* restore interrupt state */
 	if (ier)
-		writeb(ULITE_CONTROL_IE, port->membase + ULITE_CONTROL);
+		out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
ULITE_CONTROL_IE);

 	if (locked)
 		spin_unlock_irqrestore(&port->lock, flags);
@@ -356,16 +380,57 @@

 static int __init ulite_console_setup(struct console *co, char *options)
 {
+	int i, ret;
 	struct uart_port *port;
-
+	struct platform_device *pdev;
+	
 	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
 		return -EINVAL;

 	port = &ports[co->index];

 	/* not initialized yet? */
-	if (!port->membase)
-		return -ENODEV;
+	if (!port->membase) {
+		/* We might be early console */
+
+		pdev = NULL;
+
+		/* Loop through the platform devices
+		 * until we find one with correct name
+		 * and device id */
+
+		for (i = 0; i < NUM_PPC_SYS_DEVS; ++i) {
+			pdev = early_uart_get_pdev(0);
+
+			if (pdev->id != - 1 &&
+				pdev->name != NULL &&
+				(strcmp(pdev->name, "uartlite") == 0) &&
+				pdev->id == co->index) {
+				break;
+			}
+		}
+
+		if (pdev == NULL) {
+			return -ENODEV;
+		}
+
+		ret = ulite_init_port(port, pdev);
+
+		if (ret != 0)
+			return ret;
+
+		port->line = co->index;
+		spin_lock_init(&port->lock);
+		port->membase = ioremap(port->mapbase, ULITE_REGION);
+
+		if(port->membase == NULL) {
+			port->iobase = 0;
+			return -EINVAL;
+		}
+
+		/* Clear ioremap since this port has been mapped already */
+		port->flags &= ~UPF_IOREMAP;
+	}

 	return 0;
 }
@@ -406,41 +471,44 @@

 static int __devinit ulite_probe(struct platform_device *pdev)
 {
-	struct resource *res, *res2;
 	struct uart_port *port;
+	int ret;

 	if (pdev->id < 0 || pdev->id >= ULITE_NR_UARTS)
 		return -EINVAL;

-	if (ports[pdev->id].membase)
-		return -EBUSY;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!res)
-		return -ENODEV;
+	if (ports[pdev->id].membase) {
+		if (ports[pdev->id].flags & UPF_IOREMAP) {	
+			return -EBUSY; /* Port is busy */
+		}
+
+		else {
+			/* This port as be remapped so it must have been an early console */
+			port = &ports[pdev->id];
+			goto add_port;
+		}
+	}

-	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
-	if (!res2)
-		return -ENODEV;

 	port = &ports[pdev->id];

-	port->fifosize	= 16;
-	port->regshift	= 2;
-	port->iotype	= UPIO_MEM;
-	port->iobase	= 1; /* mark port in use */
-	port->mapbase	= res->start;
-	port->membase	= 0;
-	port->ops	= &ulite_ops;
-	port->irq	= res2->start;
-	port->flags	= UPF_BOOT_AUTOCONF;
-	port->dev	= &pdev->dev;
-	port->type	= PORT_UNKNOWN;
+	ret = ulite_init_port(port, pdev);

-	uart_add_one_port(&ulite_uart_driver, port);
-	platform_set_drvdata(pdev, port);
+	if (ret != 0)
+		goto out;
+	
+	port->line = pdev->id;
+
+add_port:
+	port->dev = &pdev->dev;
+	
+	ret = uart_add_one_port(&ulite_uart_driver, port);

-	return 0;
+	if(ret == 0)
+		platform_set_drvdata(pdev, port);
+
+out:
+	return ret;
 }

 static int ulite_remove(struct platform_device *pdev)
Binary files uartlite/drivers/serial/.uartlite.c.swp and
uartlite-mod/drivers/serial/.uartlite.c.swp differ
diff -urN uartlite/include/linux/serial_uartlite.h
uartlite-mod/include/linux/serial_uartlite.h
--- uartlite/include/linux/serial_uartlite.h	1969-12-31 16:00:00.000000000 -0800
+++ uartlite-mod/include/linux/serial_uartlite.h	2006-10-15
14:22:07.000000000 -0700
@@ -0,0 +1,28 @@
+#ifndef __SERIAL_UARTLITE_H__
+#define __SERIAL_UARTLITE_H__
+
+/* For register details see datasheet:
+   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
+*/
+#define ULITE_RX		0x00
+#define ULITE_TX		0x04
+#define ULITE_STATUS		0x08
+#define ULITE_CONTROL		0x0c
+
+#define ULITE_REGION		16
+
+#define ULITE_STATUS_RXVALID	0x01
+#define ULITE_STATUS_RXFULL	0x02
+#define ULITE_STATUS_TXEMPTY	0x04
+#define ULITE_STATUS_TXFULL	0x08
+#define ULITE_STATUS_IE		0x10
+#define ULITE_STATUS_OVERRUN	0x20
+#define ULITE_STATUS_FRAME	0x40
+#define ULITE_STATUS_PARITY	0x80
+
+#define ULITE_CONTROL_RST_TX	0x01
+#define ULITE_CONTROL_RST_RX	0x02
+#define ULITE_CONTROL_IE	0x10
+
+#endif /* __SERIAL_UARTLITE_H__ */
+
--
Cheers,
David
