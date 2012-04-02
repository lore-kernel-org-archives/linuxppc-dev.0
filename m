Return-Path: <tony@bakeyournoodle.com>
Date: Mon, 2 Apr 2012 16:28:29 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: kilauea compilation breaks with v3.3 kernel and ELDK 4.2
Message-ID: <20120402062826.GC2129@thor.bakeyournoodle.com>
References: <4F69C553.6070409@gmail.com>
 <CA+5PVA7+vPZmLBzkXOFwTM+kLMYHPDgVW4Jcm91XSxW=Ng-Y6g@mail.gmail.com>
 <20120321162549.8C1D0202A4D@gemini.denx.de>
 <1332633218.2882.16.camel@pasglop>
 <CA+5PVA4pGhbrM1P8Dbjaxw_1_ZgEweimLCSc1xrw0Rombr_2rg@mail.gmail.com>
 <CADNf2swF2EVO2u-yPziF2z6HyF6jRBvVsQC2nbY=W2sXJpp2hQ@mail.gmail.com>
 <1333152184.30734.3.camel@pasglop> <20120401221359.GA31730@gnubox>
 <1333332115.30734.27.camel@pasglop>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="QRj9sO5tAVLaXnSD"
In-Reply-To: <1333332115.30734.27.camel@pasglop>
Cc: Frank =?utf-8?Q?E=2E_Svendsb=C3=B8e?= <frank.svendsboe@gmail.com>,
 Wolfgang Denk <wd@denx.de>, robert.karl.berger@gmail.com,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--QRj9sO5tAVLaXnSD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 02, 2012 at 12:01:55PM +1000, Benjamin Herrenschmidt wrote:

> Ok, I've asked Tony to have a look at splitting the build decision
> in arch/powerpc/boot along the same lines as the CPU families... ie only
> wrappers for platforms potentially supported by the built kernel. That
> should fix it.

Please try this patch.  Only lightly tested here.  I haven't "split up"
src-wlib yet as I wanted to verify I'm on the right track.

=46rom e0b1ac84bfd539482bc88b943724e577e6b8dfb3 Mon Sep 17 00:00:00 2001
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
 arch/powerpc/boot/Makefile |   56 +++++++++++++++++++++++++++++++++-------=
---
 1 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index e8461cb..a3c4ae0 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -69,19 +69,49 @@ src-wlib :=3D string.S crt0.S crtsavres.S stdio.c main.=
c \
 		4xx.c ebony.c mv64x60.c mpsc.c mv64x60_i2c.c cuboot.c bamboo.c \
 		cpm-serial.c stdlib.c mpc52xx-psc.c planetcore.c uartlite.c \
 		fsl-soc.c mpc8xx.c pq2.c ugecon.c
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
+src-plat :=3D of.c
+ifeq ($(CONFIG_40x),y)
+src-plat +=3D fixed-head.S ep405.c cuboot-hotfoot.c treeboot-walnut.c \
+		cuboot-acadia.c cuboot-kilauea.c \
+		simpleboot.c virtex405-head.S virtex.c
+endif
+ifeq ($(CONFIG_44x),y)
+src-plat  +=3D treeboot-ebony cuboot-ebony treeboot-bamboo cuboot-bamboo \
+		cuboot-sam440ep.c cuboot-sequoia.c cuboot-rainier.c \
+		cuboot-taishan.c cuboot-katmai.c cuboot-warp.c \
+		cuboot-yosemite.c treeboot-iss4xx.c treeboot-currituck.c \
+		simpleboot.c fixed-head.S virtex.c
+endif
+ifeq ($(CONFIG_8xx),y)
+src-plat  +=3D cuboot-8xx.c fixed-head.S ep88xc.c redboot-8xx.c
+endif
+ifeq ($(CONFIG_PPC_MPC52xx),y)
+src-plat  +=3D cuboot-52xx.c
+endif
+ifeq ($(CONFIG_PPC_82xx),y)
+src-plat  +=3D cuboot-pq2.c fixed-head.S ep8248e.c cuboot-824x.c
+endif
+ifeq ($(CONFIG_PPC_82xx),y)
+src-plat  +=3D cuboot-83xx.c fixed-head.S redboot-83xx.c
+endif
+ifeq ($(CONFIG_FSL_SOC_BOOKE),y)
+src-plat  +=3D cuboot-85xx.c cuboot-85xx-cpm2.c
+endif
+ifeq ($(CONFIG_EMBEDDED6xx),y)
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
+src-plat  :=3D $(sort $(src-plat))
 src-boot :=3D $(src-wlib) $(src-plat) empty.c
=20
 src-boot :=3D $(addprefix $(obj)/, $(src-boot))
--=20
1.7.7.6

Yours Tony

--QRj9sO5tAVLaXnSD
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPeUcKAAoJEEsCiJRY75GKWFgQAIy8Ps6AB+l88VMKtmX6pJ8D
4vKQZJq6Hi21chwcqlEDmFKMXzifBCMVqsLDAZ3a7/onbapMFSlYRY2MzFawX5b2
mbDgLWiUQmUL/IA2SpddBv+vRbnKpLLRLFYU/0GmJuHP1wJLpmS7BOQb1lz7EwCI
mJjFnoQ/BuLM1Ja/dg9NMzMMjDGvRUUwgrZhwJ3OMUtO5ZhWVJcblKgIUS19xW5v
865Nm4GaIWMTRCtNAUmbPQxqGY++BPZyIYJBzSV3uV/BZppDqgYKyNk1idV+fkui
wi44srzP5zeS6hEYXDTKSAp0/O+yZ9fRFe+5i4ncJJOMcfWL7dOons2+fd2bgrsv
W/LaCcoM4fYTmVWClavZ5NVZzU5oTsVhTdREmG3kujs1EpQuiDWyiyNqzbnPYlSQ
9y93xgUqmsR4b85b9c7CrWXyV7gj2Fuk4WVTyFw/yEPFZW5jgvHA9TWQiNtGi14z
kWfIi3mNQ3pz6k/UwdJmp+UqCnnyay+hZzzyajYBgvMdJiyv3QuDqnRJS89fEtSq
pnz0MDTBUFpaJ4pB6p/sEmo+rKuEmrU5zuajgbCFoHbSsJP3tZU7h3eib1YBzc8F
VlEECCk9yF11+biaw9Q0sZEGksYPD5PJJNd4acWjp/nHbxiSHIiOy5P8138WXj21
4noto57CeBkI7CyFNlnq
=nXRa
-----END PGP SIGNATURE-----

--QRj9sO5tAVLaXnSD--
