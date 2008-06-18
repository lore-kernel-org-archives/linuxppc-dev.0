Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id A8788DE1DB
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 01:07:20 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	pantelis.antoniou@gmail.com, vbordug@ru.mvista.com
Subject: [PATCH] fs_enet: restore promiscuous and multicast settings in
	restart()
Date: Wed, 18 Jun 2008 17:07:07 +0200
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1386118.M8y5TnNNF1";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200806181707.17739.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1386118.M8y5TnNNF1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The restart() function is called when the link state changes and resets
multicast and promiscous settings. This patch restores those settings at the
end of restart().

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/net/fs_enet/mac-fcc.c     |    3 +++
 2 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/mac-fcc.c b/drivers/net/fs_enet/mac-fcc.c
index ce40cf9..1a95cf1 100644
=2D-- a/drivers/net/fs_enet/mac-fcc.c
+++ b/drivers/net/fs_enet/mac-fcc.c
@@ -464,6 +464,9 @@ static void restart(struct net_device *dev)
 		C32(fccp, fcc_fpsmr, FCC_PSMR_FDE | FCC_PSMR_LPB);
=20
 	S32(fccp, fcc_gfmr, FCC_GFMR_ENR | FCC_GFMR_ENT);
+
+	/* Restore multicast and promiscous settings */
+	set_multicast_list(dev);
 }
=20
 static void stop(struct net_device *dev)
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

--nextPart1386118.M8y5TnNNF1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBIWSSl8y9gWxC9vpcRAuYCAKDT9dcrHrpeZyli5c9AFpUr2ALLxQCgx95Z
itlXbHcTrA/+ZK8T6WbE0Qg=
=Wu/5
-----END PGP SIGNATURE-----

--nextPart1386118.M8y5TnNNF1--
