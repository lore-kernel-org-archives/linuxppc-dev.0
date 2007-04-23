Return-Path: <krafft@de.ibm.com>
Date: Mon, 23 Apr 2007 20:22:23 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch 1/2] powerpc: add check for initialized driver data to pmi
	driver
Message-ID: <20070423202223.549bf53a@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary=Sig_.jDnS61Vy+I1tLWddR+0toJ;
	protocol="application/pgp-signature"; micalg=PGP-SHA1
Cc: krafft@de.ibm.com, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--Sig_.jDnS61Vy+I1tLWddR+0toJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

From: Christian Krafft <krafft@de.ibm.com>
This patch adds a check for the private driver data to be initialized.
The bug showed up, as the caller found a pmi device by it's type.
Whereas the pmi driver probes for the type and the name.
Since the name was not as the driver expected, it did not initialize.
A more relaxed probing will be supplied with an extra patch, too.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

Index: sdk3/arch/powerpc/sysdev/pmi.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- sdk3.orig/arch/powerpc/sysdev/pmi.c
+++ sdk3/arch/powerpc/sysdev/pmi.c
@@ -264,6 +264,9 @@ void pmi_register_handler(struct of_devi
 	struct pmi_data *data;
 	data =3D device->dev.driver_data;
=20
+	if (!data)
+		return;
+
 	spin_lock(&data->handler_spinlock);
 	list_add_tail(&handler->node, &data->handler);
 	spin_unlock(&data->handler_spinlock);
@@ -274,10 +277,12 @@ void pmi_unregister_handler(struct of_de
 			    struct pmi_handler *handler)
 {
 	struct pmi_data *data;
+	data =3D device->dev.driver_data;
=20
-	pr_debug("pmi: unregistering handler %p\n", handler);
+	if (!data)
+		return;
=20
-	data =3D device->dev.driver_data;
+	pr_debug("pmi: unregistering handler %p\n", handler);
=20
 	spin_lock(&data->handler_spinlock);
 	list_del(&handler->node);


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


--Sig_.jDnS61Vy+I1tLWddR+0toJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGLPlr6rqK4qDx+dcRAim2AJ4iMPhyji82XwjyIj9nWK4QnwpaGACgsboC
hWQAV2+iN3jHTLUGynI7Isk=
=Eou8
-----END PGP SIGNATURE-----

--Sig_.jDnS61Vy+I1tLWddR+0toJ--
