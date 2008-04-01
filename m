Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 6D9ECDDF02
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 23:38:08 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv4 2/5] powerpc: Add bootwrapper function to get virtual reg
	from the device tree.
Date: Tue, 1 Apr 2008 14:34:28 +0200
References: <200804011433.29841.laurentp@cse-semaphore.com>
In-Reply-To: <200804011433.29841.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2927427.tSTcWtHk2E";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200804011434.28690.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart2927427.tSTcWtHk2E
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch adds a new generic device tree processing function that retrieves
virtual reg addresses from the device tree to the bootwrapper code. It also
updates the bootwrapper code to use the new function.

dt_get_virtual_reg() retrieves the virtual reg addresses from the
"virtual-reg" property. If the property can't be found, it uses the "reg"
property and walks the tree to translate it to absolute addresses.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/boot/cpm-serial.c  |   34 ++++++----------------------------
 arch/powerpc/boot/devtree.c     |   20 ++++++++++++++++++++
 arch/powerpc/boot/mpc52xx-psc.c |    9 ++-------
 arch/powerpc/boot/ns16550.c     |   10 ++--------
 arch/powerpc/boot/ops.h         |    1 +
 5 files changed, 31 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index 28296fa..1f6225a 100644
=2D-- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -177,7 +177,6 @@ int cpm_console_init(void *devp, struct serial_console_=
data *scdp)
 {
 	void *reg_virt[2];
 	int is_smc =3D 0, is_cpm2 =3D 0, n;
=2D	unsigned long reg_phys;
 	void *parent, *muram;
=20
 	if (dt_is_compatible(devp, "fsl,cpm1-smc-uart")) {
@@ -206,15 +205,8 @@ int cpm_console_init(void *devp, struct serial_console=
_data *scdp)
 	if (n < 4)
 		return -1;
=20
=2D	n =3D getprop(devp, "virtual-reg", reg_virt, sizeof(reg_virt));
=2D	if (n < (int)sizeof(reg_virt)) {
=2D		for (n =3D 0; n < 2; n++) {
=2D			if (!dt_xlate_reg(devp, n, &reg_phys, NULL))
=2D				return -1;
=2D
=2D			reg_virt[n] =3D (void *)reg_phys;
=2D		}
=2D	}
+	if (dt_get_virtual_reg(devp, reg_virt, 2) < 2)
+		return -1;
=20
 	if (is_smc)
 		smc =3D reg_virt[0];
@@ -227,15 +219,8 @@ int cpm_console_init(void *devp, struct serial_console=
_data *scdp)
 	if (!parent)
 		return -1;
=20
=2D	n =3D getprop(parent, "virtual-reg", reg_virt, sizeof(reg_virt));
=2D	if (n < (int)sizeof(reg_virt)) {
=2D		if (!dt_xlate_reg(parent, 0, &reg_phys, NULL))
=2D			return -1;
=2D
=2D		reg_virt[0] =3D (void *)reg_phys;
=2D	}
=2D
=2D	cpcr =3D reg_virt[0];
+	if (dt_get_virtual_reg(parent, &cpcr, 1) < 1)
+		return -1;
=20
 	muram =3D finddevice("/soc/cpm/muram/data");
 	if (!muram)
@@ -246,15 +231,8 @@ int cpm_console_init(void *devp, struct serial_console=
_data *scdp)
 	 * is one for both parent and child.
 	 */
=20
=2D	n =3D getprop(muram, "virtual-reg", reg_virt, sizeof(reg_virt));
=2D	if (n < (int)sizeof(reg_virt)) {
=2D		if (!dt_xlate_reg(muram, 0, &reg_phys, NULL))
=2D			return -1;
=2D
=2D		reg_virt[0] =3D (void *)reg_phys;
=2D	}
=2D
=2D	muram_start =3D reg_virt[0];
+	if (dt_get_virtual_reg(muram, (void **)&muram_start, 1) < 1)
+		return -1;
=20
 	n =3D getprop(muram, "reg", &muram_offset, 4);
 	if (n < 4)
diff --git a/arch/powerpc/boot/devtree.c b/arch/powerpc/boot/devtree.c
index 60f561e..5d12336 100644
=2D-- a/arch/powerpc/boot/devtree.c
+++ b/arch/powerpc/boot/devtree.c
@@ -350,3 +350,23 @@ int dt_is_compatible(void *node, const char *compat)
=20
 	return 0;
 }
+
+int dt_get_virtual_reg(void *node, void **addr, int nres)
+{
+	unsigned long xaddr;
+	int n;
+
+	n =3D getprop(node, "virtual-reg", addr, nres * 4);
+	if (n > 0)
+		return n / 4;
+
+	for (n =3D 0; n < nres; n++) {
+		if (!dt_xlate_reg(node, n, &xaddr, NULL))
+			break;
+
+		addr[n] =3D (void *)xaddr;
+	}
+
+	return n;
+}
+
diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-ps=
c.c
index 1074626..d4cb4e4 100644
=2D-- a/arch/powerpc/boot/mpc52xx-psc.c
+++ b/arch/powerpc/boot/mpc52xx-psc.c
@@ -51,14 +51,9 @@ static unsigned char psc_getc(void)
=20
 int mpc5200_psc_console_init(void *devp, struct serial_console_data *scdp)
 {
=2D	int n;
=2D
 	/* Get the base address of the psc registers */
=2D	n =3D getprop(devp, "virtual-reg", &psc, sizeof(psc));
=2D	if (n !=3D sizeof(psc)) {
=2D		if (!dt_xlate_reg(devp, 0, (void *)&psc, NULL))
=2D			return -1;
=2D	}
+	if (dt_get_virtual_reg(devp, &psc, 1) < 1)
+		return -1;
=20
 	scdp->open =3D psc_open;
 	scdp->putc =3D psc_putc;
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..aef3bdc 100644
=2D-- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -55,15 +55,9 @@ static u8 ns16550_tstc(void)
 int ns16550_console_init(void *devp, struct serial_console_data *scdp)
 {
 	int n;
=2D	unsigned long reg_phys;
=20
=2D	n =3D getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
=2D	if (n !=3D sizeof(reg_base)) {
=2D		if (!dt_xlate_reg(devp, 0, &reg_phys, NULL))
=2D			return -1;
=2D
=2D		reg_base =3D (void *)reg_phys;
=2D	}
+	if (dt_get_virtual_reg(devp, (void **)&reg_base, 1) < 1)
+		return -1;
=20
 	n =3D getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
 	if (n !=3D sizeof(reg_shift))
diff --git a/arch/powerpc/boot/ops.h b/arch/powerpc/boot/ops.h
index 4b0544b..321e2f5 100644
=2D-- a/arch/powerpc/boot/ops.h
+++ b/arch/powerpc/boot/ops.h
@@ -95,6 +95,7 @@ int dt_xlate_reg(void *node, int res, unsigned long *addr=
, unsigned long *size);
 int dt_xlate_addr(void *node, u32 *buf, int buflen, unsigned long *xlated_=
addr);
 int dt_is_compatible(void *node, const char *compat);
 void dt_get_reg_format(void *node, u32 *naddr, u32 *nsize);
+int dt_get_virtual_reg(void *node, void **addr, int nres);
=20
 static inline void *finddevice(const char *name)
 {
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

--nextPart2927427.tSTcWtHk2E
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8ivU8y9gWxC9vpcRApE5AKCQF7n+tVB2ddwfqeJ3pay3hHyJSQCgirIi
KGz+hxX8In9F7oKIxz3f/8M=
=snJ5
-----END PGP SIGNATURE-----

--nextPart2927427.tSTcWtHk2E--
