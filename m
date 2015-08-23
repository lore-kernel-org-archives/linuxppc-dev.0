Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 2823F1A0D01
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Aug 2015 21:13:31 +1000 (AEST)
Message-Id: <20150823104132.038008260@telegraphics.com.au>
Date: Sun, 23 Aug 2015 20:41:39 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC v6 10/25] m68k/atari: Implement arch_nvram_ops methods and
 enable CONFIG_HAVE_ARCH_NVRAM_OPS
References: <20150823104129.517600532@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Atari RTC NVRAM has a checksum so implement the remaining arch_nvram_ops
methods for the set_checksum and initialize ioctls. Enable
CONFIG_HAVE_ARCH_NVRAM_OPS.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

This re-enables the nvram module for Atari.

Changes since v3:
- Use bool (and select) instead of def_bool in the definition of the
HAVE_ARCH_NVRAM_OPS Kconfig symbol, as requested by Geert.

---
 arch/m68k/Kconfig         |    3 +++
 arch/m68k/Kconfig.machine |    1 +
 arch/m68k/atari/nvram.c   |   24 ++++++++++++++++++++++++
 drivers/char/Kconfig      |    2 +-
 4 files changed, 29 insertions(+), 1 deletion(-)

Index: linux/arch/m68k/atari/nvram.c
===================================================================
--- linux.orig/arch/m68k/atari/nvram.c	2015-08-23 20:40:57.000000000 +1000
+++ linux/arch/m68k/atari/nvram.c	2015-08-23 20:41:05.000000000 +1000
@@ -73,6 +73,26 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static long nvram_set_checksum(void)
+{
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static long nvram_initialize(void)
+{
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		__nvram_write_byte(0, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
 static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
@@ -119,6 +139,8 @@ static ssize_t nvram_write(char *buf, si
 
 static ssize_t nvram_get_size(void)
 {
+	if (!MACH_IS_ATARI)
+		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
@@ -126,6 +148,8 @@ const struct nvram_ops arch_nvram_ops =
 	.read           = nvram_read,
 	.write          = nvram_write,
 	.get_size       = nvram_get_size,
+	.set_checksum   = nvram_set_checksum,
+	.initialize     = nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
Index: linux/drivers/char/Kconfig
===================================================================
--- linux.orig/drivers/char/Kconfig	2015-08-23 20:40:53.000000000 +1000
+++ linux/drivers/char/Kconfig	2015-08-23 20:41:05.000000000 +1000
@@ -247,7 +247,7 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM
+	depends on X86 || (ARM && RTC_DRV_CMOS) || GENERIC_NVRAM || HAVE_ARCH_NVRAM_OPS
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
Index: linux/arch/m68k/Kconfig
===================================================================
--- linux.orig/arch/m68k/Kconfig	2015-08-23 20:40:53.000000000 +1000
+++ linux/arch/m68k/Kconfig	2015-08-23 20:41:05.000000000 +1000
@@ -71,6 +71,9 @@ config PGTABLE_LEVELS
 	default 2 if SUN3 || COLDFIRE
 	default 3
 
+config HAVE_ARCH_NVRAM_OPS
+	bool
+
 source "init/Kconfig"
 
 source "kernel/Kconfig.freezer"
Index: linux/arch/m68k/Kconfig.machine
===================================================================
--- linux.orig/arch/m68k/Kconfig.machine	2015-08-23 20:40:53.000000000 +1000
+++ linux/arch/m68k/Kconfig.machine	2015-08-23 20:41:05.000000000 +1000
@@ -15,6 +15,7 @@ config ATARI
 	bool "Atari support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the 68000-based Atari series of
 	  computers (including the TT, Falcon and Medusa). If you plan to use
