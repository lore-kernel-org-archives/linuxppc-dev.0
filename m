Return-Path: <krafft@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97847DE092
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 04:37:33 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m1DHbSG9167254
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:37:28 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1DHbSAs974986
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:37:28 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1DHbCks010183
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:37:12 GMT
Date: Wed, 13 Feb 2008 18:37:01 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch 2/2] powerpc: i2c-isa: add access check to legacy ioports
Message-ID: <20080213183701.254391cc@de.ibm.com>
In-Reply-To: <20080213182800.5c6940a8@de.ibm.com>
References: <20080213182800.5c6940a8@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x82tJ18quo/VNEsVC.yFIHh";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: parabelboi@bopserverein.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/x82tJ18quo/VNEsVC.yFIHh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

when probing i2c-pca-isa writes to legacy ioports, which crashes the kernel
if there is no device at that port.
This patch adds a check_legacy_ioport call, so probe failes gracefully
and thus prevents the oops.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/drivers/i2c/busses/i2c-pca-isa.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.git.orig/drivers/i2c/busses/i2c-pca-isa.c
+++ linux.git/drivers/i2c/busses/i2c-pca-isa.c
@@ -125,6 +125,13 @@ static int __devinit pca_isa_probe(struc
=20
 	dev_info(dev, "i/o base %#08lx. irq %d\n", base, irq);
=20
+#ifdef CONFIG_PPC_MERGE
+	if (check_legacy_ioport(base)) {
+		dev_err(dev, "I/O address %#08lx is not available\n", base);
+		goto out;
+	}
+#endif
+
 	if (!request_region(base, IO_SIZE, "i2c-pca-isa")) {
 		dev_err(dev, "I/O address %#08lx is in use\n", base);
 		goto out;


--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294

--Sig_/x82tJ18quo/VNEsVC.yFIHh
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHsyq/6rqK4qDx+dcRAqGjAKCAH0JTGXPrVDXCrvdKzhrhyEAb/QCfc3s/
v52DW2XZKyxbLJ4+ATJir8o=
=kR/U
-----END PGP SIGNATURE-----

--Sig_/x82tJ18quo/VNEsVC.yFIHh--
