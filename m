Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 9E4D51A0CAA
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010137.079458402@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:51 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 19/24] powerpc: Remove CONFIG_GENERIC_NVRAM and adopt
 CONFIG_HAVE_ARCH_NVRAM_OPS
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Switch PPC32 kernels from the generic_nvram module to the nvram module.

Also fix a theoretical bug where CHRP omits the chrp_nvram_init()
call when CONFIG_NVRAM_MODULE=m.

As before, when CONFIG_PPC && !CONFIG_PPC_PMAC, the IOC_NVRAM_GET_OFFSET
ioctl is unimplemented. For the nvram module, unimplemented ioctls return
-ENOTTY. Whereas, for the superseded generic_nvram module they would
return -EINVAL.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

This ioctl change is visible to userspace code but only in an error path.
I didn't find any userspace code that uses the IOC_NVRAM_GET_OFFSET ioctl.

The change in the name of the module is also visible. The module that
implements /dev/nvram on PowerPC now has suitable aliases, i.e.
MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
MODULE_ALIAS("devname:nvram"); 
so that the device special file can be automatically created and the
module automatically loaded when needed. Previously this was not the case.

---
 arch/powerpc/Kconfig                    |    2 +-
 arch/powerpc/kernel/setup_32.c          |    2 +-
 arch/powerpc/platforms/chrp/Makefile    |    2 +-
 arch/powerpc/platforms/chrp/setup.c     |    2 +-
 arch/powerpc/platforms/powermac/setup.c |    3 +--
 drivers/char/Kconfig                    |   10 ++++++----
 6 files changed, 11 insertions(+), 10 deletions(-)

Index: linux/arch/powerpc/Kconfig
===================================================================
--- linux.orig/arch/powerpc/Kconfig	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/Kconfig	2015-05-31 11:01:22.000000000 +1000
@@ -178,7 +178,7 @@ config SYSVIPC_COMPAT
 	default y
 
 # All PPC32s use generic nvram driver through ppc_md
-config GENERIC_NVRAM
+config HAVE_ARCH_NVRAM_OPS
 	bool
 	default y if PPC32
 
Index: linux/arch/powerpc/kernel/setup_32.c
===================================================================
--- linux.orig/arch/powerpc/kernel/setup_32.c	2015-05-31 11:01:19.000000000 +1000
+++ linux/arch/powerpc/kernel/setup_32.c	2015-05-31 11:01:22.000000000 +1000
@@ -168,7 +168,7 @@ int __init ppc_setup_l3cr(char *str)
 }
 __setup("l3cr=", ppc_setup_l3cr);
 
-#ifdef CONFIG_GENERIC_NVRAM
+#if IS_ENABLED(CONFIG_NVRAM)
 
 static unsigned char ppc_nvram_read_byte(int addr)
 {
Index: linux/arch/powerpc/platforms/chrp/Makefile
===================================================================
--- linux.orig/arch/powerpc/platforms/chrp/Makefile	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/chrp/Makefile	2015-05-31 11:01:22.000000000 +1000
@@ -1,3 +1,3 @@
 obj-y				+= setup.o time.o pegasos_eth.o pci.o
 obj-$(CONFIG_SMP)		+= smp.o
-obj-$(CONFIG_NVRAM)		+= nvram.o
+obj-$(CONFIG_NVRAM:m=y)	+= nvram.o
Index: linux/arch/powerpc/platforms/chrp/setup.c
===================================================================
--- linux.orig/arch/powerpc/platforms/chrp/setup.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/chrp/setup.c	2015-05-31 11:01:22.000000000 +1000
@@ -557,7 +557,7 @@ void __init chrp_init_IRQ(void)
 void __init
 chrp_init2(void)
 {
-#ifdef CONFIG_NVRAM
+#if IS_ENABLED(CONFIG_NVRAM)
 	chrp_nvram_init();
 #endif
 
Index: linux/arch/powerpc/platforms/powermac/setup.c
===================================================================
--- linux.orig/arch/powerpc/platforms/powermac/setup.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/powerpc/platforms/powermac/setup.c	2015-05-31 11:01:22.000000000 +1000
@@ -321,8 +321,7 @@ static void __init pmac_setup_arch(void)
 	find_via_pmu();
 	smu_init();
 
-#if defined(CONFIG_NVRAM) || defined(CONFIG_NVRAM_MODULE) || \
-    defined(CONFIG_PPC64)
+#if IS_ENABLED(CONFIG_NVRAM) || defined(CONFIG_PPC64)
 	pmac_nvram_init();
 #endif
 
Index: linux/drivers/char/Kconfig
===================================================================
--- linux.orig/drivers/char/Kconfig	2015-05-31 11:01:11.000000000 +1000
+++ linux/drivers/char/Kconfig	2015-05-31 11:01:22.000000000 +1000
@@ -247,7 +247,7 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM || HAVE_ARCH_NVRAM_OPS
+	depends on X86 || (ARM && RTC_DRV_CMOS) || HAVE_ARCH_NVRAM_OPS
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
@@ -256,9 +256,11 @@ config NVRAM
 	  and most Ataris.  The actual number of bytes varies, depending on the
 	  nvram in the system, but is usually 114 (128-14 for the RTC).
 
-	  This memory is conventionally called "CMOS RAM" on PCs and "NVRAM"
-	  on Ataris. /dev/nvram may be used to view settings there, or to
-	  change them (with some utility). It could also be used to frequently
+	  This memory is conventionally called "CMOS RAM" on PCs,
+	  "NVRAM" on Ataris and "PRAM" on Macintoshes.
+
+	  /dev/nvram may be used to view settings in NVRAM, or to change them
+	  (with some utility). It could also be used to frequently
 	  save a few bits of very important data that may not be lost over
 	  power-off and for which writing to disk is too insecure. Note
 	  however that most NVRAM space in a PC belongs to the BIOS and you
