Message-ID: <00933BFA237CD2119B3400409543582704A284@MEV01>
From: Ian Abbott <abbotti@mev.co.uk>
To: linuxppc-embedded@lists.linuxppc.org
Subject: I2C driver with new-style interface
Date: Mon, 13 Nov 2000 18:46:08 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="---- =_NextPart_000_01C04DA1.FCB5D290"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------ =_NextPart_000_01C04DA1.FCB5D290
Content-Type: text/plain

Hi folks,

Attached is an I2C driver using the new-style (Simon Vogl) interface
for MPC8xx. It currently only works as a single master.

It basically works, but there are one or two things in the code I'm
not too happy about, marked by "XXX", mostly to do with module
support.

It does contain a crude workaround for the problem I described in a
recent message (subject: "I2C Problems"; date: 8 Nov 2000). I'm not
sure if this workaround will NAKs in the middle of a transfer, as it
has only been tested for transfers to/from absent slave addresses.

It also fixes a "race on sleep" condition that was also present in
the code I based the driver on (the version of iic.c that Kim
Jorgensen posted and the modified version of that that Dan Winkler
posted). Dan Malek's initial read-only iic.c also handled this race
condition.

It seems to work okay with or without the CPM IIC/SPI Microcode
patch. (I don't need the patch as I'm using Ethernet on SCC2 and I
don't use SPI.)

Some notes on usage:

This uses the "new" I2C interface which is present in the 2.4.x
kernel, or you can install the kernel patches for earlier versions
of the kernel (see http://voxel.at/prj/i2c/).

The driver needs to be initialized after CPM initialisation, during
or after the core I2C initialization. If initializing during the the
core I2C initialization, you will need to add some lines to
drivers/i2c/i2c-core.c as follows:

#ifdef CONFIG_I2C_MPC8XX
	extern int i2c8xx_init(void);
#endif

Then in the i2c_init_all function in that file:

#ifdef CONFIG_I2C_MPC8XX
	i2c8xx_init();
#endif

You'll also need a boolean or tristate configuration option for
CONFIG_I2C_MPC8XX and a boolean configuration option
CONFIG_BROKEN_CPM_I2C to use my crude workaround for broken CPM I2C
implementations.

If installing the driver as a module, you'll also have to load the
i2c-core.o module before my i2c-8xx.o. Not all the symbols required
to load i2c-8xx.o as a module are currently exported, so you'll have
to add the required symbols to arch/ppc/kernel/ksyms.c.

Apart from the above, the main disadvantages with this driver are
that it is bigger than the old one, as you also require i2c-core.o
and possibly i2c-dev.o to get similar functionality. Also, you cannot
change I2C bus speeds on a per file-descriptor basis (or at all,
currently) as the driver does not have any VFS interface. There is
an ioctl mechanism for changing things globally for the whole I2C
bus, but I haven't implemented anything for that yet (possibilities
include setting the bus speed and the I2C interface's own address).

--
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti@mev.co.uk>             )=-
-=( Tel: +44 (0)161 477 1898   FAX: +44 (0)161 718 3587              )=-


------ =_NextPart_000_01C04DA1.FCB5D290
Content-Type: application/octet-stream;
	name="i2c-8xx.c"
Content-Disposition: attachment;
	filename="i2c-8xx.c"
Content-Transfer-Encoding: quoted-printable

/*
 * I2C driver for Motorola MPC8xx.
 * Copyright (c) 2000 Ian Abbott, MEV Ltd. (abbotti@mev.co.uk)
 *
 * This uses the new "Simon Vogl" I2C core interface. In the terms of
 * the core I2C interface, this driver is a combined bus and algorithm
 * driver.
 *
 * Uses bits of code from the experimental standalone (non-Vogl) I2C
 * driver by Dan Malek, Kim Jorgensen and Dan Winkler.
 *
 *=20
 * N.B. The 'MODULE' version of this requires some more symbols to be
 * exported from the kernel to module space. These include the =
following:
 *
 *    cpm_install_handler
 *    cpm_free_handler     -- if available for your kernel version
 *    local_flush_tlb_page
 *    va_to_pte
 *    m8xx_cpm_dpalloc
 *
 * The 'standalone' version needs to be initialized after or during the
 * I2C core initialization (see 'i2c_init_all()' in =
'drivers/i2c/i2c-core.c').
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
 */

/* $Id: i2c-8xx.c,v 1.9 2000/11/13 17:32:25 abbotti Exp $ */

#include <linux/config.h>
#include <linux/module.h>
#include <linux/errno.h>
#include <linux/signal.h>
#include <linux/sched.h>
#include <linux/timer.h>
#include <linux/interrupt.h>
#include <linux/major.h>
#include <linux/string.h>
#include <linux/fcntl.h>
#include <linux/ptrace.h>
#include <linux/mm.h>
#include <linux/malloc.h>
#include <linux/poll.h>
#include <linux/init.h>
#include <linux/delay.h>
#include <linux/wait.h>
#include <asm/uaccess.h>
#include <asm/pgtable.h>
#include <asm/mpc8xx.h>

#ifdef I2C_LOCAL_INCLUDE
#include "i2c.h"
#else
#include <linux/i2c.h>
#endif

#include "commproc.h"

#ifndef I2C_ALGO_MPC8XX
/* From latest i2c-id.h ... */
#define I2C_ALGO_MPC8XX 0x110000	/* MPC8xx PowerPC I2C algorithm */
#define I2C_HW_MPC8XX_EPON 0x00	/* Eponymous MPC8xx I2C adapter 	*/
#endif

/* From latest commproc.h ... */
#ifndef BD_SC_NAK
#define BD_SC_NAK	((ushort)0x0004)	/* No acknowledge. */
#endif
#ifndef BD_SC_UN
#define BD_SC_UN	((ushort)0x0002)	/* Underrun. */
#endif
#ifndef BD_SC_CL
#define BD_SC_CL	((ushort)0x0001)	/* Collision. */
#endif

/* ----- defines =
----------------------------------------------------------- */

#define DEB(x) do if (debug >=3D 1) x; while (0)
#define DEB2(x) do if (debug >=3D 2) x; while (0)

#define DEFAULT_I2C_DEBUG	1	/* Default debug level. */
#define DEFAULT_OWN		0x1A 	/* Default own address (7-bit). */
#define DEFAULT_CLOCK		100000	/* Default clock upper bound (Hz). */
#define DEFAULT_FILTER		0	/* Default digital filtering (bool). */

/* Maximum number of bytes we can xmit/receive at once (hardware). */
#define MAX_I2C_DATALEN		128

#ifdef MODULE
/* XXX res isn't exported to modules, so cheat! */
#define I2BRG_INT_CLK	(((loops_per_sec + 250000) / 500000) * 1000000)
#else
#define I2BRG_INT_CLK	(((bd_t *)res)->bi_intfreq * 1000000)
#endif

#define I2C8XX_SETOWN(x)	((void)(r_i2add =3D (0xFF & ((x) << 1))))

/* ----- forward declarations =
---------------------------------------------- */

/* "Algorithm" functions... */
static int i2c8xx_master_xfer(
		struct i2c_adapter *adap, struct i2c_msg msgs[], int num);
static int i2c8xx_algo_control(
		struct i2c_adapter *adap, unsigned int cmd, unsigned long arg);
static u32 i2c8xx_functionality(struct i2c_adapter *adap);

/* "Adapter" functions... */
#ifdef MODULE
static void i2c8xx_inc_use(struct i2c_adapter *adap);
static void i2c8xx_dec_use(struct i2c_adapter *adap);
#endif
static int i2c8xx_client_register(struct i2c_client *client);
static int i2c8xx_client_unregister(struct i2c_client *client);

/* ----- global variables =
-------------------------------------------------- */

static int debug =3D DEFAULT_I2C_DEBUG;
static int own =3D DEFAULT_OWN;
static int clock =3D DEFAULT_CLOCK;
static int digfilt =3D DEFAULT_FILTER;

static char *i2c8xx_name =3D "i2c-8xx.o";
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,3,1))
static struct wait_queue *i2c8xx_interrupt_wait =3D NULL;
#else
static wait_queue_head_t i2c8xx_interrupt_wait;
#endif

static ushort r_rbase, r_tbase;
static unchar r_i2add, r_i2mod, r_i2brg;

static struct i2c_algorithm i2c8xx_algo =3D {
	"MPC8xx algorithm",
	I2C_ALGO_MPC8XX,
	i2c8xx_master_xfer,
	NULL,			/* smbus_xfer */
	NULL,			/* slave_send */
	NULL,			/* slave_recv */
	i2c8xx_algo_control,
	i2c8xx_functionality
};

static struct i2c_adapter i2c8xx_ops =3D {
	"MPC8xx adapter",
	I2C_ALGO_MPC8XX | I2C_HW_MPC8XX_EPON,
	&i2c8xx_algo,
	NULL,			/* algo_data */
#ifdef MODULE
	i2c8xx_inc_use,
	i2c8xx_dec_use,
#else
	NULL,			/* inc_use */
	NULL,			/* dec_use */
#endif
	i2c8xx_client_register,
	i2c8xx_client_unregister,
	/* ... */
};

/* ----- functions =
--------------------------------------------------------- */

/* ----- "Algorithm" functions ----- */

static int
i2c8xx_master_xfer(struct i2c_adapter *adap, struct i2c_msg msgs[], int =
num)
{
	/*
	 * We do not support the I2C_M_NOSTART flag (just a read/write bit
	 * without the start bit or address bits). Silently ignore it.
	 *
	 * We do not support 10-bit addresses. Silently ignore it.
	 *
	 * At the moment, we ignore the timeout and retry values in the
	 * adapter structure. For a multi-master I2C bus, we'd have to
	 * do something with these.
	 */
	int retval;
	int first;	/* First component for iteration. */
	int count;	/* Number of components for iteration. */
	int i, len;
	volatile i2c8xx_t *i2c;
	volatile cbd_t	*tbdf, *rbdf;
	volatile cpm8xx_t	*cp;
	u_char			*tb, *rb, addr;
	struct i2c_msg		*pmsg;
	int toolong;
	u_short sc;
	unsigned long flags;
	long timeout;
#ifdef CONFIG_BROKEN_CPM_I2C
	int do_loopback;
#endif

	/* Get pointers to CPM and I2C registers. */
	cp =3D (cpm8xx_t *)&((immap_t *)IMAP_ADDR)->im_cpm;
	i2c =3D (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);

	/* Get pointers to buffer descriptors. */
	tbdf =3D (cbd_t *)&cp->cp_dpmem[r_tbase];
	rbdf =3D (cbd_t *)&cp->cp_dpmem[r_rbase];

	retval =3D 0;
	first =3D 0;
	toolong =3D 0;
	while ((first < num) && (retval =3D=3D 0)) {
		count =3D num - first;
		if (count >=3D 2) {
			/* Allow maximum of 2 components per iteration */
			count =3D 2;
			if (msgs[first].flags & I2C_M_RD) {
				/* but end iteration on first read component. */
				count =3D 1;
			}
		}

		len =3D 0;	/* Stop compiler warning later. */
		for (i =3D 0; i < count; i++) {
			/* Pointer to message component. */
			pmsg =3D &msgs[first + i];
			/* Get length of data. */
			len =3D pmsg->len;
			if (len > MAX_I2C_DATALEN - 1) {
				/* Clip length. */
				len =3D MAX_I2C_DATALEN - 1;
				toolong =3D 1;
			}

			/* Get pointer to transmit buffer. */
			tb =3D __va(tbdf[i].cbd_bufaddr);

			/* Get device address and determine Rd/Wr bit. */
			addr =3D pmsg->addr << 1;
			if (pmsg->flags & I2C_M_RD)
				addr |=3D 1;
			if (pmsg->flags & I2C_M_REV_DIR_ADDR)
				addr ^=3D 1;

			*tb =3D addr;	/* Set device addr and Rd/Wr bit. */

			if (!(pmsg->flags & I2C_M_RD)) {
				/* Copy Tx data into Tx buffer. */
				memcpy(tb + 1, pmsg->buf, len);
			}

			/* Set length of transfer. */
			tbdf[i].cbd_datlen =3D len + 1;

			if (i =3D=3D count - 1) {
				/* Last buffer of iteration. */
				if (pmsg->flags & I2C_M_RD) {
					/* Reading. */
					tbdf[i].cbd_sc =3D
						BD_SC_READY | BD_IIC_START
						| BD_SC_LAST | BD_SC_WRAP;
					rbdf[0].cbd_sc =3D
						BD_SC_EMPTY | BD_SC_WRAP
						| BD_SC_INTRPT;
					/* Enable Rx interrupt. */
					i2c->i2c_i2cmr =3D 0x15;

				} else {
					/* Writing. */
					tbdf[i].cbd_sc =3D
						BD_SC_READY | BD_IIC_START
						| BD_SC_LAST | BD_SC_WRAP
						| BD_SC_INTRPT;
					/* Enable Tx interrupt. */
					i2c->i2c_i2cmr =3D 0x16;
				}
			} else {
				/* Not the last buffer of iteration. */
				tbdf[i].cbd_sc =3D BD_SC_READY | BD_IIC_START;
			}
		}

		i2c->i2c_i2cer =3D 0xFF;	/* Clear event register. */
		i2c->i2c_i2brg =3D r_i2brg;

		save_flags(flags); cli();	/* Stop sleep race. */
		i2c->i2c_i2mod =3D r_i2mod | 0x01; /* Enable I2C */
		i2c->i2c_i2com =3D 0x81;	/* Start master transmit. */

		/* Wait for I2C interrupt or timeout. */
		timeout =3D interruptible_sleep_on_timeout(
				&i2c8xx_interrupt_wait, 1*HZ);
		restore_flags(flags);
			=09
		if (timeout =3D=3D 0) {
			if (signal_pending(current)) {
				DEB2(printk(KERN_DEBUG "%s: I2C signaled while waiting for =
interrupt!\n",
						i2c8xx_name));
				retval =3D -EINTR;
			} else {
				DEB2(printk(KERN_DEBUG "%s: I2C interrupt timeout!\n",
						i2c8xx_name));
				retval =3D -EREMOTEIO;
			}
		}

		/* Chip errata, clear enable. */
		i2c->i2c_i2mod =3D r_i2mod;

#ifdef CONFIG_BROKEN_CPM_I2C
		do_loopback =3D 0;
#endif

		/* Check for errors in Tx buffers. */
		for (i =3D 0; i < count; i++) {
			sc =3D tbdf[i].cbd_sc;
			if (sc & (BD_SC_READY | BD_SC_NAK
						| BD_SC_UN | BD_SC_CL)) {
				if (debug >=3D 2) {
					printk(KERN_DEBUG "%s: I2C transfer error -\n", i2c8xx_name);
					if (sc & BD_SC_READY)
						printk(KERN_DEBUG "--- TX buf still ready!\n");
					if (sc & BD_SC_NAK)
						printk(KERN_DEBUG "--- No acknowledge!\n");
					if (sc & BD_SC_UN)
						printk(KERN_DEBUG "--- Underrun!\n");
					if (sc & BD_SC_CL)
						printk(KERN_DEBUG "--- Collision!\n");
				}

#ifdef CONFIG_BROKEN_CPM_I2C
				/* Check for problems that confuse the I2C
				 * controller and can be fixed.
				 */
				if (sc & BD_SC_NAK) {
					/* Got a NAK.
					 */
					pmsg =3D &msgs[first + i];
					if (pmsg->flags & I2C_M_RD) {
						/* Do loopback transfer to
						 * recover after NAK'ed read.
						 */
						do_loopback =3D 1;
					}
				}
#endif

				retval =3D -EREMOTEIO;
			}
		}

		/* Check last component of iteration for a 'read'. */
		pmsg =3D &msgs[first + count - 1];
		if (pmsg->flags & I2C_M_RD) {
			/* Check for errors in Rx buffer. */
			if (rbdf[0].cbd_sc & BD_SC_EMPTY) {
				if (debug >=3D 2) {
					printk(KERN_DEBUG "%s: I2C transfer error -\n", i2c8xx_name);
					printk(KERN_DEBUG "--- RX buf still empty!\n");
				}

				retval =3D -EREMOTEIO;
			}

			/* Get pointer to receive buffer. */
			rb =3D __va(rbdf[0].cbd_bufaddr);

			/* Copy received data. */
			memcpy(pmsg->buf, rb, len);
		}

#ifdef CONFIG_BROKEN_CPM_I2C
		if (do_loopback) {
			/* Set up a loopback transfer to own address.
			 * This seems to work around a CPM I2C bug.
			 */

			/* Get pointer to transmit buffer. */
			tb =3D __va(tbdf[0].cbd_bufaddr);
			/* Set first byte to own address. */
			*tb =3D r_i2add;
			/* Second byte is a don't care. Total length is 2. */

			/* Set up buffer descriptors. */
			tbdf[0].cbd_datlen =3D 2;
			tbdf[0].cbd_sc =3D
				BD_SC_READY | BD_IIC_START
				| BD_SC_LAST | BD_SC_WRAP;
			rbdf[0].cbd_sc =3D
				BD_SC_EMPTY | BD_SC_WRAP | BD_SC_INTRPT;

			/* Enable Rx interrupt. */
			i2c->i2c_i2cmr =3D 0x15;
			i2c->i2c_i2cer =3D 0xFF;	/* Clear event register. */
			i2c->i2c_i2brg =3D r_i2brg;

			save_flags(flags); cli();
			i2c->i2c_i2mod =3D r_i2mod | 0x01; /* Enable I2C */
			i2c->i2c_i2com =3D 0x81;	/* Start master transmit. */

			/* Wait for I2C interrupt or timeout. */
			interruptible_sleep_on_timeout(
				&i2c8xx_interrupt_wait, 1*HZ);
			restore_flags(flags);

			/* Chip errata, clear enable. */
			i2c->i2c_i2mod =3D r_i2mod;
		}
#endif

		/* Ready for next iteration. */
		first +=3D count;
	}

	if (toolong) {
		DEB2(printk(KERN_DEBUG "%s: I2C transfer truncated!\n",
					i2c8xx_name));
	}

	if (retval =3D=3D 0) {
		/* No errors. Return number of sub-messages processed. */
		retval =3D first;
	}

	return retval;
}

static int
i2c8xx_algo_control(struct i2c_adapter *adap, unsigned int cmd,
		unsigned long arg)
{
	return 0;
}

static u32
i2c8xx_functionality(struct i2c_adapter *adap)
{
	return I2C_FUNC_I2C | I2C_FUNC_PROTOCOL_MANGLING | =
I2C_FUNC_SMBUS_EMUL;
}

/* ----- "Adapter" functions ----- */

#ifdef MODULE
static void
i2c8xx_inc_use(struct i2c_adapter *adap)
{
	MOD_INC_USE_COUNT;
}

static void
i2c8xx_dec_use(struct i2c_adapter *adap)
{
	MOD_DEC_USE_COUNT;
}
#endif

static int
i2c8xx_client_register(struct i2c_client *client)
{
	return 0;
}

static int
i2c8xx_client_unregister(struct i2c_client *client)
{
	return 0;
}

/* XXX This LINUX_VERSION_CODE test is just a bad guess. Replace it! */
#if (LINUX_VERSION_CODE < KERNEL_VERSION(2,2,13))
/* cpm_free_handler
 *
 * In case the commproc.c doesn't have this function.
 */
static void
cpm_free_handler(int vec)
{
	cpm_install_handler(vec, NULL, NULL);
	((immap_t *)IMAP_ADDR)->im_cpic.cpic_cimr |=3D (1 << vec);
}
#endif

static void
i2c8xx_interrupt(void *dev_id)
{
	volatile i2c8xx_t *i2c;

	i2c =3D (i2c8xx_t *)&(((immap_t *)IMAP_ADDR)->im_i2c);

	/* Clear interrupt. */
	i2c->i2c_i2cer =3D 0xff;

	/* Get 'me going again. */
	wake_up_interruptible(&i2c8xx_interrupt_wait);
}

/* i2c_set_clock
 *
 * Set r_i2mod and r_i2brg variables from desired clock frequency and
 * desired filter setting. Generated frequency is clipped to supported
 * range.
 */
static int
i2c8xx_set_clock(int desired, int filter)
{
	unsigned long brgclk =3D I2BRG_INT_CLK;
	unsigned long clock;
	unsigned long divfilt, min_divfilt;
	unsigned long before_prescale;
	unsigned pdiv_code;
	unsigned i2mod;

	/* Generated clock is given by
	 *   brgclk / (2 * prescale * (i2brg + 3 + (2 * filt)))
	 *
	 * filt is 0 for no digital filtering, 1 for digital filtering.
	 * Minimum i2brg is 3 if filt=3D=3D0 or 6 if filt=3D=3D1.
	 *
	 * Prescale values are 32, 16, 8 or 4, corresponding to pdiv_codes
	 * 0, 1, 2, 3 respectively. Want to use as large a prescale value
	 * as possible as this conserves power.
	 *
	 * We want the generated clock to be <=3D desired clock if possible, =
or
	 * the slowest supported clock if impossible.
	 */

	/* Fix silly desired clock values. */
	clock =3D (desired < 1) ? 1 : desired;
	before_prescale =3D brgclk / (2 * clock);
	min_divfilt =3D filter ? (6+3+(2*1)) : (3+3+(2*0));

	pdiv_code =3D 0;
	do {
		divfilt =3D ((before_prescale + (32 >> pdiv_code) - 1)
				>> (5 - pdiv_code));
	} while ((++pdiv_code < 4) && (divfilt < min_divfilt));
	--pdiv_code;

	i2mod =3D pdiv_code << 1;

	if (divfilt < min_divfilt) {
		/* Desired clock frequency is too high. */
		divfilt =3D min_divfilt;
	}

	/* Convert divfilt to FLT and I2BRG values; keep I2BRG in divfilt. */
	divfilt -=3D 3;
	if (filter) {
		divfilt -=3D 2;
		i2mod |=3D 0x08;	/* FLT */
	}
	if (divfilt > 255) {
		/* Desired clock frequency is too low. */
		divfilt =3D 255;
	}

	/* Save I2MOD and I2BRG values for use by rest of driver. */
	r_i2mod =3D (unchar)i2mod;
	r_i2brg =3D (unchar)divfilt;
	DEB2(printk(KERN_INFO "%s: i2mod 0x%X, i2brg 0x%X\n", i2c8xx_name, =
r_i2mod, r_i2brg));

	return 0;
}

static int __init
i2c8xx_do_options(void)
{
	I2C8XX_SETOWN(own);
	i2c8xx_set_clock(clock, digfilt);

	i2c8xx_ops.timeout =3D 100;	/* default values, should	*/
	i2c8xx_ops.retries =3D 3;		/* be replaced by defines	*/

	return 0;
}

/* i2c8xx_init
 *
 * Initialization entry point for monolithic kernel driver. This should =
be
 * called after or during the core I2C initialization.
 */
int __init
i2c8xx_init(void)
{
	volatile cbd_t		*bdp;
	volatile immap_t	*imp;
	volatile cpm8xx_t	*cp;
	volatile iic_t		*iip;
	volatile i2c8xx_t	*i2c;
#ifdef MODULE
	int	use_old_bds;
#endif
#ifdef CONFIG_UCODE_PATCH
	uint	reloc;
#endif
	unsigned long	mem_addr;
	int	err;

	printk(KERN_INFO "%s: CPM I2C-Bus driver\n", i2c8xx_name);

	if ((err =3D i2c8xx_do_options()) !=3D 0) {
		goto fail_options;
	}

	imp =3D (immap_t *)IMAP_ADDR;	/* Get pointer to internal regs */
	cp =3D (cpm8xx_t *)&imp->im_cpm;	/* and CPM regs. */
	i2c =3D (i2c8xx_t *)&imp->im_i2c;	/* I2C controller regs. */

	/* Configure port B pins to enable the SDA and SCL pins. */
	imp->im_cpm.cp_pbpar |=3D 0x30;
	imp->im_cpm.cp_pbdir |=3D 0x30;
	imp->im_cpm.cp_pbodr |=3D 0x30;

	/* Disable I2C controller. */
	i2c->i2c_i2mod =3D 0;

	/* Disable interrupts. */
	i2c->i2c_i2cmr =3D 0;
	i2c->i2c_i2cer =3D 0xFF;

	/* Set I2C controller to master mode. */
	i2c->i2c_i2com =3D 0x01;

	/* Set own address. */
	i2c->i2c_i2add =3D r_i2add;

	/* Set prescale and filter values. */
	i2c->i2c_i2mod =3D r_i2mod;

	/* Set clock divider. */
	i2c->i2c_i2brg =3D r_i2brg;

	iip =3D (iic_t *)&cp->cp_dparam[PROFF_IIC]; /* I2C parameter RAM */
#ifdef CONFIG_UCODE_PATCH
	/* Check for and use a microcode relocation patch. */
	if ((reloc =3D iip->iic_rpbase) !=3D 0) {
		printk(KERN_INFO "%s: Microcode relocation patch used\n", =
i2c8xx_name);
		iip =3D (iic_t *)&cp->cp_dpmem[reloc];
	}
#endif

#ifdef MODULE
	/* Try and recycle buffer descriptors from previous invocation of
	 * the module.  This kludge is because we cannot dealloc DP RAM on
	 * module clean-up.
	 * XXX This is a bit fragile and might not work.
	 */
	use_old_bds =3D 1;
	/* Check rbase and tbase are aligned and in range and not coincident.
	 * N.B. RPX-Lite initialization may set tbase to 0x840
	 * (CPM_DATAONLY_BASE + 0x40) but that may have been reallocated
	 * since so ensure rbase and tbase occur after that address.
	 */
	if ((iip->iic_rbase & 7) || (iip->iic_tbase & 7)
		|| (iip->iic_rbase >=3D CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE)
		|| (iip->iic_tbase >=3D CPM_DATAONLY_BASE + CPM_DATAONLY_SIZE)
		|| (iip->iic_rbase <=3D CPM_DATAONLY_BASE + 0x40)
		|| (iip->iic_tbase <=3D CPM_DATAONLY_BASE + 0x40)
		|| (iip->iic_tbase =3D=3D iip->iic_rbase)
		) {
		use_old_bds =3D 0;
	} else {
		/* Check rbase and tbase have enough BDs allocated.
		 * We would have allocated 2 Tx BDs followed by 1 Rx BD.
		 * We can check rbase is 2 BDs on from tbase, but cannot
		 * check number of Rx BDs easily, so if number of Tx BDs
		 * is correct, assume number of Rx BDs is correct too.
		 *
		 * XXX This is a bit of an unsafe assumption!
		 */
		if (iip->iic_rbase !=3D iip->iic_tbase + (sizeof(cbd_t) * 2)) {
			use_old_bds =3D 0;
		}
	}
	if (!use_old_bds)
#endif
	{
		uint dp_addr;
	=09
		/* Allocate 2 Tx BDs and 1 Rx BD. */
		dp_addr =3D m8xx_cpm_dpalloc(sizeof(cbd_t) * 3);

		if (dp_addr =3D=3D CPM_DP_NOSPACE) {
			err =3D -ENOSPC;
			printk(KERN_ERR
				"%s: failed to allocate CPM dual-port RAM\n",
				i2c8xx_name);
			goto fail_bd_alloc;
		}
		iip->iic_tbase =3D dp_addr;
		iip->iic_rbase =3D dp_addr + (sizeof(cbd_t) * 2);
	}
	r_tbase =3D iip->iic_tbase;
	r_rbase =3D iip->iic_rbase;
	DEB2(printk(KERN_INFO "%s: tbase 0x%X, rbase 0x%X\n", i2c8xx_name, =
r_tbase, r_rbase));

	/* Allocate 1 Rx and 2 Tx host bufs of MAX_I2C_DATALEN bytes each. */
#ifdef MODULE
	/* Allocate host buffers from a new page which we free on module
	 * clean-up. This is because we cannot free memory allocated by
	 * m8xx_cpm_hostalloc.
	 */
	mem_addr =3D __get_free_page(GFP_KERNEL);
#else
	/* Allocate host buffers from CPM host memory page. */
	mem_addr =3D m8xx_cpm_hostalloc(MAX_I2C_DATALEN * 3);
#endif
	if (!mem_addr) {
		err =3D -ENOSPC;
		printk(KERN_ERR
			"%s: failed to allocate buffers\n", i2c8xx_name);
		goto fail_hb_alloc;
	}
#ifdef MODULE
	/* Make it uncached. */
	{
		pte_t	*pte;

		if ((pte =3D va_to_pte(&init_task, mem_addr)) !=3D NULL) {
			pte_uncache(*pte);
		}
		flush_tlb_page(current->mm->mmap, mem_addr);
	}
#endif
	/* Set the buffer addresses. */
	bdp =3D (cbd_t *)&cp->cp_dpmem[r_tbase];	/* N.B. BD order Tx,Tx,Rx. */
	bdp[0].cbd_bufaddr =3D __pa(mem_addr + (0*MAX_I2C_DATALEN));
	bdp[1].cbd_bufaddr =3D __pa(mem_addr + (1*MAX_I2C_DATALEN));
	bdp[2].cbd_bufaddr =3D __pa(mem_addr + (2*MAX_I2C_DATALEN));
	DEB2(printk(KERN_INFO "%s: txb[0] 0x%X, txb[1] 0x%X, rxb[0] 0x%X\n",
		i2c8xx_name, bdp[0].cbd_bufaddr, bdp[1].cbd_bufaddr, =
bdp[2].cbd_bufaddr));

	/* Set byte order to big-endian, address type to 5. */
	iip->iic_tfcr =3D SMC_EB;
	iip->iic_rfcr =3D SMC_EB;

	/* Set maximum receive size. */
	iip->iic_mrblr =3D MAX_I2C_DATALEN;

	/* Initialize Tx/Rx parameters. */
#ifdef CONFIG_UCODE_PATCH
	if (reloc) {
		/*
		 *  Initialize required parameters if using microcode patch.
		 *
		 *  NOTE: These are the parameters required as stated in the
		 *	  Relocation spec which can be found at
		 *	  http://www.mot.com/SPS/ADC/pps/subpgs/etoolbox/8XX/i2c_spi.html
	 	 */

		iip->iic_rbptr =3D iip->iic_rbase;
		iip->iic_tbptr =3D iip->iic_tbase;

		iip->iic_rstate	=3D 0;
		iip->iic_tstate	=3D 0;
	}
	else
#endif
	{
		/* Initialize Tx/Rx parameters. */
		cp->cp_cpcr =3D
			mk_cr_cmd(CPM_CR_CH_I2C, CPM_CR_INIT_TRX) | CPM_CR_FLG;
		while (cp->cp_cpcr & CPM_CR_FLG);
	}

#if (LINUX_VERSION_CODE >=3D KERNEL_VERSION(2,3,1))
	init_waitqueue_head(&i2c8xx_interrupt_wait);
#endif

	/* Install interrupt handler. */
	cpm_install_handler(CPMVEC_I2C, i2c8xx_interrupt, (void *)iip);

	/* XXX You might want the option to scan the I2C bus and print out
	 * what was found here.
	 */

	/* Register adapter with I2C core. */
	err =3D i2c_add_adapter(&i2c8xx_ops);
	if (err) {
		goto fail_add_adapter;
	}

	return 0;

fail_add_adapter:
	/* Uninstall interrupt handler. */
	cpm_free_handler(CPMVEC_I2C);
#ifdef MODULE
#else
	/* Ideally, we'd like to free the host buffers, but we can't. */
#endif
fail_hb_alloc:
	/* Ideally, we'd like to free the 3 BDs we allocated, but we can't. */
fail_bd_alloc:
fail_options:
	return err;
}


EXPORT_NO_SYMBOLS;

#ifdef MODULE
MODULE_AUTHOR("Ian Abbott <abbotti@mev.co.uk>");
MODULE_DESCRIPTION("I2C-Bus adapter routines for MPC8xx PowerPC");

MODULE_PARM(debug, "i");
MODULE_PARM(own, "i");
MODULE_PARM(clock, "i");
MODULE_PARM(digfilt, "i");

MODULE_PARM_DESC(debug,
		"Set debug level - 0 off; 1 normal (default); 2 more verbose");
MODULE_PARM_DESC(own, "Set own address - range 0 to 0x77");
MODULE_PARM_DESC(clock, "Set desired I2C bus clock frequency (Hz)");
MODULE_PARM_DESC(digfilt, "Use digital filter - 0 off (default); 1 =
on");

int
init_module(void)
{
	return i2c8xx_init();
}

void
cleanup_module(void)
{
	/* N.B. There is no mechanism to free the CPM DP RAM used for our
	 * board descriptors. However, if the module is reloaded it will
	 * try and use the old board descriptor memory again. It is only
	 * recommended to unload the module during development.
	 */
	volatile cbd_t		*bdp;
	volatile immap_t	*imp;
	volatile cpm8xx_t	*cp;
	volatile i2c8xx_t	*i2c;
	unsigned long       mem_addr;

	/* Delete the adapter from I2C core. */
	i2c_del_adapter(&i2c8xx_ops);

	imp =3D (immap_t *)IMAP_ADDR;	/* Get pointer to internal regs */
	cp =3D (cpm8xx_t *)&imp->im_cpm;	/* and CPM regs. */
	i2c =3D (i2c8xx_t *)&imp->im_i2c;	/* I2C controller regs. */

	/* Disable I2C controller. */
	i2c->i2c_i2mod =3D 0;

	/* Disable interrupts. */
	i2c->i2c_i2cmr =3D 0;
	i2c->i2c_i2cer =3D 0xFF;

	/* Free handler. */
	cpm_free_handler(CPMVEC_I2C);

	/* Free host buffer memory page. */
	bdp =3D (cbd_t *)&cp->cp_dpmem[r_tbase];	/* N.B. BD order Tx,Tx,Rx. */
	mem_addr =3D (unsigned long)__va(bdp->cbd_bufaddr);
#if 1
	/* XXX Is this necessary? */
	/* Make it cached again. */
	{
		pte_t	*pte;

		if ((pte =3D va_to_pte(&init_task, mem_addr)) !=3D NULL) {
			pte_cache(*pte);
		}
		flush_tlb_page(current->mm->mmap, mem_addr);
	}
#endif
	free_page(mem_addr);

	/* Ideally, we'd like to free the 3 BDs we allocated, but we can't. */
}

#endif /* MODULE */


------ =_NextPart_000_01C04DA1.FCB5D290--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
