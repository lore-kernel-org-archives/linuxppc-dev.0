Return-Path: <luis.henriques@canonical.com>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112]) by ozlabs.org (Postfix) with ESMTP id BFAB62C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Jan 2014 06:39:29 +1100 (EST)
Date: Mon, 20 Jan 2014 19:39:25 +0000
From: Luis Henriques <luis.henriques@canonical.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>, Ian Munsie <imunsie@au1.ibm.com>
Subject: [PATCH] powerpc: Fix build dependencies for storcenter
Message-ID: <20140120193921.GA5267@hercules>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This fixes a build failure that seems to be present since commit

commit b81f18e55e9f4ea81759bcb00fea295de679bbe8
Author: Tony Breeds <tony@bakeyournoodle.com>
Date:   Tue Apr 3 15:00:39 2012 +0000

    powerpc/boot: Only build board support files when required.

This is easily reproducible my using the storcenter_defconfig config file:

arch/powerpc/boot/cuboot-pq2.o: In function `pq2_platform_fixups':
cuboot-pq2.c:(.text+0x30c): undefined reference to `fsl_get_immr'
make[1]: *** [arch/powerpc/boot/cuImage.storcenter] Error 1

Fixes: b81f18e55e9f ("powerpc/boot: Only build board support files when required.")
Cc: Tony Breeds <tony@bakeyournoodle.com>
Cc: <stable@vger.kernel.org> (3.6+)
Signed-off-by: Luis Henriques <luis.henriques@canonical.com>
---
 arch/powerpc/boot/Makefile | 2 +-
 arch/powerpc/boot/wrapper  | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/boot/Makefile b/arch/powerpc/boot/Makefile
index 981d418..cf8e5db 100644
--- a/arch/powerpc/boot/Makefile
+++ b/arch/powerpc/boot/Makefile
@@ -95,7 +95,7 @@ src-plat-$(CONFIG_FSL_SOC_BOOKE) += cuboot-85xx.c cuboot-85xx-cpm2.c
 src-plat-$(CONFIG_EMBEDDED6xx) += cuboot-pq2.c cuboot-mpc7448hpc2.c \
 					cuboot-c2k.c gamecube-head.S \
 					gamecube.c wii-head.S wii.c holly.c \
-					prpmc2800.c
+					prpmc2800.c fsl-soc.c
 src-plat-$(CONFIG_AMIGAONE) += cuboot-amigaone.c
 src-plat-$(CONFIG_PPC_PS3) += ps3-head.S ps3-hvcall.S ps3.c
 src-plat-$(CONFIG_EPAPR_BOOT) += epapr.c epapr-wrapper.c
diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
index 2e1af74..4d90b98 100755
--- a/arch/powerpc/boot/wrapper
+++ b/arch/powerpc/boot/wrapper
@@ -190,9 +190,12 @@ cuboot*)
     *5200*|*-motionpro)
         platformo=$object/cuboot-52xx.o
         ;;
-    *-pq2fads|*-ep8248e|*-mpc8272*|*-storcenter)
+    *-pq2fads|*-ep8248e|*-mpc8272*)
         platformo=$object/cuboot-pq2.o
         ;;
+    *-storcenter)
+	platformo="$object/cuboot-pq2.o $object/fsl-soc.o"
+	;;
     *-mpc824*)
         platformo=$object/cuboot-824x.o
         ;;
-- 
1.8.3.2

Cheers,
--
Luis
