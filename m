Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 45510DE05F
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:43:49 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv3 4/4] cpm2: Reset the CPM when early debugging is not enabled.
Date: Mon, 31 Mar 2008 18:37:38 +0200
References: <200803311834.42327.laurentp@cse-semaphore.com>
In-Reply-To: <200803311834.42327.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2606033.fMOz5CsjL5";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311837.38744.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2606033.fMOz5CsjL5
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

--nextPart2606033.fMOz5CsjL5
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8RNS8y9gWxC9vpcRAuRWAKCF4nwbv4YYGf3oqHEWDNTXIyHIdQCglngQ
qocWiZWV/7vdDFcxKPW42dU=
=UuhP
-----END PGP SIGNATURE-----

--nextPart2606033.fMOz5CsjL5--
