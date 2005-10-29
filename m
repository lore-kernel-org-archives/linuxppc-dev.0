Return-Path: <akpm@osdl.org>
Message-Id: <200510290047.j9T0lPEf030123@shell0.pdx.osdl.net>
To: paulus@samba.org
From: akpm@osdl.org
Date: Fri, 28 Oct 2005 17:46:55 -0700
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, olh@suse.de,
	linuxppc64-dev@ozlabs.org
Subject: [patch 40/43] ppc64: reenable make install with defconfig
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Olaf Hering <olh@suse.de>

'make ARCH=ppc64 O=../O install' does not work with the defconfig.
CONFIG_PPC_BPA is part of it, but the BPA bootimage variable is wrong:

make[2]: *** No rule to make target `zImage', needed by `install'.  Stop.

Signed-off-by: Olaf Hering <olh@suse.de>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/ppc64/Makefile |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/ppc64/Makefile~ppc64-reenable-make-install-with-defconfig arch/ppc64/Makefile
--- devel/arch/ppc64/Makefile~ppc64-reenable-make-install-with-defconfig	2005-10-28 17:44:05.000000000 -0700
+++ devel-akpm/arch/ppc64/Makefile	2005-10-28 17:44:05.000000000 -0700
@@ -103,7 +103,7 @@ $(boottargets-y): vmlinux
 bootimage-$(CONFIG_PPC_PSERIES) := $(boot)/zImage
 bootimage-$(CONFIG_PPC_PMAC) := vmlinux
 bootimage-$(CONFIG_PPC_MAPLE) := $(boot)/zImage
-bootimage-$(CONFIG_PPC_BPA) := zImage
+bootimage-$(CONFIG_PPC_BPA) := $(boot)/zImage
 bootimage-$(CONFIG_PPC_ISERIES) := vmlinux
 BOOTIMAGE := $(bootimage-y)
 install: vmlinux
_
