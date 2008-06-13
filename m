Return-Path: <krafft@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2A3DDE08F
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 01:37:03 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.8/8.13.8) with ESMTP id m5DFaqQu040276
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 15:36:52 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v9.0) with
	ESMTP id m5DFaqbS4157500
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 17:36:52 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id m5DFaqi9001508
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 17:36:52 +0200
Date: Fri, 13 Jun 2008 17:36:49 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [RFC] poweroff via pm_power_off if set
Message-ID: <20080613173649.5451976e@de.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/STVW3a14O6lLFUEuUw_eSe=";
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: krafft@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_/STVW3a14O6lLFUEuUw_eSe=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

This patch is needed to make ipmi_poweroff working on powerpc.
It straightens the poweroff procedure to match with other architectures.
At the moment powerpc plattforms can define their poweroff method using
ppc_md.power_off. The only way for plattform independent driver (ipmi_power=
off)
to register it's poweroff function is to use pm_power_off. So machine_power=
_off
should check whether pm_power_off has been set and if so it should be used.
If not, plattform dependent ppc_md.power_off should be called.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux.git/arch/powerpc/kernel/setup-common.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux.git.orig/arch/powerpc/kernel/setup-common.c
+++ linux.git/arch/powerpc/kernel/setup-common.c
@@ -121,6 +121,8 @@ void machine_restart(char *cmd)
 void machine_power_off(void)
 {
 	machine_shutdown();
+	if (pm_power_off)
+		pm_power_off();
 	if (ppc_md.power_off)
 		ppc_md.power_off();
 #ifdef CONFIG_SMP
@@ -133,7 +135,7 @@ void machine_power_off(void)
 /* Used by the G5 thermal driver */
 EXPORT_SYMBOL_GPL(machine_power_off);
=20
-void (*pm_power_off)(void) =3D machine_power_off;
+void (*pm_power_off)(void) =3D NULL;
 EXPORT_SYMBOL_GPL(pm_power_off);
=20
 void machine_halt(void)


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

--Sig_/STVW3a14O6lLFUEuUw_eSe=
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQFIUpQU6rqK4qDx+dcRAoX2AJ9/+QO+xFBG3B2BKglRtJBpAymEjgCfUqb6
iFDOT7teWSY4kz+6zyNo8e0=
=qIvl
-----END PGP SIGNATURE-----

--Sig_/STVW3a14O6lLFUEuUw_eSe=--
