Return-Path: <tony@bakeyournoodle.com>
Date: Wed, 4 Apr 2012 11:00:39 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
 Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH v2] powerpc/boot: Only build board support files when
 required.
Message-ID: <20120404010038.GA392@thor.bakeyournoodle.com>
References: <20120403005558.GA9194@thor.bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
In-Reply-To: <20120403005558.GA9194@thor.bakeyournoodle.com>
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


--d6Gm4EdcadzBjdND
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
 arch/powerpc/boot/Makefile |   56 +++++++++++++++++++++++++++++-----------=
----
 1 files changed, 37 insertions(+), 19 deletions(-)

Changes since v1:
 - I missed a dependancy for ep8248e.c on planetcore.c, this caused the
   6xx_defconfig to fail.
 - Use the sorted and de-duplicated src-wlib and src-plat to setup
   src-boot
 - Built:
	40x/ep405_defconfig		44x/arches_defconfig
	44x/bamboo_defconfig		44x/bluestone_defconfig
	44x/canyonlands_defconfig	44x/currituck_defconfig
	44x/ebony_defconfig		44x/eiger_defconfig
	44x/icon_defconfig		44x/iss476-smp_defconfig
	44x/katmai_defconfig		44x/rainier_defconfig
	44x/redwood_defconfig		44x/sam440ep_defconfig
	44x/sequoia_defconfig		44x/taishan_defconfig
	44x/virtex5_defconfig		44x/warp_defconfig
	86xx/sbc8641d_defconfig		cell_defconfig
	celleb_defconfig		chrp32_defconfig
	g5_defconfig			maple_defconfig
	mpc7448_hpc2_defconfig		mpc83xx_defconfig
	mpc85xx_defconfig		mpc86xx_defconfig
	mpc885_ads_defconfig		pasemi_defconfig
	pmac32_defconfig		powerpc-allmodconfig
	powerpc-allnoconfig		ppc40x_defconfig
	ppc44x_defconfig		ppc64_defconfig
	ppc6xx_defconfig		ps3_defconfig
    Without problems.

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..c802a90 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -62,26 +62,45 @@ libfdtheader :=3D fdt.h libfdt.h libfdt_internal.h
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
+		gunzip_util.c elf_util.c $(zlib) devtree.c stdlib.c \
+		oflib.c ofconsole.c cuboot.c mpsc.c cpm-serial.c \
+		uartlite.c mpc52xx-psc.c
+src-wlib-$(CONFIG_40x) +=3D 4xx.c planetcore.c
+src-wlib-$(CONFIG_44x) +=3D 4xx.c ebony.c bamboo.c
+src-wlib-$(CONFIG_8xx) +=3D mpc8xx.c planetcore.c
+src-wlib-$(CONFIG_PPC_82xx) +=3D pq2.c fsl-soc.c planetcore.c
+src-wlib-$(CONFIG_EMBEDDED6xx) +=3D mv64x60.c mv64x60_i2c.c ugecon.c
+
+src-plat-y :=3D of.c
+src-plat-$(CONFIG_40x) +=3D fixed-head.S ep405.c cuboot-hotfoot.c \
+				treeboot-walnut.c cuboot-acadia.c \
+				cuboot-kilauea.c simpleboot.c \
+				virtex405-head.S virtex.c
+src-plat-$(CONFIG_44x) +=3D treeboot-ebony.c cuboot-ebony.c treeboot-bambo=
o.c \
+				cuboot-bamboo.c cuboot-sam440ep.c \
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
 src-boot :=3D $(src-wlib) $(src-plat) empty.c
=20
 src-boot :=3D $(addprefix $(obj)/, $(src-boot))
@@ -412,4 +431,3 @@ $(wrapper-installed): $(DESTDIR)$(WRAPPER_BINDIR) $(src=
tree)/$(obj)/wrapper | $(
 	$(call cmd,install_wrapper)
=20
 $(obj)/bootwrapper_install: $(all-installed)
-
--=20
1.7.7.6

Yours Tony

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPe502AAoJEEsCiJRY75GKes4QAJ4ZWVZj9T5/Igu1uZELbfx3
YGR7LNHWMulumAR4Qjrd5CJKl2dO5QxiJSG1gsJGLeql+2pnRlIbuUM5PfX33d6a
kqhKlpLROE5zIb2bkFlARJbpDBq7cmaea54Ue8KBNSb36qWYSc+1+4njgzYaGEff
UA0zC9nBmplVMh6wduF0nRq+i4vj+6ZhrjMXPU7XMUsxLfikR7SElIdVH01auo71
I8u2P1BbokoYwWEjYxt4tqGJpH2FWmzgflaiMVajZl33GF424Fr7lIiwMXKIh6wC
qtMiZl+x8GFOQZ7Eael9R4KGtFqS5Ohecwo4DEemSMObvlTKhg7CHsITk51iK8Oq
ZcuwhT5z2/GLvtpCjx/Q7ikjMxvTwresimt8IQY/XwY3seNTdEZSIMMgYGA7AzlA
Tm4u79VQxiA+Tk5xowR/m4xGrAuZWpnd6hkbWuNZ47OTnhiuqRdaK4J6HUDP3VPK
3a4wv+BA/Pg59PnT2sHEOouIsTDjJbiljEF2qGBC6tcgLqh/C51I2nE+HxKtDw+x
b9ikT1ecmz6WJjrX/i5FVNJWiy/fwXz/IehfMj1QmEsQNdtGxoyrEVQwfoOxh4Vc
Ig4KfYOGQYOAYiVs3BVv+PjCSx0DdPfLaN/H7eN/n2n0cfYHVqp2bJDAD5d3LQ89
YMsc9bXZtHmqn2p9fTQr
=O1Lj
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
