Return-Path: <albrecht.dress@arcor.de>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 61C69B6EEB
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 20:56:51 +1100 (EST)
Message-ID: <16827431.1267696606015.JavaMail.ngmail@webmail13.arcor-online.net>
Date: Thu, 4 Mar 2010 10:56:46 +0100 (CET)
From: "Albrecht Dreﬂ" <albrecht.dress@arcor.de>
To: grant.likely@secretlab.ca, albrecht.dress@arcor.de
Subject: Re: [Patch v.2] mpc5200b/uart: improve baud rate calculation (reach
	high baud rates, better accuracy)
In-Reply-To: <fa686aa41003031307j79e004cfk49297e419a65f5da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa41003031307j79e004cfk49297e419a65f5da@mail.gmail.com>
	<1267640583.4760.0@antares>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant:

Thanks a lot for your input!

[snip]
> Save yourself some duplicated code here.  The above 14 lines can be
> shared between the 512x, 52xx and 5200b versions.  Create yourself an
> internal __mpc5xxx_psc_set_divisor() function that is passed the *psc,
> the divisor, and the clock select register setting (both the 5200 and
> the 5121 have the clock select register).

Hmm, yes, that's true.  Will look into that.

[snip]
> > @@ -604,7 +676,6 @@ mpc52xx_uart_set_termios(struct uart_por
> >
> > =A0 =A0 =A0 =A0baud =3D uart_get_baud_rate(port, new, old, 0, port->uar=
tclk/16);
>=20
> I'm probably nitpicking, because I don't know if the io pin will
> handle this speed but uartclk/16 is no longer the maximum baudrate if
> a /4 prescaler is used.

Yes, you are right. Must of course be fixed.

[snip]
> > @@ -635,8 +706,7 @@ mpc52xx_uart_set_termios(struct uart_por
> > =A0 =A0 =A0 =A0out_8(&psc->command, MPC52xx_PSC_SEL_MODE_REG_1);
> > =A0 =A0 =A0 =A0out_8(&psc->mode, mr1);
> > =A0 =A0 =A0 =A0out_8(&psc->mode, mr2);
> > - =A0 =A0 =A0 out_8(&psc->ctur, ctr >> 8);
> > - =A0 =A0 =A0 out_8(&psc->ctlr, ctr & 0xff);
> > + =A0 =A0 =A0 psc_ops->set_divisor(port, quot);
>=20
> Hmmm.  The divisor calculations have some tricky bits to them.  I
> would consider changing the set_divisor() function to accept a baud
> rate, and modify the set_divisor function to call uart_get_divisor().

That sounds like a good idea to me.  I will change the code that way.

> That way each set_divisor() can do whatever makes the most sense for
> the divisors available to it.  The 5121 for example has both a /10 and
> a /32 divisor, plus it can use an external clock.

Ouch.  I don't have a 512x, but isn't the current code plain wrong then?  I=
t uses mpc5xxx_get_bus_frequency() as input for the baud rate calculation, =
and if the serial code assumes /16 instead of /10, the result must be terri=
bly off.  Or did I miss something here?

Best, Albrecht.

Tolle Dekollet=E9s oder scharfe Tatoos? Vote jetzt ... oder mach selbst mit=
 und zeige Deine Schokoladenseite
bei Topp oder Hopp von Arcor: http://www.arcor.de/rd/footer.toh
