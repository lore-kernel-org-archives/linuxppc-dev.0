Return-Path: <krafft@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 65A0FDDF2F
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Feb 2008 04:35:45 +1100 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.8/8.13.8) with ESMTP id m1DHZf9r095214
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:35:41 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v8.7) with
	ESMTP id m1DHZfig1159354
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:35:41 GMT
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m1DHZOUR000331
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 17:35:24 GMT
Date: Wed, 13 Feb 2008 18:35:06 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/2] powerpc: avoid userspace poking to legacy ioports
Message-ID: <20080213183506.7f3e3145@de.ibm.com>
In-Reply-To: <20080213182800.5c6940a8@de.ibm.com>
References: <20080213182800.5c6940a8@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_wYLmS1NbLHChwWL=X7NGlm";
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

--Sig_/_wYLmS1NbLHChwWL=X7NGlm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

sensors_detect crashes kernel on PowerPC, as it pokes directly to memory.
This patch adds a check_legacy_ioports to read_port and write_port.
It will now return ENXIO, instead of oopsing.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/drivers/char/mem.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.git.orig/drivers/char/mem.c
+++ linux.git/drivers/char/mem.c
@@ -566,8 +566,13 @@ static ssize_t read_port(struct file * f
 	char __user *tmp =3D buf;
=20
 	if (!access_ok(VERIFY_WRITE, buf, count))
-		return -EFAULT;=20
+		return -EFAULT;
+
 	while (count-- > 0 && i < 65536) {
+#ifdef CONFIG_PPC_MERGE
+		if (check_legacy_ioport(i))
+			return -ENXIO;
+#endif
 		if (__put_user(inb(i),tmp) < 0)=20
 			return -EFAULT; =20
 		i++;
@@ -585,6 +590,7 @@ static ssize_t write_port(struct file *=20
=20
 	if (!access_ok(VERIFY_READ,buf,count))
 		return -EFAULT;
+
 	while (count-- > 0 && i < 65536) {
 		char c;
 		if (__get_user(c, tmp)) {
@@ -592,6 +598,10 @@ static ssize_t write_port(struct file *=20
 				break;
 			return -EFAULT;=20
 		}
+#ifdef CONFIG_PPC_MERGE
+		if (check_legacy_ioport(i))
+			return -ENXIO;
+#endif
 		outb(c,i);
 		i++;
 		tmp++;


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

--Sig_/_wYLmS1NbLHChwWL=X7NGlm
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFHsypM6rqK4qDx+dcRAlT5AJ9MxPye669npMZstG3636Hho1K2QgCcDl4e
US7ZWRXGItZIEv/zPYV1PdA=
=crdG
-----END PGP SIGNATURE-----

--Sig_/_wYLmS1NbLHChwWL=X7NGlm--
