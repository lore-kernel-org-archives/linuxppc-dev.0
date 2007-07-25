Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.177])
	by ozlabs.org (Postfix) with ESMTP id CFDD3DDEA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 05:42:39 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so338129wag
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jul 2007 12:42:38 -0700 (PDT)
Message-ID: <fa686aa40707251242i6be0e30pd3b4019686308b0@mail.gmail.com>
Date: Wed, 25 Jul 2007 13:42:36 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH] mpx5200_uart: drop port lock across tty_flip_buffer() call
In-Reply-To: <1185390656.3227.12.camel@chaos>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <1185390656.3227.12.camel@chaos>
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

On 7/25/07, Thomas Gleixner <tglx@linutronix.de> wrote:
> The port lock needs to be dropped across the tty_flip_buffer call, as it
> would lead to a deadlock with the spin_lock(&port->lock) in uart_start()
>
> Uncovered by lockdep / preempt-rt
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Instead of dropping the lock and reclaiming it, would it be better for
me to rework the driver to only grab the lock in the 'meat' of
mpc52xx_uart_int_rx_chars() and mpc52xx_uart_int_tx_chars()?   (As
opposed to holding the lock for the entirety of mpc52xx_uart_int())
What convention is used in other drivers?

Cheers,
g.

>
>
> Index: linux-2.6.22/drivers/serial/mpc52xx_uart.c
> ===================================================================
> --- linux-2.6.22.orig/drivers/serial/mpc52xx_uart.c     2007-07-09 01:32:17.000000000 +0200
> +++ linux-2.6.22/drivers/serial/mpc52xx_uart.c  2007-07-25 21:06:11.000000000 +0200
> @@ -501,7 +501,9 @@ mpc52xx_uart_int_rx_chars(struct uart_po
>                 }
>         }
>
> +       spin_unlock(&port->lock);
>         tty_flip_buffer_push(tty);
> +       spin_lock(&port->lock);
>
>         return in_be16(&PSC(port)->mpc52xx_psc_status) & MPC52xx_PSC_SR_RXRDY;
>  }
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
