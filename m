Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id 2C071DDE33
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 05:54:13 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so341968wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 12:54:11 -0700 (PDT)
Message-ID: <fa686aa40707251254q150b8f30k292c2163df02be4c@mail.gmail.com>
Date: Wed, 25 Jul 2007 13:54:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
In-Reply-To: <1185392838.3227.13.camel@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1185390656.3227.12.camel@chaos>
	<fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
	<1185392838.3227.13.camel@chaos>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> On Wed, 2007-07-25 at 13:42 -0600, Grant Likely wrote:
> > On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> > > The port lock needs to be dropped across the tty_flip_buffer call, as it
> > > would lead to a deadlock with the spin_lock(&port->lock) in uart_start()
> > >
> > > Uncovered by lockdep / preempt-rt
> > >
> > > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> >
> > Instead of dropping the lock and reclaiming it, would it be better for
> > me to rework the driver to only grab the lock in the 'meat' of
> > mpc52xx_uart_int_rx_chars() and mpc52xx_uart_int_tx_chars()?   (As
> > opposed to holding the lock for the entirety of mpc52xx_uart_int())
>
> No, it's not worth the trouble. You need to protect the hardware access.
>
> > What convention is used in other drivers?
>
> The same.

Okay, thanks.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

Kumar, this is a bug fix, can you pick it up please?

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
