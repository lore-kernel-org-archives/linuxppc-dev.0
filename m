Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 57C23DE028
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 21:38:21 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 linux-serial@vger.kernel.org
Subject: [RFC] cpm_uart: Fix break generation
Date: Thu, 26 Jun 2008 13:38:14 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart12031472.ByL2JTWP1D";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806261338.19358.laurentp@cse-semaphore.com>
Cc: scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart12031472.ByL2JTWP1D
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When generating a break condition on a serial port, the CPM must be told
beforehand how long the break should be. Unfortunately, this information is
not available through the current serial break handling API. This patch wor=
ks
around the problem by requesting a 32767 characters break followed by a 0
characters break after the requested duration. The CPM will stop the first
break when the second one is requested. This might not work with future CPM
revisions.

An alternative would be to change the serial break handling API to pass the=
=20
break duration down to the serial drivers.

=2D--
 drivers/serial/cpm_uart/cpm_uart_core.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/cpm_uart/cpm_uart_core.c=20
b/drivers/serial/cpm_uart/cpm_uart_core.c
index c29d87d..aa0a284 100644
=2D-- a/drivers/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/serial/cpm_uart/cpm_uart_core.c
@@ -268,14 +268,23 @@ static void cpm_uart_break_ctl(struct uart_port *port=
,=20
int break_state)
 static void cpm_uart_break_ctl(struct uart_port *port, int break_state)
 {
 	struct uart_cpm_port *pinfo =3D (struct uart_cpm_port *)port;
+	volatile u16 *brkcr =3D IS_SMC(pinfo) ? &pinfo->smcup->smc_brkcr
+				: &pinfo->sccup->scc_brkcr;
=20
 	pr_debug("CPM uart[%d]:break ctrl, break_state: %d\n", port->line,
 		break_state);
=20
 	if (break_state)
+	{
+		*brkcr =3D 32767;
 		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
+	}
 	else
+	{
+		*brkcr =3D 0;
+		cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
 		cpm_line_cr_cmd(pinfo, CPM_CR_RESTART_TX);
+	}
 }
=20
 /*
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

--nextPart12031472.ByL2JTWP1D
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY3+r8y9gWxC9vpcRAnMtAJ4onySNqgrTNRYHA0ceYGjbQhnjwACg2jhP
Yq0sa913L+cpVz6xkPJfByM=
=wUFO
-----END PGP SIGNATURE-----

--nextPart12031472.ByL2JTWP1D--
