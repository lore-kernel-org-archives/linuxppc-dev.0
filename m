Return-Path: <l.fu@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id B4F22DE137
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jul 2008 21:43:48 +1000 (EST)
Date: Fri, 25 Jul 2008 13:43:41 +0200
From: Luotao Fu <l.fu@pengutronix.de>
To: spi-devel-general@lists.sourceforge.net, linuxppc-dev@ozlabs.org
Subject: [spi][mpc52xx][PATCH] Fix mpc52xx_psc_spi master driver
Message-ID: <20080725114341.GB6415@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vEao7xgI/oilGqZ+"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--vEao7xgI/oilGqZ+
Content-Type: multipart/mixed; boundary="3lcZGd9BuhuYXNfi"
Content-Disposition: inline


--3lcZGd9BuhuYXNfi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is a fix for full duplex transfer mode on the mpc52xx_psc_spi driver.
Details see the patch header. Tested on a mpc5200b board.

Cheers
Luotao fu
--=20
   Dipl.-Ing. Luotao Fu | Phone: +49-5121-206917-3
Pengutronix - Linux Solutions for Science and Industry
Entwicklungszentrum Nord     http://www.pengutronix.de


--3lcZGd9BuhuYXNfi
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="mpc52xx_psc_spi_fix_block_send.diff"
Content-Transfer-Encoding: quoted-printable

=46rom: Luotao Fu <l.fu@pengutronix.de>
Subject: fix block transfer on mpc52xx psc spi

  The block transfer routine in the mpc52xx psc spi driver misinterpret the
  datasheet. According to the processor datasheet the chipselect is held as
  long as the EOF is not written. Theoretically block of any sizes can be
  transferd in this way. The old routine however writes an EOF after every
  word, which has the size of size_of_word. This makes the transfer slow.
  Also fixed some duplicate code.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>

---
 drivers/spi/mpc52xx_psc_spi.c |   22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

Index: drivers/spi/mpc52xx_psc_spi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/spi/mpc52xx_psc_spi.c.orig
+++ b/drivers/spi/mpc52xx_psc_spi.c
@@ -146,7 +146,6 @@ static int mpc52xx_psc_spi_transfer_rxtx
 	unsigned rfalarm;
 	unsigned send_at_once =3D MPC52xx_PSC_BUFSIZE;
 	unsigned recv_at_once;
-	unsigned bpw =3D mps->bits_per_word / 8;
=20
 	if (!t->tx_buf && !t->rx_buf && t->len)
 		return -EINVAL;
@@ -162,22 +161,15 @@ static int mpc52xx_psc_spi_transfer_rxtx
 		}
=20
 		dev_dbg(&spi->dev, "send %d bytes...\n", send_at_once);
-		if (tx_buf) {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& (sb + 1) % bpw =3D=3D 0)
-					out_8(&psc->ircr2, 0x01);
+		for (; send_at_once; sb++, send_at_once--) {
+			/* set EOF flag before the last word is sent */
+			if (send_at_once =3D=3D 1)
+				out_8(&psc->ircr2, 0x01);
+
+			if (tx_buf)
 				out_8(&psc->mpc52xx_psc_buffer_8, tx_buf[sb]);
-			}
-		} else {
-			for (; send_at_once; sb++, send_at_once--) {
-				/* set EOF flag */
-				if (mps->bits_per_word
-						&& ((sb + 1) % bpw) =3D=3D 0)
-					out_8(&psc->ircr2, 0x01);
+			else
 				out_8(&psc->mpc52xx_psc_buffer_8, 0);
-			}
 		}
=20
=20

--3lcZGd9BuhuYXNfi--

--vEao7xgI/oilGqZ+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIibxtiruQY+UyUmERAnrnAJ9oG8A0N0/uPe+rL3fv/ELUTnTL6gCeKx8D
i6ERK59IhmvpbVUcK4wDCKA=
=iisq
-----END PGP SIGNATURE-----

--vEao7xgI/oilGqZ+--
