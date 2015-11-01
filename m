Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id BAEA01A05EE
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 21:49:02 +1100 (AEDT)
Message-Id: <20151101104208.761692750@telegraphics.com.au>
Date: Sun, 01 Nov 2015 21:42:28 +1100
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v7 26/26] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
References: <20151101104202.301856132@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A multi-platform kernel binary needs to decide at run-time how to dispatch
the arch_nvram_ops calls. Add platform-independent arch_nvram_ops, for use
when multiple platform-specific NVRAM ops implementations are needed.

Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Christian T. Steigies <cts@debian.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

---

Changed since v1:
- Removed Mac and Atari ops struct definitions and the associated #ifdefs.
- Moved extern declarations for fewer lines of code and better readability.
- The IS_ENABLED(CONFIG_NVRAM) tests were moved to this patch, because it is
now in this patch that CONFIG_HAVE_ARCH_NVRAM_OPS is enabled for Macs.

Changes since v3:
- Use bool (and select) instead of def_bool in the definition of the
HAVE_ARCH_NVRAM_OPS Kconfig symbol, as requested by Geert.
- Moved extern declarations back to the header files (like in v1)
as requested by Geert.

---
 arch/m68k/Kconfig.machine         |    1 
 arch/m68k/atari/nvram.c           |   21 +------
 arch/m68k/include/asm/atarihw.h   |    6 ++
 arch/m68k/include/asm/macintosh.h |    4 +
 arch/m68k/kernel/setup_mm.c       |  100 +++++++++++++++++++++++++++++++++++++-
 arch/m68k/mac/misc.c              |   18 ++++++
 6 files changed, 133 insertions(+), 17 deletions(-)

Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-11-01 21:41:57.000000000 +1100
+++ linux/arch/m68k/mac/misc.c	2015-11-01 21:41:58.000000000 +1100
@@ -61,6 +61,7 @@ static void cuda_write_time(long data)
 		cuda_poll();
 }
 
+#if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char cuda_pram_read_byte(int offset)
 {
 	struct adb_request req;
@@ -81,6 +82,8 @@ static void cuda_pram_write_byte(unsigne
 	while (!req.complete)
 		cuda_poll();
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define cuda_read_time() 0
 #define cuda_write_time(n)
@@ -116,6 +119,7 @@ static void pmu_write_time(long data)
 		pmu_poll();
 }
 
+#if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char pmu_pram_read_byte(int offset)
 {
 	struct adb_request req;
@@ -139,6 +143,8 @@ static void pmu_pram_write_byte(unsigned
 	while (!req.complete)
 		pmu_poll();
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define pmu_read_time() 0
 #define pmu_write_time(n)
@@ -172,6 +178,7 @@ static void maciisi_write_time(long data
 			(data >> 8) & 0xFF, data & 0xFF);
 }
 
+#if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char maciisi_pram_read_byte(int offset)
 {
 	struct adb_request req;
@@ -187,6 +194,8 @@ static void maciisi_pram_write_byte(unsi
 	maciisi_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
 			(offset >> 8) & 0xFF, offset & 0xFF, data);
 }
+#endif /* CONFIG_NVRAM */
+
 #else
 #define maciisi_read_time() 0
 #define maciisi_write_time(n)
@@ -314,6 +323,7 @@ static void via_rtc_command(int command,
 	local_irq_restore(flags);
 }
 
+#if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char via_pram_read_byte(int offset)
 {
 	unsigned char temp;
@@ -336,6 +346,7 @@ static void via_pram_write_byte(unsigned
 	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
 	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
+#endif /* CONFIG_NVRAM */
 
 /*
  * Return the current time in seconds since January 1, 1904.
@@ -503,6 +514,7 @@ void pmu_shutdown(void)
  *-------------------------------------------------------------------
  */
 
+#if IS_ENABLED(CONFIG_NVRAM)
 unsigned char mac_pram_read_byte(int addr)
 {
 	unsigned char (*func)(int);
@@ -550,6 +562,12 @@ void mac_pram_write_byte(unsigned char v
 		(*func)(val, addr);
 }
 
+ssize_t mac_pram_get_size(void)
+{
+	return 256;
+}
+#endif /* CONFIG_NVRAM */
+
 void mac_poweroff(void)
 {
 	/*
Index: linux/arch/m68k/atari/nvram.c
===================================================================
--- linux.orig/arch/m68k/atari/nvram.c	2015-11-01 21:41:47.000000000 +1100
+++ linux/arch/m68k/atari/nvram.c	2015-11-01 21:41:58.000000000 +1100
@@ -73,7 +73,7 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
-static long nvram_set_checksum(void)
+long atari_nvram_set_checksum(void)
 {
 	spin_lock_irq(&rtc_lock);
 	__nvram_set_checksum();
@@ -81,7 +81,7 @@ static long nvram_set_checksum(void)
 	return 0;
 }
 
-static long nvram_initialize(void)
+long atari_nvram_initialize(void)
 {
 	loff_t i;
 
@@ -93,7 +93,7 @@ static long nvram_initialize(void)
 	return 0;
 }
 
-static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
+ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
 	loff_t i;
@@ -114,7 +114,7 @@ static ssize_t nvram_read(char *buf, siz
 	return p - buf;
 }
 
-static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
+ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
 	loff_t i;
@@ -137,22 +137,11 @@ static ssize_t nvram_write(char *buf, si
 	return p - buf;
 }
 
-static ssize_t nvram_get_size(void)
+ssize_t atari_nvram_get_size(void)
 {
-	if (!MACH_IS_ATARI)
-		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
-const struct nvram_ops arch_nvram_ops = {
-	.read           = nvram_read,
-	.write          = nvram_write,
-	.get_size       = nvram_get_size,
-	.set_checksum   = nvram_set_checksum,
-	.initialize     = nvram_initialize,
-};
-EXPORT_SYMBOL(arch_nvram_ops);
-
 #ifdef CONFIG_PROC_FS
 static struct {
 	unsigned char val;
Index: linux/arch/m68k/kernel/setup_mm.c
===================================================================
--- linux.orig/arch/m68k/kernel/setup_mm.c	2015-11-01 21:41:23.000000000 +1100
+++ linux/arch/m68k/kernel/setup_mm.c	2015-11-01 21:41:58.000000000 +1100
@@ -23,6 +23,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/nvram.h>
 #include <linux/initrd.h>
 
 #include <asm/bootinfo.h>
@@ -36,13 +37,14 @@
 #ifdef CONFIG_AMIGA
 #include <asm/amigahw.h>
 #endif
-#ifdef CONFIG_ATARI
 #include <asm/atarihw.h>
+#ifdef CONFIG_ATARI
 #include <asm/atari_stram.h>
 #endif
 #ifdef CONFIG_SUN3X
 #include <asm/dvma.h>
 #endif
+#include <asm/macintosh.h>
 #include <asm/natfeat.h>
 
 #if !FPSTATESIZE || !NR_IRQS
@@ -568,3 +570,99 @@ static int __init adb_probe_sync_enable
 
 __setup("adb_sync", adb_probe_sync_enable);
 #endif /* CONFIG_ADB */
+
+#if IS_ENABLED(CONFIG_NVRAM)
+#ifdef CONFIG_MAC
+static unsigned char m68k_nvram_read_byte(int addr)
+{
+	if (MACH_IS_MAC)
+		return mac_pram_read_byte(addr);
+	return 0xff;
+}
+
+static void m68k_nvram_write_byte(unsigned char val, int addr)
+{
+	if (MACH_IS_MAC)
+		mac_pram_write_byte(val, addr);
+}
+#endif /* CONFIG_MAC */
+
+#ifdef CONFIG_ATARI
+static ssize_t m68k_nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+	if (MACH_IS_ATARI)
+		return atari_nvram_read(buf, count, ppos);
+	else if (MACH_IS_MAC) {
+		ssize_t size = mac_pram_get_size();
+		char *p = buf;
+		loff_t i;
+
+		for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
+			*p = mac_pram_read_byte(i);
+
+		*ppos = i;
+		return p - buf;
+	}
+	return -EINVAL;
+}
+
+static ssize_t m68k_nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+	if (MACH_IS_ATARI)
+		return atari_nvram_write(buf, count, ppos);
+	else if (MACH_IS_MAC) {
+		ssize_t size = mac_pram_get_size();
+		char *p = buf;
+		loff_t i;
+
+		for (i = *ppos; count > 0 && i < size; --count, ++i, ++p)
+			mac_pram_write_byte(*p, i);
+
+		*ppos = i;
+		return p - buf;
+	}
+	return -EINVAL;
+}
+
+static long m68k_nvram_set_checksum(void)
+{
+	if (MACH_IS_ATARI)
+		return atari_nvram_set_checksum();
+	return -EINVAL;
+}
+
+static long m68k_nvram_initialize(void)
+{
+	if (MACH_IS_ATARI)
+		return atari_nvram_initialize();
+	return -EINVAL;
+}
+#endif /* CONFIG_ATARI */
+
+static ssize_t m68k_nvram_get_size(void)
+{
+	if (MACH_IS_ATARI)
+		return atari_nvram_get_size();
+	else if (MACH_IS_MAC)
+		return mac_pram_get_size();
+	return -ENODEV;
+}
+
+/* Atari device drivers call .read (to get checksum validation) whereas
+ * Mac and PowerMac device drivers just use .read_byte.
+ */
+const struct nvram_ops arch_nvram_ops = {
+#ifdef CONFIG_MAC
+	.read_byte      = m68k_nvram_read_byte,
+	.write_byte     = m68k_nvram_write_byte,
+#endif
+#ifdef CONFIG_ATARI
+	.read           = m68k_nvram_read,
+	.write          = m68k_nvram_write,
+	.set_checksum   = m68k_nvram_set_checksum,
+	.initialize     = m68k_nvram_initialize,
+#endif
+	.get_size       = m68k_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+#endif /* CONFIG_NVRAM */
Index: linux/arch/m68k/Kconfig.machine
===================================================================
--- linux.orig/arch/m68k/Kconfig.machine	2015-11-01 21:41:36.000000000 +1100
+++ linux/arch/m68k/Kconfig.machine	2015-11-01 21:41:58.000000000 +1100
@@ -26,6 +26,7 @@ config MAC
 	bool "Macintosh support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
Index: linux/arch/m68k/include/asm/atarihw.h
===================================================================
--- linux.orig/arch/m68k/include/asm/atarihw.h	2015-11-01 21:41:23.000000000 +1100
+++ linux/arch/m68k/include/asm/atarihw.h	2015-11-01 21:41:58.000000000 +1100
@@ -32,6 +32,12 @@ extern int atari_dont_touch_floppy_selec
 
 extern int atari_SCC_reset_done;
 
+extern ssize_t atari_nvram_read(char *, size_t, loff_t *);
+extern ssize_t atari_nvram_write(char *, size_t, loff_t *);
+extern ssize_t atari_nvram_get_size(void);
+extern long atari_nvram_set_checksum(void);
+extern long atari_nvram_initialize(void);
+
 /* convenience macros for testing machine type */
 #define MACH_IS_ST	((atari_mch_cookie >> 16) == ATARI_MCH_ST)
 #define MACH_IS_STE	((atari_mch_cookie >> 16) == ATARI_MCH_STE && \
Index: linux/arch/m68k/include/asm/macintosh.h
===================================================================
--- linux.orig/arch/m68k/include/asm/macintosh.h	2015-11-01 21:41:23.000000000 +1100
+++ linux/arch/m68k/include/asm/macintosh.h	2015-11-01 21:41:58.000000000 +1100
@@ -18,6 +18,10 @@ extern void mac_init_IRQ(void);
 extern void mac_irq_enable(struct irq_data *data);
 extern void mac_irq_disable(struct irq_data *data);
 
+extern unsigned char mac_pram_read_byte(int);
+extern void mac_pram_write_byte(unsigned char, int);
+extern ssize_t mac_pram_get_size(void);
+
 /*
  *	Macintosh Table
  */
