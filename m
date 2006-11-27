Return-Path: <arnd@arndb.de>
Message-Id: <20061127182431.436201000@arndb.de>
References: <20061127181851.796747000@arndb.de>
Date: Mon, 27 Nov 2006 19:18:58 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: [POWERPC 7/9] ps3: add a default zImage target
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's currently not possible to build the default zImage
target if PS3 is the only selected platform. This is
a hack to fall back to building the pseries style
zImage, so the build is successful. This will probably
change in the future, if someone writes a PS3 specific
boot wrapper.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Index: linux-2.6/arch/powerpc/boot/Makefile
===================================================================
--- linux-2.6.orig/arch/powerpc/boot/Makefile
+++ linux-2.6/arch/powerpc/boot/Makefile
@@ -155,6 +155,7 @@ $(obj)/uImage: vmlinux $(wrapperbits)
 image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
 image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
+image-$(CONFIG_PPC_PS3)			+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage

--
