Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-fra-R.bigfish.com (outbound-fra.frontbridge.com
	[62.209.45.174])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0635267DDB
	for <linuxppc-dev@ozlabs.org>; Sun,  8 Oct 2006 08:56:51 +1000 (EST)
Message-ID: <45282B51.4020909@am.sony.com>
Date: Sat, 07 Oct 2006 15:33:53 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] cell: fix default zImage build target
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Change CONFIG_PPC_CELL to CONFIG_PPC_IBM_CELL_BLADE in the powerpc boot
makefile.

CONFIG_PPC_CELL is used to build the generic cell processor support, and
is not an indication of platform.


Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>

---

Index: cell--common--5/arch/powerpc/boot/Makefile
===================================================================
--- cell--common--5.orig/arch/powerpc/boot/Makefile
+++ cell--common--5/arch/powerpc/boot/Makefile
@@ -151,12 +151,12 @@
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
-image-$(CONFIG_PPC_PSERIES)	+= zImage.pseries
-image-$(CONFIG_PPC_MAPLE)	+= zImage.pseries
-image-$(CONFIG_PPC_CELL)	+= zImage.pseries
-image-$(CONFIG_PPC_CHRP)	+= zImage.chrp
-image-$(CONFIG_PPC_PMAC)	+= zImage.pmac
-image-$(CONFIG_DEFAULT_UIMAGE)	+= uImage
+image-$(CONFIG_PPC_PSERIES)		+= zImage.pseries
+image-$(CONFIG_PPC_MAPLE)		+= zImage.pseries
+image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
+image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
+image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
 # as well as the ELF images.
