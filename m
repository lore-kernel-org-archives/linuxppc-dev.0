Return-Path: <wsa@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by ozlabs.org (Postfix) with ESMTP id 35B9BDE035
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 16:42:33 +1000 (EST)
Date: Wed, 20 May 2009 08:42:18 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: mpc5200 fec error
Message-ID: <20090520064218.GA29102@pengutronix.de>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
In-Reply-To: <fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > I am able to reproduce the error using 2.6.29.2-rt11. =A0I was able to
> > mitigate the problem by raising the priority of the transmit irq.
> > However when running an NFS server on the pcm030 under high cpu load I
> > now get
> >
> > [ =A0132.477503] net eth0: FEC_IEVENT_RFIFO_ERROR
> > [ =A0132.892329] net eth0: FEC_IEVENT_RFIFO_ERROR
> > [ =A0133.884109] net eth0: FEC_IEVENT_RFIFO_ERROR
> > [ =A0134.876059] net eth0: FEC_IEVENT_RFIFO_ERROR
> >
> > Raising the priority of the rx irq does not seem to fix this problem
> > though.
>=20
> Hi Eric,
>=20
> This error has been seen before in non-rt kernels.  I haven't had the
> chance to track it down and kill it yet.  I believe there are locking
> issues associated with it.

Uuuh, I recall this message. Kept me busy for some time :(

You might try this patch which helped in our situation.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Subject: Enable XLB pipelining for MPC5200B
=46rom: Wolfram Sang <w.sang@pengutronix.de>

Enable pipelining as it helps getting rid of FEC problems.
Not intended for upstream, this must be dealt differently there.

This patch is disabled by default. The bootloader should enable this featur=
e.
So, this patch is only intended to be used where the bootloader does it in a
wrong manner and can't be replaced.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Acked-by: Juergen Beisert <j.beisert@pengutronix.de>

---
 arch/powerpc/platforms/52xx/mpc52xx_common.c |    7 +++++++
 1 file changed, 7 insertions(+)

Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
+++ arch/powerpc/platforms/52xx/mpc52xx_common.c
@@ -107,6 +107,13 @@ mpc5200_setup_xlb_arbiter(void)
 	 */
 	if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) =3D=3D MPC5200_SVR)
 		out_be32(&xlb->config, in_be32(&xlb->config) | MPC52xx_XLB_CFG_PLDIS);
+#if 0
+	/*
+	 * Enable pipelining, fixes FEC problems. The previous workaround is not
+	 * needed, as we have an MPC5200B (not A).
+	 */
+	out_be32(&xlb->config, in_be32(&xlb->config) & ~MPC52xx_XLB_CFG_PLDIS);
+#endif
=20
 	iounmap(xlb);
 }

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkoTpkoACgkQD27XaX1/VRsYzACfZIXPnRXQrTOSt3kSSB9cwOZy
m6wAoLaEOW2INgrfwCdJZbxbZHSlefhN
=QfT1
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
