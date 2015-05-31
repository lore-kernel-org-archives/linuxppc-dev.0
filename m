Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 894D21A0CA3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:01 +1000 (AEST)
Message-Id: <20150531010138.309478365@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:56 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [RFC 24/24] m68k: Dispatch nvram_ops calls to Atari or Mac functions
References: <20150531010132.289674310@telegraphics.com.au>
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

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---
 arch/m68k/Kconfig                 |    2 
 arch/m68k/atari/nvram.c           |   22 +++++----
 arch/m68k/include/asm/atarihw.h   |    6 ++
 arch/m68k/include/asm/macintosh.h |    4 +
 arch/m68k/kernel/setup_mm.c       |   89 ++++++++++++++++++++++++++++++++++++++
 arch/m68k/mac/misc.c              |    8 ++-
 6 files changed, 117 insertions(+), 14 deletions(-)

Index: linux/arch/m68k/atari/nvram.c
===================================================================
--- linux.orig/arch/m68k/atari/nvram.c	2015-05-31 11:01:21.000000000 +1000
+++ linux/arch/m68k/atari/nvram.c	2015-05-31 11:01:29.000000000 +1000
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
@@ -137,21 +137,23 @@ static ssize_t nvram_write(char *buf, si
 	return p - buf;
 }
 
-static ssize_t nvram_get_size(void)
+ssize_t atari_nvram_get_size(void)
 {
 	if (!MACH_IS_ATARI)
 		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
+#ifndef CONFIG_MAC
 const struct nvram_ops arch_nvram_ops = {
-	.read           = nvram_read,
-	.write          = nvram_write,
-	.get_size       = nvram_get_size,
-	.set_checksum   = nvram_set_checksum,
-	.initialize     = nvram_initialize,
+	.read           = atari_nvram_read,
+	.write          = atari_nvram_write,
+	.get_size       = atari_nvram_get_size,
+	.set_checksum   = atari_nvram_set_checksum,
+	.initialize     = atari_nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
+#endif
 
 #ifdef CONFIG_PROC_FS
 static struct {
Index: linux/arch/m68k/mac/misc.c
===================================================================
--- linux.orig/arch/m68k/mac/misc.c	2015-05-31 11:01:28.000000000 +1000
+++ linux/arch/m68k/mac/misc.c	2015-05-31 11:01:29.000000000 +1000
@@ -489,7 +489,7 @@ void pmu_shutdown(void)
  */
 
 #if IS_ENABLED(CONFIG_NVRAM)
-static unsigned char mac_pram_read_byte(int addr)
+unsigned char mac_pram_read_byte(int addr)
 {
 	unsigned char (*func)(int);
 
@@ -513,7 +513,7 @@ static unsigned char mac_pram_read_byte(
 	return 0xff;
 }
 
-static void mac_pram_write_byte(unsigned char val, int addr)
+void mac_pram_write_byte(unsigned char val, int addr)
 {
 	void (*func)(unsigned char, int);
 
@@ -536,19 +536,21 @@ static void mac_pram_write_byte(unsigned
 		(*func)(val, addr);
 }
 
-static ssize_t mac_pram_get_size(void)
+ssize_t mac_pram_get_size(void)
 {
 	if (!MACH_IS_MAC)
 		return -ENODEV;
 	return 256;
 }
 
+#ifndef CONFIG_ATARI
 const struct nvram_ops arch_nvram_ops = {
 	.read_byte      = mac_pram_read_byte,
 	.write_byte     = mac_pram_write_byte,
 	.get_size       = mac_pram_get_size,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
+#endif
 #endif /* CONFIG_NVRAM */
 
 
Index: linux/arch/m68k/kernel/setup_mm.c
===================================================================
--- linux.orig/arch/m68k/kernel/setup_mm.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/m68k/kernel/setup_mm.c	2015-05-31 11:01:29.000000000 +1000
@@ -23,6 +23,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/nvram.h>
 #include <linux/initrd.h>
 
 #include <asm/bootinfo.h>
@@ -40,6 +41,9 @@
 #include <asm/atarihw.h>
 #include <asm/atari_stram.h>
 #endif
+#ifdef CONFIG_MAC
+#include <asm/macintosh.h>
+#endif
 #ifdef CONFIG_SUN3X
 #include <asm/dvma.h>
 #endif
@@ -568,3 +572,88 @@ static int __init adb_probe_sync_enable
 
 __setup("adb_sync", adb_probe_sync_enable);
 #endif /* CONFIG_ADB */
+
+#if IS_ENABLED(CONFIG_NVRAM) && defined(CONFIG_ATARI) && defined(CONFIG_MAC)
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
+
+const struct nvram_ops arch_nvram_ops = {
+	.read           = m68k_nvram_read,
+	.write          = m68k_nvram_write,
+	.read_byte      = m68k_nvram_read_byte,
+	.write_byte     = m68k_nvram_write_byte,
+	.get_size       = m68k_nvram_get_size,
+	.set_checksum   = m68k_nvram_set_checksum,
+	.initialize     = m68k_nvram_initialize,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+#endif
Index: linux/arch/m68k/Kconfig
===================================================================
--- linux.orig/arch/m68k/Kconfig	2015-05-31 11:01:26.000000000 +1000
+++ linux/arch/m68k/Kconfig	2015-05-31 11:01:29.000000000 +1000
@@ -72,7 +72,7 @@ config PGTABLE_LEVELS
 	default 3
 
 config HAVE_ARCH_NVRAM_OPS
-	def_bool (ATARI && !MAC) || (MAC && !ATARI)
+	def_bool ATARI || MAC
 
 source "init/Kconfig"
 
Index: linux/arch/m68k/include/asm/atarihw.h
===================================================================
--- linux.orig/arch/m68k/include/asm/atarihw.h	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/m68k/include/asm/atarihw.h	2015-05-31 11:01:29.000000000 +1000
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
--- linux.orig/arch/m68k/include/asm/macintosh.h	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/m68k/include/asm/macintosh.h	2015-05-31 11:01:29.000000000 +1000
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
