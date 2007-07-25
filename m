Return-Path: <tglx@linutronix.de>
Received: from mail.tglx.de (www.osadl.org [213.239.205.134])
	by ozlabs.org (Postfix) with ESMTP id 5936ADDF15
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 05:47:21 +1000 (EST)
Subject: Re: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
From: Thomas Gleixner <tglx@linutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
References: <1185390656.3227.12.camel@chaos>
	<fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 25 Jul 2007 21:47:18 +0200
Message-Id: <1185392838.3227.13.camel@chaos>
Mime-Version: 1.0
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

On Wed, 2007-07-25 at 13:42 -0600, Grant Likely wrote:
> On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> > The port lock needs to be dropped across the tty_flip_buffer call, as it
> > would lead to a deadlock with the spin_lock(&port->lock) in uart_start()
> >
> > Uncovered by lockdep / preempt-rt
> >
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Instead of dropping the lock and reclaiming it, would it be better for
> me to rework the driver to only grab the lock in the 'meat' of
> mpc52xx_uart_int_rx_chars() and mpc52xx_uart_int_tx_chars()?   (As
> opposed to holding the lock for the entirety of mpc52xx_uart_int())

No, it's not worth the trouble. You need to protect the hardware access.

> What convention is used in other drivers?

The same.

	tglx
