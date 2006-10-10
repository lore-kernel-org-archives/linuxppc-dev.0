Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.175])
	by ozlabs.org (Postfix) with ESMTP id E8C9767C0D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Oct 2006 08:04:50 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so5219ugc
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Oct 2006 15:04:49 -0700 (PDT)
Message-ID: <528646bc0610101504n47e568b3t50d8c7f32cb4c221@mail.gmail.com>
Date: Tue, 10 Oct 2006 16:04:48 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "David Bolcsfoldi" <dbolcsfoldi@gmail.com>
Subject: Re: [PATCH] Xilinx UART Lite 2.6.18 driver
In-Reply-To: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <609d5c8e0610101349w64cdd4ecjc5359ad8d1f5d635@mail.gmail.com>
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

On 10/10/06, David Bolcsfoldi <dbolcsfoldi@gmail.com> wrote:
> Hi,
>
> here's a set of patches that adds support for Xilinx UART lite
> devices. It has been tested on an ML403-FX using xapp902
> (ml403_ppc_plb_temac) using a 2.6.18 kernel and a BusyBox userspace.
>
> This is my first patch for the Linux kernel, so please be gentle :-)

Okay; here goes.  :)

First off; it is easiest to review patches when they are sent inline,
one per email.  When they are attachements, they have to be extracted
and copied back into an email to comment on them.  Also, most of the
patches here are pretty minor.  You can roll all of them up into a
single patch (or two if you want to separate the boot wrapper driver
and the full driver)

Other generic comments:
- Try to keep lines under 80 character long.

xuartlite_tty.c.patch: These changes look pretty good
misc-common.c.patch: ok
virtex.h.patch: ok
xilinx_ml403.c.patch: ok
serial_core.h: ok
virtex.c.patch:
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

You need to add a pointer to a table of available UartLites her.
Include base addresses/irq# in the table.  There is no point adding
something to the platform bus if you don't describe the devices that
are available.  Use the .dev.platform_data value.  It's a void*
pointer available for your driver.

xuartlite.c.patch:
> diff -urN 2.6.18/drivers/serial/xuartlite.c patched/drivers/serial/xuartlite.c
> --- 2.6.18/drivers/serial/xuartlite.c	1969-12-31 16:00:00.000000000 -0800
> +++ patched/drivers/serial/xuartlite.c	2006-10-10 11:08:08.000000000 -0700
> @@ -0,0 +1,723 @@

<snip>

> +
> +#include <asm/delay.h>
> +#include <asm/io.h>
> +#include <platforms/4xx/xparameters/xparameters.h>

I'd like to move away from drivers including xparameters.h.  We're
moving towards using the flattened device tree to populate the
platform bus for xilinx devices.  arch/ppc doesn't use the device
tree, but it does populate the platform bus.  Device drivers should
get base addresses, irqs, etc from the platform bus instead of
xparams.

> +
> +#if defined(CONFIG_SERIAL_XUL_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/serial_core.h>
> +
> +#define SERIAL_XUL_MAJOR	204
> +#define SERIAL_XUL_MINOR	187
Have you added you new major/minor pair to Documentation/devices.txt?

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

Don't do this stuff here.  Add a table to the platform bus initializer
in virtex.c.

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

Break these out into an include file, and share them with
arch/ppc/boot/simple/xuartlite_tty.c

<snip>

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

This will always fail w/ -EINVAL.  Check your braces.
Also, merge all these tests into a single if; or break them out into
individual if's.  No need for the half-and-half approach done here.

<snip>

======================================================================== */
> +/* Interrupt handling                                                       */
> +/* ======================================================================== */

<snip>

> +
> +static irqreturn_t
> +xul_uart_int(int irq, void *dev_id, struct pt_regs *regs)
> +{
> +	struct uart_port *port = (struct uart_port *) dev_id;

Cast not needed.

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

No need to check (irq != port->irq).  All those code blocks have been
removed from mainline.

<snip>

======================================================================== */
> +/* Platform Driver                                                          */
> +/* ======================================================================== */
> +
> +static int __devinit
> +xul_uart_probe(struct platform_device *dev)
> +{
> +	/* Probe does nothing */
> +	return 0;
> +}

Gah!  What's the point of registering with the platform bus, if you
don't have a probe() routine!  :)  This is where you should pull the
base addresses and number of devices out of the platform_device
structure and dynamically set up your ports.

<snip>

Cheers,
g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
