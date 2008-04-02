Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 1D4CEDDF19
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Apr 2008 01:46:35 +1100 (EST)
Received: from smtp.belgium.cse-semaphore.com (localhost [127.0.0.1])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id A0271AFA9
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 16:46:32 +0200 (CEST)
Received: from pclaurent.belgium.cse-semaphore.com
	(pclaurent.belgium.cse-semaphore.com [192.168.1.47])
	by smtp.belgium.cse-semaphore.com (Postfix) with ESMTP id 88434ADBF
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 16:46:32 +0200 (CEST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix CPM2 SCC1 clock initialization.
MIME-Version: 1.0
Date: Wed, 2 Apr 2008 16:46:31 +0200
Content-Type: multipart/signed; boundary="nextPart1642700.GHfaVG8Ep7";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804021646.31765.laurentp@cse-semaphore.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1642700.GHfaVG8Ep7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

A missing break statement in a switch caused cpm2_clk_setup() to initialize
SCC2 instead of SCC1. This patch fixes the bug.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/sysdev/cpm2.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 57ed1a4..7478e81 100644
=2D-- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -246,6 +246,7 @@ int cpm2_clk_setup(enum cpm_clk_target target, int cloc=
k, int mode)
 	case CPM_CLK_SCC1:
 		reg =3D &im_cpmux->cmx_scr;
 		shift =3D 24;
+		break;
 	case CPM_CLK_SCC2:
 		reg =3D &im_cpmux->cmx_scr;
 		shift =3D 16;
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

--nextPart1642700.GHfaVG8Ep7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH85xH8y9gWxC9vpcRAuktAKCAimIlYUS/1A761/7MTW8xSvxI0ACfUjOd
c/3TERju5eh6dvUZq2MpycQ=
=OO8O
-----END PGP SIGNATURE-----

--nextPart1642700.GHfaVG8Ep7--
