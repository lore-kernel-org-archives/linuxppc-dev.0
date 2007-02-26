Return-Path: <krafft@de.ibm.com>
Received: from mtagate3.uk.ibm.com (mtagate3.uk.ibm.com [195.212.29.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C6A4CDDEE0
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 02:11:36 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate3.uk.ibm.com (8.13.8/8.13.8) with ESMTP id l1QFBQ06043486
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 15:11:26 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.2) with
	ESMTP id l1QFBPxZ1233026
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 15:11:26 GMT
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l1QFBOPo001552
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Feb 2007 15:11:25 GMT
Date: Mon, 26 Feb 2007 16:09:17 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: michael@ellerman.id.au
Subject: [patch] ipmi: check, if default ports are accessible on PPC
Message-ID: <20070226160917.2c801ec7@localhost>
In-Reply-To: <1172295412.16060.8.camel@concordia.ozlabs.ibm.com>
References: <1172223703.4695.59.camel@concordia.ozlabs.ibm.com>
	<20070223135859.62e19ca8@localhost>
	<1172295412.16060.8.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_h/1zvgsRiDF15f.Tx0lelNo";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	"openipmi-developer@lists.sourceforge.net"
	<openipmi-developer@lists.sourceforge.net>,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_h/1zvgsRiDF15f.Tx0lelNo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Subject: ipmi: check, if default ports are accessible on PPC

From: Christian Krafft <krafft@de.ibm.com>

ipmi_si_intf tries to access default ports, if no device could
be found elsewhere. On PPC we have a function to check,
if these legacy IO ports are accessible. This patch adds
a check for these ports on PPC.
This patch fixes a breakage of IPMI module
on PPC machines without a BMC.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/drivers/char/ipmi/ipmi_si_intf.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/drivers/char/ipmi/ipmi_si_intf.c
+++ linux/drivers/char/ipmi/ipmi_si_intf.c
@@ -2580,6 +2580,11 @@ static __devinit void default_find_bmc(v
 		if (!info)
 			return;
=20
+#ifdef CONFIG_PPC_MERGE
+		if (check_legacy_ioport(ipmi_defaults[i].port))
+			continue;
+#endif
+
 		info->addr_source =3D NULL;
=20
 		info->si_type =3D ipmi_defaults[i].type;
=20

--=20
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,
Linux Kernel Development
IT Specialist


Vorsitzender des Aufsichtsrats:	Johann Weihen
Geschaeftsfuehrung:		Herbert Kircher
Sitz der Gesellschaft:		Boeblingen
Registriergericht:		Amtsgericht Stuttgart, HRB 243294


--Sig_h/1zvgsRiDF15f.Tx0lelNo
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF4vg66rqK4qDx+dcRAhhNAKC9g5NIJ8C1qc86p6242yawAB7QWQCfUFrV
SevFBVmLX1G1RjLRnn+TG1Q=
=8sq1
-----END PGP SIGNATURE-----

--Sig_h/1zvgsRiDF15f.Tx0lelNo--
