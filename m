Return-Path: <jbe@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3D745DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Sep 2007 01:07:56 +1000 (EST)
Received: from themisto.extern.pengutronix.de ([83.236.181.29] helo=localhost)
	by metis.extern.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <jbe@pengutronix.de>) id 1IbHRT-0003Ck-14
	for linuxppc-embedded@ozlabs.org; Fri, 28 Sep 2007 17:07:51 +0200
From: Juergen Beisert <jbe@pengutronix.de>
To: linuxppc-embedded@ozlabs.org
Date: Fri, 28 Sep 2007 17:07:44 +0200
References: <20070810095153.GC13994@moe.telargo.com>
	<200709271907.50479.jbe@pengutronix.de>
In-Reply-To: <200709271907.50479.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709281707.45030.jbe@pengutronix.de>
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

On Thursday 27 September 2007 19:07, Juergen Beisert wrote:
> On Friday 10 August 2007 11:51, Domen Puncer wrote:
> > Not for merge (yet)! But please do review.
> >
> > fec_mpc52xx driver (not in-tree, but floating around) isn't in very
> > good shape, so I tried to change that.
> > Diff against original is quite big (fec_phy.c is completely rewritten)
> > and confuzing, so I'm including whole drivers/net/fec_mpc52xx/ .
> >
> > I still have 'make CONFIG_FEC_MPC52xx_MDIO=3Dn compile and work' on my
> > TODO, maybe even ethtool support.

I add a few more debug outputs and now with this driver I can run a

$ nmap <ip>

from my host against the target and target's network stops always at the sa=
me=20
point.

The last output from the driver is (with DEBUG macro defined):

net eth0: ievent: 08020000

and no further interrupt occurs anymore (I checked all three interrupt entr=
y=20
functions)

nmap on host's side outputs:

Starting Nmap 4.20 ( http://insecure.org ) at 2007-09-28 16:56 CEST
Interesting ports on 192.168.23.226:
Not shown: 852 filtered ports, 843 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
23/tcp open  telnet

Nmap finished: 1 IP address (1 host up) scanned in 14.120 seconds

But I can't run it a second time, as the network on target's side doesn't=20
respond. Any idea?

Juergen

=2D-=20
Dipl.-Ing. Juergen Beisert | http://www.pengutronix.de
=A0Pengutronix - Linux Solutions for Science and Industry
=A0   Handelsregister: Amtsgericht Hildesheim, HRA 2686
=A0 =A0 =A0    Vertretung Sued/Muenchen, Germany
   Phone: +49-8766-939 228 |  Fax: +49-5121-206917-9
