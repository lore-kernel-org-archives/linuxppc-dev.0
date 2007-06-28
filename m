Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id ED6DCDDFDA
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 21:15:10 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id l5SBF6O1116270
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 11:15:06 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l5SBF6EV2162712
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 13:15:06 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l5SBF5H2017953
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Jun 2007 13:15:06 +0200
Date: Thu, 28 Jun 2007 13:14:38 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Subject: Re: PMI breakage in cell_defconfig
Message-ID: <20070628131438.274a796e@localhost>
In-Reply-To: <20070628115049.393e8a6d@localhost>
References: <1182902559.32153.13.camel@concordia.ozlabs.ibm.com>
	<20070627161545.468b03ba@localhost>
	<18051.5736.648631.189740@cargo.ozlabs.ibm.com>
	<20070628115049.393e8a6d@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_fXG7A7k+yliT3VA=QXqbmgH";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: Christian Krafft <krafft@de.ibm.com>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_fXG7A7k+yliT3VA=QXqbmgH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Subject: cbe_cpufreq: fix build error

From: Christian Krafft <krafft@de.ibm.com>

The cbe_cpufreq driver should build without PMI
interface. The code that deals with PMI has been
#ifdef'ed out. This is not the optimal solution for now.
A later version of the cpufreq driver has been cleaned out
from all PMI code. Until that patch makes it into the kernel
use this patch to fix build issues when building cpufreq driver without PMI.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.orig/arch/powerpc/platforms/cell/cbe_cpufreq.c
+++ linux/arch/powerpc/platforms/cell/cbe_cpufreq.c
@@ -74,6 +74,7 @@ static unsigned int pmi_frequency_limit=20
=20
 static struct of_device *pmi_dev;
=20
+#ifdef CONFIG_PPC_PMI
 static int set_pmode_pmi(int cpu, unsigned int pmode)
 {
 	int ret;
@@ -102,7 +103,7 @@ static int set_pmode_pmi(int cpu, unsign
 #endif
 	return ret;
 }
-
+#endif
=20
 static int get_pmode(int cpu)
 {
@@ -157,9 +158,11 @@ static int set_pmode_reg(int cpu, unsign
 }
=20
 static int set_pmode(int cpu, unsigned int slow_mode) {
+#ifdef CONFIG_PPC_PMI
 	if (pmi_dev)
 		return set_pmode_pmi(cpu, slow_mode);
 	else
+#endif
 		return set_pmode_reg(cpu, slow_mode);
 }
=20
@@ -323,26 +326,28 @@ static struct cpufreq_driver cbe_cpufreq
=20
 static int __init cbe_cpufreq_init(void)
 {
+#ifdef CONFIG_PPC_PMI
 	struct device_node *np;
-
+#endif
 	if (!machine_is(cell))
 		return -ENODEV;
-
+#ifdef CONFIG_PPC_PMI
 	np =3D of_find_node_by_type(NULL, "ibm,pmi");
=20
 	pmi_dev =3D of_find_device_by_node(np);
=20
 	if (pmi_dev)
 		pmi_register_handler(pmi_dev, &cbe_pmi_handler);
-
+#endif
 	return cpufreq_register_driver(&cbe_cpufreq_driver);
 }
=20
 static void __exit cbe_cpufreq_exit(void)
 {
+#ifdef CONFIG_PPC_PMI
 	if (pmi_dev)
 		pmi_unregister_handler(pmi_dev, &cbe_pmi_handler);
-
+#endif
 	cpufreq_unregister_driver(&cbe_cpufreq_driver);
 }
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


--Sig_fXG7A7k+yliT3VA=QXqbmgH
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGg5gs6rqK4qDx+dcRAg+YAJ40QF3lbsPSE91jadpdO/Wj1VkzkgCgmejz
4L2Ak9Jhy3TByfoapaPjlaU=
=G8nw
-----END PGP SIGNATURE-----

--Sig_fXG7A7k+yliT3VA=QXqbmgH--
