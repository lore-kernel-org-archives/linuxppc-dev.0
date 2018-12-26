Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E996C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:19:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6648B214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:19:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6648B214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ph9337HDzDqMv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:19:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgn05RXmzDqHJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:56 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 5A9EB29523; Tue, 25 Dec 2018 19:43:56 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Joshua Thompson <funaho@jurai.org>
Message-Id: <505240b144f1666acf26a3c1e93c8e6868fe1408.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 13/25] m68k: Dispatch nvram_ops calls to Atari or Mac
 functions
Date: Wed, 26 Dec 2018 11:37:59 +1100
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

A multi-platform kernel binary has to decide at run-time how to dispatch
the arch_nvram_ops calls. Add a platform-independent arch_nvram_ops
struct for this, to replace the atari-specific one.

Enable CONFIG_HAVE_ARCH_NVRAM_OPS for Macs.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Christian T. Steigies <cts@debian.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/m68k/Kconfig.machine         |   1 +
 arch/m68k/atari/nvram.c           |  21 ++-----
 arch/m68k/include/asm/atarihw.h   |   6 ++
 arch/m68k/include/asm/macintosh.h |   4 ++
 arch/m68k/kernel/setup_mm.c       | 100 +++++++++++++++++++++++++++++-
 arch/m68k/mac/misc.c              |  11 ++++
 6 files changed, 126 insertions(+), 17 deletions(-)

diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 0c8c4c7982c1..da21783136c7 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -27,6 +27,7 @@ config MAC
 	bool "Macintosh support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the Apple Macintosh series of
 	  computers (yes, there is experimental support now, at least for part
diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 4b27f1683a37..0a6fe59c95e8 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,7 +74,7 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
-static long nvram_set_checksum(void)
+long atari_nvram_set_checksum(void)
 {
 	spin_lock_irq(&rtc_lock);
 	__nvram_set_checksum();
@@ -82,7 +82,7 @@ static long nvram_set_checksum(void)
 	return 0;
 }
 
-static long nvram_initialize(void)
+long atari_nvram_initialize(void)
 {
 	loff_t i;
 
@@ -94,7 +94,7 @@ static long nvram_initialize(void)
 	return 0;
 }
 
-static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
+ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
 	loff_t i;
@@ -115,7 +115,7 @@ static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 	return p - buf;
 }
 
-static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
+ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
 	loff_t i;
@@ -138,22 +138,11 @@ static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
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
diff --git a/arch/m68k/include/asm/atarihw.h b/arch/m68k/include/asm/atarihw.h
index 9000b249d225..533008262b69 100644
--- a/arch/m68k/include/asm/atarihw.h
+++ b/arch/m68k/include/asm/atarihw.h
@@ -33,6 +33,12 @@ extern int atari_dont_touch_floppy_select;
 
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
diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 08cee11180e6..d9a08bed4b12 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -19,6 +19,10 @@ extern void mac_init_IRQ(void);
 extern void mac_irq_enable(struct irq_data *data);
 extern void mac_irq_disable(struct irq_data *data);
 
+extern unsigned char mac_pram_read_byte(int);
+extern void mac_pram_write_byte(unsigned char, int);
+extern ssize_t mac_pram_get_size(void);
+
 /*
  *	Macintosh Table
  */
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index ad0195cbe042..4dd80bb8a283 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -24,6 +24,7 @@
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/module.h>
+#include <linux/nvram.h>
 #include <linux/initrd.h>
 
 #include <asm/bootinfo.h>
@@ -37,13 +38,14 @@
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
@@ -547,3 +549,99 @@ static int __init adb_probe_sync_enable (char *str) {
 
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
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 0009efebb264..b7e6bc037fc4 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -36,6 +36,7 @@
 
 static void (*rom_reset)(void);
 
+#if IS_ENABLED(CONFIG_NVRAM)
 #ifdef CONFIG_ADB_CUDA
 static unsigned char cuda_pram_read_byte(int offset)
 {
@@ -84,6 +85,7 @@ static void pmu_pram_write_byte(unsigned char data, int offset)
 	pmu_wait_complete(&req);
 }
 #endif /* CONFIG_ADB_PMU */
+#endif /* CONFIG_NVRAM */
 
 /*
  * VIA PRAM/RTC access routines
@@ -205,6 +207,7 @@ static void via_rtc_command(int command, __u8 *data)
 	local_irq_restore(flags);
 }
 
+#if IS_ENABLED(CONFIG_NVRAM)
 static unsigned char via_pram_read_byte(int offset)
 {
 	unsigned char temp;
@@ -227,6 +230,7 @@ static void via_pram_write_byte(unsigned char data, int offset)
 	temp = 0x55 | RTC_FLG_WRITE_PROTECT;
 	via_rtc_command(RTC_CMD_WRITE(RTC_REG_WRITE_PROTECT), &temp);
 }
+#endif /* CONFIG_NVRAM */
 
 /*
  * Return the current time in seconds since January 1, 1904.
@@ -372,6 +376,7 @@ static void cuda_shutdown(void)
  *-------------------------------------------------------------------
  */
 
+#if IS_ENABLED(CONFIG_NVRAM)
 unsigned char mac_pram_read_byte(int addr)
 {
 	switch (macintosh_config->adb_type) {
@@ -417,6 +422,12 @@ void mac_pram_write_byte(unsigned char val, int addr)
 	}
 }
 
+ssize_t mac_pram_get_size(void)
+{
+	return 256;
+}
+#endif /* CONFIG_NVRAM */
+
 void mac_poweroff(void)
 {
 	if (oss_present) {
-- 
2.19.2

