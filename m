Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 243A9DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Sep 2007 19:12:31 +1000 (EST)
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 28 Sep 2007 11:12:17 +0200
References: <20070810095153.GC13994@moe.telargo.com>
	<9e4733910709271112y100e55e8q100336ce95acaf3f@mail.gmail.com>
	<46FBF9B7.9010007@freescale.com>
In-Reply-To: <46FBF9B7.9010007@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709281112.18480.jbe@pengutronix.de>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 27 September 2007 20:43, Scott Wood wrote:
> Jon Smirl wrote:
> > The call to msleep() is inside a block protected with
> >
> > :#define in_interrupt()          (irq_count())
> >
> > if (!in_interrupt)
> >
> > The stack trace looks like it is in a timer interrupt so shouldn't
> > irq_count be non-zero?
> > Could there be some lack of coordination on irq_count and the timer
> > tick with the preempt patch applied?  Or does irq_count() not count
> > soft irqs?
> >
> > (!in_interrupt) may be the wrong way to protect this code.
>
> I think in_atomic() is what you want.

I tried with in_atomic(). The BUG report is gone, but the problem still=20
exists.=20

While network stress testing:=20

[...]
NETDEV WATCHDOG: eth0: transmit timed out
net eth0: transmit timed out
net eth0: queues didn't drain
net eth0:   tx: index: 35, outdex: 36
net eth0:   rx: index: 24, outdex: 25
PHY: f0003000:00 - Link is Down
PHY: f0003000:00 - Link is Up - 100/Full

The link is up again, but any connection is dead (no answers to ping etc.).=
=20
But the serial console is still working. I'm not sure if the RT-Preempt pat=
ch=20
*causes* this behavior or only *discover* it. Any idea?

Juergen
=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=C2=A0Pengutronix - Linux Solutions for Science and Industry
=C2=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=C2=A0 =C2=A0 =C2=A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
