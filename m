Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 88BA0DDF1D
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 04:32:39 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so1625477anc.78
	for <linuxppc-dev@ozlabs.org>; Tue, 08 Jan 2008 09:32:38 -0800 (PST)
Message-ID: <fa686aa40801080932g71fb6215wc3d6df107bec7238@mail.gmail.com>
Date: Tue, 8 Jan 2008 10:32:37 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [PATCH 7/7] Add MPC512x PSC serial driver
In-Reply-To: <1199808093-15929-8-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>
	<1199808093-15929-5-git-send-email-jrigby@freescale.com>
	<1199808093-15929-6-git-send-email-jrigby@freescale.com>
	<1199808093-15929-7-git-send-email-jrigby@freescale.com>
	<1199808093-15929-8-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Exactly *how* different is the 5121 PSC from the 5200 PSC?  If it is
really different, then it makes sense to clone.  In fact; I'd
duplicate the mpc52xx_psc.h file also to avoid any crossover.

However, if the differences are manegable, I'd rather see a single
driver that can drive either type of PSC.  In fact, can you post a
diff between this driver and the original PSC driver?

Cheers,
g.

On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
> mpc512x_uart.c is based on mpc52xx_uart.c with
>     names changed
>     arch/ppc support removed
>     512x psc fifo support added
>     shares mpc52xx_psc.h with 52xx driver
>
> Signed-off-by: John Rigby <jrigby@freescale.com>
> ---
>  drivers/serial/Kconfig            |   18 +
>  drivers/serial/Makefile           |    1 +
>  drivers/serial/mpc512x_uart.c     |  969 +++++++++++++++++++++++++++++++++++++
>  include/asm-powerpc/mpc52xx_psc.h |   47 ++
>  4 files changed, 1035 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/serial/mpc512x_uart.c
>
> diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
> index d7e1996..643b84a 100644
> --- a/drivers/serial/Kconfig
> +++ b/drivers/serial/Kconfig
> @@ -1113,6 +1113,24 @@ config SERIAL_SGI_L1_CONSOLE
>                 controller serial port as your console (you want this!),
>                 say Y.  Otherwise, say N.
>
> +config SERIAL_MPC512x
> +       tristate "Freescale MPC512x family PSC serial support"
> +       depends on PPC_512x
> +       select SERIAL_CORE
> +       help
> +         This drivers support the MPC512x PSC serial ports. If you would
> +         like to use them, you must answer Y or M to this option. Not that
> +         for use as console, it must be included in kernel and not as a
> +         module.
> +
> +config SERIAL_MPC512x_CONSOLE
> +       bool "Console on a Freescale MPC512x family PSC serial port"
> +       depends on SERIAL_MPC512x=y
> +       select SERIAL_CORE_CONSOLE
> +       help
> +         Select this options if you'd like to use one of the PSC serial port
> +         of the Freescale MPC52xx family as a console.
> +
>  config SERIAL_MPC52xx
>         tristate "Freescale MPC52xx family PSC serial support"
>         depends on PPC_MPC52xx
> diff --git a/drivers/serial/Makefile b/drivers/serial/Makefile
> index af6377d..13e8176 100644
> --- a/drivers/serial/Makefile
> +++ b/drivers/serial/Makefile
> @@ -48,6 +48,7 @@ obj-$(CONFIG_SERIAL_SH_SCI) += sh-sci.o
>  obj-$(CONFIG_SERIAL_SGI_L1_CONSOLE) += sn_console.o
>  obj-$(CONFIG_SERIAL_CPM) += cpm_uart/
>  obj-$(CONFIG_SERIAL_IMX) += imx.o
> +obj-$(CONFIG_SERIAL_MPC512x) += mpc512x_uart.o
>  obj-$(CONFIG_SERIAL_MPC52xx) += mpc52xx_uart.o
>  obj-$(CONFIG_SERIAL_ICOM) += icom.o
>  obj-$(CONFIG_SERIAL_M32R_SIO) += m32r_sio.o
> diff --git a/drivers/serial/mpc512x_uart.c b/drivers/serial/mpc512x_uart.c
> new file mode 100644
> index 0000000..e2ff0b8
> --- /dev/null
> +++ b/drivers/serial/mpc512x_uart.c
> @@ -0,0 +1,969 @@
> +/*
> + * Driver for the PSC of the Freescale MPC512x PSCs configured as UARTs.
> + *
> + * Copyright (C) 2007 Freescale Semiconductor Inc
> + * John Rigby <jrigby@freescale.com>
> + *
> + * Fork of mpc512x_uart.c:
> + *
> + *     Copyright (C) 2006 Secret Lab Technologies Ltd.
> + *                        Grant Likely <grant.likely@secretlab.ca>
> + *     Copyright (C) 2004-2006 Sylvain Munaut <tnt@246tNt.com>
> + *     Copyright (C) 2003 MontaVista, Software, Inc.
> + *                           Dale Farnsworth <dfarnsworth@mvista.com>.
> + *
> + * This file is licensed under the terms of the GNU General Public License
> + * version 2. This program is licensed "as is" without any warranty of any
> + * kind, whether express or implied.
> + */
> +
> +/*
> + * The 512x PSCs are almost identical to those on 52xx.  The most notable
> + * difference is that the FIFOs have been separated out.  This file
> + * still uses the mpc52xx_psc.h which has had the fifo differences added.
> + *
> + * TODO (maybe) abstract out the fifo differences and merge this back
> + * into mpc512x_serial.c
> + */
> +
> +/* OF Platform device Usage :
> + *
> + * This driver is only used for PSCs configured in uart mode.  The device
> + * tree will have a node for each PSC in uart mode w/ device_type = "serial"
> + * and "mpc52xx-psc-uart" in the compatible string
> + *
> + * By default, PSC devices are enumerated in the order they are found.  However
> + * a particular PSC number can be forced by adding 'device_no = <port#>'
> + * to the device node.
> + *
> + * The driver init all necessary registers to place the PSC in uart mode without
> + * DCD. However, the pin multiplexing aren't changed and should be set either
> + * by the bootloader or in the platform init code.
> + */
> +
> +#undef DEBUG
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/tty.h>
> +#include <linux/serial.h>
> +#include <linux/sysrq.h>
> +#include <linux/console.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +
> +#include <asm/of_platform.h>
> +#include <asm/mpc52xx_psc.h>
> +#include <asm/mpc512x.h>
> +
> +#if defined(CONFIG_SERIAL_MPC512x_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
> +#define SUPPORT_SYSRQ
> +#endif
> +
> +#include <linux/serial_core.h>
> +
> +/* We've been assigned a range on the "Low-density serial ports" major */
> +#define SERIAL_PSC_MAJOR       204
> +#define SERIAL_PSC_MINOR       148
> +
> +#define ISR_PASS_LIMIT 256     /* Max number of iteration in the interrupt */
> +
> +static struct uart_port mpc512x_uart_ports[MPC52xx_PSC_MAXNUM];
> +
> +/* lookup table for matching device nodes to index numbers */
> +static struct device_node *mpc512x_uart_nodes[MPC52xx_PSC_MAXNUM];
> +
> +static void mpc512x_uart_of_enumerate(void);
> +
> +static unsigned long getuartclk(void *p)
> +{
> +       return mpc512x_find_ips_freq(p);
> +}
> +
> +#define PSC(port) ((struct mpc52xx_psc __iomem *)((port)->membase))
> +#define FIFO(port) ((struct mpc512x_psc_fifo __iomem *)(PSC(port)+1))
> +
> +/* Forward declaration of the interruption handling routine */
> +static irqreturn_t mpc512x_uart_int(int irq, void *dev_id);
> +
> +/* Simple macro to test if a port is console or not. This one is taken
> + * for serial_core.c and maybe should be moved to serial_core.h ? */
> +#ifdef CONFIG_SERIAL_CORE_CONSOLE
> +#define uart_console(port) ((port)->cons && (port)->cons->index == (port)->line)
> +#else
> +#define uart_console(port) (0)
> +#endif
> +
> +static struct of_device_id mpc512x_uart_of_match[] = {
> +       {.type = "serial", .compatible = "mpc512x-psc-uart",},
> +       {},
> +};
> +
> +/* ======================================================================== */
> +/* UART operations                                                          */
> +/* ======================================================================== */
> +
> +static unsigned int mpc512x_uart_tx_empty(struct uart_port *port)
> +{
> +       int status;
> +
> +       status = in_be32(&FIFO(port)->txsr);
> +       return (status & MPC512x_PSC_FIFO_EMPTY) ? TIOCSER_TEMT : 0;
> +}
> +
> +static void mpc512x_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +       /* Not implemented */
> +}
> +
> +static unsigned int mpc512x_uart_get_mctrl(struct uart_port *port)
> +{
> +       /* Not implemented */
> +       return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
> +}
> +
> +static void mpc512x_uart_stop_tx(struct uart_port *port)
> +{
> +       /* port->lock taken by caller */
> +       unsigned long tx_fifo_imr;
> +
> +       tx_fifo_imr = in_be32(&FIFO(port)->tximr);
> +       tx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
> +       out_be32(&FIFO(port)->tximr, tx_fifo_imr);
> +}
> +
> +static void mpc512x_uart_start_tx(struct uart_port *port)
> +{
> +       /* port->lock taken by caller */
> +       unsigned long tx_fifo_imr;
> +
> +       tx_fifo_imr = in_be32(&FIFO(port)->tximr);
> +       tx_fifo_imr |= MPC512x_PSC_FIFO_ALARM;
> +       out_be32(&FIFO(port)->tximr, tx_fifo_imr);
> +}
> +
> +static void mpc512x_uart_send_xchar(struct uart_port *port, char ch)
> +{
> +       unsigned long flags;
> +       spin_lock_irqsave(&port->lock, flags);
> +
> +       port->x_char = ch;
> +       if (ch) {
> +               /* Make sure tx interrupts are on */
> +               /* Truly necessary ??? They should be anyway */
> +               unsigned long tx_fifo_imr;
> +
> +               tx_fifo_imr = in_be32(&FIFO(port)->tximr);
> +               tx_fifo_imr |= MPC512x_PSC_FIFO_ALARM;
> +               out_be32(&FIFO(port)->tximr, tx_fifo_imr);
> +       }
> +
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void mpc512x_uart_stop_rx(struct uart_port *port)
> +{
> +       /* port->lock taken by caller */
> +       unsigned long rx_fifo_imr;
> +
> +       rx_fifo_imr = in_be32(&FIFO(port)->rximr);
> +       rx_fifo_imr &= ~MPC512x_PSC_FIFO_ALARM;
> +       out_be32(&FIFO(port)->rximr, rx_fifo_imr);
> +}
> +
> +static void mpc512x_uart_enable_ms(struct uart_port *port)
> +{
> +       /* Not implemented */
> +}
> +
> +static void mpc512x_uart_break_ctl(struct uart_port *port, int ctl)
> +{
> +       unsigned long flags;
> +       spin_lock_irqsave(&port->lock, flags);
> +
> +       if (ctl == -1)
> +               out_8(&PSC(port)->command, MPC52xx_PSC_START_BRK);
> +       else
> +               out_8(&PSC(port)->command, MPC52xx_PSC_STOP_BRK);
> +
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static void mpc512x_uart_fifo_init(struct mpc52xx_psc *psc)
> +{
> +       struct mpc512x_psc_fifo *fifo;
> +
> +       /* fifo is right after the psc */
> +       fifo = (struct mpc512x_psc_fifo *)(psc + 1);
> +
> +       out_be32(&fifo->txcmd, MPC512x_PSC_FIFO_RESET_SLICE);
> +       out_be32(&fifo->txcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
> +       out_be32(&fifo->txalarm, 1);
> +       out_be32(&fifo->tximr, 0);
> +
> +       out_be32(&fifo->rxcmd, MPC512x_PSC_FIFO_RESET_SLICE);
> +       out_be32(&fifo->rxcmd, MPC512x_PSC_FIFO_ENABLE_SLICE);
> +       out_be32(&fifo->rxalarm, 1);
> +       out_be32(&fifo->rximr, 0);
> +}
> +
> +static int mpc512x_uart_startup(struct uart_port *port)
> +{
> +       struct mpc52xx_psc __iomem *psc = PSC(port);
> +       int ret;
> +
> +       /* Request IRQ */
> +       ret = request_irq(port->irq, mpc512x_uart_int,
> +                         IRQF_DISABLED | IRQF_SAMPLE_RANDOM,
> +                         "mpc512x_psc_uart", port);
> +       if (ret)
> +               return ret;
> +
> +       /* Reset/activate the port, clear and enable interrupts */
> +       out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +       out_8(&psc->command, MPC52xx_PSC_RST_TX);
> +
> +       out_be32(&psc->sicr, 0);        /* UART mode DCD ignored */
> +
> +       mpc512x_uart_fifo_init(psc);
> +
> +       out_be32(&FIFO(port)->tximr, MPC512x_PSC_FIFO_ALARM);
> +       out_be32(&FIFO(port)->rximr, MPC512x_PSC_FIFO_ALARM);
> +
> +       out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
> +       out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
> +
> +       return 0;
> +}
> +
> +static void mpc512x_uart_shutdown(struct uart_port *port)
> +{
> +       struct mpc52xx_psc __iomem *psc = PSC(port);
> +
> +       /* Shut down the port.  Leave TX active if on a console port */
> +       out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +       if (!uart_console(port))
> +               out_8(&psc->command, MPC52xx_PSC_RST_TX);
> +
> +       out_be32(&FIFO(port)->tximr, 0);
> +       out_be32(&FIFO(port)->rximr, 0);
> +
> +       /* Release interrupt */
> +       free_irq(port->irq, port);
> +}
> +
> +static void
> +mpc512x_uart_set_termios(struct uart_port *port, struct ktermios *new,
> +                        struct ktermios *old)
> +{
> +       struct mpc52xx_psc __iomem *psc = PSC(port);
> +       unsigned long flags;
> +       unsigned char mr1, mr2;
> +       unsigned short ctr;
> +       unsigned int j, baud, quot;
> +       struct mpc512x_psc_fifo *fifo = FIFO(port);
> +
> +       /* Prepare what we're gonna write */
> +       mr1 = 0;
> +
> +       switch (new->c_cflag & CSIZE) {
> +       case CS5:
> +               mr1 |= MPC52xx_PSC_MODE_5_BITS;
> +               break;
> +       case CS6:
> +               mr1 |= MPC52xx_PSC_MODE_6_BITS;
> +               break;
> +       case CS7:
> +               mr1 |= MPC52xx_PSC_MODE_7_BITS;
> +               break;
> +       case CS8:
> +       default:
> +               mr1 |= MPC52xx_PSC_MODE_8_BITS;
> +       }
> +
> +       if (new->c_cflag & PARENB) {
> +               mr1 |= (new->c_cflag & PARODD) ?
> +                   MPC52xx_PSC_MODE_PARODD : MPC52xx_PSC_MODE_PAREVEN;
> +       } else
> +               mr1 |= MPC52xx_PSC_MODE_PARNONE;
> +
> +       mr2 = 0;
> +
> +       if (new->c_cflag & CSTOPB)
> +               mr2 |= MPC52xx_PSC_MODE_TWO_STOP;
> +       else
> +               mr2 |= ((new->c_cflag & CSIZE) == CS5) ?
> +                   MPC52xx_PSC_MODE_ONE_STOP_5_BITS :
> +                   MPC52xx_PSC_MODE_ONE_STOP;
> +
> +       baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
> +       quot = uart_get_divisor(port, baud);
> +       ctr = quot & 0xffff;
> +
> +       /* Get the lock */
> +       spin_lock_irqsave(&port->lock, flags);
> +
> +       /* Update the per-port timeout */
> +       uart_update_timeout(port, new->c_cflag, baud);
> +
> +       /* Do our best to flush TX & RX, so we don't loose anything */
> +       /* But we don't wait indefinitly ! */
> +       j = 5000000;            /* Maximum wait */
> +       /* FIXME Can't receive chars since set_termios might be called at early
> +        * boot for the console, all stuff is not yet ready to receive at that
> +        * time and that just makes the kernel oops */
> +       /* while (j-- && mpc512x_uart_int_rx_chars(port)); */
> +       while (!(in_be32(&fifo->txsr) & MPC512x_PSC_FIFO_EMPTY) && --j)
> +               udelay(1);
> +
> +       if (!j)
> +               printk(KERN_ERR "mpc512x_uart.c: "
> +                      "Unable to flush RX & TX fifos in-time in set_termios."
> +                      "Some chars may have been lost.\n");
> +
> +       /* Reset the TX & RX */
> +       out_8(&psc->command, MPC52xx_PSC_RST_RX);
> +       out_8(&psc->command, MPC52xx_PSC_RST_TX);
> +
> +       /* Send new mode settings */
> +       out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
> +       out_8(&psc->mode, mr1);
> +       out_8(&psc->mode, mr2);
> +       out_8(&psc->ctur, ctr >> 8);
> +       out_8(&psc->ctlr, ctr & 0xff);
> +
> +       /* Reenable TX & RX */
> +       out_8(&psc->command, MPC52xx_PSC_TX_ENABLE);
> +       out_8(&psc->command, MPC52xx_PSC_RX_ENABLE);
> +
> +       /* We're all set, release the lock */
> +       spin_unlock_irqrestore(&port->lock, flags);
> +}
> +
> +static const char *mpc512x_uart_type(struct uart_port *port)
> +{
> +       return port->type == PORT_MPC52xx ? "MPC52xx PSC" : NULL;
> +}
> +
> +static void mpc512x_uart_release_port(struct uart_port *port)
> +{
> +       /* remapped by us ? */
> +       if (port->flags & UPF_IOREMAP) {
> +               iounmap(port->membase);
> +               port->membase = NULL;
> +       }
> +
> +       release_mem_region(port->mapbase, sizeof(struct mpc52xx_psc));
> +}
> +
> +static int mpc512x_uart_request_port(struct uart_port *port)
> +{
> +       int err;
> +
> +       if (port->flags & UPF_IOREMAP)  /* Need to remap ? */
> +               port->membase = ioremap(port->mapbase,
> +                                       sizeof(struct mpc52xx_psc));
> +
> +       if (!port->membase)
> +               return -EINVAL;
> +
> +       err = request_mem_region(port->mapbase, sizeof(struct mpc52xx_psc),
> +                                "mpc512x_psc_uart") != NULL ? 0 : -EBUSY;
> +
> +       if (err && (port->flags & UPF_IOREMAP)) {
> +               iounmap(port->membase);
> +               port->membase = NULL;
> +       }
> +
> +       return err;
> +}
> +
> +static void mpc512x_uart_config_port(struct uart_port *port, int flags)
> +{
> +       if ((flags & UART_CONFIG_TYPE) &&
> +           (mpc512x_uart_request_port(port) == 0))
> +               port->type = PORT_MPC52xx;
> +}
> +
> +static int
> +mpc512x_uart_verify_port(struct uart_port *port, struct serial_struct *ser)
> +{
> +       if (ser->type != PORT_UNKNOWN && ser->type != PORT_MPC52xx)
> +               return -EINVAL;
> +
> +       if ((ser->irq != port->irq) ||
> +           (ser->io_type != SERIAL_IO_MEM) ||
> +           (ser->baud_base != port->uartclk) ||
> +           (ser->iomem_base != (void *)port->mapbase) || (ser->hub6 != 0))
> +               return -EINVAL;
> +
> +       return 0;
> +}
> +
> +static struct uart_ops mpc512x_uart_ops = {
> +       .tx_empty = mpc512x_uart_tx_empty,
> +       .set_mctrl = mpc512x_uart_set_mctrl,
> +       .get_mctrl = mpc512x_uart_get_mctrl,
> +       .stop_tx = mpc512x_uart_stop_tx,
> +       .start_tx = mpc512x_uart_start_tx,
> +       .send_xchar = mpc512x_uart_send_xchar,
> +       .stop_rx = mpc512x_uart_stop_rx,
> +       .enable_ms = mpc512x_uart_enable_ms,
> +       .break_ctl = mpc512x_uart_break_ctl,
> +       .startup = mpc512x_uart_startup,
> +       .shutdown = mpc512x_uart_shutdown,
> +       .set_termios = mpc512x_uart_set_termios,
> +/*     .pm             = mpc512x_uart_pm,              Not supported yet */
> +/*     .set_wake       = mpc512x_uart_set_wake,        Not supported yet */
> +       .type = mpc512x_uart_type,
> +       .release_port = mpc512x_uart_release_port,
> +       .request_port = mpc512x_uart_request_port,
> +       .config_port = mpc512x_uart_config_port,
> +       .verify_port = mpc512x_uart_verify_port
> +};
> +
> +/* ======================================================================== */
> +/* Interrupt handling                                                       */
> +/* ======================================================================== */
> +
> +static inline int mpc512x_uart_int_rx_chars(struct uart_port *port)
> +{
> +       struct tty_struct *tty = port->info->tty;
> +       unsigned char ch, flag;
> +       unsigned short status;
> +       unsigned long fifostatus;
> +       struct mpc52xx_psc __iomem *psc = PSC(port);
> +       struct mpc512x_psc_fifo __iomem *fifo = FIFO(port);
> +
> +       /* While we can read, do so ! */
> +       while (1) {
> +               fifostatus = in_be32(&fifo->rxsr);
> +
> +               if (fifostatus & MPC512x_PSC_FIFO_EMPTY)
> +                       break;
> +
> +               status = in_be16(&psc->mpc52xx_psc_status);
> +
> +               /* Get the char */
> +               ch = in_8(&fifo->rxdata_8);
> +
> +               /* Handle sysreq char */
> +#ifdef SUPPORT_SYSRQ
> +               if (uart_handle_sysrq_char(port, ch)) {
> +                       port->sysrq = 0;
> +                       continue;
> +               }
> +#endif
> +
> +               /* Store it */
> +
> +               flag = TTY_NORMAL;
> +               port->icount.rx++;
> +
> +               if (status & (MPC52xx_PSC_SR_PE |
> +                             MPC52xx_PSC_SR_FE | MPC52xx_PSC_SR_RB)) {
> +
> +                       if (status & MPC52xx_PSC_SR_RB) {
> +                               flag = TTY_BREAK;
> +                               uart_handle_break(port);
> +                       } else if (status & MPC52xx_PSC_SR_PE)
> +                               flag = TTY_PARITY;
> +                       else if (status & MPC52xx_PSC_SR_FE)
> +                               flag = TTY_FRAME;
> +
> +                       /* Clear error condition */
> +                       out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STAT);
> +
> +               }
> +               tty_insert_flip_char(tty, ch, flag);
> +               if (status & MPC52xx_PSC_SR_OE) {
> +                       /*
> +                        * Overrun is special, since it's
> +                        * reported immediately, and doesn't
> +                        * affect the current character
> +                        */
> +                       tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +               }
> +       }
> +
> +       tty_flip_buffer_push(tty);
> +
> +       fifostatus = in_be32(&fifo->rxsr);
> +       return !(fifostatus & MPC512x_PSC_FIFO_EMPTY);
> +}
> +
> +static inline int mpc512x_uart_int_tx_chars(struct uart_port *port)
> +{
> +       struct circ_buf *xmit = &port->info->xmit;
> +       struct mpc512x_psc_fifo *fifo = FIFO(port);
> +
> +       /* Process out of band chars */
> +       if (port->x_char) {
> +               out_8(&fifo->txdata_8, port->x_char);
> +               port->icount.tx++;
> +               port->x_char = 0;
> +               return 1;
> +       }
> +
> +       /* Nothing to do ? */
> +       if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
> +               mpc512x_uart_stop_tx(port);
> +               return 0;
> +       }
> +
> +       /* Send chars */
> +       while (!(in_be32(&fifo->txsr) & MPC512x_PSC_FIFO_FULL)) {
> +               out_8(&fifo->txdata_8, xmit->buf[xmit->tail]);
> +               xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
> +               port->icount.tx++;
> +               if (uart_circ_empty(xmit))
> +                       break;
> +       }
> +
> +       /* Wake up */
> +       if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
> +               uart_write_wakeup(port);
> +
> +       /* Maybe we're done after all */
> +       if (uart_circ_empty(xmit)) {
> +               mpc512x_uart_stop_tx(port);
> +               return 0;
> +       }
> +
> +       return 1;
> +}
> +
> +static irqreturn_t mpc512x_uart_int(int irq, void *dev_id)
> +{
> +       struct uart_port *port = dev_id;
> +       unsigned long pass = ISR_PASS_LIMIT;
> +       unsigned int keepgoing;
> +       unsigned long rx_fifo_status;
> +       unsigned long tx_fifo_status;
> +
> +       spin_lock(&port->lock);
> +
> +       /* While we have stuff to do, we continue */
> +       do {
> +               /* If we don't find anything to do, we stop */
> +               keepgoing = 0;
> +
> +               /* clear any pending interrupts */
> +               out_be32(&FIFO(port)->rxisr, in_be32(&FIFO(port)->rxisr));
> +
> +               rx_fifo_status = in_be32(&FIFO(port)->rxsr);
> +               out_be32(&FIFO(port)->rxisr, rx_fifo_status);
> +               rx_fifo_status &= in_be32(&FIFO(port)->rximr);
> +
> +               if (rx_fifo_status & MPC512x_PSC_FIFO_ALARM)
> +                       keepgoing |= mpc512x_uart_int_rx_chars(port);
> +
> +               /* clear any pending interrupts */
> +               out_be32(&FIFO(port)->txisr, in_be32(&FIFO(port)->txisr));
> +
> +               tx_fifo_status = in_be32(&FIFO(port)->txsr);
> +               out_be32(&FIFO(port)->txisr, tx_fifo_status);
> +               tx_fifo_status &= in_be32(&FIFO(port)->tximr);
> +
> +               if (tx_fifo_status & MPC512x_PSC_FIFO_ALARM)
> +                       keepgoing |= mpc512x_uart_int_tx_chars(port);
> +
> +               /* Limit number of iteration */
> +               if (!(--pass))
> +                       keepgoing = 0;
> +
> +       } while (keepgoing);
> +
> +       spin_unlock(&port->lock);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +/* ======================================================================== */
> +/* Console ( if applicable )                                                */
> +/* ======================================================================== */
> +
> +#ifdef CONFIG_SERIAL_MPC512x_CONSOLE
> +
> +static void __init
> +mpc512x_console_get_options(struct uart_port *port,
> +                           int *baud, int *parity, int *bits, int *flow)
> +{
> +       struct mpc52xx_psc __iomem *psc = PSC(port);
> +       unsigned char mr1;
> +
> +       pr_debug("mpc512x_console_get_options(port=%p)\n", port);
> +
> +       /* Read the mode registers */
> +       out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
> +       mr1 = in_8(&psc->mode);
> +
> +       /* CT{U,L}R are write-only ! */
> +       *baud = 115200;
> +       /* Parse them */
> +       switch (mr1 & MPC52xx_PSC_MODE_BITS_MASK) {
> +       case MPC52xx_PSC_MODE_5_BITS:
> +               *bits = 5;
> +               break;
> +       case MPC52xx_PSC_MODE_6_BITS:
> +               *bits = 6;
> +               break;
> +       case MPC52xx_PSC_MODE_7_BITS:
> +               *bits = 7;
> +               break;
> +       case MPC52xx_PSC_MODE_8_BITS:
> +       default:
> +               *bits = 8;
> +       }
> +
> +       if (mr1 & MPC52xx_PSC_MODE_PARNONE)
> +               *parity = 'n';
> +       else
> +               *parity = mr1 & MPC52xx_PSC_MODE_PARODD ? 'o' : 'e';
> +}
> +
> +static void
> +mpc512x_console_write(struct console *co, const char *s, unsigned int count)
> +{
> +       struct uart_port *port = &mpc512x_uart_ports[co->index];
> +       unsigned int i, j;
> +       unsigned long rx_fifo_imr, tx_fifo_imr;
> +
> +       /* Disable interrupts */
> +       tx_fifo_imr = in_be32(&FIFO(port)->tximr);
> +       out_be32(&FIFO(port)->tximr, 0);
> +       rx_fifo_imr = in_be32(&FIFO(port)->rximr);
> +       out_be32(&FIFO(port)->rximr, 0);
> +
> +       /* Wait the TX buffer to be empty */
> +       j = 5000000;            /* Maximum wait */
> +       while (!(in_be32(&FIFO(port)->txsr) & MPC512x_PSC_FIFO_EMPTY) && --j)
> +               udelay(1);
> +       /* Write all the chars */
> +       for (i = 0; i < count; i++, s++) {
> +               /* Line return handling */
> +               if (*s == '\n')
> +                       out_8(&FIFO(port)->txdata_8, '\r');
> +
> +               /* Send the char */
> +               out_8(&FIFO(port)->txdata_8, *s);
> +
> +               /* Wait the TX buffer to be empty */
> +               j = 20000;      /* Maximum wait */
> +               while (!(in_be32(&FIFO(port)->txsr) & MPC512x_PSC_FIFO_EMPTY)
> +                      && --j)
> +                       udelay(1);
> +       }
> +
> +       /* Restore interrupt state */
> +       out_be32(&FIFO(port)->tximr, tx_fifo_imr);
> +       out_be32(&FIFO(port)->rximr, rx_fifo_imr);
> +}
> +
> +static int __init mpc512x_console_setup(struct console *co, char *options)
> +{
> +       struct uart_port *port = &mpc512x_uart_ports[co->index];
> +       struct device_node *np = mpc512x_uart_nodes[co->index];
> +       struct resource res;
> +
> +       int baud = 115200;
> +       int bits = 8;
> +       int parity = 'n';
> +       int flow = 'n';
> +
> +       pr_debug("mpc512x_console_setup co=%p, co->index=%i, options=%s\n",
> +                co, co->index, options);
> +
> +       if ((co->index < 0) || (co->index > MPC52xx_PSC_MAXNUM)) {
> +               pr_debug("PSC%x out of range\n", co->index);
> +               return -EINVAL;
> +       }
> +
> +       if (!np) {
> +               pr_debug("PSC%x not found in device tree\n", co->index);
> +               return -EINVAL;
> +       }
> +
> +       pr_debug("Console on ttyPSC%x is %s\n",
> +                co->index, mpc512x_uart_nodes[co->index]->full_name);
> +
> +       /* Fetch register locations */
> +       if (of_address_to_resource(np, 0, &res)) {
> +               pr_debug("Could not get resources for PSC%x\n", co->index);
> +               return -EINVAL;
> +       }
> +
> +       /* Basic port init. Needed since we use some uart_??? func before
> +        * real init for early access */
> +       spin_lock_init(&port->lock);
> +       port->uartclk = getuartclk(np);
> +       port->ops = &mpc512x_uart_ops;
> +       port->mapbase = res.start;
> +       port->membase = ioremap(res.start, sizeof(struct mpc52xx_psc));
> +       port->irq = irq_of_parse_and_map(np, 0);
> +
> +       if (port->membase == NULL)
> +               return -EINVAL;
> +
> +       pr_debug("mpc52xx-psc uart at %p, mapped to %p, irq=%x, freq=%i\n",
> +                (void *)port->mapbase, port->membase, port->irq,
> +                port->uartclk);
> +
> +       /* Setup the port parameters accoding to options */
> +       if (options)
> +               uart_parse_options(options, &baud, &parity, &bits, &flow);
> +       else
> +               mpc512x_console_get_options(port, &baud, &parity, &bits, &flow);
> +
> +       pr_debug("Setting console parameters: %i %i%c1 flow=%c\n",
> +                baud, bits, parity, flow);
> +
> +       return uart_set_options(port, co, baud, parity, bits, flow);
> +}
> +
> +static struct uart_driver mpc512x_uart_driver;
> +
> +static struct console mpc512x_console = {
> +       .name = "ttyPSC",
> +       .write = mpc512x_console_write,
> +       .device = uart_console_device,
> +       .setup = mpc512x_console_setup,
> +       .flags = CON_PRINTBUFFER,
> +       .index = -1,
> +       .data = &mpc512x_uart_driver,
> +};
> +
> +static int __init mpc512x_console_init(void)
> +{
> +       mpc512x_uart_of_enumerate();
> +       register_console(&mpc512x_console);
> +       return 0;
> +}
> +
> +console_initcall(mpc512x_console_init);
> +
> +#define MPC52xx_PSC_CONSOLE &mpc512x_console
> +#else
> +#define MPC52xx_PSC_CONSOLE NULL
> +#endif
> +
> +/* ======================================================================== */
> +/* UART Driver                                                              */
> +/* ======================================================================== */
> +
> +static struct uart_driver mpc512x_uart_driver = {
> +       .owner = THIS_MODULE,
> +       .driver_name = "mpc512x_psc_uart",
> +       .dev_name = "ttyPSC",
> +       .major = SERIAL_PSC_MAJOR,
> +       .minor = SERIAL_PSC_MINOR,
> +       .nr = MPC52xx_PSC_MAXNUM,
> +       .cons = MPC52xx_PSC_CONSOLE,
> +};
> +
> +/* ======================================================================== */
> +/* OF Platform Driver                                                       */
> +/* ======================================================================== */
> +
> +static int __devinit
> +mpc512x_uart_of_probe(struct of_device *op, const struct of_device_id *match)
> +{
> +       int idx = -1;
> +       struct uart_port *port = NULL;
> +       struct resource res;
> +       int ret;
> +
> +       dev_dbg(&op->dev, "mpc512x_uart_probe(op=%p, match=%p)\n", op, match);
> +
> +       /* Check validity & presence */
> +       for (idx = 0; idx < MPC52xx_PSC_MAXNUM; idx++)
> +               if (mpc512x_uart_nodes[idx] == op->node)
> +                       break;
> +       if (idx >= MPC52xx_PSC_MAXNUM)
> +               return -EINVAL;
> +       pr_debug("Found %s assigned to ttyPSC%x\n",
> +                mpc512x_uart_nodes[idx]->full_name, idx);
> +
> +       /* Init the port structure */
> +       port = &mpc512x_uart_ports[idx];
> +
> +       spin_lock_init(&port->lock);
> +       port->uartclk = getuartclk(op->node);
> +       port->fifosize = 512;
> +       port->iotype = UPIO_MEM;
> +       port->flags = UPF_BOOT_AUTOCONF |
> +           (uart_console(port) ? 0 : UPF_IOREMAP);
> +       port->line = idx;
> +       port->ops = &mpc512x_uart_ops;
> +       port->dev = &op->dev;
> +
> +       /* Search for IRQ and mapbase */
> +       if (of_address_to_resource(op->node, 0, &res))
> +               return -EINVAL;
> +
> +       port->mapbase = res.start;
> +       port->irq = irq_of_parse_and_map(op->node, 0);
> +
> +       dev_dbg(&op->dev, "mpc52xx-psc uart at %p, irq=%x, freq=%i\n",
> +               (void *)port->mapbase, port->irq, port->uartclk);
> +
> +       if ((port->irq == NO_IRQ) || !port->mapbase) {
> +               printk(KERN_ERR "Could not allocate resources for PSC\n");
> +               return -EINVAL;
> +       }
> +
> +       /* Add the port to the uart sub-system */
> +       ret = uart_add_one_port(&mpc512x_uart_driver, port);
> +       if (!ret)
> +               dev_set_drvdata(&op->dev, (void *)port);
> +
> +       return ret;
> +}
> +
> +static int mpc512x_uart_of_remove(struct of_device *op)
> +{
> +       struct uart_port *port = dev_get_drvdata(&op->dev);
> +       dev_set_drvdata(&op->dev, NULL);
> +
> +       if (port) {
> +               uart_remove_one_port(&mpc512x_uart_driver, port);
> +               irq_dispose_mapping(port->irq);
> +       }
> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mpc512x_uart_of_suspend(struct of_device *op, pm_message_t state)
> +{
> +       struct uart_port *port = (struct uart_port *)dev_get_drvdata(&op->dev);
> +
> +       if (port)
> +               uart_suspend_port(&mpc512x_uart_driver, port);
> +
> +       return 0;
> +}
> +
> +static int mpc512x_uart_of_resume(struct of_device *op)
> +{
> +       struct uart_port *port = (struct uart_port *)dev_get_drvdata(&op->dev);
> +
> +       if (port)
> +               uart_resume_port(&mpc512x_uart_driver, port);
> +
> +       return 0;
> +}
> +#endif
> +
> +static void mpc512x_uart_of_assign(struct device_node *np, int idx)
> +{
> +       int free_idx = -1;
> +       int i;
> +
> +       /* Find the first free node */
> +       for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
> +               if (mpc512x_uart_nodes[i] == NULL) {
> +                       free_idx = i;
> +                       break;
> +               }
> +       }
> +
> +       if ((idx < 0) || (idx >= MPC52xx_PSC_MAXNUM))
> +               idx = free_idx;
> +
> +       if (idx < 0)
> +               return;         /* No free slot; abort */
> +
> +       /* If the slot is already occupied, then swap slots */
> +       if (mpc512x_uart_nodes[idx] && (free_idx != -1))
> +               mpc512x_uart_nodes[free_idx] = mpc512x_uart_nodes[idx];
> +       mpc512x_uart_nodes[idx] = np;
> +}
> +
> +static void mpc512x_uart_of_enumerate(void)
> +{
> +       static int enum_done;
> +       struct device_node *np;
> +       const unsigned int *devno;
> +       int i;
> +
> +       if (enum_done)
> +               return;
> +
> +       for_each_node_by_type(np, "serial") {
> +               if (!of_match_node(mpc512x_uart_of_match, np))
> +                       continue;
> +
> +               /* Is a particular device number requested? */
> +               devno = of_get_property(np, "port-number", NULL);
> +               mpc512x_uart_of_assign(of_node_get(np), devno ? *devno : -1);
> +       }
> +
> +       enum_done = 1;
> +
> +       for (i = 0; i < MPC52xx_PSC_MAXNUM; i++) {
> +               if (mpc512x_uart_nodes[i])
> +                       pr_debug("%s assigned to ttyPSC%x\n",
> +                                mpc512x_uart_nodes[i]->full_name, i);
> +       }
> +}
> +
> +MODULE_DEVICE_TABLE(of, mpc512x_uart_of_match);
> +
> +static struct of_platform_driver mpc512x_uart_of_driver = {
> +       .owner = THIS_MODULE,
> +       .name = "mpc52xx-psc-uart",
> +       .match_table = mpc512x_uart_of_match,
> +       .probe = mpc512x_uart_of_probe,
> +       .remove = mpc512x_uart_of_remove,
> +#ifdef CONFIG_PM
> +       .suspend = mpc512x_uart_of_suspend,
> +       .resume = mpc512x_uart_of_resume,
> +#endif
> +       .driver = {
> +                  .name = "mpc52xx-psc-uart",
> +                  },
> +};
> +
> +/* ======================================================================== */
> +/* Module                                                                   */
> +/* ======================================================================== */
> +
> +static int __init mpc512x_uart_init(void)
> +{
> +       int ret;
> +
> +       printk(KERN_INFO "Serial: MPC512x PSC UART driver\n");
> +
> +       ret = uart_register_driver(&mpc512x_uart_driver);
> +       if (ret) {
> +               printk(KERN_ERR "%s: uart_register_driver failed (%i)\n",
> +                      __FILE__, ret);
> +               return ret;
> +       }
> +
> +       mpc512x_uart_of_enumerate();
> +
> +       ret = of_register_platform_driver(&mpc512x_uart_of_driver);
> +       if (ret) {
> +               printk(KERN_ERR "%s: of_register_platform_driver failed (%i)\n",
> +                      __FILE__, ret);
> +               uart_unregister_driver(&mpc512x_uart_driver);
> +               return ret;
> +       }
> +       return 0;
> +}
> +
> +static void __exit mpc512x_uart_exit(void)
> +{
> +       of_unregister_platform_driver(&mpc512x_uart_of_driver);
> +       uart_unregister_driver(&mpc512x_uart_driver);
> +}
> +
> +module_init(mpc512x_uart_init);
> +module_exit(mpc512x_uart_exit);
> +
> +MODULE_AUTHOR("John Rigby <jrigby@freescale.com>");
> +MODULE_DESCRIPTION("Freescale MPC512x PSC UART");
> +MODULE_LICENSE("GPL");
> diff --git a/include/asm-powerpc/mpc52xx_psc.h b/include/asm-powerpc/mpc52xx_psc.h
> index bea42b9..6841868 100644
> --- a/include/asm-powerpc/mpc52xx_psc.h
> +++ b/include/asm-powerpc/mpc52xx_psc.h
> @@ -190,5 +190,52 @@ struct mpc52xx_psc_fifo {
>         u16             tflwfptr;       /* PSC + 0x9e */
>  };
>
> +#define MPC512x_PSC_FIFO_RESET_SLICE   0x80
> +#define MPC512x_PSC_FIFO_ENABLE_SLICE  0x01
> +
> +#define MPC512x_PSC_FIFO_EMPTY         0x1
> +#define MPC512x_PSC_FIFO_FULL          0x2
> +#define MPC512x_PSC_FIFO_ALARM         0x4
> +#define MPC512x_PSC_FIFO_URERR         0x8
> +#define MPC512x_PSC_FIFO_ORERR         0x01
> +#define MPC512x_PSC_FIFO_MEMERROR      0x02
> +
> +struct mpc512x_psc_fifo {
> +       u32             reserved1[10];
> +       u32             txcmd;          /* PSC + 0x80 */
> +       u32             txalarm;        /* PSC + 0x84 */
> +       u32             txsr;           /* PSC + 0x88 */
> +       u32             txisr;          /* PSC + 0x8c */
> +       u32             tximr;          /* PSC + 0x90 */
> +       u32             txcnt;          /* PSC + 0x94 */
> +       u32             txptr;          /* PSC + 0x98 */
> +       u32             txsz;           /* PSC + 0x9c */
> +       u32             reserved2[7];
> +       union {
> +               u8      txdata_8;
> +               u16     txdata_16;
> +               u32     txdata_32;
> +       } txdata;                       /* PSC + 0xbc */
> +#define txdata_8 txdata.txdata_8
> +#define txdata_16 txdata.txdata_16
> +#define txdata_32 txdata.txdata_32
> +       u32             rxcmd;          /* PSC + 0xc0 */
> +       u32             rxalarm;        /* PSC + 0xc4 */
> +       u32             rxsr;           /* PSC + 0xc8 */
> +       u32             rxisr;          /* PSC + 0xcc */
> +       u32             rximr;          /* PSC + 0xd0 */
> +       u32             rxcnt;          /* PSC + 0xd4 */
> +       u32             rxptr;          /* PSC + 0xd8 */
> +       u32             rxsz;           /* PSC + 0xdc */
> +       u32             reserved3[7];
> +       union {
> +               u8      rxdata_8;
> +               u16     rxdata_16;
> +               u32     rxdata_32;
> +       } rxdata;                       /* PSC + 0xfc */
> +#define rxdata_8 rxdata.rxdata_8
> +#define rxdata_16 rxdata.rxdata_16
> +#define rxdata_32 rxdata.rxdata_32
> +};
>
>  #endif  /* __ASM_MPC52xx_PSC_H__ */
> --
> 1.5.3.5.726.g41a7a
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
