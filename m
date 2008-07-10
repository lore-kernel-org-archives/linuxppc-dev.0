Return-Path: <wsa@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 61336DDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2008 22:39:19 +1000 (EST)
Date: Thu, 10 Jul 2008 14:39:09 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [BUG] fec_mpc52xx: Don't call mpc52xx_fec_reset() in ISR
Message-ID: <20080710123909.GA4275@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Cc: domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

today, I was debugging a kernel crash on a board with a MPC5200B using
2.6.26-rc9. I found the following code in drivers/net/fec_mpc52xx.c:

static irqreturn_t mpc52xx_fec_interrupt(int irq, void *dev_id)
{
[...]
	/* on fifo error, soft-reset fec */
	if (ievent & (FEC_IEVENT_RFIFO_ERROR | FEC_IEVENT_XFIFO_ERROR)) {

		if (net_ratelimit() && (ievent & FEC_IEVENT_RFIFO_ERROR))
			dev_warn(&dev->dev, "FEC_IEVENT_RFIFO_ERROR\n");
		if (net_ratelimit() && (ievent & FEC_IEVENT_XFIFO_ERROR))
			dev_warn(&dev->dev, "FEC_IEVENT_XFIFO_ERROR\n");

		mpc52xx_fec_reset(dev);

		netif_wake_queue(dev);
		return IRQ_HANDLED;
	}
[...]
}

Calling mpc52xx_fec_reset() from interrupt context is bad, at least
because

a) it calls phy_write, which contains BUG_ON(in_interrupt())
b) it calls mpc52xx_fec_hw_init, which has a delay-loop to check
   if the reset was successful (1..50 us)

I assume the proper thing to do is to set a flag in the ISR and handle
the soft reset later in some other context. Having never dealt with the
network core and its drivers so far, I am not sure which place would be
the right one to perform the soft reset. To not make things worse, I
hope people with more insight to network stuff can deliver a suitable
solution to this problem.

All the best,

   Wolfram

--=20
  Dipl.-Ing. Wolfram Sang | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIdgLtD27XaX1/VRsRAgXeAKCl8ge5pQxRUdNqKypdbsE/5qPI1wCgkbnz
cEcT55Msv+xiRtm5fXycRWg=
=7a8w
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
