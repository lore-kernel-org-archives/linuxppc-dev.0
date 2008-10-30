Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.231])
	by ozlabs.org (Postfix) with ESMTP id 4B35EDDDEA
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 02:19:05 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so625465rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 08:19:04 -0700 (PDT)
Message-ID: <fa686aa40810300819w265c375euff3f46d7bb0a9176@mail.gmail.com>
Date: Thu, 30 Oct 2008 09:19:03 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "=?ISO-8859-1?Q?Ren=E9_B=FCrgel?=" <r.buergel@unicontrol.de>
Subject: Re: [PATCH] mpc52xx_uart: report serial errors to users
In-Reply-To: <490950AF.1000303@unicontrol.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <490950AF.1000303@unicontrol.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 30, 2008 at 12:14 AM, Ren=E9 B=FCrgel <r.buergel@unicontrol.de>=
 wrote:
> Hi! This patch adds the capability to the mpc52xx-uart to report framing
> errors, parity errors, breaks and overruns to userspace. These values may=
 be
> requested in userspace by using the ioctl TIOCGICOUNT.
>
> Signed-off-by: Ren=E9 B=FCrgel <r.buergel@unicontrol.de>

Looks mostly good.  A few comments below.  Make sure you CC: me when
you send the next version (which goes for all 5xxx patches).

g.

>
> Kind regards, Ren=E9 B=FCrgel
>
> --
> Ren=E9 B=FCrgel
> Software Engineer
> Unicontrol Systemtechnik GmbH
> OT Dittersbach
> Sachsenburger Weg 34
> 09669 Frankenberg
>
> Tel.: 03 72 06/ 88 73 - 19
> Fax: 03 72 06/ 88 73 - 60
> E-Mail: r.buergel@unicontrol.de
> Internet: www.unicontrol.de
>
>
>
> --- drivers/serial/mpc52xx_uart.c       2008-08-07 15:55:43.000000000 +02=
00
> +++ drivers/serial/mpc52xx_uart_orig.c  2008-09-11 13:19:12.000000000 +02=
00

Patch is one level too shallow; for regular tools to work without
manual intervention you should be generating the patch from the
directory above the kernel source.

> @@ -752,10 +752,17 @@
>                        if (status & MPC52xx_PSC_SR_RB) {
>                                flag =3D TTY_BREAK;
>                                uart_handle_break(port);
> +                               port->icount.brk++;
>                        } else if (status & MPC52xx_PSC_SR_PE)
> +                       {

Please use '} else if () {' form

>                                flag =3D TTY_PARITY;
> +                               port->icount.parity++;
> +                       }
>                        else if (status & MPC52xx_PSC_SR_FE)
> +                       {

ditto

>                                flag =3D TTY_FRAME;
> +                               port->icount.frame++;
> +                       }
>
>                        /* Clear error condition */
>                        out_8(&PSC(port)->command, MPC52xx_PSC_RST_ERR_STA=
T);
> @@ -769,6 +776,7 @@
>                         * affect the current character
>                         */
>                        tty_insert_flip_char(tty, 0, TTY_OVERRUN);
> +                       port->icount.overrun++;
>                }
>        }
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
