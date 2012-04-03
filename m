Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 3 Apr 2012 10:55:59 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: [PATCH] powerpc/boot: Only build board support files when required.
Message-ID: <20120403005558.GA9194@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="zYM0uCDKw75PZbzx"
Cc: Frank =?utf-8?Q?Svendsb=C3=B8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--zYM0uCDKw75PZbzx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Currently we build all board files regardless of the final zImage
target.  This is sub-optimal (in terms on compilation) and leads to
problems in one platform needlessly causing failures for other
platforms.

Use the Kconfig variables to selectively construct this board files to
build.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile |   69 +++++++++++++++++++++++++++++++++-------=
----
 1 files changed, 52 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..3d4d9ea 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -65,23 +65,58 @@ $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simplebo=
ot.o epapr.o): \
 src-wlib :=3D string.S crt0.S crtsavres.S stdio.c main.c \
 		$(libfdt) libfdt-wrapper.c \
 		ns16550.c serial.c simple_alloc.c div64.S util.S \
-		gunzip_util.c elf_util.c $(zlib) devtree.c oflib.c ofconsole.c \
-		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
-		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
-		fsl-soc.c mpc8xx.c pq2.c ugecon.c
-src-plat :=3D of.c cuboot-52xx.c cuboot-824x.c cuboot-83xx.c cuboot-85xx.c=
 holly.c \
-		cuboot-ebony.c cuboot-hotfoot.c epapr.c treeboot-ebony.c \
-		prpmc2800.c \
-		ps3-head.S ps3-hvcall.S ps3.c treeboot-bamboo.c cuboot-8xx.c \
-		cuboot-pq2.c cuboot-sequoia.c treeboot-walnut.c \
-		cuboot-bamboo.c cuboot-mpc7448hpc2.c cuboot-taishan.c \
-		fixed-head.S ep88xc.c ep405.c cuboot-c2k.c \
-		cuboot-katmai.c cuboot-rainier.c redboot-8xx.c ep8248e.c \
-		cuboot-warp.c cuboot-85xx-cpm2.c cuboot-yosemite.c simpleboot.c \
-		virtex405-head.S virtex.c redboot-83xx.c cuboot-sam440ep.c \
-		cuboot-acadia.c cuboot-amigaone.c cuboot-kilauea.c \
-		gamecube-head.S gamecube.c wii-head.S wii.c treeboot-iss4xx.c \
-		treeboot-currituck.c
+		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
+		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
+		uartlite.c mpc52xx-psc.c
+src-plat :=3D of.c
+ifeq ($(CONFIG_40x),y)
+src-wlib  +=3D 4xx.c planetcore.c
+src-plat +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeboot-walnut.c \
+		cuboot-acadia.c cuboot-kilauea.c \
+		simpleboot.c virtex405-head.S virtex.c
+endif
+ifeq ($(CONFIG_44x),y)
+src-wlib  +=3D 4xx.c ebony.c bamboo.c
+src-plat  +=3D treeboot-ebony cuboot-ebony treeboot-bamboo cuboot-bamboo \
+		cuboot-sam440ep.c cuboot-sequoia.c cuboot-rainier.c \
+		cuboot-taishan.c cuboot-katmai.c cuboot-warp.c \
+		cuboot-yosemite.c treeboot-iss4xx.c treeboot-currituck.c \
+		simpleboot.c fixed-head.S virtex.c
+endif
+ifeq ($(CONFIG_8xx),y)
+src-wlib  +=3D mpc8xx.c planetcore.c
+src-plat  +=3D cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx.c
+endif
+ifeq ($(CONFIG_PPC_MPC52xx),y)
+src-plat  +=3D cuboot-52xx.c
+endif
+ifeq ($(CONFIG_PPC_82xx),y)
+src-wlib  +=3D pq2.c fsl-soc.c
+src-plat  +=3D cuboot-pq2.c fixed-head.S ep8248e.c cuboot-824x.c
+endif
+ifeq ($(CONFIG_PPC_83xx),y)
+src-plat  +=3D cuboot-83xx.c fixed-head.S redboot-83xx.c
+endif
+ifeq ($(CONFIG_FSL_SOC_BOOKE),y)
+src-plat  +=3D cuboot-85xx.c cuboot-85xx-cpm2.c
+endif
+ifeq ($(CONFIG_EMBEDDED6xx),y)
+src-wlib  +=3D mv64x60.c mv64x60_i2c.c ugecon.c
+src-plat  +=3D cuboot-pq2.c cuboot-mpc7448hpc2.c cuboot-c2k.c \
+		gamecube-head.S gamecube.c wii-head.S wii.c holly.c \
+		prpmc2800.c
+endif
+ifeq ($(CONFIG_AMIGAONE),y)
+src-plat  +=3D cuboot-amigaone.c
+endif
+ifeq ($(CONFIG_PPC_PS3),y)
+src-plat  +=3D ps3-head.S ps3-hvcall.S ps3.c
+endif
+ifeq ($(CONFIG_EPAPR_BOOT),y)
+src-plat  +=3D epapr.c
+endif
+src-wlib :=3D $(sort $(src-wlib))
+src-plat :=3D $(sort $(src-plat))
 src-boot :=3D $(src-wlib) $(src-plat) empty.c
=20
 src-boot :=3D $(addprefix $(obj)/, $(src-boot))
--=20
1.7.7.6



Yours Tony

--zYM0uCDKw75PZbzx
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPekqeAAoJEEsCiJRY75GKI3kP/0KTf2mUhNrhAd2rz0os7sLr
Yp+hRXaOSd7/2E7Kd5QH2JaQeAjSWgTm0FkZ0e5v6Ikbt4ectUL+J+HY7SQdzXC2
xUzJuL1biESAfPVZ5HXLwgQTt0ZUBp65Bq5QdaISDRApFygiyWOZSNcVqqcS4TXD
5odumsMn9Mw699rY6FeQnA3186PVZXzw549En2Vys2q3Hb3uGY/Ttun6NSn17xf4
GqR8SGxEbEhXRLuMpsNXtxjbPqGi7akdB6TcmOVkw7RuqCShYfq9AiBGfQFkqup2
PGYEEsK9uD9KeyAx7gD5DDf924evX225alWRWqDrnBNjDlxRIwbTfhGSOl5DStpY
JxNJBLDDmDRG0v3PdRu/8GZ9otGg/WX4zhLGrcf2DSs39KC8PvoRX+m/lCFJAPde
mBTU6RcNSpA0sGQ0vo+Twa/BJBSTxLkBRmLhX2IDP+eGPal0gN5vqg4qIXdi4pm7
gOPTaY9NrOZkDFlFMIXdsUCqb+V2HIZOA5x9OlFBDALleNo8gS6oBGOAkjnM4eaY
eJyAwp89ZUKr4oVnMKiUkLlLwKReprDYmktCvzljoG5zHYuJPqr6+DaTK+l2OIQ0
wYQB8nC7rdmpuIFOtYrnoDCutipxSK9cvT6ikg7Zcl50+J7VGS77YKAl6cHN9m5y
7G4XjU920GCuQiEs3BQH
=ps4P
-----END PGP SIGNATURE-----

--zYM0uCDKw75PZbzx--
