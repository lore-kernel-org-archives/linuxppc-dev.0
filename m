Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id D102CDDEEB
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 02:36:57 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 2B9474501
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 16:36:55 +0100 (CET)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 0FA7141E8
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 16:36:55 +0100 (CET)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: [PATCH] fs_enet: Don't call NAPI functions when NAPI is not used.
Date: Thu, 28 Feb 2008 16:36:47 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1920599.eM8EEF6dkO";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802281636.53815.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1920599.eM8EEF6dkO
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

fs_enet_close() calls napi_disable() unconditionally. This patch skips the
call when use_napi isn't set.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 drivers/net/fs_enet/fs_enet-main.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/net/fs_enet/fs_enet-main.c=20
b/drivers/net/fs_enet/fs_enet-main.c
index c83bd65..1801ce3 100644
=2D-- a/drivers/net/fs_enet/fs_enet-main.c
+++ b/drivers/net/fs_enet/fs_enet-main.c
@@ -835,7 +835,8 @@ static int fs_enet_close(struct net_device *dev)
=20
 	netif_stop_queue(dev);
 	netif_carrier_off(dev);
=2D	napi_disable(&fep->napi);
+	if (fep->fpi->use_napi)
+		napi_disable(&fep->napi);
 	phy_stop(fep->phydev);
=20
 	spin_lock_irqsave(&fep->lock, flags);
=2D-=20
1.5.0

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1920599.eM8EEF6dkO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBHxtUV8y9gWxC9vpcRAmT8AJ4/5JqfIckRxBZGWNmMJhKPjLruKQCgiW36
9vWPnYPkKvAcOXuPeKcS3Vc=
=mnlh
-----END PGP SIGNATURE-----

--nextPart1920599.eM8EEF6dkO--
