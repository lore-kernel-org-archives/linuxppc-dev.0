Return-Path: <dmitry.torokhov@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id B28A8DE379
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 04:10:30 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so287690anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Jun 2008 11:10:28 -0700 (PDT)
Date: Mon, 30 Jun 2008 14:10:23 -0400
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: Xilinx: PS2: Added new XPS PS2 driver
Message-ID: <20080630135531.ZZRA012@mailhub.coreip.homeip.net>
References: <20080630142451.516A41D1006C@mail57-sin.bigfish.com>
	<20080630171628.GF17916@secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080630171628.GF17916@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, linux-input@vger.kernel.org,
	John Linn <john.linn@xilinx.com>, Sadanand <sadanan@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Grant, John,

On Mon, Jun 30, 2008 at 11:16:28AM -0600, Grant Likely wrote:
> On Mon, Jun 30, 2008 at 07:24:48AM -0700, John Linn wrote:
> > +config SERIO_XILINX_XPS_PS2
> > +	tristate "Xilinx XPS PS/2 Controller Support"
> > +	help
> > +	  This driver supports XPS PS/2 IP from Xilinx EDK.
> > +
> 
> Consider moving this block to somewhere in the middle of the file to
> reduce the possibility of merge conflicts.
> 

I can take care of that, no worries.

> > + *
> > + * (c) 2005 MontaVista Software, Inc.
> > + * (c) 2008 Xilinx Inc.
> > + *
> > + * This program is free software; you can redistribute it and/or modify it
> > + * under the terms of the GNU General Public License as published by the
> > + * Free Software Foundation; either version 2 of the License, or (at your
> > + * option) any later version.
> > + *
> > + * You should have received a copy of the GNU General Public License along
> > + * with this program; if not, write to the Free Software Foundation, Inc.,
> > + * 675 Mass Ave, Cambridge, MA 02139, USA.
> 
> These two paragraphs are redundant.  Being in the Linux source tree
> implies that it is GPL licensed.  You can remove them.
> 

I prefer having the statement in right in the code actually. While
being the in kernel implies that the code is GPLv2 compatible it could
be dual-licensed or GPLv2 only. This removes any doubt as to what
license is used on this particular piece of code.

> > + */
> > +
> > +
> > +#include <linux/module.h>
> > +#include <linux/serio.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/list.h>
> > +#include <asm/io.h>
> > +
> > +#ifdef CONFIG_OF		/* For open firmware */
> > + #include <linux/of_device.h>
> > + #include <linux/of_platform.h>
> > +#endif /* CONFIG_OF */
> 
> This is a given for mainline since arch/ppc will not exist in 2.6.27
> 
> > +
> > +#include "xilinx_ps2.h"
> 
> This header can simple be rolled into this .c file because the driver no
> longer has multiple .c files.
> 
> 
> > +#define DRIVER_DESCRIPTION	"Xilinx XPS PS/2 driver"
> > +#define XPS2_NAME_DESC		"Xilinx XPS PS/2 Port #%d"
> > +#define XPS2_PHYS_DESC		"xilinxps2/serio%d"
> 
> These strings are only used in 1 place each, no need to use a #define
> 
> > +
> > +
> > +static DECLARE_MUTEX(cfg_sem);
> 
> This mutex should be part of the driver private data structure
> 
> > +
> > +/*********************/
> > +/* Interrupt handler */
> > +/*********************/
> > +static irqreturn_t xps2_interrupt(int irq, void *dev_id)
> > +{
> > +	struct xps2data *drvdata = (struct xps2data *)dev_id;
> > +	u32 intr_sr;
> > +	u32 ier;
> > +	u8 c;
> > +	u8 retval;
> > +
> > +	/* Get the PS/2 interrupts and clear them */
> > +	intr_sr = in_be32(drvdata->base_address + XPS2_IPISR_OFFSET);
> > +	out_be32(drvdata->base_address + XPS2_IPISR_OFFSET, intr_sr);
> > +
> > +	/* Check which interrupt is active */
> > +	if (intr_sr & XPS2_IPIXR_RX_OVF) {
> > +		printk(KERN_ERR "%s: receive overrun error\n",
> > +			drvdata->serio.name);
> > +	}
> > +
> > +	if (intr_sr & XPS2_IPIXR_RX_ERR) {
> > +		drvdata->dfl |= SERIO_PARITY;
> > +	}
> > +
> > +	if (intr_sr & (XPS2_IPIXR_TX_NOACK | XPS2_IPIXR_WDT_TOUT)) {
> > +		drvdata->dfl |= SERIO_TIMEOUT;
> > +	}
> > +
> > +	if (intr_sr & XPS2_IPIXR_RX_FULL) {
> > +		retval = xps2_recv(drvdata, &drvdata->rxb);
> > +
> > +		/* Error, if 1 byte is not received */
> > +		if (retval != 1) {
> > +			printk(KERN_ERR
> > +				"%s: wrong rcvd byte count (%d)\n",
> > +				drvdata->serio.name, retval);

Don't you want to bail out here? Otherwise you will feed garbage to
serio_interrupt() I think.

> > +		}
> > +		c = drvdata->rxb;
> > +		serio_interrupt(&drvdata->serio, c, drvdata->dfl);
> > +		drvdata->dfl = 0;
> > +	}
> > +
> > +	if (intr_sr & XPS2_IPIXR_TX_ACK) {
> > +
> > +		/* Disable the TX interrupts after the transmission is
> > +		 * complete */
> > +		ier = in_be32(drvdata->base_address + XPS2_IPIER_OFFSET);
> > +		ier &= (~(XPS2_IPIXR_TX_ACK & XPS2_IPIXR_ALL ));
> > +		out_be32(drvdata->base_address + XPS2_IPIER_OFFSET, ier);
> > +		drvdata->dfl = 0;
> > +	}
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/*******************/
> > +/* serio callbacks */
> > +/*******************/
> > +
> > +/*
> > + * sxps2_write() sends a byte out through the PS/2 interface.
> > + *
> > + * The sole purpose of drvdata->tx_end is to prevent the driver
> > + * from locking up in the do {} while; loop when nothing is connected
> > + * to the given PS/2 port. That's why we do not try to recover
> > + * from the transmission failure.
> > + * drvdata->tx_end needs not to be initialized to some "far in the
> > + * future" value, as the very first attempt to xps2_send() a byte
> > + * is always successful, and drvdata->tx_end will be set to a proper
> > + * value at that moment - before the 1st use in the comparison.
> > + */
> 
> Good comment block.
> 
> nitpick: can you reformat the comment blocks to be in kerneldoc format?
> That will allow the automatic document generation tools to parse it.
> 
> see: Documentation/kernel-doc-nano-HOWTO.txt

This is an internal function so its not going to be exposed in
kerneldoc though.

> 
> > +static int sxps2_write(struct serio *pserio, unsigned char c)
> > +{
> > +	struct xps2data *drvdata = pserio->port_data;
> > +	unsigned long flags;
> > +	int retval;
> > +
> > +	do {
> > +		spin_lock_irqsave(&drvdata->lock, flags);
> > +		retval = xps2_send(drvdata, &c);
> > +		spin_unlock_irqrestore(&drvdata->lock, flags);
> > +
> > +		if (retval == 1) {
> > +			drvdata->tx_end = jiffies + HZ;
> > +			return 0;	/* success */
> > +		}
> > +	} while (!time_after(jiffies, drvdata->tx_end));

The logic escapes me... Let's say you send a byte and time when
jiffies were 10000 and now it is time 20000 and we try to send another
byte. Our first attempt fails and with time fence 11000 (HZ=1000) we
bail out of sxps2_write() after the very first unsiccessful attempt.
Is this what you intended?

> > +
> > +	return 1;			/* transmission is frozen */

It is better to return a negative on error, even if you don't report
actual -EXXXX error code.

-- 
Dmitry
