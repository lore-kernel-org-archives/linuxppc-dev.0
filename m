Date: Mon, 24 Feb 2003 20:50:36 +0100
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: UART lite driver?
Message-ID: <20030224195035.GA2803@mind.be>
References: <C08678384BE7D311B4D70004ACA3710511194713@amer22.avnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="opJtzjQTFsWo+cga"
In-Reply-To: <C08678384BE7D311B4D70004ACA3710511194713@amer22.avnet.com>
From: p2@mind.be (Peter 'p2' De Schrijver)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi John,

>
> Hello,
>
> Does anyone have a UART lite driver for Xilinx Virtex-II Pro?
> I've got a recent Denx tree (about 2 weeks ago) which does include
> support for 16550 UART, but unfortunately I don't have a license
> for that peripheral.
>

I recently made a driver for the UART lite. I didn't test it fully yet,
but basic functionality seems ok. I didn't find the time to make a
proper patch for it yet, so you will have to integrate it yourself into
the kernel tree.

Comments welcome & happy hacking,

Peter.

--opJtzjQTFsWo+cga
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="xilinx_uartlite.c"

/*
 * xilinx_uartlite.c: Driver for the Xilinx UART lite
 *
 * Copyright 2003 Mind NV
 *
 * http://www.mind.be/
 *
 * Author : Peter De Schrijver (p2@mind.be)
 *
 * Based on drivers/char/serial_amba.c
 *
 * This software may be used and distributed according to the terms of
 * the GNU General Public License (GPL) version 2, incorporated herein by
 * reference. Drivers based on or derived from this code fall under the GPL
 * and must retain the authorship, copyright and this license notice. This
 * file is not a complete program and may only be used when the entire
 * operating system is licensed under the GPL.
 *
 */
#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/interrupt.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/ptrace.h>
#include <linux/ioport.h>
#include <linux/mm.h>
#include <linux/slab.h>
#include <linux/init.h>
#include <linux/circ_buf.h>
#include <linux/serial.h>
#include <linux/console.h>
#include <linux/sysrq.h>

#include <asm/system.h>
#include <asm/io.h>
#include <asm/irq.h>
#include <asm/uaccess.h>
#include <asm/bitops.h>

#define SERIAL_UARTLITE_NAME	"ttyUL"
#define SERIAL_UARTLITE_MAJOR	204
#define SERIAL_UARTLITE_MINOR	18
#define SERIAL_UARTLITE_NR		2

#define CALLOUT_UARTLITE_NAME	"cuaUL"
#define CALLOUT_UARTLITE_MAJOR	205
#define CALLOUT_UARTLITE_MINOR	18
#define CALLOUT_UARTLITE_NR		SERIAL_UARTLITE_NR

#define HIGH_BITS_OFFSET    ((sizeof(long)-sizeof(int))*8)

#define UARTLITE_XMIT_SIZE		1024
#define WAKEUP_CHARS        256
#define UARTLITE_ISR_PASS_LIMIT 256

#define EVT_WRITE_WAKEUP    0

#define UART_RFIFO	0
#define UART_WFIFO	4

#define UART_SR		8
#define UART_RX_FIFO_VALID_DATA (1<<0)
#define UART_TX_FIFO_EMPTY (1<<2)
#define UART_OVERRUN_ERROR (1<<5)
#define UART_FRAME_ERROR (1<<6)
#define UART_PAR_ERROR (1<<7)
#define UART_ERROR (UART_OVERRUN_ERROR | UART_FRAME_ERROR | UART_PAR_ERROR)
#define UART_BUSY UART_TX_FIFO_EMPTY

#define UART_CR		0xc
#define UART_ENABLE_INTR	(1<<4)

#define UART_GET_CR(p) (p->cr)
#define UART_GET_SR(p) ((*(volatile unsigned int *)(p->uart_base+UART_SR)))
#define UART_PUT_CR(p,x) (*(volatile unsigned int *)(p->uart_base+UART_CR)=p->cr=x)
#define UART_PUT_CHAR(p,x) ((*(volatile unsigned int *)(p->uart_base+UART_WFIFO))=x)
#define UART_GET_CHAR(p) (*(volatile unsigned int *)(p->uart_base+UART_RFIFO))

#define UART_RX_DATA(x) (x & UART_RX_FIFO_VALID_DATA)

static struct tty_driver uartlite_driver, uartlitecallout_driver;
static int uartlite_refcount;
static struct tty_struct *uartlite_table[SERIAL_UARTLITE_NR];
static struct termios *uartlite_termios[SERIAL_UARTLITE_NR];
static struct termios *uartlite_termios_locked[SERIAL_UARTLITE_NR];

#if defined(CONFIG_SERIAL_UARTLITE_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
#define SUPPORT_SYSRQ
#endif

static u_char *tmp_buf;
static DECLARE_MUTEX(tmp_buf_sem);

struct uartlite_icount {
	__u32	rx;
	__u32	tx;
	__u32	frame;
	__u32	overrun;
	__u32	parity;
	__u32	brk;
	__u32	buf_overrun;
};

struct uartlite_port {
	unsigned int 	uart_base;
	unsigned int    irq;
	unsigned int	uartclk;
	unsigned int 	fifosize;
	unsigned int 	tiocm_support;
	unsigned int 	cr;
};

struct uartlite_state {
	struct uartlite_icount	icount;
	unsigned int	line;
	unsigned int	close_delay;
	unsigned int	closing_wait;
	unsigned int	flags;
	struct termios	normal_termios;
	struct termios	callout_termios;

	int	count;
	struct uartlite_info *info;
};

struct uartlite_info {
	struct uartlite_port	*port;
	struct uartlite_state	*state;
	struct tty_struct		*tty;
	unsigned char			x_char;
	unsigned char			old_status;
	unsigned char			read_status_mask;
	unsigned char			ignore_status_mask;
	unsigned int 			xmit_busy;
	struct circ_buf			xmit;
	unsigned int			flags;
#ifdef SUPPORT_SYSRQ
	unsigned long			sysrq;
#endif

	unsigned int			event;
	unsigned int 			timeout;
	int 					blocked_open;
	pid_t					session;
	pid_t					pgrp;

	struct tasklet_struct	tlet;

	wait_queue_head_t   open_wait;
	wait_queue_head_t   close_wait;
	wait_queue_head_t   delta_msr_wait;

};

#ifdef CONFIG_SERIAL_UARTLITE_CONSOLE
static struct condole uartlite_cons;
#endif
static void uartlite_wait_until_sent(struct tty_struct *tty, int timeout);

static struct uartlite_port uartlite_ports[SERIAL_UARTLITE_NR] = {
	{
		uart_base: 	0xf0000100,
		irq:		0,
	},
	{
		uart_base: 	0,
		irq:		0,
	}
};

static struct uartlite_state uartlite_state[SERIAL_UARTLITE_NR];

static void uartlite_enable_rx_interrupt(struct uartlite_info *info) {

	unsigned int cr;

	cr=UART_GET_CR(info->port);
	cr|=UART_ENABLE_INTR;
	UART_PUT_CR(info->port,cr);

}


static void uartlite_disable_rx_interrupt(struct uartlite_info *info) {

	unsigned int cr;

	cr=UART_GET_CR(info->port);
	cr|=UART_ENABLE_INTR;
	UART_PUT_CR(info->port,cr);

}

static void uartlite_stop(struct tty_struct *tty)
{
	struct uartlite_info *info=tty->driver_data;

	UART_PUT_CR(info->port,0);
	info->xmit_busy=0;

}

static void uartlite_start(struct tty_struct *tty)
{
	struct uartlite_info *info=tty->driver_data;
	info->xmit_busy=0;
}

/*
 * This routine is used by the interrupt handler to schedule
 * processing in the software interrupt portion of the driver.
 */
static void uartlite_event(struct uartlite_info *info, int event)
{
    info->event |= 1 << event;
    tasklet_schedule(&info->tlet);
}

static void
#ifdef SUPPORT_SYSRQ
uartlite_rx_chars(struct uartlite_info *info, struct pt_regs *regs)
#else
uartlite_rx_chars(struct uartlite_info *info)
#endif
{
	struct tty_struct *tty = info->tty;
	unsigned int status, ch, rsr, flg, ignored = 0;
	struct uartlite_port *port = info->port;
	struct uartlite_icount *icount=&info->state->icount;

	status=UART_GET_SR(port);
	while(UART_RX_DATA(status)) {
		ch=UART_GET_CHAR(port);

		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
			goto ignore_char;

		icount->rx++;

		flg = TTY_NORMAL;

		if(status & UART_ERROR)
			goto handle_error;

#ifdef SUPPORT_SYSRQ
        if (info->sysrq) {
			if (ch && time_before(jiffies, info->sysrq)) {
				handle_sysrq(ch, regs, NULL, NULL);
				info->sysrq = 0;
				goto ignore_char;
			}
			info->sysrq = 0;
		}
#endif
		error_return:
			*tty->flip.flag_buf_ptr++ = flg;
			*tty->flip.char_buf_ptr++ = ch;
			tty->flip.count++;
		ignore_char:
			status=UART_GET_SR(port);
	}
out:
	tty_flip_buffer_push(tty);
	return ;

handle_error:
	if(rsr & UART_PAR_ERROR)
		icount->parity++;
	else if(rsr & UART_FRAME_ERROR)
		icount->frame++;

	if(rsr & UART_OVERRUN_ERROR)
		icount->overrun++;

	if (rsr & info->ignore_status_mask) {
		if (++ignored > 100)
			goto out;
		goto ignore_char;
	}

	rsr &= info->read_status_mask;

	if(rsr & UART_PAR_ERROR)
		flg=TTY_PARITY;
	else if(rsr & UART_FRAME_ERROR)
		flg=TTY_FRAME;

	if(rsr & UART_OVERRUN_ERROR) {
		*tty->flip.flag_buf_ptr++ = flg;
		*tty->flip.char_buf_ptr++ = ch;
		tty->flip.count++;
		if (tty->flip.count >= TTY_FLIPBUF_SIZE)
			goto ignore_char;
		ch=0;
		flg=TTY_OVERRUN;
	}
#ifdef SUPPORT_SYSRQ
	info->sysrq = 0;
#endif
	goto error_return;
}

static void uartlite_tx_chars(struct uartlite_info *info)
{
	struct uartlite_port *port=info->port;
	int count;

	if(info->x_char) {
		UART_PUT_CHAR(port, info->x_char);
		info->state->icount.tx++;
		info->x_char = 0;
		return ;
	}
	if (info->xmit.head == info->xmit.tail
		|| info->tty->stopped
		|| info->tty->hw_stopped) {
		info->xmit_busy=0;
		return ;
	}

	count=port->fifosize;

	do {
		UART_PUT_CHAR(port, info->xmit.buf[info->xmit.tail]);
		info->xmit.tail = (info->xmit.tail + 1) & (UARTLITE_XMIT_SIZE - 1);
		info->state->icount.tx++;
		if (info->xmit.head == info->xmit.tail)
			break;
	} while (--count > 0);

	if (CIRC_CNT(info->xmit.head,
				 info->xmit.tail,
				 UARTLITE_XMIT_SIZE) < WAKEUP_CHARS)
			uartlite_event(info, EVT_WRITE_WAKEUP);

}


static void uartlite_int(int irq, void *dev_id, struct pt_regs *regs)
{
	struct uartlite_info *info=dev_id;
	unsigned int status, pass_counter=0;

	status=UART_GET_SR(info->port);
	do {
		if(status & UART_RX_FIFO_VALID_DATA)
#ifdef SUPPORT_SYSRQ
			uartlite_rx_chars(info, regs);
#else
			uartlite_rx_chars(info);
#endif
		if(status & UART_TX_FIFO_EMPTY)
			uartlite_tx_chars(info);
		if(pass_counter++ > UARTLITE_ISR_PASS_LIMIT)
			break;

		status=UART_GET_SR(info->port);
	} while(status & (UART_TX_FIFO_EMPTY | UART_RX_FIFO_VALID_DATA));
}

static void uartlite_tasklet_action(unsigned long data)
{
	struct uartlite_info *info=(struct uartlite_info *)data;
	struct tty_struct *tty;

	tty=info->tty;

	if(!tty || !test_and_clear_bit(EVT_WRITE_WAKEUP, &info->event))
		return ;

	if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
		tty->ldisc.write_wakeup)
		(tty->ldisc.write_wakeup)(tty);
	wake_up_interruptible(&tty->write_wait);
}

static int uartlite_startup(struct uartlite_info *info)
{
	unsigned long flags;
	unsigned long page;
	int retval=0;

	page = get_zeroed_page(GFP_KERNEL);
	if(!page)
		return -ENOMEM;

	save_flags(flags); cli();

	if (info->flags & ASYNC_INITIALIZED) {
		free_page(page);
		goto errout;
	}

	if (info->xmit.buf)
		free_page(page);
	else
		info->xmit.buf = (unsigned char *) page;

	/*
	 * Allocate IRQ
	 */
	retval = request_irq(info->port->irq, uartlite_int, 0, "uartlite", info);
	if (retval) {
		if (capable(CAP_SYS_ADMIN)) {
			if (info->tty)
				set_bit(TTY_IO_ERROR, &info->tty->flags);
			retval=0;
		}
		goto errout;
	}

	uartlite_enable_rx_interrupt(info);

	if(info->tty)
		clear_bit(TTY_IO_ERROR, &info->tty->flags);
    info->xmit.head = info->xmit.tail = 0;

	info->flags |= ASYNC_INITIALIZED;
    restore_flags(flags);
	return 0;

errout:
	restore_flags(flags);
	return retval;
}

static void uartlite_shutdown(struct uartlite_info *info)
{
	unsigned long flags;

    if (!(info->flags & ASYNC_INITIALIZED))
		return;

	save_flags(flags); cli(); /* Disable interrupts */

	free_irq(info->port->irq, info);

    if (info->xmit.buf) {
		unsigned long pg = (unsigned long) info->xmit.buf;
		info->xmit.buf = NULL;
		free_page(pg);
	}

    /*
	 *  disable all interrupts, disable the port
	 */

	UART_PUT_CR(info->port, 0);

	/* kill off our tasklet */
	tasklet_kill(&info->tlet);
	if(info->tty)
		set_bit(TTY_IO_ERROR, &info->tty->flags);

    info->flags &= ~ASYNC_INITIALIZED;
	restore_flags(flags);
}

static void uartlite_put_char(struct tty_struct *tty, u_char ch)
{
	struct uartlite_info *info= tty->driver_data;
	unsigned long flags;

	if (!tty || !info->xmit.buf)
		return ;

	save_flags(flags); cli();
	if (CIRC_SPACE(info->xmit.head, info->xmit.tail, UARTLITE_XMIT_SIZE) != 0) {
		info->xmit.buf[info->xmit.head] = ch;
		info->xmit.head = (info->xmit.head + 1) & (UARTLITE_XMIT_SIZE - 1);
	}
	restore_flags(flags);
}

static void uartlite_flush_chars(struct tty_struct *tty)
{

	struct uartlite_info *info=tty->driver_data;

    if (info->xmit.head == info->xmit.tail
        || tty->stopped
        || tty->hw_stopped
        || !info->xmit.buf)
        return;
}

static int uartlite_write(struct tty_struct *tty, int from_user,
						  const u_char * buf, int count)
{

	struct uartlite_info *info=tty->driver_data;
	unsigned long flags;
	int c,ret=0;

	if(!tty || !info->xmit.buf || !tmp_buf)
		return 0;

	save_flags(flags);
	if (from_user) {
		down(&tmp_buf_sem);
		while(1) {
			int c1;
			c=CIRC_SPACE_TO_END(info->xmit.head,
								info->xmit.tail,
								UARTLITE_XMIT_SIZE);
			if(count < c)
				c=count;
			if(c <= 0)
				break;

			c-=copy_from_user(tmp_buf, buf, c);
			if(!c) {
				if(!ret)
					ret=-EFAULT;
				break;
			}
			cli();
			c1=CIRC_SPACE_TO_END(info->xmit.head,
								 info->xmit.tail,
								 UARTLITE_XMIT_SIZE);
			if (c1 < c)
				c=c1;
			memcpy(info->xmit.buf + info->xmit.head, tmp_buf, c);
			info->xmit.head = (info->xmit.head + c) &
							  (UARTLITE_XMIT_SIZE -1);
			restore_flags(flags);
			buf+=c;
			count-=c;
			ret+=c;
		}
		up(&tmp_buf_sem);
	} else {
		cli();
		while(1) {
			c = CIRC_SPACE_TO_END(info->xmit.head,
								  info->xmit.tail,
								  UARTLITE_XMIT_SIZE);
			if(count < c)
				c=count;
			if(c<=0)
				break;
			memcpy(info->xmit.buf + info->xmit.head, buf, c);
			info->xmit.head = (info->xmit.head + c) &
							(UARTLITE_XMIT_SIZE - 1);
			buf += c;
			count -= c;
			ret += c;
		}
		restore_flags(flags);
	}
	if (info->xmit.head != info->xmit.tail
			&& !tty->stopped
			&& !tty->hw_stopped
			&& !info->xmit_busy) {
			save_flags(flags);
			cli();
	        UART_PUT_CHAR(info->port, info->xmit.buf[info->xmit.tail]);
	        info->xmit.tail = (info->xmit.tail + 1) & (UARTLITE_XMIT_SIZE - 1);
	        info->state->icount.tx++;
			info->xmit_busy=1;
			restore_flags(flags);
	}

	return ret;
}

static int uartlite_write_room(struct tty_struct *tty) {

	struct uartlite_info *info=tty->driver_data;

	return CIRC_SPACE(info->xmit.head, info->xmit.tail, UARTLITE_XMIT_SIZE);

}

static int uartlite_chars_in_buffer(struct tty_struct *tty) {

	struct uartlite_info *info=tty->driver_data;

	return CIRC_CNT(info->xmit.head, info->xmit.tail, UARTLITE_XMIT_SIZE);

}

static void uartlite_flush_buffer(struct tty_struct *tty) {

	struct uartlite_info *info=tty->driver_data;
	unsigned long flags;

	save_flags(flags); cli();
	info->xmit.head = info->xmit.tail = 0;
	restore_flags(flags);
	wake_up_interruptible(&tty->write_wait);
    if ((tty->flags & (1 << TTY_DO_WRITE_WAKEUP)) &&
		 tty->ldisc.write_wakeup)
		 (tty->ldisc.write_wakeup)(tty);
}

static void uartlite_send_xchar(struct tty_struct *tty, char ch) {

	struct uartlite_info *info = tty->driver_data;
	unsigned long flags;

	info->x_char = ch;
	if(ch && !info->xmit_busy) {
		save_flags(flags); cli();
		cli();
	    UART_PUT_CHAR(info->port, ch);
		info->xmit_busy=1;
		restore_flags(flags);
	}
}

static void uartlite_throttle(struct tty_struct *tty) {

    if (I_IXOFF(tty))
		uartlite_send_xchar(tty, STOP_CHAR(tty));
}

static void uartlite_unthrottle(struct tty_struct *tty) {

	struct uartlite_info *info = tty->driver_data;

	if (I_IXOFF(tty)) {
		if (info->x_char)
			info->x_char = 0;
		else
			uartlite_send_xchar(tty, STOP_CHAR(tty));
	}
}

static int get_serial_info(struct uartlite_info *info,
						   struct serial_struct *retinfo) {

	struct uartlite_state *state=info->state;
	struct uartlite_port *port=info->port;
	struct serial_struct tmp;

	memset(&tmp, 0, sizeof(tmp));
    tmp.type       = 0;
    tmp.line       = state->line;
    tmp.port       = port->uart_base;
    if (HIGH_BITS_OFFSET)
        tmp.port_high = port->uart_base >> HIGH_BITS_OFFSET;
    tmp.irq        = port->irq;
    tmp.flags      = 0;
    tmp.xmit_fifo_size = port->fifosize;
    tmp.close_delay    = state->close_delay;
    tmp.closing_wait   = state->closing_wait;

    if (copy_to_user(retinfo, &tmp, sizeof(*retinfo)))
        return -EFAULT;
    return 0;
}

static int set_serial_info(struct uartlite_info *info,
			               struct serial_struct *newinfo) {

    struct serial_struct new_serial;
	struct uartlite_state *state, old_state;
	struct uartlite_port *port;
    unsigned long new_port;
    unsigned int i, change_irq, change_port;
    int retval = 0;

	if (copy_from_user(&new_serial, newinfo, sizeof(new_serial)))
		return -EFAULT;

    state = info->state;
    old_state = *state;
    port = info->port;

	new_port = new_serial.port;
    if (HIGH_BITS_OFFSET)
		new_port += (unsigned long) new_serial.port_high << HIGH_BITS_OFFSET;

	change_irq  = new_serial.irq != port->irq;
	change_port = new_port != port->uart_base;

	if (!capable(CAP_SYS_ADMIN)) {
		if (change_irq || change_port ||
			(new_serial.close_delay != state->close_delay) ||
			(new_serial.xmit_fifo_size != port->fifosize) ||
			((new_serial.flags & ~ASYNC_USR_MASK) !=
			 (state->flags & ~ASYNC_USR_MASK)))
			return -EPERM;
		state->flags = ((state->flags & ~ASYNC_USR_MASK) |
					(new_serial.flags & ASYNC_USR_MASK));
		info->flags = ((info->flags & ~ASYNC_USR_MASK) |
					(new_serial.flags & ASYNC_USR_MASK));
		goto check_and_exit;
	}

    if ((new_serial.irq >= NR_IRQS) || (new_serial.irq < 0))
		return -EINVAL;

    if (new_serial.type && change_port) {
        for (i = 0; i < SERIAL_UARTLITE_NR; i++)
            if ((port != uartlite_ports + i) &&
                uartlite_ports[i].uart_base != new_port)
                return -EADDRINUSE;
    }

	if ((change_port || change_irq) && (state->count > 1))
		return -EBUSY;

    state->flags = ((state->flags & ~ASYNC_FLAGS) |
		            (new_serial.flags & ASYNC_FLAGS));
    info->flags = ((state->flags & ~ASYNC_INTERNAL_FLAGS) |
	               (info->flags & ASYNC_INTERNAL_FLAGS));
	state->close_delay = new_serial.close_delay * HZ / 100;
    state->closing_wait = new_serial.closing_wait * HZ / 100;
    info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
    port->fifosize = new_serial.xmit_fifo_size;

	if (change_port || change_irq) {
		uartlite_shutdown(info);
        port->irq = new_serial.irq;
        port->uart_base = new_port;
    }

check_and_exit:
    if (!port->uart_base)
        return 0;
	if ((info->flags & ASYNC_INITIALIZED)) {
		if ((old_state.flags & ASYNC_SPD_MASK) !=
			(state->flags & ASYNC_SPD_MASK)) {
				return 0;
		}
	}
	else
        retval = uartlite_startup(info);
	return retval;
}

static int get_lsr_info(struct uartlite_info *info, unsigned int *value) {

	unsigned int result, status;
    unsigned long flags;

	save_flags(flags); cli();
	status=UART_GET_SR(info->port);
	restore_flags(flags);
	result=status & UART_BUSY ? TIOCSER_TEMT : 0;

	if (info->x_char ||
		((CIRC_CNT(info->xmit.head, info->xmit.tail,
				 UARTLITE_XMIT_SIZE) > 0) &&
		 !info->tty->stopped && !info->tty->hw_stopped))
		result &= TIOCSER_TEMT;

    return put_user(result, value);
}

static int get_modem_info(struct uartlite_info *info, unsigned int *value) {

	return put_user(0, value);

}

static int set_modem_info(struct uartlite_info *info, unsigned int cmd,
				              unsigned int *value) {

	return 0;
}

static void uartlite_break_ctl(struct tty_struct *tty, int break_state) {

	return ;

}

static int uartlite_ioctl(struct tty_struct *tty, struct file *file,
						  unsigned int cmd, unsigned long arg)
{
	struct uartlite_info *info = tty->driver_data;
	struct uartlite_icount cnow;
    struct serial_icounter_struct icount;
	unsigned long flags;


    if ((cmd != TIOCGSERIAL) && (cmd != TIOCSSERIAL) &&
        (cmd != TIOCSERCONFIG) && (cmd != TIOCSERGSTRUCT) &&
        (cmd != TIOCMIWAIT) && (cmd != TIOCGICOUNT)) {
        if (tty->flags & (1 << TTY_IO_ERROR))
            return -EIO;
    }

    switch (cmd) {
		case TIOCMGET:
			return get_modem_info(info, (unsigned int *)arg);
        case TIOCMBIS:
        case TIOCMBIC:
        case TIOCMSET:
            return set_modem_info(info, cmd, (unsigned int *)arg);
        case TIOCGSERIAL:
            return get_serial_info(info,
	                           (struct serial_struct *)arg);
		case TIOCSSERIAL:
			return set_serial_info(info, (struct serial_struct *)arg);
		case TIOCSERGETLSR: /* Get line status register */
			return get_lsr_info(info, (unsigned int *)arg);
		case TIOCMIWAIT:
			return 0;

		case TIOCGICOUNT:
			save_flags(flags); cli();
			cnow = info->state->icount;
			restore_flags(flags);
			icount.cts=icount.dsr=icount.rng=icount.dcd=icount.brk=0;
			icount.rx  = cnow.rx;
			icount.tx  = cnow.tx;
			icount.frame = cnow.frame;
			icount.overrun = cnow.overrun;
			icount.parity = cnow.parity;
			icount.buf_overrun = cnow.buf_overrun;

			return copy_to_user((void *)arg, &icount, sizeof(icount))
						? -EFAULT : 0;

		default:
			return -ENOIOCTLCMD;
	}
	return 0;
}

static void uartlite_set_termios(struct tty_struct *tty, struct termios *old_termios) {

	return ;

}

static void uartlite_close(struct tty_struct *tty, struct file *filp) {

	struct uartlite_info *info=tty->driver_data;
	struct uartlite_state *state;
	unsigned long flags;

	if (!info)
		return;

	state=info->state;

	save_flags(flags); cli();

	if (tty_hung_up_p(filp)) {
		MOD_DEC_USE_COUNT;
		restore_flags(flags);
		return ;
	}

	if ((tty->count == 1) && (state->count != 1)) {
        printk("uartlite_close: bad serial port count; tty->count is 1, "
			   "state->count is %d\n", state->count);
		state->count=1;
	}

	if (--state->count < 0) {
		printk("rs_close: bad serial port count for %s%d: %d\n",
				tty->driver.name, info->state->line, state->count);
		state->count = 0;
	}

	info->flags |= ASYNC_CLOSING;
	restore_flags(flags);

    if (info->flags & ASYNC_NORMAL_ACTIVE)
        info->state->normal_termios = *tty->termios;
    if (info->flags & ASYNC_CALLOUT_ACTIVE)
        info->state->callout_termios = *tty->termios;

	tty->closing = 1;
	if (info->state->closing_wait != ASYNC_CLOSING_WAIT_NONE)
		tty_wait_until_sent(tty, info->state->closing_wait);

    if (info->flags & ASYNC_INITIALIZED) {
        uartlite_disable_rx_interrupt(info);
        uartlite_wait_until_sent(tty, info->timeout);
    }

	uartlite_shutdown(info);
    if (tty->driver.flush_buffer)
        tty->driver.flush_buffer(tty);
    if (tty->ldisc.flush_buffer)
       tty->ldisc.flush_buffer(tty);
    tty->closing = 0;
    info->event = 0;
    info->tty = NULL;
    if (info->blocked_open) {
        if (info->state->close_delay) {
            set_current_state(TASK_INTERRUPTIBLE);
			schedule_timeout(info->state->close_delay);
		}
		wake_up_interruptible(&info->open_wait);
	}
    info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE|
					             ASYNC_CLOSING);
    wake_up_interruptible(&info->close_wait);
    MOD_DEC_USE_COUNT;
}

static void uartlite_wait_until_sent(struct tty_struct *tty, int timeout) {

	struct uartlite_info *info=(struct uartlite_info *)tty->driver_data;
    unsigned long char_time, expire;
    unsigned int status;

    if (info->port->fifosize == 0)
        return;

	char_time = (info->timeout - HZ/50) / info->port->fifosize;
	char_time = char_time / 5;
	if (char_time == 0)
		char_time=1;
	if (timeout && timeout < char_time)
        char_time = timeout;

	if (!timeout || timeout > 2 * info->timeout)
		timeout = 2 * info->timeout;

	expire = jiffies + timeout;

	while(UART_GET_SR(info->port) & UART_BUSY) {
		set_current_state(TASK_INTERRUPTIBLE);
		schedule_timeout(char_time);
		if (signal_pending(current))
			break;
		if (timeout && time_after(jiffies, expire))
			break;
		status = UART_GET_SR(info->port);
	}
    set_current_state(TASK_RUNNING);
}

static void uartlite_hangup(struct tty_struct *tty)
{
	struct uartlite_info *info = tty->driver_data;
	struct uartlite_state *state = info->state;

	uartlite_flush_buffer(tty);
	if (info->flags & ASYNC_CLOSING)
		return;
	uartlite_shutdown(info);
	info->event = 0;
	state->count = 0;
	info->flags &= ~(ASYNC_NORMAL_ACTIVE|ASYNC_CALLOUT_ACTIVE);
	info->tty = NULL;
	wake_up_interruptible(&info->open_wait);
}

static int block_til_ready(struct tty_struct *tty, struct file *filp,
			   struct uartlite_info *info)
{
	DECLARE_WAITQUEUE(wait, current);
	struct uartlite_state *state = info->state;
	unsigned long flags;
	int do_clocal = 0, extra_count = 0, retval;

	/*
	 * If the device is in the middle of being closed, then block
	 * until it's done, and then try again.
	 */
	if (tty_hung_up_p(filp) ||
	    (info->flags & ASYNC_CLOSING)) {
		if (info->flags & ASYNC_CLOSING)
			interruptible_sleep_on(&info->close_wait);
		return (info->flags & ASYNC_HUP_NOTIFY) ?
			-EAGAIN : -ERESTARTSYS;
	}

	/*
	 * If this is a callout device, then just make sure the normal
	 * device isn't being used.
	 */
	if (tty->driver.subtype == SERIAL_TYPE_CALLOUT) {
		if (info->flags & ASYNC_NORMAL_ACTIVE)
			return -EBUSY;
		if ((info->flags & ASYNC_CALLOUT_ACTIVE) &&
		    (info->flags & ASYNC_SESSION_LOCKOUT) &&
		    (info->session != current->session))
			return -EBUSY;
		if ((info->flags & ASYNC_CALLOUT_ACTIVE) &&
		    (info->flags & ASYNC_PGRP_LOCKOUT) &&
		    (info->pgrp != current->pgrp))
			return -EBUSY;
		info->flags |= ASYNC_CALLOUT_ACTIVE;
		return 0;
	}

	/*
	 * If non-blocking mode is set, or the port is not enabled,
	 * then make the check up front and then exit.
	 */
	if ((filp->f_flags & O_NONBLOCK) ||
	    (tty->flags & (1 << TTY_IO_ERROR))) {
		if (info->flags & ASYNC_CALLOUT_ACTIVE)
			return -EBUSY;
		info->flags |= ASYNC_NORMAL_ACTIVE;
		return 0;
	}

	if (info->flags & ASYNC_CALLOUT_ACTIVE) {
		if (state->normal_termios.c_cflag & CLOCAL)
			do_clocal = 1;
	} else {
		if (tty->termios->c_cflag & CLOCAL)
			do_clocal = 1;
	}

	/*
	 * Block waiting for the carrier detect and the line to become
	 * free (i.e., not in use by the callout).  While we are in
	 * this loop, state->count is dropped by one, so that
	 * rs_close() knows when to free things.  We restore it upon
	 * exit, either normal or abnormal.
	 */
	retval = 0;
	add_wait_queue(&info->open_wait, &wait);
	save_flags(flags); cli();
	if (!tty_hung_up_p(filp)) {
		extra_count = 1;
		state->count--;
	}
	restore_flags(flags);
	info->blocked_open++;
	while (1) {
		save_flags(flags); cli();
		restore_flags(flags);
		set_current_state(TASK_INTERRUPTIBLE);
		if (tty_hung_up_p(filp) ||
		    !(info->flags & ASYNC_INITIALIZED)) {
			if (info->flags & ASYNC_HUP_NOTIFY)
				retval = -EAGAIN;
			else
				retval = -ERESTARTSYS;
			break;
		}
		if (signal_pending(current)) {
			retval = -ERESTARTSYS;
			break;
		}
		schedule();
	}
	set_current_state(TASK_RUNNING);
	remove_wait_queue(&info->open_wait, &wait);
	if (extra_count)
		state->count++;
	info->blocked_open--;
	if (retval)
		return retval;
	info->flags |= ASYNC_NORMAL_ACTIVE;
	return 0;
}

static struct uartlite_info *uartlite_get(int line)
{
	struct uartlite_info *info;
	struct uartlite_state *state = uartlite_state + line;

	state->count++;
	if (state->info)
		return state->info;
	info = kmalloc(sizeof(struct uartlite_info), GFP_KERNEL);
	if (info) {
		memset(info, 0, sizeof(struct uartlite_info));
		init_waitqueue_head(&info->open_wait);
		init_waitqueue_head(&info->close_wait);
		init_waitqueue_head(&info->delta_msr_wait);
		info->flags = state->flags;
		info->state = state;
		info->port  = uartlite_ports + line;
		tasklet_init(&info->tlet, uartlite_tasklet_action,
			     (unsigned long)info);
	}
	if (state->info) {
		kfree(info);
		return state->info;
	}
	state->info = info;
	return info;
}

static int uartlite_open(struct tty_struct *tty, struct file *filp)
{
	struct uartlite_info *info;
	int retval, line = MINOR(tty->device) - tty->driver.minor_start;

	// is this a line that we've got?
	MOD_INC_USE_COUNT;
	if (line >= SERIAL_UARTLITE_NR) {
		MOD_DEC_USE_COUNT;
		return -ENODEV;
	}

	info = uartlite_get(line);
	if (!info)
		return -ENOMEM;

	tty->driver_data = info;
	info->tty = tty;
	info->tty->low_latency = (info->flags & ASYNC_LOW_LATENCY) ? 1 : 0;

	/*
	 * Make sure we have the temporary buffer allocated
	 */
	if (!tmp_buf) {
		unsigned long page = get_zeroed_page(GFP_KERNEL);
		if (tmp_buf)
			free_page(page);
		else if (!page) {
			MOD_DEC_USE_COUNT;
			return -ENOMEM;
		}
		tmp_buf = (u_char *)page;
	}

	/*
	 * If the port is in the middle of closing, bail out now.
	 */
	if (tty_hung_up_p(filp) ||
	    (info->flags & ASYNC_CLOSING)) {
		if (info->flags & ASYNC_CLOSING)
			interruptible_sleep_on(&info->close_wait);
		MOD_DEC_USE_COUNT;
		return -EAGAIN;
	}

	/*
	 * Start up the serial port
	 */
	retval = uartlite_startup(info);
	if (retval) {
		MOD_DEC_USE_COUNT;
		return retval;
	}

	retval = block_til_ready(tty, filp, info);
	if (retval) {
		MOD_DEC_USE_COUNT;
		return retval;
	}

	if ((info->state->count == 1) &&
	    (info->flags & ASYNC_SPLIT_TERMIOS)) {
		if (tty->driver.subtype == SERIAL_TYPE_NORMAL)
			*tty->termios = info->state->normal_termios;
		else
			*tty->termios = info->state->callout_termios;
	}
#ifdef CONFIG_SERIAL_AMBA_CONSOLE
	if (uartlite_cons.cflag && uartlite_cons.index == line) {
		tty->termios->c_cflag = uartlite_cons.cflag;
		uartlite_cons.cflag = 0;
	}
#endif

	info->session = current->session;
	info->pgrp = current->pgrp;
	return 0;
}

int __init uartlite_init(void)
{
	int i;

	uartlite_driver.magic = TTY_DRIVER_MAGIC;
	uartlite_driver.driver_name = "serial_uartlite";
	uartlite_driver.name = SERIAL_UARTLITE_NAME;
	uartlite_driver.major = SERIAL_UARTLITE_MAJOR;
	uartlite_driver.minor_start = SERIAL_UARTLITE_MINOR;
	uartlite_driver.num = SERIAL_UARTLITE_NR;
	uartlite_driver.type = TTY_DRIVER_TYPE_SERIAL;
	uartlite_driver.subtype = SERIAL_TYPE_NORMAL;
	uartlite_driver.init_termios = tty_std_termios;
	uartlite_driver.init_termios.c_cflag = B38400 | CS8 | CREAD | HUPCL | CLOCAL;
	uartlite_driver.flags = TTY_DRIVER_REAL_RAW | TTY_DRIVER_NO_DEVFS;
	uartlite_driver.refcount = &uartlite_refcount;
	uartlite_driver.table = uartlite_table;
	uartlite_driver.termios = uartlite_termios;
	uartlite_driver.termios_locked = uartlite_termios_locked;

	uartlite_driver.open = uartlite_open;
	uartlite_driver.close = uartlite_close;
	uartlite_driver.write = uartlite_write;
	uartlite_driver.put_char = uartlite_put_char;
	uartlite_driver.flush_chars = uartlite_flush_chars;
	uartlite_driver.write_room = uartlite_write_room;
	uartlite_driver.chars_in_buffer = uartlite_chars_in_buffer;
	uartlite_driver.flush_buffer	= uartlite_flush_buffer;
	uartlite_driver.ioctl = uartlite_ioctl;
	uartlite_driver.throttle = uartlite_throttle;
	uartlite_driver.unthrottle = uartlite_unthrottle;
	uartlite_driver.send_xchar = uartlite_send_xchar;
	uartlite_driver.set_termios = uartlite_set_termios;
	uartlite_driver.stop = uartlite_stop;
	uartlite_driver.start = uartlite_start;
	uartlite_driver.hangup = uartlite_hangup;
	uartlite_driver.break_ctl = uartlite_break_ctl;
	uartlite_driver.wait_until_sent = uartlite_wait_until_sent;
	uartlite_driver.read_proc = NULL;

	/*
	 * The callout device is just like the normal device except for
	 * the major number and the subtype code.
	 */
	uartlitecallout_driver = uartlite_driver;
	uartlitecallout_driver.name = CALLOUT_UARTLITE_NAME;
	uartlitecallout_driver.major = CALLOUT_UARTLITE_MAJOR;
	uartlitecallout_driver.subtype = SERIAL_TYPE_CALLOUT;
	uartlitecallout_driver.read_proc = NULL;
	uartlitecallout_driver.proc_entry = NULL;

	if (tty_register_driver(&uartlite_driver))
		panic("Couldn't register uartlite serial driver\n");
	if (tty_register_driver(&uartlitecallout_driver))
		panic("Couldn't register uartlite callout driver\n");

	for (i = 0; i < SERIAL_UARTLITE_NR; i++) {
		struct uartlite_state *state = uartlite_state + i;
		state->line		= i;
		state->close_delay	= 5 * HZ / 10;
		state->closing_wait	= 30 * HZ;
		state->callout_termios	= uartlitecallout_driver.init_termios;
		state->normal_termios	= uartlite_driver.init_termios;
	}

	return 0;
}

__initcall(uartlite_init);

static void uartlite_console_write(struct console *co, const char *s, u_int count) {

	struct uartlite_port *port=&uartlite_ports[co->index];
	unsigned int status, old_cr;
	int i;

	old_cr=UART_GET_CR(port);
	UART_PUT_CR(port,0);

	for (i = 0; i < count; i++) {
		do {
			status=UART_GET_SR(port);
		} while(status & 0x8);
		UART_PUT_CHAR(port,s[i]);
		if (s[i] == '\n') {
			do {
				status=UART_GET_SR(port);
			} while(status & 0x8);
			UART_PUT_CHAR(port,'\r');
		}
	}

	do {
		status=UART_GET_SR(port);
	} while(!(status & 0x4));
	UART_PUT_CR(port,old_cr);

}

static kdev_t uartlite_console_device(struct console *c) {

	return MKDEV(SERIAL_UARTLITE_MAJOR, SERIAL_UARTLITE_MINOR + c->index);

}

static int __init uartlite_console_setup(struct console *co, char *options) {

	struct uartlite_port *port=&uartlite_ports[co->index];

	UART_PUT_CR(port,0);

	if (co->index >= SERIAL_UARTLITE_NR)
		co->index=0;

	return 0;

}

static struct console xilinxuart_cons =
{
	.name = "ttyUL",
	.write = uartlite_console_write,
	.device = uartlite_console_device,
	.setup = uartlite_console_setup,
	.flags = CON_PRINTBUFFER,
	.index = -1,
};

void __init xilinxuart_console_init(void)
{
	register_console(&xilinxuart_cons);
}

--opJtzjQTFsWo+cga--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
