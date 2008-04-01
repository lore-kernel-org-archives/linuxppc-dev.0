Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 05B53DE020
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:38:11 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv4 5/5] cpm2: Reset the CPM when early debugging is not enabled.
Date: Tue, 1 Apr 2008 14:35:55 +0200
References: <200804011433.29841.laurentp@cse-semaphore.com>
In-Reply-To: <200804011433.29841.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart34492018.48kukJvuPK";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804011435.55969.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart34492018.48kukJvuPK
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Similarly to what is done for PQ1-based platforms, this patch resets the
PQ2 Communication Processor Module in cpm2_reset() when early debugging is
not enabled. This helps avoiding conflicts when the boot loader configured
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

--nextPart34492018.48kukJvuPK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8iwr8y9gWxC9vpcRAhfNAJ94Xv1T3XzXhBM7qQrc4U4HzbLTTACghksk
7Si2X/156zUYNqxT684De8c=
=iwoS
-----END PGP SIGNATURE-----

--nextPart34492018.48kukJvuPK--
