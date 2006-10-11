Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2D3EB67B54
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 Oct 2006 08:10:44 +1000 (EST)
Message-ID: <452D6AFA.2010107@dlasys.net>
Date: Wed, 11 Oct 2006 18:06:50 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
In-Reply-To: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------020800000002050708060202"
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

This is a multi-part message in MIME format.
--------------020800000002050708060202
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


    also:

         your driver is strictly interrupt driven.
          I need polled for the Pico E12 - which my driver an early 
version was posted in January, supports.
          Somebody else needs DCR support.


David Bolcsfoldi wrote:
> Hi,
>
> here's a set of patches that adds support for Xilinx UART lite
> devices. It has been tested on an ML403-FX using xapp902
> (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox userspace.
>
> This is my first patch for the Linux kernel, so please be gentle :-)
>
> David
> ------------------------------------------------------------------------
>
> diff -urN 2.6.18/arch/ppc/boot/simple/Makefile patched/arch/ppc/boot/simple/Makefile
> --- 2.6.18/arch/ppc/boot/simple/Makefile	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/boot/simple/Makefile	2006-10-07 10:34:32.000000000 -0700
> @@ -205,6 +205,7 @@
>  endif
>  boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
>  boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
> +boot-$(CONFIG_SERIAL_XUL_CONSOLE)	+= xuartlite_tty.o
>  
>  LIBS				:= $(common)/lib.a $(bootlib)/lib.a
>  ifeq ($(CONFIG_PPC_PREP),y)
> diff -urN 2.6.18/arch/ppc/boot/simple/misc.c patched/arch/ppc/boot/simple/misc.c
> --- 2.6.18/arch/ppc/boot/simple/misc.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/boot/simple/misc.c	2006-10-07 10:27:34.000000000 -0700
> @@ -48,7 +48,8 @@
>  #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_VGA_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)) \
>  	&& !defined(CONFIG_GEMINI)
>  #define INTERACTIVE_CONSOLE	1
>  #endif
> diff -urN 2.6.18/arch/ppc/boot/simple/xuartlite_tty.c patched/arch/ppc/boot/simple/xuartlite_tty.c
> --- 2.6.18/arch/ppc/boot/simple/xuartlite_tty.c	1969-12-31 16:00:00.000000000 -0800
> +++ patched/arch/ppc/boot/simple/xuartlite_tty.c	2006-10-07 10:29:30.000000000 -0700
> @@ -0,0 +1,74 @@
> +/*
> + * Xilinx UART Lite support. 
> + * Right now it only works over UART0 and none other.
> + *
> + * Copyright (C) 2006 David Bolcsfoldi <dbolcsfoldi@gmail.com>
> + * 
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <asm/io.h>
> +#include <platforms/4xx/xparameters/xparameters.h>
> +
> +#define XUL_STATUS_REG_OFFSET           8   /* status register, read only */
> +#define XUL_SR_TX_FIFO_FULL             0x08    /* transmit FIFO full */
> +#define XUL_SR_RX_FIFO_VALID_DATA       0x01    /* data in receive FIFO */
> +#define XUL_RX_FIFO_OFFSET              0   /* receive FIFO, read only */
> +#define XUL_TX_FIFO_OFFSET              4   /* transmit FIFO, write only */
> +
> +static inline int is_xmit_full(unsigned int address)
> +{
> +	return ((in_be32((volatile unsigned *) (address + XUL_STATUS_REG_OFFSET)) & XUL_SR_TX_FIFO_FULL) == XUL_SR_TX_FIFO_FULL);
> +}
> +
> +static inline int is_recv_empty(unsigned int address)
> +{
> +	return ((in_be32((volatile unsigned *) (address + XUL_STATUS_REG_OFFSET)) & XUL_SR_RX_FIFO_VALID_DATA) != XUL_SR_RX_FIFO_VALID_DATA);
> +}
> +
> +unsigned long serial_init(int chan, void *ignored)
> +{
> +	switch (chan)  {
> +	#ifdef XPAR_XUL_UART_0_BASEADDR
> +		case 0:
> +			return XPAR_XUL_UART_0_BASEADDR;
> +	#endif
> +	#ifdef XPAR_XUL_UART_1_BASEADDR
> +		case 1:		
> +			return XPAR_XUL_UART_1_BASEADDR;
> +	#endif
> +	#ifdef XPAR_XUL_UART_2_BASEADDR
> +		case 2:
> +			return XPAR_XUL_UART_2_BASEADDR;
> +	#endif
> +	#ifdef XPAR_XUL_UART_3_BASEADDR
> +		case 3:
> +			return XPAR_XUL_UART_3_BASEADDR;
> +	#endif
> +		default:
> +			goto out;
> +	}
> +	
> +out:
> +	return -1;
> +}
> +
> +void serial_putc(unsigned long com_port, unsigned char c)
> +{
> +	while(is_xmit_full(XPAR_XUL_UART_0_BASEADDR));
> +	out_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + XUL_TX_FIFO_OFFSET), c);
> +}
> +
> +unsigned char serial_getc(unsigned long com_port)
> +{
> +	while(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
> +	return in_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + XUL_RX_FIFO_OFFSET));
> +}
> +
> +int serial_tstc(unsigned long com_port)
> +{
> +	return !(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
> +}
> +
>   
> ------------------------------------------------------------------------
>
> diff -urN 2.6.18/arch/ppc/boot/common/misc-common.c patched/arch/ppc/boot/common/misc-common.c
> --- 2.6.18/arch/ppc/boot/common/misc-common.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/boot/common/misc-common.c	2006-10-07 10:33:28.000000000 -0700
> @@ -57,7 +57,8 @@
>  
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
>  extern unsigned long com_port;
>  
>  extern int serial_tstc(unsigned long com_port);
> @@ -80,7 +81,8 @@
>  {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
>  	if(keyb_present)
>  		return (CRT_tstc() || serial_tstc(com_port));
>  	else
> @@ -95,7 +97,8 @@
>  	while (1) {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
>  		if (serial_tstc(com_port))
>  			return (serial_getc(com_port));
>  #endif /* serial console */
> @@ -112,7 +115,8 @@
>  
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
>  	serial_putc(com_port, c);
>  	if ( c == '\n' )
>  		serial_putc(com_port, '\r');
> @@ -161,7 +165,8 @@
>  	while ( ( c = *s++ ) != '\0' ) {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
>  	        serial_putc(com_port, c);
>  	        if ( c == '\n' ) serial_putc(com_port, '\r');
>  #endif /* serial console */
>   
> ------------------------------------------------------------------------
>
> --- 2.6.18/arch/ppc/platforms/4xx/virtex.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/platforms/4xx/virtex.c	2006-10-07 11:21:18.000000000 -0700
> @@ -52,5 +52,10 @@
>  		.id		= 0,
>  		.dev.platform_data = serial_platform_data,
>  	},
> +
> +	[VIRTEX_XUL_UART] = {
> +		.name = "xul_uart",
> +		.id	  = 0,
> +	},
>  };
>  
>   
> ------------------------------------------------------------------------
>
> --- 2.6.18/arch/ppc/platforms/4xx/virtex.h	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/platforms/4xx/virtex.h	2006-10-07 10:35:31.000000000 -0700
> @@ -27,7 +27,9 @@
>  /* Device type enumeration for platform bus definitions */
>  #ifndef __ASSEMBLY__
>  enum ppc_sys_devices {
> -	VIRTEX_UART, NUM_PPC_SYS_DEVS,
> +	VIRTEX_UART,
> +	VIRTEX_XUL_UART,
> +	NUM_PPC_SYS_DEVS,
>  };
>  #endif
>    
>   
> ------------------------------------------------------------------------
>
> diff -urN 2.6.18/drivers/serial/Kconfig patched/drivers/serial/Kconfig
> --- 2.6.18/drivers/serial/Kconfig	2006-10-04 14:31:18.000000000 -0700
> +++ patched/drivers/serial/Kconfig	2006-10-07 10:50:20.000000000 -0700
> @@ -959,4 +959,22 @@
>  	  If you have enabled the serial port on the Motorola IMX
>  	  CPU you can make it the console by answering Y to this option.
>  
> +config SERIAL_XUL
> +	tristate "Xilinx UART Lite serial support"
> +	depends on XILINX_ML403
> +	select SERIAL_CORE
> +	help
> +	  This driver supports the Xilinx UART Lite serial ports. If you would
> +	  like to use them, you must answer Y or M to this option. Note that
> +	  for use as console, it must be included in the kernel and not as a 
> +	  module.
> +
> +config SERIAL_XUL_CONSOLE
> +	bool "Console on a Xilinx UART Lite serial port"
> +	depends on SERIAL_XUL
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  Select this option if you'd like to use the UART Lite serial port
> +	  of the Xilinx ML403 board as a console.
> +
>  endmenu
> diff -urN 2.6.18/drivers/serial/Makefile patched/drivers/serial/Makefile
> --- 2.6.18/drivers/serial/Makefile	2006-10-04 14:31:18.000000000 -0700
> +++ patched/drivers/serial/Makefile	2006-10-07 10:51:02.000000000 -0700
> @@ -56,3 +56,4 @@
>  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
>  obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> +obj-$(CONFIG_SERIAL_XUL) += xuartlite.o
> diff -urN 2.6.18/drivers/serial/xuartlite.c patched/drivers/serial/xuartlite.c
> --- 2.6.18/drivers/serial/xuartlite.c	1969-12-31 16:00:00.000000000 -0800
> +++ patched/drivers/serial/xuartlite.c	2006-10-10 11:08:08.000000000 -0700
> @@ -0,0 +1,723 @@
> +/*
> + * drivers/serial/xuartlite.c
> + *
> + * Driver for Xilinx UART Lite device.
> + *
> + * This driver has only been tested with the Xilinx ML403-FX board using the plb_temac
> + * reference design with on UART port.
> + * 
> + * This driver is loosely based off the mpc52xx_uart driver.
> + * 
> + * Copyright (C) 2006 David Bolcsfoldi <dbolcsfoldi@gmail.com>
> + * 
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/config.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/sysrq.h>
> +#include <linux/console.h>
> +
> +#include <asm/delay.h>
> +#include <asm/io.h>
> +#include <platforms/4xx/xparameters/xparameters.h>
> +
> +#if defined(CONFIG_SERIAL_XUL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/serial_core.h>
> +
> +#define SERIAL_XUL_MAJOR	204
> +#define SERIAL_XUL_MINOR	187
> +
> +/*
> + * Keeps various tidbits about the serial port taken
> + * from xparameters.h
> + * */
> +
> +struct xul_uart_data {
> +	int baud;
> +	int parity;
> +	int bits;
> +	int flow;
> +	int uartclk;
> +	int irq;
> +	int mapbase;
> +	int size;
> +};
> +
> +static struct xul_uart_data xul_data[XPAR_XUARTLITE_NUM_INSTANCES] = {
> +	{ 
> +		.baud = XPAR_XUL_UART_0_BAUDRATE,
> +#if (XPAR_XUL_UART_0_USE_PARITY != 0)
> +		.parity = 'y',
> +#else
> +		.parity = 'n',
> +#endif /* XPAR_XUL_UART_0_USE_PARITY */
> +		.bits = XPAR_XUL_UART_0_DATA_BITS,		
> +		.flow = 'n',
> +		.uartclk = 100000000 / 16, /* PLB speed / 16 */
> +		.irq = XPAR_INTC_0_XUL_UART_0_VEC_ID,
> +		.mapbase = XPAR_XUL_UART_0_BASEADDR,
> +		.size = (XPAR_XUL_UART_0_HIGHADDR - XPAR_XUL_UART_0_BASEADDR) + 1
> +	}
> +
> +	/* Add next uart here */
> +};
> +
> +static const long ISR_PASS_LIMIT = 255;
> +static struct uart_port xul_uart_ports[XPAR_XUARTLITE_NUM_INSTANCES];
> +
> +#define XUL(port) ((unsigned int)((port)->membase))
> +
> +#define XUL_RX_FIFO_OFFSET              0   /* receive FIFO, read only */
> +#define XUL_TX_FIFO_OFFSET              4   /* transmit FIFO, write only */
> +#define XUL_STATUS_REG_OFFSET           8   /* status register, read only */
> +#define XUL_CONTROL_REG_OFFSET          12  /* control register, write only */
> +
> +#define XUL_CR_ENABLE_INTR              0x10    /* enable interrupt */
> +#define XUL_CR_FIFO_RX_RESET            0x02    /* reset receive FIFO */
> +#define XUL_CR_FIFO_TX_RESET            0x01    /* reset transmit FIFO */
> +
> +#define XUL_SR_PARITY_ERROR             0x80
> +#define XUL_SR_FRAMING_ERROR            0x40
> +#define XUL_SR_OVERRUN_ERROR            0x20
> +#define XUL_SR_TX_FIFO_FULL             0x08    /* transmit FIFO full */
> +#define XUL_SR_TX_FIFO_EMPTY            0x04    /* transmit FIFO empty */
> +#define XUL_SR_RX_FIFO_VALID_DATA       0x01    /* data in receive FIFO */
> +
> +/* Forward declaration of the interruption handling routine */
> +static irqreturn_t xul_uart_int(int irq,void *dev_id,struct pt_regs *regs);
> +
> +/* Simple macro to test if a port is console or not. This one is taken
> + * for serial_core.c and maybe should be moved to serial_core.h ? */
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +#define uart_console(port)	((port)->cons && (port)->cons->index == (port)->line)
> +#else
> +#define uart_console(port)	(0)
> +#endif
> +
> +/* ======================================================================== */
> +/* UART operations                                                          */
> +/* ======================================================================== */
> +
> +static int
> +xul_uart_int_tx_chars(struct uart_port *port);
> +
> +static inline int is_xmit_empty(struct uart_port *port)
> +{
> +	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) & XUL_SR_TX_FIFO_EMPTY) == XUL_SR_TX_FIFO_EMPTY);
> +}
> +
> +static inline int is_recv_empty(struct uart_port *port)
> +{
> +	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) & XUL_SR_RX_FIFO_VALID_DATA) != XUL_SR_RX_FIFO_VALID_DATA);
> +}
> +
> +static inline int is_xmit_full(struct uart_port *port)
> +{
> +	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) & XUL_SR_TX_FIFO_FULL) == XUL_SR_TX_FIFO_FULL);
> +}
> +
> +static inline void xmit_char(struct uart_port *port, char c)
> +{
> +	while(is_xmit_full(port));
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_TX_FIFO_OFFSET), c); 
> +}
> +
> +static inline char recv_char(struct uart_port *port)
> +{
> +	while(is_recv_empty(port));
> +	return in_be32((volatile unsigned *) (XUL(port) + XUL_RX_FIFO_OFFSET));
> +}
> +
> +static unsigned int 
> +xul_uart_tx_empty(struct uart_port *port)
> +{
> +	return ((is_xmit_empty(port)) ? TIOCSER_TEMT : 0);
> +}
> +
> +static void 
> +xul_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/* Not implemented */
> +}
> +
> +static unsigned int 
> +xul_uart_get_mctrl(struct uart_port *port)
> +{
> +	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void 
> +xul_uart_stop_tx(struct uart_port *port)
> +{
> +	/* port->lock taken by caller */
> +}
> +
> +static void 
> +xul_uart_start_tx(struct uart_port *port)
> +{
> +	/* port->lock taken by caller */
> +	xul_uart_int_tx_chars(port);
> +}
> +
> +static void 
> +xul_uart_send_xchar(struct uart_port *port, char ch)
> +{
> +	unsigned long flags;
> +	
> +	spin_lock_irqsave(&port->lock, flags);
> +	
> +	port->x_char = ch;
> +	
> +	if (ch) {
> +		xmit_char(port, ch);
> +	}
> +	
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void
> +xul_uart_stop_rx(struct uart_port *port)
> +{
> +	/* port->lock taken by caller */
> +}
> +
> +static void
> +xul_uart_enable_ms(struct uart_port *port)
> +{
> +	/* Not implemented */
> +}
> +
> +static void
> +xul_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +	/* Not implemented */
> +}
> +
> +static int
> +xul_uart_startup(struct uart_port *port)
> +{
> +	int ret;
> +	
> +	/* Request IRQ */
> +	ret = request_irq(port->irq, xul_uart_int,
> +		SA_INTERRUPT | SA_SAMPLE_RANDOM, "xul_uart", port);
> +	if (ret)
> +		return ret;
> +
> +	/* Reset/activate the port, clear and enable interrupts */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_TX_RESET); /* Reset TX */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_RX_RESET); /* Reset RX */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_ENABLE_INTR); /* Enable interrupt */
> +		
> +	return 0;
> +}
> +
> +static void
> +xul_uart_shutdown(struct uart_port *port)
> +{
> +	/* Shut down the port, interrupt and all */
> +
> +	/* Disable interrupt bu clearing control register */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0);
> +
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_TX_RESET); /* Reset TX */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_RX_RESET); /* Reset RX */
> +
> +	/* Release interrupt */
> +	free_irq(port->irq, port);
> +}
> +
> +static void 
> +xul_uart_set_termios(struct uart_port *port, struct termios *new,
> +                         struct termios *old)
> +{
> +	/* Nothing can be set, fixed at IP block generation */
> +}
> +
> +static const char *
> +xul_uart_type(struct uart_port *port)
> +{
> +	return port->type == PORT_XUL ? "ttyXUL" : NULL;
> +}
> +
> +static void
> +xul_uart_release_port(struct uart_port *port)
> +{
> +	if (port->flags & UPF_IOREMAP) {
> +		iounmap(port->membase);
> +		port->membase = NULL;
> +	}
> +	
> +	release_mem_region(port->mapbase, xul_data[port->line].size);
> +}
> +
> +static int
> +xul_uart_request_port(struct uart_port *port)
> +{
> +	int mem_region;
> +	
> +	if (port->flags & UPF_IOREMAP) {
> +		port->membase = ioremap(port->mapbase, xul_data[port->line].size);
> +	}
> +
> +	if (!port->membase) {
> +		return -EINVAL;
> +	}
> +	
> +	mem_region = request_mem_region(port->mapbase, xul_data[port->line].size, "xul_uart") != NULL ? 0 : -EBUSY;
> +	return 0;
> +}
> +
> +static void
> +xul_uart_config_port(struct uart_port *port, int flags)
> +{
> +	if ( (flags & UART_CONFIG_TYPE) &&
> +	     (xul_uart_request_port(port) == 0) )
> +	     	port->type = PORT_XUL;
> +}
> +
> +static int
> +xul_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +	if ( ser->type != PORT_UNKNOWN && ser->type != PORT_XUL ) {
> +		printk(KERN_WARNING "xul_uart_verify_port(1)\n");
> +		return -EINVAL;
> +	}
> +
> +	if ( (ser->irq != port->irq) ||
> +	     (ser->io_type != SERIAL_IO_MEM) ||
> +	     (ser->baud_base != port->uartclk)  || 
> +	     (ser->iomem_base != (void*)port->mapbase) ||
> +	     (ser->hub6 != 0 ) ) {
> +		printk(KERN_WARNING "xul_uart_verify_port(1)\n");
> +	}
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +
> +static struct uart_ops xul_uart_ops = {
> +	.tx_empty	= xul_uart_tx_empty,
> +	.set_mctrl	= xul_uart_set_mctrl,
> +	.get_mctrl	= xul_uart_get_mctrl,
> +	.stop_tx	= xul_uart_stop_tx,
> +	.start_tx	= xul_uart_start_tx,
> +	.send_xchar	= xul_uart_send_xchar,
> +	.stop_rx	= xul_uart_stop_rx,
> +	.enable_ms	= xul_uart_enable_ms,
> +	.break_ctl	= xul_uart_break_ctl,
> +	.startup	= xul_uart_startup,
> +	.shutdown	= xul_uart_shutdown,
> +	.set_termios	= xul_uart_set_termios,
> +/*	.pm		= xul_uart_pm,		Not supported yet */
> +/*	.set_wake	= xul_uart_set_wake,	Not supported yet */
> +	.type		= xul_uart_type,
> +	.release_port	= xul_uart_release_port,
> +	.request_port	= xul_uart_request_port,
> +	.config_port	= xul_uart_config_port,
> +	.verify_port	= xul_uart_verify_port
> +};
> +
> +	
> +/* ======================================================================== */
> +/* Interrupt handling                                                       */
> +/* ======================================================================== */
> +	
> +static int
> +xul_uart_int_rx_chars(struct uart_port *port, struct pt_regs *regs)
> +{
> +	struct tty_struct *tty = port->info->tty;
> +	unsigned char ch, flag;
> +	unsigned long status;
> +	
> +	status = in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET));
> +	
> +	/* While we can read, do so ! */
> +	if ((status & XUL_SR_RX_FIFO_VALID_DATA) == XUL_SR_RX_FIFO_VALID_DATA) {
> +
> +		/* Get the char */
> +		ch = recv_char(port);
> +		
> +		/* Handle sysreq char */
> +#ifdef SUPPORT_SYSRQ
> +		if (uart_handle_sysrq_char(port, ch, regs)) {
> +			port->sysrq = 0;
> +			continue;
> +		}
> +#endif
> +		/* Store it */
> +
> +		flag = TTY_NORMAL;
> +		port->icount.rx++;
> +	
> +		if (status & XUL_SR_PARITY_ERROR)
> +			flag = TTY_PARITY;
> +		else if (status & XUL_SR_FRAMING_ERROR)
> +			flag = TTY_FRAME;
> +	
> +		tty_insert_flip_char(tty, ch, flag);
> +
> +		if (status & XUL_SR_OVERRUN_ERROR) {
> +			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +		}
> +	}
> +
> +	spin_unlock(&port->lock);
> +	tty_flip_buffer_push(tty);
> +	spin_lock(&port->lock);
> +		
> +	return 0;
> +}
> +
> +static int
> +xul_uart_int_tx_chars(struct uart_port *port)
> +{
> +	struct circ_buf *xmit = &port->info->xmit;
> +	
> +	/* Process out of band chars */
> +	if (port->x_char) {
> +		xmit_char(port, port->x_char);
> +		port->icount.tx++;
> +		port->x_char = 0;
> +		return 1;
> +	}
> +
> +	/* Nothing to do ? */
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +		xul_uart_stop_tx(port);
> +		return 0;
> +	}
> +
> +	/* Send chars */
> +	while (is_xmit_full(port) == 0)  {
> +		xmit_char(port, xmit->buf[xmit->tail]);
> +		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +		port->icount.tx++;
> +
> +		if (uart_circ_empty(xmit))
> +			break;
> +	}
> +
> +	/* Wake up */
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
> +		uart_write_wakeup(port);
> +	}
> +
> +	/* Maybe we're done after all */
> +	if (uart_circ_empty(xmit)) {
> +		xul_uart_stop_tx(port);
> +		return 0;
> +	}
> +
> +	return 1;
> +}
> +
> +static irqreturn_t 
> +xul_uart_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = (struct uart_port *) dev_id;
> +	unsigned long pass = ISR_PASS_LIMIT;
> +	unsigned int keepgoing;
> +
> +	if ( irq != port->irq ) {
> +		printk( KERN_WARNING
> +		        "xul_uart_int : " \
> +		        "Received wrong int %d. Waiting for %d\n",
> +		       irq, port->irq);
> +		return IRQ_NONE;
> +	}
> +	
> +	spin_lock(&port->lock);
> +	
> +	/* While we have stuff to do, we continue */
> +	do {
> +		/* If we don't find anything to do, we stop */
> +		keepgoing = 0; 
> +		
> +		/* Do we need to receive chars ? */
> +		if (is_recv_empty(port) == 0) {
> +			keepgoing |= xul_uart_int_rx_chars(port, regs);
> +		}
> +
> +		/* Do we need to send chars ? */
> +		if (is_xmit_empty(port)) {
> +			keepgoing |= xul_uart_int_tx_chars(port);
> +		}
> +		
> +		/* Limit number of iteration */
> +		if ( !(--pass) )
> +			keepgoing = 0;
> +
> +	} while (keepgoing);
> +	
> +	spin_unlock(&port->lock);
> +	
> +	return IRQ_HANDLED;
> +}
> +
> +
> +/*
> + * Utility routines
> + */
> +
> +static void __init xul_uart_init_ports(void)
> +{
> +	int i;
> +	static int once = 1;
> +
> +	/* Initialize ports only once */
> +	if (!once)
> +		return;
> +	once = 0;
> +	
> +	for (i = 0; i < XPAR_XUARTLITE_NUM_INSTANCES; ++i) {
> +		struct uart_port *xup = &xul_uart_ports[i];
> +		
> +		xup->line = i;
> +		spin_lock_init(&xup->lock);
> +		xup->uartclk	= xul_data[i].uartclk / 16;
> +		xup->fifosize	= 16;
> +		xup->iotype	= UPIO_MEM;
> +		xup->flags	= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
> +		xup->ops	= &xul_uart_ops;
> +		xup->irq	= xul_data[i].irq;
> +		xup->mapbase = xul_data[i].mapbase;
> +	}
> +}
> +
> +static void __init xul_uart_register_ports(struct uart_driver *driver)
> +{
> +	int i, ret;
> +	
> +	for(i = 0; i < XPAR_XUARTLITE_NUM_INSTANCES; ++i) {
> +		struct uart_port *port = &xul_uart_ports[i];
> +		/* Add the port to the uart sub-system */
> +		ret = uart_add_one_port(driver, port);
> +	}
> +}
> +
> +/* ======================================================================== */
> +/* Console ( if applicable )                                                */
> +/* ======================================================================== */
> +
> +#ifdef CONFIG_SERIAL_XUL_CONSOLE
> +
> +static void  
> +xul_console_write(struct console *co, const char *s, unsigned int count)
> +{
> +	struct uart_port *port = &xul_uart_ports[co->index];
> +	unsigned int i, j;
> +
> +	/* Disable interrupts */
> +	
> +	spin_lock(&port->lock);
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0);
> +	spin_unlock(&port->lock);
> +	
> +	/* Wait the TX buffer to be empty */
> +	j = 5000000;	/* Maximum wait */	
> +	while (!(is_xmit_empty(port)) &&
> +	       --j)
> +		udelay(1);
> +
> +	for (i = 0; i < count; i++, s++) {
> +		if (*s == '\n')
> +			xmit_char(port, '\r');
> +
> +		xmit_char(port, *s);
> +	}
> +
> +	/* Restore interrupt state */
> +	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0); 
> +}
> +
> +static int __init
> +xul_console_setup(struct console *co, char *options)
> +{
> +	struct uart_port *port;
> +	int baud;
> +	int bits;
> +	int parity;
> +	int flow;
> +
> +	if (co->index < 0 || co->index >= XPAR_XUARTLITE_NUM_INSTANCES)
> +		return -EINVAL;
> +
> +	port = &xul_uart_ports[co->index];
> +
> +	/* We ioremap ourself */
> +	port->membase = ioremap(port->mapbase, xul_data[co->index].size);
> +
> +	if (port->membase == NULL) {	
> +		return -EINVAL;
> +	}
> +
> +	port->flags &= ~UPF_IOREMAP;
> +
> +	baud = xul_data[co->index].baud;
> +	parity = xul_data[co->index].parity;
> +	bits = xul_data[co->index].bits;
> +	flow = xul_data[co->index].flow;
> +
> +	return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct uart_driver xul_uart_driver;
> +
> +static struct console xul_console = {
> +	.name	= "ttyXUL",
> +	.write	= xul_console_write,
> +	.device	= uart_console_device,
> +	.setup	= xul_console_setup,
> +	.flags	= CON_PRINTBUFFER,
> +	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyXUL0 ) */
> +	.data	= &xul_uart_driver,
> +};
> +
> +	
> +static int __init 
> +xul_console_init(void)
> +{
> +	xul_uart_init_ports();
> +	register_console(&xul_console);
> +	return 0;
> +}
> +
> +console_initcall(xul_console_init);
> +
> +#define XUL_CONSOLE &xul_console
> +#else
> +#define XUL_CONSOLE NULL
> +#endif
> +
> +
> +/* ======================================================================== */
> +/* UART Driver                                                              */
> +/* ======================================================================== */
> +
> +static struct uart_driver xul_uart_driver = {
> +	.owner			= THIS_MODULE,
> +	.driver_name	= "xul_uart",
> +	.dev_name		= "ttyXUL",
> +	.major			= SERIAL_XUL_MAJOR,
> +	.minor			= SERIAL_XUL_MINOR,
> +	.nr				= XPAR_XUARTLITE_NUM_INSTANCES,
> +	.cons			= XUL_CONSOLE,
> +};
> +
> +
> +/* ======================================================================== */
> +/* Platform Driver                                                          */
> +/* ======================================================================== */
> +
> +static int __devinit
> +xul_uart_probe(struct platform_device *dev)
> +{
> +	/* Probe does nothing */
> +	return 0;
> +}
> +
> +static int
> +xul_uart_remove(struct platform_device *dev)
> +{
> +	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
> +
> +	platform_set_drvdata(dev, NULL);
> +
> +	if (port)
> +		uart_remove_one_port(&xul_uart_driver, port);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int
> +xul_uart_suspend(struct platform_device *dev, pm_message_t state)
> +{
> +	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
> +
> +	if (port)
> +		uart_suspend_port(&xul_uart_driver, port);
> +
> +	return 0;
> +}
> +
> +static int
> +xul_uart_resume(struct platform_device *dev)
> +{
> +	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
> +
> +	if (port)
> +		uart_resume_port(&xul_uart_driver, port);
> +
> +	return 0;
> +}
> +#endif
> +
> +static struct platform_driver xul_uart_platform_driver = {
> +	.probe		= xul_uart_probe,
> +	.remove		= xul_uart_remove,
> +#ifdef CONFIG_PM
> +	.suspend	= xul_uart_suspend,
> +	.resume		= xul_uart_resume,
> +#endif
> +	.driver		= {
> +		.name	= "xul_uart"
> +	},
> +};
> +
> +
> +/* ======================================================================== */
> +/* Module                                                                   */
> +/* ======================================================================== */
> +
> +static int __init
> +xul_uart_init(void)
> +{
> +	int ret;
> +
> +	printk(KERN_INFO "Serial: Xilinx UART Lite driver\n");	
> +	
> +	xul_uart_init_ports();
> +
> +	ret = uart_register_driver(&xul_uart_driver);
> +
> +	if (ret == 0) {
> +		xul_uart_register_ports(&xul_uart_driver);
> +		
> +		ret = platform_driver_register(&xul_uart_platform_driver);
> +
> +		if (ret) {
> +			printk(KERN_WARNING "platform_driver_register failed! :%i\n", ret);
> +			uart_unregister_driver(&xul_uart_driver);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void __exit
> +xul_uart_exit(void)
> +{
> +	platform_driver_unregister(&xul_uart_platform_driver);
> +	uart_unregister_driver(&xul_uart_driver);
> +}
> +
> +
> +module_init(xul_uart_init);
> +module_exit(xul_uart_exit);
> +
> +MODULE_AUTHOR("David Bolcsfoldi <dbolcsfoldi@gmail.com>");
> +MODULE_DESCRIPTION("Xilinx UART Lite");
> +MODULE_LICENSE("GPL");
> +
>   
> ------------------------------------------------------------------------
>
> --- 2.6.18/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-07 10:41:50.000000000 -0700
> @@ -69,6 +69,7 @@
>  		.device_list	= (enum ppc_sys_devices[])
>  		{
>  			VIRTEX_UART,
> +			VIRTEX_XUL_UART,
>  		},
>  	},
>  };
>   
> ------------------------------------------------------------------------
>
> --- 2.6.18/include/linux/serial_core.h	2006-10-04 14:31:19.000000000 -0700
> +++ patched/include/linux/serial_core.h	2006-10-07 10:52:24.000000000 -0700
> @@ -132,6 +132,8 @@
>  
>  #define PORT_S3C2412	73
>  
> +/* Xilinx UART Lite */
> +#define PORT_XUL 74
>  
>  #ifdef __KERNEL__
>  
>   
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------020800000002050708060202
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<br>
&nbsp;&nbsp;&nbsp; also:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; your driver is strictly interrupt driven.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; I need polled for the Pico E12 - which my driver an early
version was posted in January, supports.<br>
&nbsp;&nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; Somebody else needs DCR support.<br>
<br>
<br>
David Bolcsfoldi wrote:
<blockquote
 cite="mid609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com"
 type="cite">Hi,
  <br>
  <br>
here's a set of patches that adds support for Xilinx UART lite
  <br>
devices. It has been tested on an ML403-FX using xapp902
  <br>
(ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox userspace.
  <br>
  <br>
This is my first patch for the Linux kernel, so please be gentle :-)
  <br>
  <br>
David
  <br>
  <pre wrap="">
<hr size="4" width="90%">
diff -urN 2.6.18/arch/ppc/boot/simple/Makefile patched/arch/ppc/boot/simple/Makefile
--- 2.6.18/arch/ppc/boot/simple/Makefile	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/boot/simple/Makefile	2006-10-07 10:34:32.000000000 -0700
@@ -205,6 +205,7 @@
 endif
 boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
 boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
+boot-$(CONFIG_SERIAL_XUL_CONSOLE)	+= xuartlite_tty.o
 
 LIBS				:= $(common)/lib.a $(bootlib)/lib.a
 ifeq ($(CONFIG_PPC_PREP),y)
diff -urN 2.6.18/arch/ppc/boot/simple/misc.c patched/arch/ppc/boot/simple/misc.c
--- 2.6.18/arch/ppc/boot/simple/misc.c	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/boot/simple/misc.c	2006-10-07 10:27:34.000000000 -0700
@@ -48,7 +48,8 @@
 #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_VGA_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)) \
 	&amp;&amp; !defined(CONFIG_GEMINI)
 #define INTERACTIVE_CONSOLE	1
 #endif
diff -urN 2.6.18/arch/ppc/boot/simple/xuartlite_tty.c patched/arch/ppc/boot/simple/xuartlite_tty.c
--- 2.6.18/arch/ppc/boot/simple/xuartlite_tty.c	1969-12-31 16:00:00.000000000 -0800
+++ patched/arch/ppc/boot/simple/xuartlite_tty.c	2006-10-07 10:29:30.000000000 -0700
@@ -0,0 +1,74 @@
+/*
+ * Xilinx UART Lite support. 
+ * Right now it only works over UART0 and none other.
+ *
+ * Copyright (C) 2006 David Bolcsfoldi <a class="moz-txt-link-rfc2396E" href="mailto:dbolcsfoldi@gmail.com">&lt;dbolcsfoldi@gmail.com&gt;</a>
+ * 
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include &lt;asm/io.h&gt;
+#include &lt;platforms/4xx/xparameters/xparameters.h&gt;
+
+#define XUL_STATUS_REG_OFFSET           8   /* status register, read only */
+#define XUL_SR_TX_FIFO_FULL             0x08    /* transmit FIFO full */
+#define XUL_SR_RX_FIFO_VALID_DATA       0x01    /* data in receive FIFO */
+#define XUL_RX_FIFO_OFFSET              0   /* receive FIFO, read only */
+#define XUL_TX_FIFO_OFFSET              4   /* transmit FIFO, write only */
+
+static inline int is_xmit_full(unsigned int address)
+{
+	return ((in_be32((volatile unsigned *) (address + XUL_STATUS_REG_OFFSET)) &amp; XUL_SR_TX_FIFO_FULL) == XUL_SR_TX_FIFO_FULL);
+}
+
+static inline int is_recv_empty(unsigned int address)
+{
+	return ((in_be32((volatile unsigned *) (address + XUL_STATUS_REG_OFFSET)) &amp; XUL_SR_RX_FIFO_VALID_DATA) != XUL_SR_RX_FIFO_VALID_DATA);
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
+	out_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + XUL_TX_FIFO_OFFSET), c);
+}
+
+unsigned char serial_getc(unsigned long com_port)
+{
+	while(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
+	return in_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + XUL_RX_FIFO_OFFSET));
+}
+
+int serial_tstc(unsigned long com_port)
+{
+	return !(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
+}
+
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
diff -urN 2.6.18/arch/ppc/boot/common/misc-common.c patched/arch/ppc/boot/common/misc-common.c
--- 2.6.18/arch/ppc/boot/common/misc-common.c	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/boot/common/misc-common.c	2006-10-07 10:33:28.000000000 -0700
@@ -57,7 +57,8 @@
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
 extern unsigned long com_port;
 
 extern int serial_tstc(unsigned long com_port);
@@ -80,7 +81,8 @@
 {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
 	if(keyb_present)
 		return (CRT_tstc() || serial_tstc(com_port));
 	else
@@ -95,7 +97,8 @@
 	while (1) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
 		if (serial_tstc(com_port))
 			return (serial_getc(com_port));
 #endif /* serial console */
@@ -112,7 +115,8 @@
 
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
 	serial_putc(com_port, c);
 	if ( c == '\n' )
 		serial_putc(com_port, '\r');
@@ -161,7 +165,8 @@
 	while ( ( c = *s++ ) != '\0' ) {
 #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
 	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
-	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
+	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
+	|| defined(CONFIG_SERIAL_XUL_CONSOLE)
 	        serial_putc(com_port, c);
 	        if ( c == '\n' ) serial_putc(com_port, '\r');
 #endif /* serial console */
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
--- 2.6.18/arch/ppc/platforms/4xx/virtex.c	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/platforms/4xx/virtex.c	2006-10-07 11:21:18.000000000 -0700
@@ -52,5 +52,10 @@
 		.id		= 0,
 		.dev.platform_data = serial_platform_data,
 	},
+
+	[VIRTEX_XUL_UART] = {
+		.name = "xul_uart",
+		.id	  = 0,
+	},
 };
 
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
--- 2.6.18/arch/ppc/platforms/4xx/virtex.h	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/platforms/4xx/virtex.h	2006-10-07 10:35:31.000000000 -0700
@@ -27,7 +27,9 @@
 /* Device type enumeration for platform bus definitions */
 #ifndef __ASSEMBLY__
 enum ppc_sys_devices {
-	VIRTEX_UART, NUM_PPC_SYS_DEVS,
+	VIRTEX_UART,
+	VIRTEX_XUL_UART,
+	NUM_PPC_SYS_DEVS,
 };
 #endif
   
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
diff -urN 2.6.18/drivers/serial/Kconfig patched/drivers/serial/Kconfig
--- 2.6.18/drivers/serial/Kconfig	2006-10-04 14:31:18.000000000 -0700
+++ patched/drivers/serial/Kconfig	2006-10-07 10:50:20.000000000 -0700
@@ -959,4 +959,22 @@
 	  If you have enabled the serial port on the Motorola IMX
 	  CPU you can make it the console by answering Y to this option.
 
+config SERIAL_XUL
+	tristate "Xilinx UART Lite serial support"
+	depends on XILINX_ML403
+	select SERIAL_CORE
+	help
+	  This driver supports the Xilinx UART Lite serial ports. If you would
+	  like to use them, you must answer Y or M to this option. Note that
+	  for use as console, it must be included in the kernel and not as a 
+	  module.
+
+config SERIAL_XUL_CONSOLE
+	bool "Console on a Xilinx UART Lite serial port"
+	depends on SERIAL_XUL
+	select SERIAL_CORE_CONSOLE
+	help
+	  Select this option if you'd like to use the UART Lite serial port
+	  of the Xilinx ML403 board as a console.
+
 endmenu
diff -urN 2.6.18/drivers/serial/Makefile patched/drivers/serial/Makefile
--- 2.6.18/drivers/serial/Makefile	2006-10-04 14:31:18.000000000 -0700
+++ patched/drivers/serial/Makefile	2006-10-07 10:51:02.000000000 -0700
@@ -56,3 +56,4 @@
 obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
 obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
 obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
+obj-$(CONFIG_SERIAL_XUL) += xuartlite.o
diff -urN 2.6.18/drivers/serial/xuartlite.c patched/drivers/serial/xuartlite.c
--- 2.6.18/drivers/serial/xuartlite.c	1969-12-31 16:00:00.000000000 -0800
+++ patched/drivers/serial/xuartlite.c	2006-10-10 11:08:08.000000000 -0700
@@ -0,0 +1,723 @@
+/*
+ * drivers/serial/xuartlite.c
+ *
+ * Driver for Xilinx UART Lite device.
+ *
+ * This driver has only been tested with the Xilinx ML403-FX board using the plb_temac
+ * reference design with on UART port.
+ * 
+ * This driver is loosely based off the mpc52xx_uart driver.
+ * 
+ * Copyright (C) 2006 David Bolcsfoldi <a class="moz-txt-link-rfc2396E" href="mailto:dbolcsfoldi@gmail.com">&lt;dbolcsfoldi@gmail.com&gt;</a>
+ * 
+ * This file is licensed under the terms of the GNU General Public License
+ * version 2. This program is licensed "as is" without any warranty of any
+ * kind, whether express or implied.
+ */
+
+#include &lt;linux/config.h&gt;
+#include &lt;linux/platform_device.h&gt;
+#include &lt;linux/module.h&gt;
+#include &lt;linux/tty.h&gt;
+#include &lt;linux/serial.h&gt;
+#include &lt;linux/sysrq.h&gt;
+#include &lt;linux/console.h&gt;
+
+#include &lt;asm/delay.h&gt;
+#include &lt;asm/io.h&gt;
+#include &lt;platforms/4xx/xparameters/xparameters.h&gt;
+
+#if defined(CONFIG_SERIAL_XUL_CONSOLE) &amp;&amp; defined(CONFIG_MAGIC_SYSRQ)
+#define SUPPORT_SYSRQ
+#endif
+
+#include &lt;linux/serial_core.h&gt;
+
+#define SERIAL_XUL_MAJOR	204
+#define SERIAL_XUL_MINOR	187
+
+/*
+ * Keeps various tidbits about the serial port taken
+ * from xparameters.h
+ * */
+
+struct xul_uart_data {
+	int baud;
+	int parity;
+	int bits;
+	int flow;
+	int uartclk;
+	int irq;
+	int mapbase;
+	int size;
+};
+
+static struct xul_uart_data xul_data[XPAR_XUARTLITE_NUM_INSTANCES] = {
+	{ 
+		.baud = XPAR_XUL_UART_0_BAUDRATE,
+#if (XPAR_XUL_UART_0_USE_PARITY != 0)
+		.parity = 'y',
+#else
+		.parity = 'n',
+#endif /* XPAR_XUL_UART_0_USE_PARITY */
+		.bits = XPAR_XUL_UART_0_DATA_BITS,		
+		.flow = 'n',
+		.uartclk = 100000000 / 16, /* PLB speed / 16 */
+		.irq = XPAR_INTC_0_XUL_UART_0_VEC_ID,
+		.mapbase = XPAR_XUL_UART_0_BASEADDR,
+		.size = (XPAR_XUL_UART_0_HIGHADDR - XPAR_XUL_UART_0_BASEADDR) + 1
+	}
+
+	/* Add next uart here */
+};
+
+static const long ISR_PASS_LIMIT = 255;
+static struct uart_port xul_uart_ports[XPAR_XUARTLITE_NUM_INSTANCES];
+
+#define XUL(port) ((unsigned int)((port)-&gt;membase))
+
+#define XUL_RX_FIFO_OFFSET              0   /* receive FIFO, read only */
+#define XUL_TX_FIFO_OFFSET              4   /* transmit FIFO, write only */
+#define XUL_STATUS_REG_OFFSET           8   /* status register, read only */
+#define XUL_CONTROL_REG_OFFSET          12  /* control register, write only */
+
+#define XUL_CR_ENABLE_INTR              0x10    /* enable interrupt */
+#define XUL_CR_FIFO_RX_RESET            0x02    /* reset receive FIFO */
+#define XUL_CR_FIFO_TX_RESET            0x01    /* reset transmit FIFO */
+
+#define XUL_SR_PARITY_ERROR             0x80
+#define XUL_SR_FRAMING_ERROR            0x40
+#define XUL_SR_OVERRUN_ERROR            0x20
+#define XUL_SR_TX_FIFO_FULL             0x08    /* transmit FIFO full */
+#define XUL_SR_TX_FIFO_EMPTY            0x04    /* transmit FIFO empty */
+#define XUL_SR_RX_FIFO_VALID_DATA       0x01    /* data in receive FIFO */
+
+/* Forward declaration of the interruption handling routine */
+static irqreturn_t xul_uart_int(int irq,void *dev_id,struct pt_regs *regs);
+
+/* Simple macro to test if a port is console or not. This one is taken
+ * for serial_core.c and maybe should be moved to serial_core.h ? */
+#ifdef CONFIG_SERIAL_CORE_CONSOLE
+#define uart_console(port)	((port)-&gt;cons &amp;&amp; (port)-&gt;cons-&gt;index == (port)-&gt;line)
+#else
+#define uart_console(port)	(0)
+#endif
+
+/* ======================================================================== */
+/* UART operations                                                          */
+/* ======================================================================== */
+
+static int
+xul_uart_int_tx_chars(struct uart_port *port);
+
+static inline int is_xmit_empty(struct uart_port *port)
+{
+	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) &amp; XUL_SR_TX_FIFO_EMPTY) == XUL_SR_TX_FIFO_EMPTY);
+}
+
+static inline int is_recv_empty(struct uart_port *port)
+{
+	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) &amp; XUL_SR_RX_FIFO_VALID_DATA) != XUL_SR_RX_FIFO_VALID_DATA);
+}
+
+static inline int is_xmit_full(struct uart_port *port)
+{
+	return ((in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET)) &amp; XUL_SR_TX_FIFO_FULL) == XUL_SR_TX_FIFO_FULL);
+}
+
+static inline void xmit_char(struct uart_port *port, char c)
+{
+	while(is_xmit_full(port));
+	out_be32((volatile unsigned *) (XUL(port) + XUL_TX_FIFO_OFFSET), c); 
+}
+
+static inline char recv_char(struct uart_port *port)
+{
+	while(is_recv_empty(port));
+	return in_be32((volatile unsigned *) (XUL(port) + XUL_RX_FIFO_OFFSET));
+}
+
+static unsigned int 
+xul_uart_tx_empty(struct uart_port *port)
+{
+	return ((is_xmit_empty(port)) ? TIOCSER_TEMT : 0);
+}
+
+static void 
+xul_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* Not implemented */
+}
+
+static unsigned int 
+xul_uart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
+static void 
+xul_uart_stop_tx(struct uart_port *port)
+{
+	/* port-&gt;lock taken by caller */
+}
+
+static void 
+xul_uart_start_tx(struct uart_port *port)
+{
+	/* port-&gt;lock taken by caller */
+	xul_uart_int_tx_chars(port);
+}
+
+static void 
+xul_uart_send_xchar(struct uart_port *port, char ch)
+{
+	unsigned long flags;
+	
+	spin_lock_irqsave(&amp;port-&gt;lock, flags);
+	
+	port-&gt;x_char = ch;
+	
+	if (ch) {
+		xmit_char(port, ch);
+	}
+	
+	spin_unlock_irqrestore(&amp;port-&gt;lock, flags);
+}
+
+static void
+xul_uart_stop_rx(struct uart_port *port)
+{
+	/* port-&gt;lock taken by caller */
+}
+
+static void
+xul_uart_enable_ms(struct uart_port *port)
+{
+	/* Not implemented */
+}
+
+static void
+xul_uart_break_ctl(struct uart_port *port, int ctl)
+{
+	/* Not implemented */
+}
+
+static int
+xul_uart_startup(struct uart_port *port)
+{
+	int ret;
+	
+	/* Request IRQ */
+	ret = request_irq(port-&gt;irq, xul_uart_int,
+		SA_INTERRUPT | SA_SAMPLE_RANDOM, "xul_uart", port);
+	if (ret)
+		return ret;
+
+	/* Reset/activate the port, clear and enable interrupts */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_TX_RESET); /* Reset TX */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_RX_RESET); /* Reset RX */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_ENABLE_INTR); /* Enable interrupt */
+		
+	return 0;
+}
+
+static void
+xul_uart_shutdown(struct uart_port *port)
+{
+	/* Shut down the port, interrupt and all */
+
+	/* Disable interrupt bu clearing control register */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0);
+
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_TX_RESET); /* Reset TX */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), XUL_CR_FIFO_RX_RESET); /* Reset RX */
+
+	/* Release interrupt */
+	free_irq(port-&gt;irq, port);
+}
+
+static void 
+xul_uart_set_termios(struct uart_port *port, struct termios *new,
+                         struct termios *old)
+{
+	/* Nothing can be set, fixed at IP block generation */
+}
+
+static const char *
+xul_uart_type(struct uart_port *port)
+{
+	return port-&gt;type == PORT_XUL ? "ttyXUL" : NULL;
+}
+
+static void
+xul_uart_release_port(struct uart_port *port)
+{
+	if (port-&gt;flags &amp; UPF_IOREMAP) {
+		iounmap(port-&gt;membase);
+		port-&gt;membase = NULL;
+	}
+	
+	release_mem_region(port-&gt;mapbase, xul_data[port-&gt;line].size);
+}
+
+static int
+xul_uart_request_port(struct uart_port *port)
+{
+	int mem_region;
+	
+	if (port-&gt;flags &amp; UPF_IOREMAP) {
+		port-&gt;membase = ioremap(port-&gt;mapbase, xul_data[port-&gt;line].size);
+	}
+
+	if (!port-&gt;membase) {
+		return -EINVAL;
+	}
+	
+	mem_region = request_mem_region(port-&gt;mapbase, xul_data[port-&gt;line].size, "xul_uart") != NULL ? 0 : -EBUSY;
+	return 0;
+}
+
+static void
+xul_uart_config_port(struct uart_port *port, int flags)
+{
+	if ( (flags &amp; UART_CONFIG_TYPE) &amp;&amp;
+	     (xul_uart_request_port(port) == 0) )
+	     	port-&gt;type = PORT_XUL;
+}
+
+static int
+xul_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
+{
+	if ( ser-&gt;type != PORT_UNKNOWN &amp;&amp; ser-&gt;type != PORT_XUL ) {
+		printk(KERN_WARNING "xul_uart_verify_port(1)\n");
+		return -EINVAL;
+	}
+
+	if ( (ser-&gt;irq != port-&gt;irq) ||
+	     (ser-&gt;io_type != SERIAL_IO_MEM) ||
+	     (ser-&gt;baud_base != port-&gt;uartclk)  || 
+	     (ser-&gt;iomem_base != (void*)port-&gt;mapbase) ||
+	     (ser-&gt;hub6 != 0 ) ) {
+		printk(KERN_WARNING "xul_uart_verify_port(1)\n");
+	}
+		return -EINVAL;
+
+	return 0;
+}
+
+
+static struct uart_ops xul_uart_ops = {
+	.tx_empty	= xul_uart_tx_empty,
+	.set_mctrl	= xul_uart_set_mctrl,
+	.get_mctrl	= xul_uart_get_mctrl,
+	.stop_tx	= xul_uart_stop_tx,
+	.start_tx	= xul_uart_start_tx,
+	.send_xchar	= xul_uart_send_xchar,
+	.stop_rx	= xul_uart_stop_rx,
+	.enable_ms	= xul_uart_enable_ms,
+	.break_ctl	= xul_uart_break_ctl,
+	.startup	= xul_uart_startup,
+	.shutdown	= xul_uart_shutdown,
+	.set_termios	= xul_uart_set_termios,
+/*	.pm		= xul_uart_pm,		Not supported yet */
+/*	.set_wake	= xul_uart_set_wake,	Not supported yet */
+	.type		= xul_uart_type,
+	.release_port	= xul_uart_release_port,
+	.request_port	= xul_uart_request_port,
+	.config_port	= xul_uart_config_port,
+	.verify_port	= xul_uart_verify_port
+};
+
+	
+/* ======================================================================== */
+/* Interrupt handling                                                       */
+/* ======================================================================== */
+	
+static int
+xul_uart_int_rx_chars(struct uart_port *port, struct pt_regs *regs)
+{
+	struct tty_struct *tty = port-&gt;info-&gt;tty;
+	unsigned char ch, flag;
+	unsigned long status;
+	
+	status = in_be32((volatile unsigned *) (XUL(port) + XUL_STATUS_REG_OFFSET));
+	
+	/* While we can read, do so ! */
+	if ((status &amp; XUL_SR_RX_FIFO_VALID_DATA) == XUL_SR_RX_FIFO_VALID_DATA) {
+
+		/* Get the char */
+		ch = recv_char(port);
+		
+		/* Handle sysreq char */
+#ifdef SUPPORT_SYSRQ
+		if (uart_handle_sysrq_char(port, ch, regs)) {
+			port-&gt;sysrq = 0;
+			continue;
+		}
+#endif
+		/* Store it */
+
+		flag = TTY_NORMAL;
+		port-&gt;icount.rx++;
+	
+		if (status &amp; XUL_SR_PARITY_ERROR)
+			flag = TTY_PARITY;
+		else if (status &amp; XUL_SR_FRAMING_ERROR)
+			flag = TTY_FRAME;
+	
+		tty_insert_flip_char(tty, ch, flag);
+
+		if (status &amp; XUL_SR_OVERRUN_ERROR) {
+			tty_insert_flip_char(tty, 0, TTY_OVERRUN);
+		}
+	}
+
+	spin_unlock(&amp;port-&gt;lock);
+	tty_flip_buffer_push(tty);
+	spin_lock(&amp;port-&gt;lock);
+		
+	return 0;
+}
+
+static int
+xul_uart_int_tx_chars(struct uart_port *port)
+{
+	struct circ_buf *xmit = &amp;port-&gt;info-&gt;xmit;
+	
+	/* Process out of band chars */
+	if (port-&gt;x_char) {
+		xmit_char(port, port-&gt;x_char);
+		port-&gt;icount.tx++;
+		port-&gt;x_char = 0;
+		return 1;
+	}
+
+	/* Nothing to do ? */
+	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
+		xul_uart_stop_tx(port);
+		return 0;
+	}
+
+	/* Send chars */
+	while (is_xmit_full(port) == 0)  {
+		xmit_char(port, xmit-&gt;buf[xmit-&gt;tail]);
+		xmit-&gt;tail = (xmit-&gt;tail + 1) &amp; (UART_XMIT_SIZE - 1);
+		port-&gt;icount.tx++;
+
+		if (uart_circ_empty(xmit))
+			break;
+	}
+
+	/* Wake up */
+	if (uart_circ_chars_pending(xmit) &lt; WAKEUP_CHARS) {
+		uart_write_wakeup(port);
+	}
+
+	/* Maybe we're done after all */
+	if (uart_circ_empty(xmit)) {
+		xul_uart_stop_tx(port);
+		return 0;
+	}
+
+	return 1;
+}
+
+static irqreturn_t 
+xul_uart_int(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct uart_port *port = (struct uart_port *) dev_id;
+	unsigned long pass = ISR_PASS_LIMIT;
+	unsigned int keepgoing;
+
+	if ( irq != port-&gt;irq ) {
+		printk( KERN_WARNING
+		        "xul_uart_int : " \
+		        "Received wrong int %d. Waiting for %d\n",
+		       irq, port-&gt;irq);
+		return IRQ_NONE;
+	}
+	
+	spin_lock(&amp;port-&gt;lock);
+	
+	/* While we have stuff to do, we continue */
+	do {
+		/* If we don't find anything to do, we stop */
+		keepgoing = 0; 
+		
+		/* Do we need to receive chars ? */
+		if (is_recv_empty(port) == 0) {
+			keepgoing |= xul_uart_int_rx_chars(port, regs);
+		}
+
+		/* Do we need to send chars ? */
+		if (is_xmit_empty(port)) {
+			keepgoing |= xul_uart_int_tx_chars(port);
+		}
+		
+		/* Limit number of iteration */
+		if ( !(--pass) )
+			keepgoing = 0;
+
+	} while (keepgoing);
+	
+	spin_unlock(&amp;port-&gt;lock);
+	
+	return IRQ_HANDLED;
+}
+
+
+/*
+ * Utility routines
+ */
+
+static void __init xul_uart_init_ports(void)
+{
+	int i;
+	static int once = 1;
+
+	/* Initialize ports only once */
+	if (!once)
+		return;
+	once = 0;
+	
+	for (i = 0; i &lt; XPAR_XUARTLITE_NUM_INSTANCES; ++i) {
+		struct uart_port *xup = &amp;xul_uart_ports[i];
+		
+		xup-&gt;line = i;
+		spin_lock_init(&amp;xup-&gt;lock);
+		xup-&gt;uartclk	= xul_data[i].uartclk / 16;
+		xup-&gt;fifosize	= 16;
+		xup-&gt;iotype	= UPIO_MEM;
+		xup-&gt;flags	= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
+		xup-&gt;ops	= &amp;xul_uart_ops;
+		xup-&gt;irq	= xul_data[i].irq;
+		xup-&gt;mapbase = xul_data[i].mapbase;
+	}
+}
+
+static void __init xul_uart_register_ports(struct uart_driver *driver)
+{
+	int i, ret;
+	
+	for(i = 0; i &lt; XPAR_XUARTLITE_NUM_INSTANCES; ++i) {
+		struct uart_port *port = &amp;xul_uart_ports[i];
+		/* Add the port to the uart sub-system */
+		ret = uart_add_one_port(driver, port);
+	}
+}
+
+/* ======================================================================== */
+/* Console ( if applicable )                                                */
+/* ======================================================================== */
+
+#ifdef CONFIG_SERIAL_XUL_CONSOLE
+
+static void  
+xul_console_write(struct console *co, const char *s, unsigned int count)
+{
+	struct uart_port *port = &amp;xul_uart_ports[co-&gt;index];
+	unsigned int i, j;
+
+	/* Disable interrupts */
+	
+	spin_lock(&amp;port-&gt;lock);
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0);
+	spin_unlock(&amp;port-&gt;lock);
+	
+	/* Wait the TX buffer to be empty */
+	j = 5000000;	/* Maximum wait */	
+	while (!(is_xmit_empty(port)) &amp;&amp;
+	       --j)
+		udelay(1);
+
+	for (i = 0; i &lt; count; i++, s++) {
+		if (*s == '\n')
+			xmit_char(port, '\r');
+
+		xmit_char(port, *s);
+	}
+
+	/* Restore interrupt state */
+	out_be32((volatile unsigned *) (XUL(port) + XUL_CONTROL_REG_OFFSET), 0); 
+}
+
+static int __init
+xul_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	int baud;
+	int bits;
+	int parity;
+	int flow;
+
+	if (co-&gt;index &lt; 0 || co-&gt;index &gt;= XPAR_XUARTLITE_NUM_INSTANCES)
+		return -EINVAL;
+
+	port = &amp;xul_uart_ports[co-&gt;index];
+
+	/* We ioremap ourself */
+	port-&gt;membase = ioremap(port-&gt;mapbase, xul_data[co-&gt;index].size);
+
+	if (port-&gt;membase == NULL) {	
+		return -EINVAL;
+	}
+
+	port-&gt;flags &amp;= ~UPF_IOREMAP;
+
+	baud = xul_data[co-&gt;index].baud;
+	parity = xul_data[co-&gt;index].parity;
+	bits = xul_data[co-&gt;index].bits;
+	flow = xul_data[co-&gt;index].flow;
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver xul_uart_driver;
+
+static struct console xul_console = {
+	.name	= "ttyXUL",
+	.write	= xul_console_write,
+	.device	= uart_console_device,
+	.setup	= xul_console_setup,
+	.flags	= CON_PRINTBUFFER,
+	.index	= -1,	/* Specified on the cmdline (e.g. console=ttyXUL0 ) */
+	.data	= &amp;xul_uart_driver,
+};
+
+	
+static int __init 
+xul_console_init(void)
+{
+	xul_uart_init_ports();
+	register_console(&amp;xul_console);
+	return 0;
+}
+
+console_initcall(xul_console_init);
+
+#define XUL_CONSOLE &amp;xul_console
+#else
+#define XUL_CONSOLE NULL
+#endif
+
+
+/* ======================================================================== */
+/* UART Driver                                                              */
+/* ======================================================================== */
+
+static struct uart_driver xul_uart_driver = {
+	.owner			= THIS_MODULE,
+	.driver_name	= "xul_uart",
+	.dev_name		= "ttyXUL",
+	.major			= SERIAL_XUL_MAJOR,
+	.minor			= SERIAL_XUL_MINOR,
+	.nr				= XPAR_XUARTLITE_NUM_INSTANCES,
+	.cons			= XUL_CONSOLE,
+};
+
+
+/* ======================================================================== */
+/* Platform Driver                                                          */
+/* ======================================================================== */
+
+static int __devinit
+xul_uart_probe(struct platform_device *dev)
+{
+	/* Probe does nothing */
+	return 0;
+}
+
+static int
+xul_uart_remove(struct platform_device *dev)
+{
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
+
+	platform_set_drvdata(dev, NULL);
+
+	if (port)
+		uart_remove_one_port(&amp;xul_uart_driver, port);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int
+xul_uart_suspend(struct platform_device *dev, pm_message_t state)
+{
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
+
+	if (port)
+		uart_suspend_port(&amp;xul_uart_driver, port);
+
+	return 0;
+}
+
+static int
+xul_uart_resume(struct platform_device *dev)
+{
+	struct uart_port *port = (struct uart_port *) platform_get_drvdata(dev);
+
+	if (port)
+		uart_resume_port(&amp;xul_uart_driver, port);
+
+	return 0;
+}
+#endif
+
+static struct platform_driver xul_uart_platform_driver = {
+	.probe		= xul_uart_probe,
+	.remove		= xul_uart_remove,
+#ifdef CONFIG_PM
+	.suspend	= xul_uart_suspend,
+	.resume		= xul_uart_resume,
+#endif
+	.driver		= {
+		.name	= "xul_uart"
+	},
+};
+
+
+/* ======================================================================== */
+/* Module                                                                   */
+/* ======================================================================== */
+
+static int __init
+xul_uart_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Serial: Xilinx UART Lite driver\n");	
+	
+	xul_uart_init_ports();
+
+	ret = uart_register_driver(&amp;xul_uart_driver);
+
+	if (ret == 0) {
+		xul_uart_register_ports(&amp;xul_uart_driver);
+		
+		ret = platform_driver_register(&amp;xul_uart_platform_driver);
+
+		if (ret) {
+			printk(KERN_WARNING "platform_driver_register failed! :%i\n", ret);
+			uart_unregister_driver(&amp;xul_uart_driver);
+		}
+	}
+
+	return ret;
+}
+
+static void __exit
+xul_uart_exit(void)
+{
+	platform_driver_unregister(&amp;xul_uart_platform_driver);
+	uart_unregister_driver(&amp;xul_uart_driver);
+}
+
+
+module_init(xul_uart_init);
+module_exit(xul_uart_exit);
+
+MODULE_AUTHOR("David Bolcsfoldi <a class="moz-txt-link-rfc2396E" href="mailto:dbolcsfoldi@gmail.com">&lt;dbolcsfoldi@gmail.com&gt;</a>");
+MODULE_DESCRIPTION("Xilinx UART Lite");
+MODULE_LICENSE("GPL");
+
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
--- 2.6.18/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-04 14:31:15.000000000 -0700
+++ patched/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-07 10:41:50.000000000 -0700
@@ -69,6 +69,7 @@
 		.device_list	= (enum ppc_sys_devices[])
 		{
 			VIRTEX_UART,
+			VIRTEX_XUL_UART,
 		},
 	},
 };
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
--- 2.6.18/include/linux/serial_core.h	2006-10-04 14:31:19.000000000 -0700
+++ patched/include/linux/serial_core.h	2006-10-07 10:52:24.000000000 -0700
@@ -132,6 +132,8 @@
 
 #define PORT_S3C2412	73
 
+/* Xilinx UART Lite */
+#define PORT_XUL 74
 
 #ifdef __KERNEL__
 
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------020800000002050708060202--
