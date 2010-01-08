Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 457551007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  8 Jan 2010 14:03:03 +1100 (EST)
Subject: Re: [PATCH] Re: ZILOG serial port broken in 2.6.32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Rob Landley <rob@landley.net>
In-Reply-To: <200912080642.52103.rob@landley.net>
References: <200912060101.22515.rob@landley.net>
	<1260148248.2076.1348.camel@pasglop>
	<200912080642.52103.rob@landley.net>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 08 Jan 2010 14:00:43 +1100
Message-ID: <1262919644.2173.704.camel@pasglop>
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> Ok, here's the fix.  It's not the _right_ fix, but it Works For Me (tm) and I'll
> leave it to you guys to figure out what this _means_:

I've failed to reproduce so far on both a Wallstreet powerbook (similar
generation and chipset as your beige G3) and a G5 with an added serial
port using current upstream...

Can you verify it's still there ? I might be able to reproduce on a
Beige G3 as well next week.

Cheers,
Ben.

> Signed-off-by: Rob Landley <rob@landley.net>
> 
> diff -ru build/packages/linux/drivers/serial/serial_core.c build/packages/linux2/drivers/serial/serial_core.c
> --- build/packages/linux/drivers/serial/serial_core.c	2009-12-02 21:51:21.000000000 -0600
> +++ build/packages/linux2/drivers/serial/serial_core.c	2009-12-08 06:17:06.000000000 -0600
> @@ -113,7 +113,7 @@
>  static void uart_tasklet_action(unsigned long data)
>  {
>  	struct uart_state *state = (struct uart_state *)data;
> -	tty_wakeup(state->port.tty);
> +	if (state->port.tty) tty_wakeup(state->port.tty);
>  }
>  
>  static inline void
> 
> That one line workaround makes the panic go away, and things seem to work fine from there.
> 
> I note that pmac_zilog.c function pmz_receiv_chars() has the following chunk:
> 
>         /* Sanity check, make sure the old bug is no longer happening */
>         if (uap->port.state == NULL || uap->port.state->port.tty == NULL) {
>                 WARN_ON(1);
>                 (void)read_zsdata(uap);
>                 return NULL;
>         }
> 
> Which doesn't catch this because it's the write code path (not the read code path) that's running into 
> this.
> 
> Rob
