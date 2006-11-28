Return-Path: <Geoffrey.Levand@am.sony.com>
Message-ID: <456BAB86.4070104@am.sony.com>
Date: Mon, 27 Nov 2006 19:22:46 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: [POWERPC] ps3: add a default zImage target
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's currently not possible to build the default zImage target if PS3 is the
only selected platform. This adds a target that builds a stripped vmlinux,
which the PS3 bootloader (kboot) will be able to load.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>


---

This replaces Arnd's patch '[POWERPC 7/9] ps3: add a default zImage target'
sent out earlier today.

-Geoff

 arch/powerpc/boot/Makefile |    4 ++++
 1 files changed, 4 insertions(+)

Index: cell--common--7/arch/powerpc/boot/Makefile
===================================================================
--- cell--common--7.orig/arch/powerpc/boot/Makefile
+++ cell--common--7/arch/powerpc/boot/Makefile
@@ -149,6 +149,9 @@
 $(obj)/zImage.initrd.miboot: vmlinux $(wrapperbits)
 	$(call cmd,wrap_initrd,miboot)
 
+$(obj)/zImage.ps3: vmlinux
+	$(STRIP) -s -R .comment $< -o $@
+
 $(obj)/uImage: vmlinux $(wrapperbits)
 	$(call cmd,wrap,uboot)
 
@@ -157,6 +160,7 @@
 image-$(CONFIG_PPC_IBM_CELL_BLADE)	+= zImage.pseries
 image-$(CONFIG_PPC_CHRP)		+= zImage.chrp
 image-$(CONFIG_PPC_PMAC)		+= zImage.pmac
+image-$(CONFIG_PPC_PS3)			+= zImage.ps3
 image-$(CONFIG_DEFAULT_UIMAGE)		+= uImage
 
 # For 32-bit powermacs, build the COFF and miboot images
