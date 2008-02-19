Return-Path: <yoush@debian.org>
Received: from zigzag.lvk.cs.msu.su (zigzag.lvk.cs.msu.su [158.250.17.23])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B99F1DDE2A
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:52:48 +1100 (EST)
Received: from Debian-exim by zigzag.lvk.cs.msu.su with spam-scanned (Exim
	4.50) id 1JRbxA-0002CC-A5
	for linuxppc-dev@ozlabs.org; Wed, 20 Feb 2008 02:32:51 +0300
Received: from ppp85-140-97-220.pppoe.mtu-net.ru ([85.140.97.220] helo=blacky)
	by zigzag.lvk.cs.msu.su with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA:32)
	(Exim 4.50) id 1JRbxA-0002Bz-0J
	for linuxppc-dev@ozlabs.org; Wed, 20 Feb 2008 02:32:48 +0300
Received: from nikita by blacky with local (Exim 4.63)
	(envelope-from <yoush@debian.org>) id 1JRbx6-0004Ru-Gw
	for linuxppc-dev@ozlabs.org; Wed, 20 Feb 2008 02:32:44 +0300
From: "Nikita V. Youshchenko" <yoush@debian.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: don't create two devices for each cpm_uart device
	tree node
Date: Wed, 20 Feb 2008 02:32:33 +0300
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart41531025.VEMFMQtb0j";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200802200232.44486@blacky.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart41531025.VEMFMQtb0j
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


    powerpc: don't create two devices for each cpm_uart device tree node
   =20
    Code in arch/powerpc/sysdev/fsl_soc.c used to create two 'struct device'
    objects for each cpm_uart device tree node - one "fsl-cpm-scc:uart"
    in cpm_uart_of_init() and one "fsl-cpm-smc:uart" in cpm_smc_uart_of_ini=
t().
   =20
    This patch adds additional test to those routines, such that cpm_uart_o=
f_init()
    only registers devices with model "SCC", and cpm_smc_uart_of_init() only
    registers devices with model "SMC".
   =20
    Signed-off-by: Nikita Youshchenko <yoush@debian.org>

diff --git a/arch/powerpc/sysdev/fsl_soc.c b/arch/powerpc/sysdev/fsl_soc.c
index f1b8412..536f8c9 100644
=2D-- a/arch/powerpc/sysdev/fsl_soc.c
+++ b/arch/powerpc/sysdev/fsl_soc.c
@@ -890,6 +890,10 @@ static int __init cpm_uart_of_init(void)
 		const int *id;
 		const char *model;
=20
+		model =3D of_get_property(np, "model", NULL);
+		if (!model || strcmp(model, "SCC") !=3D 0)
+			continue;
+
 		memset(r, 0, sizeof(r));
 		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
=20
@@ -917,7 +921,6 @@ static int __init cpm_uart_of_init(void)
 		id =3D of_get_property(np, "device-id", NULL);
 		cpm_uart_data.fs_no =3D *id;
=20
=2D		model =3D of_get_property(np, "model", NULL);
 		strcpy(cpm_uart_data.fs_type, model);
=20
 		cpm_uart_data.uart_clk =3D ppc_proc_freq;
@@ -1175,6 +1178,10 @@ static int __init cpm_smc_uart_of_init(void)
 		const int *id;
 		const char *model;
=20
+		model =3D of_get_property(np, "model", NULL);
+		if (!model || strcmp(model, "SMC") !=3D 0)
+			continue;
+
 		memset(r, 0, sizeof(r));
 		memset(&cpm_uart_data, 0, sizeof(cpm_uart_data));
=20
@@ -1200,7 +1207,6 @@ static int __init cpm_smc_uart_of_init(void)
 			goto err;
 		}
=20
=2D		model =3D of_get_property(np, "model", NULL);
 		strcpy(cpm_uart_data.fs_type, model);
=20
 		id =3D of_get_property(np, "device-id", NULL);

--nextPart41531025.VEMFMQtb0j
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHu2ccv3x5OskTLdsRArhcAKDSBRonFVX9xKyrjVksZhO3nnKN/wCePX0c
Nf09iwP1GFuE7JEhfGBy5ps=
=6fYp
-----END PGP SIGNATURE-----

--nextPart41531025.VEMFMQtb0j--
