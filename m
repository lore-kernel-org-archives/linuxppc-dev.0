Return-Path: <glikely@secretlab.ca>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.227])
	by ozlabs.org (Postfix) with ESMTP id 5AD25DDF5D
	for <linuxppc-dev@ozlabs.org>; Fri,  2 May 2008 04:07:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 67so1122990wri.3
	for <linuxppc-dev@ozlabs.org>; Thu, 01 May 2008 11:07:06 -0700 (PDT)
Message-ID: <fa686aa40805011107p3b3ed242ue79849719961f8db@mail.gmail.com>
Date: Thu, 1 May 2008 12:07:06 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Andrew Liu" <shengping.liu@windriver.com>
Subject: Re: [PATCH] Fix a potential issue in mpc52xx uart driver
In-Reply-To: <4816CFF9.5030505@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4816CFF9.5030505@windriver.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 1:36 AM, Andrew Liu <shengping.liu@windriver.com> wrote:
> mpc52xx_uart_int and __uart_put_char both try to acquire the
>  port->lock. Therefore the function sequence of:
>
>  mpc52xx_uart_int--> ...-->flush_to_ldisc-->...-->__uart_put_char
>
>  can potentially trigger a deadlock. To avoid this deadlock a fix
>  similar to that found in the 8250.c serial driver is applied. The
>  deadlock is avoided by releasing the lock before pushing a buffer
>  and reacquiring it when completed.
>
>  Signed-off-by: Andrew Liu <shengping.liu@windriver.com>

Your patch is whitespace damaged and does not apply (tabs have been
converted to spaces).  It was trivial so I've applied it manually, but
please be careful when posting future patches.

Thanks,
g.

>
>  diff --git a/drivers/serial/mpc52xx_uart.c b/drivers/serial/mpc52xx_uart.c
>  index d93b357..5f95e53 100644
>  --- a/drivers/serial/mpc52xx_uart.c
>  +++ b/drivers/serial/mpc52xx_uart.c
>  @@ -783,7 +783,9 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
>                 }
>         }
>
>  +       spin_unlock(&port->lock);
>         tty_flip_buffer_push(tty);
>  +       spin_lock(&port->lock);
>
>         return psc_ops->raw_rx_rdy(port);
>   }
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
