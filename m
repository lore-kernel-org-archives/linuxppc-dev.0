Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 8DDE0DE44B
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:55:12 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org,
	galak@kernel.crashing.org
Subject: [PATCH] cpm_uart: Support uart_wait_until_sent()
Date: Thu, 26 Jun 2008 13:55:03 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1881114.T7qVHi569F";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806261355.09334.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1881114.T7qVHi569F
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Set port->fifosize to the software FIFO size, and update the port timeout
when the baud rate is modified. SCC ports have an optional 32 byte hardware
=46IFO which is currently not taken into account, as there is no documented=
 way
to check when the FIFO becomes empty.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/serial/cpm_uart/cpm_uart_core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c b/drivers/serial/cpm_u=
art/cpm_uart_core.c
index a19dc7e..151cad2 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -547,6 +547,11 @@ static void cpm_uart_set_termios(struct uart_port *por=
t,
 	}
=20
 	/*
+	 * Update the timeout
+	 */
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	/*
 	 * Set up parity check flag
 	 */
 #define RELEVANT_IFLAG(iflag) (iflag & (IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK))
@@ -1154,6 +1159,7 @@ int cpm_uart_drv_get_platform_data(struct platform_de=
vice *pdev, int is_con)
 	pinfo->port.uartclk =3D pdata->uart_clk;
 	pinfo->port.mapbase =3D (unsigned long)mem;
 	pinfo->port.irq =3D platform_get_irq(pdev, 0);
+	pinfo->port.fifosize =3D pinfo->tx_nrfifos * pinfo->tx_fifosize;
=20
 	return 0;
 }
=2D-=20
1.5.0

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1881114.T7qVHi569F
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY4Od8y9gWxC9vpcRArheAJ4itu/nIrMxuLJezvl9sfvRgLR10wCg30AR
+fJA5hFGrrneVnZDLsdzKGA=
=hS1Q
-----END PGP SIGNATURE-----

--nextPart1881114.T7qVHi569F--
