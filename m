Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6D2E7DDE26
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Jun 2007 03:49:38 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l5MHnXVw031616
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 17:49:33 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l5MHnXun593938
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 19:49:33 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l5MHnXLo029208
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 19:49:33 +0200
Received: from localhost (dyn-9-152-242-67.boeblingen.de.ibm.com
	[9.152.242.67])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.12.11) with ESMTP
	id l5MHnX02028800
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jun 2007 19:49:33 +0200
Date: Fri, 22 Jun 2007 19:48:53 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: [patch] powerpc: sysfs fix compiler warning
Message-ID: <20070622194853.72fb652a@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_E7_tUgshyV/DJbz3GpZ9Vrv";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_E7_tUgshyV/DJbz3GpZ9Vrv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>

This patch fixes the following compiler warning:
arch/powerpc/kernel/sysfs.c:385: warning: ignoring return value of
`sysfs_create_group',

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.22-rc5.orig/arch/powerpc/kernel/sysfs.c
+++ linux-2.6.22-rc5/arch/powerpc/kernel/sysfs.c
@@ -380,16 +380,23 @@ int cpu_add_sysdev_attr_group(struct att
 {
 	int cpu;
 	struct sys_device *sysdev;
+	int error;
=20
 	mutex_lock(&cpu_mutex);
=20
 	for_each_possible_cpu(cpu) {
 		sysdev =3D get_cpu_sysdev(cpu);
-		sysfs_create_group(&sysdev->kobj, attrs);
+		error |=3D sysfs_create_group(&sysdev->kobj, attrs);
 	}
=20
+	if(error)
+		for_each_possible_cpu(cpu) {
+			sysdev =3D get_cpu_sysdev(cpu);
+			sysfs_remove_group(&sysdev->kobj, attrs);
+		}
+
 	mutex_unlock(&cpu_mutex);
-	return 0;
+	return error;
 }
 EXPORT_SYMBOL_GPL(cpu_add_sysdev_attr_group);
=20


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


--Sig_E7_tUgshyV/DJbz3GpZ9Vrv
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGfAuP6rqK4qDx+dcRAnJDAJ9MexyiOK/fafelksg2wK45arbQOgCfSrI7
xL8Li2agvEEyCRuLl2olxjM=
=JVw1
-----END PGP SIGNATURE-----

--Sig_E7_tUgshyV/DJbz3GpZ9Vrv--
