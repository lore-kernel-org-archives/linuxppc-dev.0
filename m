Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id BCAEDDDF89
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 19:48:29 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org,
 netdev@vger.kernel.org
Subject: [PATCHv2] fs_enet: restore promiscuous and multicast settings in
	restart()
Date: Thu, 26 Jun 2008 11:48:22 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart9003016.thAWR5S1O3";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806261148.26569.laurentp@cse-semaphore.com>
Cc: Matvejchikov Ilya <matvejchikov@gmail.com>, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart9003016.thAWR5S1O3
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The restart() function is called when the link state changes and resets
multicast and promiscuous settings. This patch restores those settings at t=
he
end of restart().

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/net/fs_enet/mac-fcc.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index e363211..849afbe 100644
=2D-- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -463,6 +463,9 @@ static void restart(struct net_device *dev)
 	else
 		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
=20
+	/* Restore multicast and promiscuous settings */
+	set_multicast_list(dev);
+
 	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
 }
=20
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

--nextPart9003016.thAWR5S1O3
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIY2Xq8y9gWxC9vpcRAn+iAJ4ho6iSqLULCZ1hKG4OQzqzHVAIGQCeL4QA
cM/DwfNtOJWJbSNVj6HNKgc=
=MCsk
-----END PGP SIGNATURE-----

--nextPart9003016.thAWR5S1O3--
