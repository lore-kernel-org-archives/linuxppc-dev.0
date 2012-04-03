Return-Path: <tony@bakeyournoodle.com>
Date: Tue, 3 Apr 2012 11:55:08 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/boot: Only build board support files when
 required.
Message-ID: <20120403015508.GC9194@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
 <20120403114150.cbf53c999ed842b25e9932b5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
In-Reply-To: <20120403114150.cbf53c999ed842b25e9932b5@canb.auug.org.au>
Cc: Frank =?utf-8?Q?Svendsb=C3=B8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 03, 2012 at 11:41:50AM +1000, Stephen Rothwell wrote:

> It is more ususal in the kernel makefiles to do something like:
>=20
> src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
> src-plat-$(CONFIG_40x) +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeboo=
t-walnut.c \

Gah you are right.  How about this.

=46rom b59e3f86d72fe3e16881ec972602a9bb3e28045a Mon Sep 17 00:00:00 2001
=46rom: Tony Breeds <tony@bakeyournoodle.com>
Date: Mon, 2 Apr 2012 16:20:35 +1000
Subject: [PATCH] powerpc/boot: Only build board support files when required.

Currently we build all board files regardless of the final zImage
target.  This is sub-optimal (in terms on compilation) and leads to
problems in one platform needlessly causing failures for other
platforms.

Use the Kconfig variables to selectively construct this board files to
build.

Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
---
 arch/powerpc/boot/Makefile |   57 +++++++++++++++++++++++++++++-----------=
---
 1 files changed, 38 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..a05d32d 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -62,27 +62,46 @@ libfdtheader :=3D fdt.h libfdt.h libfdt_internal.h
 $(addprefix $(obj)/,$(libfdt) libfdt-wrapper.o simpleboot.o epapr.o): \
 	$(addprefix $(obj)/,$(libfdtheader))
=20
-src-wlib :=3D string.S crt0.S crtsavres.S stdio.c main.c \
+src-wlib-y :=3D string.S crt0.S crtsavres.S stdio.c main.c \
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
-src-boot :=3D $(src-wlib) $(src-plat) empty.c
+		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
+		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
+		uartlite.c mpc52xx-psc.c
+src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
+src-wlib-$(CONFIG_44x) +=3D 4xx.c ebony.c bamboo.c
+src-wlib-$(CONFIG_8xx) +=3D mpc8xx.c planetcore.c
+src-wlib-$(CONFIG_PPC_82xx) +=3D pq2.c fsl-soc.c
+src-wlib-$(CONFIG_EMBEDDED6xx) +=3D mv64x60.c mv64x60_i2c.c ugecon.c
+
+src-plat-y :=3D of.c
+src-plat-$(CONFIG_40x) +=3D fixed-head.S ep405.c cuboot-hotfoot.c \
+				treeboot-walnut.c cuboot-acadia.c \
+				cuboot-kilauea.c simpleboot.c \
+				virtex405-head.S virtex.c
+src-plat-$(CONFIG_44x) +=3D treeboot-ebony cuboot-ebony treeboot-bamboo \
+				cuboot-bamboo cuboot-sam440ep.c \
+				cuboot-sequoia.c cuboot-rainier.c \
+				cuboot-taishan.c cuboot-katmai.c \
+				cuboot-warp.c cuboot-yosemite.c \
+				treeboot-iss4xx.c treeboot-currituck.c \
+				simpleboot.c fixed-head.S virtex.c
+src-plat-$(CONFIG_8xx) +=3D cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx=
=2Ec
+src-plat-$(CONFIG_PPC_MPC52xx) +=3D cuboot-52xx.c
+src-plat-$(CONFIG_PPC_82xx) +=3D cuboot-pq2.c fixed-head.S ep8248e.c cuboo=
t-824x.c
+src-plat-$(CONFIG_PPC_83xx) +=3D cuboot-83xx.c fixed-head.S redboot-83xx.c
+src-plat-$(CONFIG_FSL_SOC_BOOKE) +=3D cuboot-85xx.c cuboot-85xx-cpm2.c
+src-plat-$(CONFIG_EMBEDDED6xx) +=3D cuboot-pq2.c cuboot-mpc7448hpc2.c \
+					cuboot-c2k.c gamecube-head.S \
+					gamecube.c wii-head.S wii.c holly.c \
+					prpmc2800.c
+src-plat-$(CONFIG_AMIGAONE) +=3D cuboot-amigaone.c
+src-plat-$(CONFIG_PPC_PS3) +=3D ps3-head.S ps3-hvcall.S ps3.c
+src-plat-$(CONFIG_EPAPR_BOOT) +=3D epapr.c
+
+src-wlib :=3D $(sort $(src-wlib-y))
+src-plat :=3D $(sort $(src-plat-y))
+src-boot :=3D $(src-wlib-y) $(src-plat-y) empty.c
=20
 src-boot :=3D $(addprefix $(obj)/, $(src-boot))
 obj-boot :=3D $(addsuffix .o, $(basename $(src-boot)))
--=20
1.7.7.6

Yours Tony

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPelh8AAoJEEsCiJRY75GKV9MP/jfQ/7ljcUeDEH3jv3T3xurt
STR3v8hC53JDvhq8KFOEFH0r9b55cPE7+uYseyDxfNlK0UbBRkP7tIrdiv8W74Jj
o8bduA/0BDhqii0trWRej7N3habSlQNg4YDcKcEVuvzJogKea04zDJX+FZOA7sKm
pctxtD/EMXcrZi0ULNtOGkTimUSQRIYghf7bysneA1UFU77RuPMKEtVgL9Tm5RRy
QFnz6x+Ls0zKpaC1agzEkcpGqP4Q+Tf1lAKJ5h9bTyrVBad8s5POAVWmxH8M2kYO
cGZsCG6hbI5WaPW5/LjN1tz5MMXRZkdp93KRyHszAO4JA79uJysHKKrfsQ00qMOV
9b3J3o1Z+QIZDavHz1jOIYfcRa7VxPvE073B+IspZ9nEeman+2oHiPZVXDVKK18Z
GM4sje2J56uq7ouZJTWzomxtlr3n/jGy3goAtgcnh7nskMmKlYtEllsWgzry9ygp
dlN42sNHwu8WfAl83szxJ3BWtHEsSx9MTvoMaB+cHwdGXoS1gjN52k8v46T89g2J
K04iEjEY/Oo2oDY+yaC7lDBE8xLCvLoXlswjoNgtc0gP+YzKLeXyFq4DubTvszoN
mEYf5LpKV8UkuQb0edyjbjEfHj+gkrd0vjHWWWksL1JkFfP5w+TqSDtB0z3yjk0r
RWrMtLmQLUTl+lpAV3F3
=Z7Rq
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--
