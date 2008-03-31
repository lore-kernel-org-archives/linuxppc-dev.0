Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 773DDDE798
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Apr 2008 02:58:47 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCHv3 2/4] cpm-serial: Relocate CPM buffer descriptors and SMC
	parameter ram.
Date: Mon, 31 Mar 2008 18:36:07 +0200
References: <200803311834.42327.laurentp@cse-semaphore.com>
In-Reply-To: <200803311834.42327.laurentp@cse-semaphore.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4041506.o1nJoalkWE";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803311836.08142.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart4041506.o1nJoalkWE
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

This patch relocates the buffer descriptors and the SMC parameter RAM at the
end of the first CPM muram chunk, as described in the device tree. This all=
ows
device trees to stop excluding SMC parameter ram allocated by the boot load=
er
from the CPM muram node.

Signed-off-by: Laurent Pinchart <laurentp@cse-semaphore.com>
=2D--
 arch/powerpc/Kconfig.debug     |    2 +-
 arch/powerpc/boot/cpm-serial.c |  132 ++++++++++++++++++++++++++----------=
=2D---
 2 files changed, 87 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index db7cc34..a86d8d8 100644
=2D-- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -269,7 +269,7 @@ config PPC_EARLY_DEBUG_CPM_ADDR
 	hex "CPM UART early debug transmit descriptor address"
 	depends on PPC_EARLY_DEBUG_CPM
 	default "0xfa202008" if PPC_EP88XC
=2D	default "0xf0000008" if CPM2
+	default "0xf0001ff8" if CPM2
 	default "0xff002008" if CPM1
 	help
 	  This specifies the address of the transmit descriptor
diff --git a/arch/powerpc/boot/cpm-serial.c b/arch/powerpc/boot/cpm-serial.c
index 28296fa..8d02b2d 100644
=2D-- a/arch/powerpc/boot/cpm-serial.c
+++ b/arch/powerpc/boot/cpm-serial.c
@@ -11,6 +11,7 @@
 #include "types.h"
 #include "io.h"
 #include "ops.h"
+#include "page.h"
=20
 struct cpm_scc {
 	u32 gsmrl;
@@ -42,6 +43,22 @@ struct cpm_param {
 	u16 tbase;
 	u8 rfcr;
 	u8 tfcr;
+	u16 mrblr;
+	u32 rstate;
+	u8 res1[4];
+	u16 rbptr;
+	u8 res2[6];
+	u32 tstate;
+	u8 res3[4];
+	u16 tbptr;
+	u8 res4[6];
+	u16 maxidl;
+	u16 idlc;
+	u16 brkln;
+	u16 brkec;
+	u16 brkcr;
+	u16 rmask;
+	u8 res5[4];
 };
=20
 struct cpm_bd {
@@ -54,10 +71,10 @@ static void *cpcr;
 static struct cpm_param *param;
 static struct cpm_smc *smc;
 static struct cpm_scc *scc;
=2Dstruct cpm_bd *tbdf, *rbdf;
+static struct cpm_bd *tbdf, *rbdf;
 static u32 cpm_cmd;
=2Dstatic u8 *muram_start;
=2Dstatic u32 muram_offset;
+static void *cbd_addr;
+static u32 cbd_offset;
=20
 static void (*do_cmd)(int op);
 static void (*enable_port)(void);
@@ -119,20 +136,25 @@ static int cpm_serial_open(void)
=20
 	out_8(&param->rfcr, 0x10);
 	out_8(&param->tfcr, 0x10);
=2D
=2D	rbdf =3D (struct cpm_bd *)muram_start;
=2D	rbdf->addr =3D (u8 *)(rbdf + 2);
+	out_be16(&param->mrblr, 1);
+	out_be16(&param->maxidl, 0);
+	out_be16(&param->brkec, 0);
+	out_be16(&param->brkln, 0);
+	out_be16(&param->brkcr, 0);
+
+	rbdf =3D cbd_addr;
+	rbdf->addr =3D (u8 *)rbdf - 1;
 	rbdf->sc =3D 0xa000;
 	rbdf->len =3D 1;
=20
 	tbdf =3D rbdf + 1;
=2D	tbdf->addr =3D (u8 *)(rbdf + 2) + 1;
+	tbdf->addr =3D (u8 *)rbdf - 2;
 	tbdf->sc =3D 0x2000;
 	tbdf->len =3D 1;
=20
 	sync();
=2D	out_be16(&param->rbase, muram_offset);
=2D	out_be16(&param->tbase, muram_offset + sizeof(struct cpm_bd));
+	out_be16(&param->rbase, cbd_offset);
+	out_be16(&param->tbase, cbd_offset + sizeof(struct cpm_bd));
=20
 	do_cmd(CPM_CMD_INIT_RX_TX);
=20
@@ -173,12 +195,31 @@ static unsigned char cpm_serial_getc(void)
 	return c;
 }
=20
+static int cpm_get_virtual_address(void *devp, void **addr, int ncells)
+{
+	unsigned long xaddr;
+	int n;
+
+	n =3D getprop(devp, "virtual-reg", addr, ncells * sizeof *addr);
+	if (n < ncells * sizeof *addr) {
+		for (n =3D 0; n < ncells; n++) {
+			if (!dt_xlate_reg(devp, n, &xaddr, NULL))
+				return -1;
+
+			addr[n] =3D (void*)xaddr;
+		}
+	}
+
+	return ncells;
+}
+
 int cpm_console_init(void *devp, struct serial_console_data *scdp)
 {
=2D	void *reg_virt[2];
=2D	int is_smc =3D 0, is_cpm2 =3D 0, n;
=2D	unsigned long reg_phys;
+	void *reg[2];
 	void *parent, *muram;
+	void *muram_addr;
+	int is_smc =3D 0, is_cpm2 =3D 0;
+	unsigned long muram_offset, muram_size;
=20
 	if (dt_is_compatible(devp, "fsl,cpm1-smc-uart")) {
 		is_smc =3D 1;
@@ -202,63 +243,62 @@ int cpm_console_init(void *devp, struct serial_consol=
e_data *scdp)
 	else
 		do_cmd =3D cpm1_cmd;
=20
=2D	n =3D getprop(devp, "fsl,cpm-command", &cpm_cmd, 4);
=2D	if (n < 4)
+	if (getprop(devp, "fsl,cpm-command", &cpm_cmd, 4) < sizeof cpm_cmd)
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
+	if (cpm_get_virtual_address(devp, reg, 2) < 0)
+		return -1;
=20
 	if (is_smc)
=2D		smc =3D reg_virt[0];
+		smc =3D reg[0];
 	else
=2D		scc =3D reg_virt[0];
+		scc =3D reg[0];
=20
=2D	param =3D reg_virt[1];
+	param =3D reg[1];
=20
 	parent =3D get_parent(devp);
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
+	if (cpm_get_virtual_address(devp, &cpcr, 1) < 0)
+		return -1;
=20
 	muram =3D finddevice("/soc/cpm/muram/data");
 	if (!muram)
 		return -1;
=20
 	/* For bootwrapper-compatible device trees, we assume that the first
=2D	 * entry has at least 18 bytes, and that #address-cells/#data-cells
+	 * entry has at least 128 bytes, and that #address-cells/#data-cells
 	 * is one for both parent and child.
 	 */
=20
=2D	n =3D getprop(muram, "virtual-reg", reg_virt, sizeof(reg_virt));
=2D	if (n < (int)sizeof(reg_virt)) {
=2D		if (!dt_xlate_reg(muram, 0, &reg_phys, NULL))
=2D			return -1;
+	if (cpm_get_virtual_address(devp, &muram_addr, 1) < 0)
+		return -1;
+=09
+	if (getprop(muram, "reg", reg, sizeof reg) < sizeof reg)
+		return -1;
+
+	muram_offset =3D (unsigned long)reg[0];
+	muram_size =3D (unsigned long)reg[1];
+
+	/* Store the buffer descriptors at the end of the first muram chunk.
+	 * For SMC ports on CPM2-based platforms, relocate the parameter RAM
+	 * just before the buffer descriptors.
+	 */
+
+	cbd_offset =3D muram_offset + muram_size - 2 * sizeof(struct cpm_bd);
=20
=2D		reg_virt[0] =3D (void *)reg_phys;
=2D	}
+	if (is_cpm2 && is_smc) {
+		u16 *smc_base =3D (u16*)param;
+		u16 pram_offset;
=20
=2D	muram_start =3D reg_virt[0];
+		pram_offset =3D cbd_offset - 64;
+		pram_offset =3D _ALIGN_DOWN(pram_offset, 64);
+		*smc_base =3D pram_offset;
+		param =3D muram_addr - muram_offset + pram_offset;
+	}
=20
=2D	n =3D getprop(muram, "reg", &muram_offset, 4);
=2D	if (n < 4)
=2D		return -1;
+	cbd_addr =3D muram_addr - muram_offset + cbd_offset;
=20
 	scdp->open =3D cpm_serial_open;
 	scdp->putc =3D cpm_serial_putc;
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

--nextPart4041506.o1nJoalkWE
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBH8RL48y9gWxC9vpcRAr5ZAJ44o5G5TUS435CwGMslYAXGn7ZbHgCfSBbD
UJ06jgaHaJ4Uk78LUOqb898=
=SDq0
-----END PGP SIGNATURE-----

--nextPart4041506.o1nJoalkWE--
