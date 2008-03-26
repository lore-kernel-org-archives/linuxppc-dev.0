Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 30D63DDFD8
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 22:21:14 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv2 0/3] cpm2: Reset the CPM when early debugging is not enabled.
Date: Wed, 26 Mar 2008 12:21:12 +0100
References: <200803261217.46671.laurentp@cse-semaphore.com>
In-Reply-To: <200803261217.46671.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1501631.usu8nvKoro";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803261221.12274.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1501631.usu8nvKoro
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Similarly to what is done for PQ1-based platforms, this patch resets the
PQ2 Communication Processor Module in cpm2_reset() when early debugging
is not enabled. This helps avoiding conflicts when the boot loader configur=
ed
the CPM in an unexpected way.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/sysdev/cpm2.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 7be7112..57ed1a4 100644
=2D-- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -80,6 +80,12 @@ void __init cpm2_reset(void)
 	/* Tell everyone where the comm processor resides.
 	 */
 	cpmp =3D &cpm2_immr->im_cpm;
+
+#ifndef CONFIG_PPC_EARLY_DEBUG_CPM
+	/* Reset the CPM.
+	 */
+	cpm_command(CPM_CR_RST, 0);
+#endif
 }
=20
 static DEFINE_SPINLOCK(cmd_lock);
=2D-=20
1.5.0


=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=C3=A9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1501631.usu8nvKoro
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH6jGo8y9gWxC9vpcRArN9AKCQ8YMcy6voYz1LyQ+v1bCkCzoQywCffQNz
NhJfIsPt83JxtadhOeY1Jak=
=VqRZ
-----END PGP SIGNATURE-----

--nextPart1501631.usu8nvKoro--
