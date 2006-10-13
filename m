Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A194867BD7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 17:09:37 +1000 (EST)
Message-ID: <452F3A82.7070803@dlasys.net>
Date: Fri, 13 Oct 2006 03:04:34 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: David Bolcsfoldi <dbolcsfoldi@gmail.com>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
	<87ac41esap.fsf@sleipner.barco.com>
	<609d5c8e0610121412o1288ef6i667b908597bf3d76@mail.gmail.com>
	<609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
In-Reply-To: <609d5c8e0610122221i7c5e5049n4db5fcf3f61bd132@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

David Bolcsfoldi wrote:
> Here's an initial patch based on a modified uartlite (by Peter
> Korsgaard), it's by no means ment to be final and any feedback would
> be appreciated.
>
> What I have changed:
>
> - Early console support.
>
> Since the platform bus isn't initialized by the time the first printk
> comes I've added a call 'early_uart_get_pdev' fashioned after the CPM
> serial driver.
>   
    If you want to mess with this my recomendation would be to switch to 
passing a uart_port
    like the 8250 does. You can find 8250 early serial init code in 
xilinx_ml403.c
    I beleive the init routine is called early_console_init().

    Nobody has given me a reason yet why the UartLite should init 
different from the 8250,
    and absent a reason, I would mimic the 8250. I do not think there is 
reason for a different routing name.
    The ml403 8250 init code deals with multiple  8250's, I did the same 
with UartLite.

    I am not sure I did nto follow everything on linux-serial - but I 
think Peter was asked to remove support
    for additional uarts. I am not sure why.



> - Platform device.
>
> The 'uartlite' is now a platform device although I am not entirely
> happy how this is done since there's only one VIRTEX_UARTLITE device
> with id of 0 although there might be several more described by the
> plafrom_data. Maybe the additional devices can be added to the
> platform bus in the probe call or would it be better to add these
> devices at compile time to the list of platform_devices in virtex.c?
>
> - readb/writeb to in_be32/out_be32.
>
> For some reason on my board the readb and writeb don't behave
> correctly when reading and writing to the uartlite device. I haven't
> looked into it but if this is unacceptable I will try to revert to
> readb/writeb.
>   
    I would appreciate some further elaboration. I think they were 
working for me when I tried Peter's driver.
    I even think that is one change I made to my own driver based on 
Peter's.
    But maybe I am wrong and that has something to do with my inability 
to get Peter's driver working on my hardware.


> - Embedded boot serial support.
>
> There's now support for embedded boot serial I/O over uartlite device 0.
>
> - uartlite.h
>   
    To be consistent with other uarts I think it should be 
include/linux/serial_uartlite.h

> A shared header file between the embedded boot serial driver and the
> real one with all the reg offsets and such. I don't know if the
> location for this file is ok though.
>   
    Finally, I think that this really needs submitted to linux-serial if 
you are looking to get it in.



> diff -urN 2.6.18/arch/ppc/boot/common/misc-common.c
> patched-uartlite/arch/ppc/boot/common/misc-common.c
> --- 2.6.18/arch/ppc/boot/common/misc-common.c	2006-10-04
> 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/boot/common/misc-common.c	2006-10-12
> 12:47:31.000000000 -0700
> @@ -57,7 +57,8 @
>   

Just a minor nit, but you can make the patches simpler by adding 
SERIAL_UARTLITE_CONSOLE into the middle of the list instead of the end.
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
>  extern unsigned long com_port;
>
>  extern int serial_tstc(unsigned long com_port);
> @@ -80,7 +81,8 @@
>  {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
>  	if(keyb_present)
>  		return (CRT_tstc() || serial_tstc(com_port));
>  	else
> @@ -95,7 +97,8 @@
>  	while (1) {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
>  		if (serial_tstc(com_port))
>  			return (serial_getc(com_port));
>  #endif /* serial console */
> @@ -112,7 +115,8 @@
>
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
>  	serial_putc(com_port, c);
>  	if ( c == '\n' )
>  		serial_putc(com_port, '\r');
> @@ -161,7 +165,8 @@
>  	while ( ( c = *s++ ) != '\0' ) {
>  #if defined(CONFIG_SERIAL_CPM_CONSOLE) || defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)
>  	        serial_putc(com_port, c);
>  	        if ( c == '\n' ) serial_putc(com_port, '\r');
>  #endif /* serial console */
> diff -urN 2.6.18/arch/ppc/boot/simple/Makefile
> patched-uartlite/arch/ppc/boot/simple/Makefile
> --- 2.6.18/arch/ppc/boot/simple/Makefile	2006-10-04 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/boot/simple/Makefile	2006-10-12
> 12:45:53.000000000 -0700
> @@ -205,6 +205,7 @@
>  endif
>  boot-$(CONFIG_SERIAL_MPC52xx_CONSOLE)	+= mpc52xx_tty.o
>  boot-$(CONFIG_SERIAL_MPSC_CONSOLE)	+= mv64x60_tty.o
> +boot-$(CONFIG_SERIAL_UARTLITE_CONSOLE)	+= uartlite_tty.o
>
>  LIBS				:= $(common)/lib.a $(bootlib)/lib.a
>  ifeq ($(CONFIG_PPC_PREP),y)
> diff -urN 2.6.18/arch/ppc/boot/simple/misc.c
> patched-uartlite/arch/ppc/boot/simple/misc.c
> --- 2.6.18/arch/ppc/boot/simple/misc.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/boot/simple/misc.c	2006-10-12
> 12:48:01.000000000 -0700
> @@ -48,7 +48,8 @@
>  #if (defined(CONFIG_SERIAL_8250_CONSOLE) \
>  	|| defined(CONFIG_VGA_CONSOLE) \
>  	|| defined(CONFIG_SERIAL_MPC52xx_CONSOLE) \
> -	|| defined(CONFIG_SERIAL_MPSC_CONSOLE)) \
> +	|| defined(CONFIG_SERIAL_MPSC_CONSOLE) \
> +	|| defined(CONFIG_SERIAL_UARTLITE_CONSOLE)) \
>  	&& !defined(CONFIG_GEMINI)
>  #define INTERACTIVE_CONSOLE	1
>  #endif
> diff -urN 2.6.18/arch/ppc/boot/simple/uartlite_tty.c
> patched-uartlite/arch/ppc/boot/simple/uartlite_tty.c
> --- 2.6.18/arch/ppc/boot/simple/uartlite_tty.c	1969-12-31
> 16:00:00.000000000 -0800
> +++ patched-uartlite/arch/ppc/boot/simple/uartlite_tty.c	2006-10-12
> 22:10:44.000000000 -0700
> @@ -0,0 +1,69 @@
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
> +#include <asm/uartlite.h>
> +#include <platforms/4xx/xparameters/xparameters.h>
> +
> +static inline int is_xmit_full(unsigned int address)
> +{
> +	return ((in_be32((volatile unsigned *) (address + ULITE_STATUS)) &
> ULITE_STATUS_TXFULL) == ULITE_STATUS_TXFULL);
> +}
> +
> +static inline int is_recv_empty(unsigned int address)
> +{
> +	return ((in_be32((volatile unsigned *) (address + ULITE_STATUS)) &
> ULITE_STATUS_RXVALID) != ULITE_STATUS_RXVALID);
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
> +	out_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + ULITE_TX), c);
> +}
> +
> +unsigned char serial_getc(unsigned long com_port)
> +{
> +	while(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
> +	return in_be32((volatile unsigned *) (XPAR_XUL_UART_0_BASEADDR + ULITE_RX));
> +}
> +
> +int serial_tstc(unsigned long com_port)
> +{
> +	return !(is_recv_empty(XPAR_XUL_UART_0_BASEADDR));
> +}
> +
> Binary files 2.6.18/arch/ppc/boot/simple/.uartlite_tty.c.swp and
> patched-uartlite/arch/ppc/boot/simple/.uartlite_tty.c.swp differ
> diff -urN 2.6.18/arch/ppc/platforms/4xx/virtex.c
> patched-uartlite/arch/ppc/platforms/4xx/virtex.c
> --- 2.6.18/arch/ppc/platforms/4xx/virtex.c	2006-10-04 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/platforms/4xx/virtex.c	2006-10-12
> 16:37:23.000000000 -0700
> @@ -46,11 +46,71 @@
>  	{ }, /* terminated by empty record */
>  };
>
> +#define XPAR_UARTLITE(num) { \
> +		.mapbase = XPAR_XUL_UART_##num##_BASEADDR, \
> +		.irq	 = XPAR_INTC_0_XUL_UART_##num##_VEC_ID, \
> +		.size	 = (XPAR_XUL_UART_##num##_HIGHADDR -
> XPAR_XUL_UART_##num##_BASEADDR) + 1, \
> +		.baud	 = XPAR_XUL_UART_##num##_BAUDRATE, \
> +		.bits	 = XPAR_XUL_UART_##num##_DATA_BITS, \
> +		.parity	 = XPAR_XUL_UART_##num##_USE_PARITY, \
> +		.odd_parity = XPAR_XUL_UART_##num##_ODD_PARITY, \
> +}
> +		
> +struct plat_uartlite_port uartlite_platform_data[] = {
> +#ifdef XPAR_XUL_UART_0_BASEADDR
> +	XPAR_UARTLITE(0),
> +#endif
> +#ifdef XPAR_XUL_UART_1_BASEADDR
> +	XPAR_UARTLITE(1),
> +#endif
> +#ifdef XPAR_XUL_UART_2_BASEADDR
> +	XPAR_UARTLITE(2),
> +#endif
> +#ifdef XPAR_XUL_UART_3_BASEADDR
> +	XPAR_UARTLITE(3),
> +#endif
> +	{ }, /* terminated by empty record */
> +};
> +
>  struct platform_device ppc_sys_platform_devices[] = {
>  	[VIRTEX_UART] = {
>  		.name		= "serial8250",
>  		.id		= 0,
>  		.dev.platform_data = serial_platform_data,
>  	},
> +
> +	[VIRTEX_UARTLITE] = {
> +		.name = "uartlite",
> +		.id	  = 0,
> +		.dev.platform_data = uartlite_platform_data,
> +#ifdef XPAR_XUL_UART_0_BASEADDR		
> +		.num_resources = 2,
> +		.resource = (struct resource[]) {
> +			{
> +				.start = XPAR_XUL_UART_0_BASEADDR,
> +				.end = XPAR_XUL_UART_0_HIGHADDR,
> +				.flags = IORESOURCE_MEM,
> +			},
> +			{
> +				.start = XPAR_INTC_0_XUL_UART_0_VEC_ID,
> +				.end = XPAR_INTC_0_XUL_UART_0_VEC_ID,
> +				.flags = IORESOURCE_IRQ,
> +			},
> +		},
> +#endif /* XPAR_XUL_UART_0_BASEADDR */	
> +	},
>  };
>
> +/* For early console on the uartlite serial port some way of
> + * getting to the platform_device is needed */
> +
> +struct platform_device* early_uart_get_pdev(int dev)
> +{
> +	if (dev < 0 ||
> +		dev >= NUM_PPC_SYS_DEVS) {
> +		return NULL;
> +	}
> +
> +	return &ppc_sys_platform_devices[dev];
> +}
> +
> diff -urN 2.6.18/arch/ppc/platforms/4xx/virtex.h
> patched-uartlite/arch/ppc/platforms/4xx/virtex.h
> --- 2.6.18/arch/ppc/platforms/4xx/virtex.h	2006-10-04 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/platforms/4xx/virtex.h	2006-10-12
> 16:37:41.000000000 -0700
> @@ -27,8 +27,21 @@
>  /* Device type enumeration for platform bus definitions */
>  #ifndef __ASSEMBLY__
>  enum ppc_sys_devices {
> -	VIRTEX_UART, NUM_PPC_SYS_DEVS,
> +	VIRTEX_UART,
> +	VIRTEX_UARTLITE,
> +	NUM_PPC_SYS_DEVS,
>  };
> +
> +struct plat_uartlite_port {
> +	unsigned int mapbase;
> +	unsigned int irq;
> +	unsigned int size;
> +	unsigned int baud;
> +	unsigned char bits;
> +	unsigned char parity;
> +	unsigned char odd_parity;
> +};
> +
>  #endif
>
>  #endif				/* __ASM_VIRTEX_H__ */
> diff -urN 2.6.18/arch/ppc/platforms/4xx/xilinx_ml403.c
> patched-uartlite/arch/ppc/platforms/4xx/xilinx_ml403.c
> --- 2.6.18/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-04
> 14:31:15.000000000 -0700
> +++ patched-uartlite/arch/ppc/platforms/4xx/xilinx_ml403.c	2006-10-12
> 13:15:36.000000000 -0700
> @@ -65,10 +65,11 @@
>  		.ppc_sys_name	= "Xilinx ML403 Reference Design",
>  		.mask 		= 0x00000000,
>  		.value 		= 0x00000000,
> -		.num_devices	= 1,
> +		.num_devices	= 2,
>  		.device_list	= (enum ppc_sys_devices[])
>  		{
>  			VIRTEX_UART,
> +			VIRTEX_UARTLITE,
>  		},
>  	},
>  };
> diff -urN 2.6.18/drivers/serial/Kconfig patched-uartlite/drivers/serial/Kconfig
> --- 2.6.18/drivers/serial/Kconfig	2006-10-04 14:31:18.000000000 -0700
> +++ patched-uartlite/drivers/serial/Kconfig	2006-10-12 12:15:32.000000000 -0700
> @@ -511,6 +511,25 @@
>  	  your boot loader (lilo or loadlin) about how to pass options to the
>  	  kernel at boot time.)
>
> +config SERIAL_UARTLITE
> +	tristate "Xilinx uartlite serial port support"
> +	depends on PPC32
> +	select SERIAL_CORE
> +	help
> +	  Say Y here if you want to use the Xilinx uartlite serial controller.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called uartlite.ko.
> +
> +config SERIAL_UARTLITE_CONSOLE
> +	bool "Support for console on Xilinx uartlite serial port"
> +	depends on SERIAL_UARTLITE=y
> +	select SERIAL_CORE_CONSOLE
> +	help
> +	  Say Y here if you wish to use a Xilinx uartlite as the system
> +	  console (the system console is the device which receives all kernel
> +	  messages and warnings and which allows logins in single user mode).
> +
>  config SERIAL_SUNCORE
>  	bool
>  	depends on SPARC
> diff -urN 2.6.18/drivers/serial/Makefile
> patched-uartlite/drivers/serial/Makefile
> --- 2.6.18/drivers/serial/Makefile	2006-10-04 14:31:18.000000000 -0700
> +++ patched-uartlite/drivers/serial/Makefile	2006-10-12 12:15:32.000000000 -0700
> @@ -55,4 +55,5 @@
>  obj-$(CONFIG_SERIAL_SGI_IOC4) += ioc4_serial.o
>  obj-$(CONFIG_SERIAL_SGI_IOC3) += ioc3_serial.o
>  obj-$(CONFIG_SERIAL_AT91) += at91_serial.o
> +obj-$(CONFIG_SERIAL_UARTLITE) += uartlite.o
>  obj-$(CONFIG_SERIAL_NETX) += netx-serial.o
> diff -urN 2.6.18/drivers/serial/uartlite.c
> patched-uartlite/drivers/serial/uartlite.c
> --- 2.6.18/drivers/serial/uartlite.c	1969-12-31 16:00:00.000000000 -0800
> +++ patched-uartlite/drivers/serial/uartlite.c	2006-10-12
> 22:10:57.000000000 -0700
> @@ -0,0 +1,551 @@
> +/*
> + * uartlite.c: Serial driver for Xilinx uartlite serial controller
> + *
> + * Peter Korsgaard <jacmet@sunsite.dk>
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2.  This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/console.h>
> +#include <linux/serial.h>
> +#include <linux/serial_core.h>
> +#include <linux/tty.h>
> +#include <linux/delay.h>
> +#include <linux/interrupt.h>
> +#include <asm/io.h>
> +#include <asm/uartlite.h>
> +
> +#define ULITE_MAJOR		204
> +#define ULITE_MINOR		187
> +#define ULITE_NR_UARTS		4
> +
> +static struct uart_port ports[ULITE_NR_UARTS];
> +
> +/* Place-holder for board-specific stuff */
> +struct platform_device* __attribute__ ((weak)) __init
> +early_uart_get_pdev(int index)
> +{
> +	return NULL;
> +}
> +
> +static int ulite_receive(struct uart_port *port, int stat)
> +{
> +	struct tty_struct *tty = port->info->tty;
> +	unsigned char ch = 0;
> +	char flag = TTY_NORMAL;
> +
> +	if ((stat & (ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
> +		     | ULITE_STATUS_FRAME)) == 0)
> +		return 0;
> +
> +	/* stats */
> +	if (stat & ULITE_STATUS_RXVALID) {
> +		port->icount.rx++;
> +		ch = in_be32((unsigned volatile *) (port->membase + ULITE_RX));
> +
> +		if (stat & ULITE_STATUS_PARITY)
> +			port->icount.parity++;
> +	}
> +
> +	if (stat & ULITE_STATUS_OVERRUN)
> +		port->icount.overrun++;
> +
> +	if (stat & ULITE_STATUS_FRAME)
> +		port->icount.frame++;
> +
> +
> +	/* drop byte with parity error if IGNPAR specificed */
> +	if (stat & port->ignore_status_mask & ULITE_STATUS_PARITY)
> +		stat &= ~ULITE_STATUS_RXVALID;
> +
> +	stat &= port->read_status_mask;
> +
> +	if (stat & ULITE_STATUS_PARITY)
> +		flag = TTY_PARITY;
> +
> +
> +	stat &= ~port->ignore_status_mask;
> +
> +	if (stat & ULITE_STATUS_RXVALID)
> +		tty_insert_flip_char(tty, ch, flag);
> +
> +	if (stat & ULITE_STATUS_FRAME)
> +		tty_insert_flip_char(tty, 0, TTY_FRAME);
> +
> +	if (stat & ULITE_STATUS_OVERRUN)
> +		tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +
> +	return 1;
> +}
> +
> +static int ulite_transmit(struct uart_port *port, int stat)
> +{
> +	struct circ_buf *xmit  = &port->info->xmit;
> +
> +	if (stat & ULITE_STATUS_TXFULL)
> +		return 0;
> +
> +	if (port->x_char) {
> +		out_be32((unsigned volatile *) (port->membase + ULITE_TX), port->x_char);
> +		port->x_char = 0;
> +		port->icount.tx++;
> +		return 1;
> +	}
> +
> +	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
> +		return 0;
> +
> +	out_be32((unsigned volatile *) (port->membase + ULITE_TX),
> xmit->buf[xmit->tail]);
> +	xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE-1);
> +	port->icount.tx++;
> +
> +	/* wake up */
> +	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +		uart_write_wakeup(port);
> +
> +	return 1;
> +}
> +
> +static irqreturn_t ulite_isr(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = (struct uart_port *)dev_id;
> +	int busy;
> +
> +	spin_lock(&port->lock); /* Lock the port in case of printk */
> +	
> +	do {
> +		int stat = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS));
> +		busy  = ulite_receive(port, stat);
> +		busy |= ulite_transmit(port, stat);
> +	} while (busy);
> +
> +	spin_unlock(&port->lock);
> +	
> +	tty_flip_buffer_push(port->info->tty);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static unsigned int ulite_tx_empty(struct uart_port *port)
> +{
> +	unsigned long flags;
> +	unsigned int ret;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	ret = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS));
> +	spin_unlock_irqrestore(&port->lock, flags);
> +
> +	return ret & ULITE_STATUS_TXEMPTY ? TIOCSER_TEMT : 0;
> +}
> +
> +static unsigned int ulite_get_mctrl(struct uart_port *port)
> +{
> +	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void ulite_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_stop_tx(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_start_tx(struct uart_port *port)
> +{
> +	ulite_transmit(port, in_be32((unsigned volatile *) (port->membase +
> ULITE_STATUS)));
> +}
> +
> +static void ulite_stop_rx(struct uart_port *port)
> +{
> +	/* don't forward any more data (like !CREAD) */
> +	port->ignore_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
> +		| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +}
> +
> +static void ulite_enable_ms(struct uart_port *port)
> +{
> +	/* N/A */
> +}
> +
> +static void ulite_break_ctl(struct uart_port *port, int ctl)
> +{
> +	/* N/A */
> +}
> +
> +static int ulite_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	ret = request_irq(port->irq, ulite_isr,
> +			  IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "uartlite", port);
> +	if (ret)
> +		return ret;
> +
> +	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
> ULITE_CONTROL_RST_RX | ULITE_CONTROL_RST_TX);
> +	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
> ULITE_CONTROL_IE);
> +
> +	return 0;
> +}
> +
> +static void ulite_shutdown(struct uart_port *port)
> +{
> +	writeb(0, port->membase + ULITE_CONTROL);
> +	free_irq(port->irq, port);
> +}
> +
> +static void ulite_set_termios(struct uart_port *port, struct termios *termios,
> +			      struct termios *old)
> +{
> +	struct plat_uartlite_port *uport;
> +	unsigned long flags;
> +	unsigned int baud;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +
> +	port->read_status_mask = ULITE_STATUS_RXVALID | ULITE_STATUS_OVERRUN
> +		| ULITE_STATUS_TXFULL;
> +
> +	if (termios->c_iflag & INPCK)
> +		port->read_status_mask |=
> +			ULITE_STATUS_PARITY | ULITE_STATUS_FRAME;
> +
> +	port->ignore_status_mask = 0;
> +	if (termios->c_iflag & IGNPAR)
> +		port->ignore_status_mask |= ULITE_STATUS_PARITY
> +			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +
> +	/* ignore all characters if CREAD is not set */
> +	if ((termios->c_cflag & CREAD) == 0)
> +		port->ignore_status_mask |=
> +			ULITE_STATUS_RXVALID | ULITE_STATUS_PARITY
> +			| ULITE_STATUS_FRAME | ULITE_STATUS_OVERRUN;
> +
> +	/* update timeout */
> +	uport = &((struct plat_uartlite_port *)port->dev->platform_data)[port->line];
> +	
> +	baud = uart_get_baud_rate(port, termios, old, uport->baud, uport->baud);
> +	uart_update_timeout(port, termios->c_cflag, baud);
> +
> +	spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *ulite_type(struct uart_port *port)
> +{
> +	return port->type == PORT_UARTLITE ? "uartlite" : NULL;
> +}
> +
> +static void ulite_release_port(struct uart_port *port)
> +{
> +	release_mem_region(port->mapbase, ULITE_REGION);
> +	iounmap(port->membase);
> +	port->membase = 0;
> +}
> +
> +static int ulite_request_port(struct uart_port *port)
> +{
> +	if (!request_mem_region(port->mapbase, ULITE_REGION, "uartlite")) {
> +		dev_err(port->dev, "Memory region busy\n");
> +		return -EBUSY;
> +	}
> +
> +	if (port->flags & UPF_IOREMAP) {
> +		port->membase = ioremap(port->mapbase, ULITE_REGION);
> +	}
> +	
> +	if (!port->membase) {
> +		dev_err(port->dev, "Unable to map registers\n");
> +		release_mem_region(port->mapbase, ULITE_REGION);
> +		return -EBUSY;
> +	}
> +
> +	return 0;
> +}
> +
> +static void ulite_config_port(struct uart_port *port, int flags)
> +{
> +	ulite_request_port(port);
> +	port->type = PORT_UARTLITE;
> +}
> +
> +static int ulite_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +	/* we don't want the core code to modify any port params */
> +	return -EINVAL;
> +}
> +
> +static struct uart_ops ulite_ops = {
> +	.tx_empty	= ulite_tx_empty,
> +	.set_mctrl	= ulite_set_mctrl,
> +	.get_mctrl	= ulite_get_mctrl,
> +	.stop_tx	= ulite_stop_tx,
> +	.start_tx	= ulite_start_tx,
> +	.stop_rx	= ulite_stop_rx,
> +	.enable_ms	= ulite_enable_ms,
> +	.break_ctl	= ulite_break_ctl,
> +	.startup	= ulite_startup,
> +	.shutdown	= ulite_shutdown,
> +	.set_termios	= ulite_set_termios,
> +	.type		= ulite_type,
> +	.release_port	= ulite_release_port,
> +	.request_port	= ulite_request_port,
> +	.config_port	= ulite_config_port,
> +	.verify_port	= ulite_verify_port
> +};
> +
> +static inline void ulite_init_port(struct uart_port *port)
> +{
> +	port->uartclk = 0;
> +	port->membase = 0;
> +	port->fifosize = 16;
> +	port->regshift = 2;
> +	port->iobase = 1; /* Mark port in use */
> +	port->iotype = UPIO_MEM;
> +	port->flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP;
> +	port->ops = &ulite_ops;
> +	port->type = PORT_UNKNOWN;
> +}
> +
> +#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
> +static void ulite_console_wait_tx(struct uart_port *port)
> +{
> +	int i;
> +
> +	/* wait up to 10ms for the character(s) to be sent */
> +	for (i=0; i<10000; i++) {
> +		if (in_be32((unsigned volatile *) (port->membase + ULITE_STATUS)) &
> ULITE_STATUS_TXEMPTY)
> +			break;
> +		udelay(1);
> +	}
> +}
> +
> +static void ulite_console_putchar(struct uart_port *port, int ch)
> +{
> +	ulite_console_wait_tx(port);
> +	out_be32((unsigned volatile *) (port->membase + ULITE_TX), ch);
> +}
> +
> +static void ulite_console_write(struct console *co, const char *s,
> +				unsigned int count)
> +{
> +	struct uart_port *port = &ports[co->index];
> +	unsigned long flags;
> +	unsigned int ier;
> +	int locked = 1;
> +
> +	if (oops_in_progress) {
> +		locked = spin_trylock_irqsave(&port->lock, flags);
> +	} else
> +		spin_lock_irqsave(&port->lock, flags);
> +
> +	/* save and disable interrupt */
> +	ier = in_be32((unsigned volatile *) (port->membase + ULITE_STATUS))
> & ULITE_STATUS_IE;
> +	
> +	//writeb(0, port->membase + ULITE_CONTROL);
> +	out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL), 0);
> +	
> +	uart_console_write(port, s, count, ulite_console_putchar);
> +
> +	ulite_console_wait_tx(port);
> +
> +	/* restore interrupt state */
> +	if (ier)
> +		out_be32((unsigned volatile *) (port->membase + ULITE_CONTROL),
> ULITE_CONTROL_IE);
> +
> +	if (locked)
> +		spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static int __init ulite_console_setup(struct console *co, char *options)
> +{
> +	int i;
> +	struct uart_port *port;
> +	struct platform_device *pdev;
> +	struct plat_uartlite_port *uport;
> +	
> +	if (co->index < 0 || co->index >= ULITE_NR_UARTS)
> +		return -EINVAL;
> +
> +	port = &ports[co->index];
> +
> +	/* not initialized yet? */
> +	if (!port->membase) {
> +		/* We might be early console */
> +		pdev = early_uart_get_pdev(VIRTEX_UARTLITE);
> +
> +		if (pdev == NULL) {
> +			return -ENODEV;
> +		}
> +		
> +		uport = pdev->dev.platform_data;
> +
> +		for (i = 0; i <= co->index; ++i) {
> +			/* We need to count the number of ports available */
> +			/* List of ports is terminated by a 0 record */
> +
> +			if (uport[i].baud == 0) {
> +				return -ENODEV;
> +			}
> +		}
> +
> +		ulite_init_port(port);
> +		
> +		port->irq = uport[co->index].irq;
> +		port->mapbase = uport[co->index].mapbase;
> +		port->line = co->index;
> +		spin_lock_init(&port->lock);
> +		port->membase = ioremap(port->mapbase, ULITE_REGION);
> +
> +		if(port->membase == NULL) {
> +			port->iobase = 0;
> +			return -EINVAL;
> +		}
> +
> +		/* Clear ioremap since this port has been mapped already */
> +		port->flags &= ~UPF_IOREMAP;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct uart_driver ulite_uart_driver;
> +
> +static struct console ulite_console = {
> +	.name	= "ttyUL",
> +	.write	= ulite_console_write,
> +	.device	= uart_console_device,
> +	.setup	= ulite_console_setup,
> +	.flags	= CON_PRINTBUFFER,
> +	.index	= -1, /* Specified on the cmdline (e.g. console=ttyUL0 ) */
> +	.data	= &ulite_uart_driver,
> +};
> +
> +static int __init ulite_console_init(void)
> +{
> +	register_console(&ulite_console);
> +	return 0;
> +}
> +
> +console_initcall(ulite_console_init);
> +
> +#endif /* CONFIG_SERIAL_UARTLITE_CONSOLE */
> +
> +static struct uart_driver ulite_uart_driver = {
> +	.owner		= THIS_MODULE,
> +	.driver_name	= "uartlite",
> +	.dev_name	= "ttyUL",
> +	.major		= ULITE_MAJOR,
> +	.minor		= ULITE_MINOR,
> +	.nr		= ULITE_NR_UARTS,
> +#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
> +	.cons		= &ulite_console,
> +#endif
> +};
> +
> +static int __devinit ulite_probe(struct platform_device *pdev)
> +{
> +	struct resource *res, *res2;
> +	struct uart_port *port;
> +	int ret;
> +
> +	if (pdev->id < 0 || pdev->id >= ULITE_NR_UARTS)
> +		return -EINVAL;
> +
> +	if (ports[pdev->id].membase) {
> +		if (ports[pdev->id].flags & UPF_IOREMAP) {	
> +			return -EBUSY; /* Port is busy */
> +		}
> +
> +		else {
> +			/* This port as be remapped so it must have been an early console */
> +			port = &ports[pdev->id];
> +			goto add_port;
> +		}
> +	}
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +
> +	if (!res)
> +		return -ENODEV;
> +
> +	res2 = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +	
> +	if (!res2)
> +		return -ENODEV;
> +
> +	port = &ports[pdev->id];
> +
> +	ulite_init_port(port);
> +	
> +	port->mapbase = res->start;
> +	port->irq = res2->start;
> +	port->line = pdev->id;
> +
> +add_port:
> +	port->dev = &pdev->dev;
> +	
> +	ret = uart_add_one_port(&ulite_uart_driver, port);
> +
> +	if(ret == 0)
> +		platform_set_drvdata(pdev, port);
> +		
> +	return ret;
> +}
> +
> +static int ulite_remove(struct platform_device *pdev)
> +{
> +	struct uart_port *port = platform_get_drvdata(pdev);
> +
> +	platform_set_drvdata(pdev, NULL);
> +
> +	if (port)
> +		uart_remove_one_port(&ulite_uart_driver, port);
> +
> +	/* mark port as free */
> +	port->membase = 0;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver ulite_platform_driver = {
> +	.probe	= ulite_probe,
> +	.remove	= ulite_remove,
> +	.driver	= {
> +		   .owner = THIS_MODULE,
> +		   .name  = "uartlite",
> +		   },
> +};
> +
> +int __init ulite_init(void)
> +{
> +	int ret;
> +
> +	ret = uart_register_driver(&ulite_uart_driver);
> +	if (ret)
> +		return ret;
> +
> +	ret = platform_driver_register(&ulite_platform_driver);
> +	if (ret)
> +		uart_unregister_driver(&ulite_uart_driver);
> +
> +	return ret;
> +}
> +
> +void __exit ulite_exit(void)
> +{
> +	platform_driver_unregister(&ulite_platform_driver);
> +	uart_unregister_driver(&ulite_uart_driver);
> +}
> +
> +module_init(ulite_init);
> +module_exit(ulite_exit);
> +
> +MODULE_AUTHOR("Peter Korsgaard <jacmet@sunsite.dk>");
> +MODULE_DESCRIPTION("Xilinx uartlite serial driver");
> +MODULE_LICENSE("GPL");
> Binary files 2.6.18/drivers/serial/.uartlite.c.swp and
> patched-uartlite/drivers/serial/.uartlite.c.swp differ
> diff -urN 2.6.18/include/asm-ppc/uartlite.h
> patched-uartlite/include/asm-ppc/uartlite.h
> --- 2.6.18/include/asm-ppc/uartlite.h	1969-12-31 16:00:00.000000000 -0800
> +++ patched-uartlite/include/asm-ppc/uartlite.h	2006-10-12
> 21:53:00.000000000 -0700
> @@ -0,0 +1,28 @@
> +#ifndef __ASM_UARTLITE_H__
> +#define __ASM_UARTLITE_H__
> +
> +/* For register details see datasheet:
> +   http://www.xilinx.com/bvdocs/ipcenter/data_sheet/opb_uartlite.pdf
> +*/
> +#define ULITE_RX		0x00
> +#define ULITE_TX		0x04
> +#define ULITE_STATUS		0x08
> +#define ULITE_CONTROL		0x0c
> +
> +#define ULITE_REGION		16
> +
> +#define ULITE_STATUS_RXVALID	0x01
> +#define ULITE_STATUS_RXFULL	0x02
> +#define ULITE_STATUS_TXEMPTY	0x04
> +#define ULITE_STATUS_TXFULL	0x08
> +#define ULITE_STATUS_IE		0x10
> +#define ULITE_STATUS_OVERRUN	0x20
> +#define ULITE_STATUS_FRAME	0x40
> +#define ULITE_STATUS_PARITY	0x80
> +
> +#define ULITE_CONTROL_RST_TX	0x01
> +#define ULITE_CONTROL_RST_RX	0x02
> +#define ULITE_CONTROL_IE	0x10
> +
> +#endif /* __ASM_UARTLITE_H__ */
> +
> diff -urN 2.6.18/include/linux/serial_core.h
> patched-uartlite/include/linux/serial_core.h
> --- 2.6.18/include/linux/serial_core.h	2006-10-04 14:31:19.000000000 -0700
> +++ patched-uartlite/include/linux/serial_core.h	2006-10-12
> 12:15:32.000000000 -0700
> @@ -132,6 +132,8 @@
>
>  #define PORT_S3C2412	73
>
> +/* Xilinx uartlite */
> +#define PORT_UARTLITE	74
>
>  #ifdef __KERNEL__
>
> diff -urN 2.6.18/MAINTAINERS patched-uartlite/MAINTAINERS
> --- 2.6.18/MAINTAINERS	2006-10-04 14:31:14.000000000 -0700
> +++ patched-uartlite/MAINTAINERS	2006-10-12 12:15:32.000000000 -0700
> @@ -3311,6 +3311,12 @@
>  T:	git git://oss.sgi.com:8090/xfs/xfs-2.6
>  S:	Supported
>
> +XILINX UARTLITE SERIAL DRIVER
> +P:	Peter Korsgaard
> +M:	jacmet@sunsite.dk
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +
>  X86 3-LEVEL PAGING (PAE) SUPPORT
>  P:	Ingo Molnar
>  M:	mingo@redhat.com
> --
>
> Cheers,
> David
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
