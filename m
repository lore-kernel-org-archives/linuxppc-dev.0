Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23ABC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:04:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6189821720
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6189821720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfV75RqQzDqKv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:03:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDF5RrRzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:57 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 8B859292DC; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <5a285a9d9aecc1ee748f62e41870111e7e0f4cff.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 02/25] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
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

Move the m68k-specific code out of the driver to make the driver generic.

I've used 'SPDX-License-Identifier: GPL-2.0+' for the new file because the
old file is covered by MODULE_LICENSE("GPL").

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Christian T. Steigies <cts@debian.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Changed since v7:
 - Added SPDX-License-Identifier.
---
 arch/m68k/atari/Makefile |   2 +
 arch/m68k/atari/nvram.c  | 243 +++++++++++++++++++++++++++++++++
 drivers/char/nvram.c     | 280 +++++----------------------------------
 3 files changed, 280 insertions(+), 245 deletions(-)
 create mode 100644 arch/m68k/atari/nvram.c

diff --git a/arch/m68k/atari/Makefile b/arch/m68k/atari/Makefile
index 0cac723306f9..0b86bb6cfa87 100644
--- a/arch/m68k/atari/Makefile
+++ b/arch/m68k/atari/Makefile
@@ -6,3 +6,5 @@ obj-y		:= config.o time.o debug.o ataints.o stdma.o \
 			atasound.o stram.o
 
 obj-$(CONFIG_ATARI_KBD_CORE)	+= atakeyb.o
+
+obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
new file mode 100644
index 000000000000..3e620ee955ba
--- /dev/null
+++ b/arch/m68k/atari/nvram.c
@@ -0,0 +1,243 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * CMOS/NV-RAM driver for Atari. Adapted from drivers/char/nvram.c.
+ * Copyright (C) 1997 Roman Hodek <Roman.Hodek@informatik.uni-erlangen.de>
+ * idea by and with help from Richard Jelinek <rj@suse.de>
+ * Portions copyright (c) 2001,2002 Sun Microsystems (thockin@sun.com)
+ * Further contributions from Cesar Barros, Erik Gilling, Tim Hockin and
+ * Wim Van Sebroeck.
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/mc146818rtc.h>
+#include <linux/module.h>
+#include <linux/nvram.h>
+#include <linux/proc_fs.h>
+#include <linux/seq_file.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+#include <asm/atarihw.h>
+#include <asm/atariints.h>
+
+#define NVRAM_BYTES		50
+
+/* It is worth noting that these functions all access bytes of general
+ * purpose memory in the NVRAM - that is to say, they all add the
+ * NVRAM_FIRST_BYTE offset. Pass them offsets into NVRAM as if you did not
+ * know about the RTC cruft.
+ */
+
+/* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
+ * rtc_lock held. Due to the index-port/data-port design of the RTC, we
+ * don't want two different things trying to get to it at once. (e.g. the
+ * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
+ */
+
+unsigned char __nvram_read_byte(int i)
+{
+	return CMOS_READ(NVRAM_FIRST_BYTE + i);
+}
+
+unsigned char nvram_read_byte(int i)
+{
+	unsigned long flags;
+	unsigned char c;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	c = __nvram_read_byte(i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return c;
+}
+EXPORT_SYMBOL(nvram_read_byte);
+
+/* This races nicely with trying to read with checksum checking */
+void __nvram_write_byte(unsigned char c, int i)
+{
+	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
+}
+
+void nvram_write_byte(unsigned char c, int i)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	__nvram_write_byte(c, i);
+	spin_unlock_irqrestore(&rtc_lock, flags);
+}
+
+/* On Ataris, the checksum is over all bytes except the checksum bytes
+ * themselves; these are at the very end.
+ */
+#define ATARI_CKS_RANGE_START	0
+#define ATARI_CKS_RANGE_END	47
+#define ATARI_CKS_LOC		48
+
+int __nvram_check_checksum(void)
+{
+	int i;
+	unsigned char sum = 0;
+
+	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
+		sum += __nvram_read_byte(i);
+	return (__nvram_read_byte(ATARI_CKS_LOC) == (~sum & 0xff)) &&
+	       (__nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
+}
+
+int nvram_check_checksum(void)
+{
+	unsigned long flags;
+	int rv;
+
+	spin_lock_irqsave(&rtc_lock, flags);
+	rv = __nvram_check_checksum();
+	spin_unlock_irqrestore(&rtc_lock, flags);
+	return rv;
+}
+EXPORT_SYMBOL(nvram_check_checksum);
+
+static void __nvram_set_checksum(void)
+{
+	int i;
+	unsigned char sum = 0;
+
+	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
+		sum += __nvram_read_byte(i);
+	__nvram_write_byte(~sum, ATARI_CKS_LOC);
+	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
+}
+
+#ifdef CONFIG_PROC_FS
+static struct {
+	unsigned char val;
+	const char *name;
+} boot_prefs[] = {
+	{ 0x80, "TOS" },
+	{ 0x40, "ASV" },
+	{ 0x20, "NetBSD (?)" },
+	{ 0x10, "Linux" },
+	{ 0x00, "unspecified" },
+};
+
+static const char * const languages[] = {
+	"English (US)",
+	"German",
+	"French",
+	"English (UK)",
+	"Spanish",
+	"Italian",
+	"6 (undefined)",
+	"Swiss (French)",
+	"Swiss (German)",
+};
+
+static const char * const dateformat[] = {
+	"MM%cDD%cYY",
+	"DD%cMM%cYY",
+	"YY%cMM%cDD",
+	"YY%cDD%cMM",
+	"4 (undefined)",
+	"5 (undefined)",
+	"6 (undefined)",
+	"7 (undefined)",
+};
+
+static const char * const colors[] = {
+	"2", "4", "16", "256", "65536", "??", "??", "??"
+};
+
+static void atari_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
+				  void *offset)
+{
+	int checksum;
+	int i;
+	unsigned int vmode;
+
+	spin_lock_irq(&rtc_lock);
+	checksum = __nvram_check_checksum();
+	spin_unlock_irq(&rtc_lock);
+
+	seq_printf(seq, "Checksum status  : %svalid\n", checksum ? "" : "not ");
+
+	seq_puts(seq, "Boot preference  : ");
+	for (i = ARRAY_SIZE(boot_prefs) - 1; i >= 0; --i)
+		if (nvram[1] == boot_prefs[i].val) {
+			seq_printf(seq, "%s\n", boot_prefs[i].name);
+			break;
+		}
+	if (i < 0)
+		seq_printf(seq, "0x%02x (undefined)\n", nvram[1]);
+
+	seq_printf(seq, "SCSI arbitration : %s\n",
+		   (nvram[16] & 0x80) ? "on" : "off");
+	seq_puts(seq, "SCSI host ID     : ");
+	if (nvram[16] & 0x80)
+		seq_printf(seq, "%d\n", nvram[16] & 7);
+	else
+		seq_puts(seq, "n/a\n");
+
+	if (!MACH_IS_FALCON)
+		return;
+
+	seq_puts(seq, "OS language      : ");
+	if (nvram[6] < ARRAY_SIZE(languages))
+		seq_printf(seq, "%s\n", languages[nvram[6]]);
+	else
+		seq_printf(seq, "%u (undefined)\n", nvram[6]);
+	seq_puts(seq, "Keyboard language: ");
+	if (nvram[7] < ARRAY_SIZE(languages))
+		seq_printf(seq, "%s\n", languages[nvram[7]]);
+	else
+		seq_printf(seq, "%u (undefined)\n", nvram[7]);
+	seq_puts(seq, "Date format      : ");
+	seq_printf(seq, dateformat[nvram[8] & 7],
+		   nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
+	seq_printf(seq, ", %dh clock\n", nvram[8] & 16 ? 24 : 12);
+	seq_puts(seq, "Boot delay       : ");
+	if (nvram[10] == 0)
+		seq_puts(seq, "default");
+	else
+		seq_printf(seq, "%ds%s\n", nvram[10],
+			   nvram[10] < 8 ? ", no memory test" : "");
+
+	vmode = (nvram[14] << 8) | nvram[15];
+	seq_printf(seq,
+		   "Video mode       : %s colors, %d columns, %s %s monitor\n",
+		   colors[vmode & 7], vmode & 8 ? 80 : 40,
+		   vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
+	seq_printf(seq,
+		   "                   %soverscan, compat. mode %s%s\n",
+		   vmode & 64 ? "" : "no ", vmode & 128 ? "on" : "off",
+		   vmode & 256 ?
+		   (vmode & 16 ? ", line doubling" : ", half screen") : "");
+}
+
+static int nvram_proc_read(struct seq_file *seq, void *offset)
+{
+	unsigned char contents[NVRAM_BYTES];
+	int i;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		contents[i] = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	atari_nvram_proc_read(contents, seq, offset);
+
+	return 0;
+}
+
+static int __init atari_nvram_init(void)
+{
+	if (!(MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK)))
+		return -ENODEV;
+
+	if (!proc_create_single("driver/nvram", 0, NULL, nvram_proc_read)) {
+		pr_err("nvram: can't create /proc/driver/nvram\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+device_initcall(atari_nvram_init);
+#endif /* CONFIG_PROC_FS */
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 25264d65e716..a9d4652f9e90 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -21,13 +21,6 @@
  * ioctl(NVRAM_SETCKS) (doesn't change contents, just makes checksum valid
  * again; use with care!)
  *
- * This file also provides some functions for other parts of the kernel that
- * want to access the NVRAM: nvram_{read,write,check_checksum,set_checksum}.
- * Obviously this can be used only if this driver is always configured into
- * the kernel and is not a module. Since the functions are used by some Atari
- * drivers, this is the case on the Atari.
- *
- *
  * 	1.1	Cesar Barros: SMP locking fixes
  * 		added changelog
  * 	1.2	Erik Gilling: Cobalt Networks support
@@ -39,64 +32,6 @@
 
 #include <linux/module.h>
 #include <linux/nvram.h>
-
-#define PC		1
-#define ATARI		2
-
-/* select machine configuration */
-#if defined(CONFIG_ATARI)
-#  define MACH ATARI
-#elif defined(__i386__) || defined(__x86_64__) || defined(__arm__)  /* and ?? */
-#  define MACH PC
-#else
-#  error Cannot build nvram driver for this machine configuration.
-#endif
-
-#if MACH == PC
-
-/* RTC in a PC */
-#define CHECK_DRIVER_INIT()	1
-
-/* On PCs, the checksum is built only over bytes 2..31 */
-#define PC_CKS_RANGE_START	2
-#define PC_CKS_RANGE_END	31
-#define PC_CKS_LOC		32
-#define NVRAM_BYTES		(128-NVRAM_FIRST_BYTE)
-
-#define mach_check_checksum	pc_check_checksum
-#define mach_set_checksum	pc_set_checksum
-#define mach_proc_infos		pc_proc_infos
-
-#endif
-
-#if MACH == ATARI
-
-/* Special parameters for RTC in Atari machines */
-#include <asm/atarihw.h>
-#include <asm/atariints.h>
-#define RTC_PORT(x)		(TT_RTC_BAS + 2*(x))
-#define CHECK_DRIVER_INIT()	(MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK))
-
-#define NVRAM_BYTES		50
-
-/* On Ataris, the checksum is over all bytes except the checksum bytes
- * themselves; these are at the very end */
-#define ATARI_CKS_RANGE_START	0
-#define ATARI_CKS_RANGE_END	47
-#define ATARI_CKS_LOC		48
-
-#define mach_check_checksum	atari_check_checksum
-#define mach_set_checksum	atari_set_checksum
-#define mach_proc_infos		atari_proc_infos
-
-#endif
-
-/* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
- * rtc_lock held. Due to the index-port/data-port design of the RTC, we
- * don't want two different things trying to get to it at once. (e.g. the
- * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
- */
-
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/miscdevice.h>
@@ -120,12 +55,9 @@ static int nvram_open_mode;	/* special open modes */
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
-static int mach_check_checksum(void);
-static void mach_set_checksum(void);
-
 #ifdef CONFIG_PROC_FS
-static void mach_proc_infos(unsigned char *contents, struct seq_file *seq,
-								void *offset);
+static void pc_nvram_proc_read(unsigned char *contents, struct seq_file *seq,
+			       void *offset);
 #endif
 
 /*
@@ -139,6 +71,14 @@ static void mach_proc_infos(unsigned char *contents, struct seq_file *seq,
  * know about the RTC cruft.
  */
 
+#define NVRAM_BYTES		(128 - NVRAM_FIRST_BYTE)
+
+/* Note that *all* calls to CMOS_READ and CMOS_WRITE must be done with
+ * rtc_lock held. Due to the index-port/data-port design of the RTC, we
+ * don't want two different things trying to get to it at once. (e.g. the
+ * periodic 11 min sync from kernel/time/ntp.c vs. this driver.)
+ */
+
 unsigned char __nvram_read_byte(int i)
 {
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
@@ -174,9 +114,22 @@ void nvram_write_byte(unsigned char c, int i)
 }
 EXPORT_SYMBOL(nvram_write_byte);
 
+/* On PCs, the checksum is built only over bytes 2..31 */
+#define PC_CKS_RANGE_START	2
+#define PC_CKS_RANGE_END	31
+#define PC_CKS_LOC		32
+
 int __nvram_check_checksum(void)
 {
-	return mach_check_checksum();
+	int i;
+	unsigned short sum = 0;
+	unsigned short expect;
+
+	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
+		sum += __nvram_read_byte(i);
+	expect = __nvram_read_byte(PC_CKS_LOC)<<8 |
+	    __nvram_read_byte(PC_CKS_LOC+1);
+	return (sum & 0xffff) == expect;
 }
 EXPORT_SYMBOL(__nvram_check_checksum);
 
@@ -194,7 +147,13 @@ EXPORT_SYMBOL(nvram_check_checksum);
 
 static void __nvram_set_checksum(void)
 {
-	mach_set_checksum();
+	int i;
+	unsigned short sum = 0;
+
+	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
+		sum += __nvram_read_byte(i);
+	__nvram_write_byte(sum >> 8, PC_CKS_LOC);
+	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
 }
 
 #if 0
@@ -384,7 +343,7 @@ static int nvram_proc_read(struct seq_file *seq, void *offset)
 		contents[i] = __nvram_read_byte(i);
 	spin_unlock_irq(&rtc_lock);
 
-	mach_proc_infos(contents, seq, offset);
+	pc_nvram_proc_read(contents, seq, offset);
 
 	return 0;
 }
@@ -418,10 +377,6 @@ static int __init nvram_init(void)
 {
 	int ret;
 
-	/* First test whether the driver should init at all */
-	if (!CHECK_DRIVER_INIT())
-		return -ENODEV;
-
 	ret = misc_register(&nvram_dev);
 	if (ret) {
 		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
@@ -451,36 +406,6 @@ static void __exit nvram_cleanup_module(void)
 module_init(nvram_init);
 module_exit(nvram_cleanup_module);
 
-/*
- * Machine specific functions
- */
-
-#if MACH == PC
-
-static int pc_check_checksum(void)
-{
-	int i;
-	unsigned short sum = 0;
-	unsigned short expect;
-
-	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
-		sum += __nvram_read_byte(i);
-	expect = __nvram_read_byte(PC_CKS_LOC)<<8 |
-	    __nvram_read_byte(PC_CKS_LOC+1);
-	return (sum & 0xffff) == expect;
-}
-
-static void pc_set_checksum(void)
-{
-	int i;
-	unsigned short sum = 0;
-
-	for (i = PC_CKS_RANGE_START; i <= PC_CKS_RANGE_END; ++i)
-		sum += __nvram_read_byte(i);
-	__nvram_write_byte(sum >> 8, PC_CKS_LOC);
-	__nvram_write_byte(sum & 0xff, PC_CKS_LOC + 1);
-}
-
 #ifdef CONFIG_PROC_FS
 
 static const char * const floppy_types[] = {
@@ -495,8 +420,8 @@ static const char * const gfx_types[] = {
 	"monochrome",
 };
 
-static void pc_proc_infos(unsigned char *nvram, struct seq_file *seq,
-								void *offset)
+static void pc_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
+			       void *offset)
 {
 	int checksum;
 	int type;
@@ -557,143 +482,8 @@ static void pc_proc_infos(unsigned char *nvram, struct seq_file *seq,
 
 	return;
 }
-#endif
-
-#endif /* MACH == PC */
-
-#if MACH == ATARI
-
-static int atari_check_checksum(void)
-{
-	int i;
-	unsigned char sum = 0;
-
-	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
-		sum += __nvram_read_byte(i);
-	return (__nvram_read_byte(ATARI_CKS_LOC) == (~sum & 0xff)) &&
-	    (__nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
-}
-
-static void atari_set_checksum(void)
-{
-	int i;
-	unsigned char sum = 0;
-
-	for (i = ATARI_CKS_RANGE_START; i <= ATARI_CKS_RANGE_END; ++i)
-		sum += __nvram_read_byte(i);
-	__nvram_write_byte(~sum, ATARI_CKS_LOC);
-	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
-}
-
-#ifdef CONFIG_PROC_FS
-
-static struct {
-	unsigned char val;
-	const char *name;
-} boot_prefs[] = {
-	{ 0x80, "TOS" },
-	{ 0x40, "ASV" },
-	{ 0x20, "NetBSD (?)" },
-	{ 0x10, "Linux" },
-	{ 0x00, "unspecified" }
-};
-
-static const char * const languages[] = {
-	"English (US)",
-	"German",
-	"French",
-	"English (UK)",
-	"Spanish",
-	"Italian",
-	"6 (undefined)",
-	"Swiss (French)",
-	"Swiss (German)"
-};
-
-static const char * const dateformat[] = {
-	"MM%cDD%cYY",
-	"DD%cMM%cYY",
-	"YY%cMM%cDD",
-	"YY%cDD%cMM",
-	"4 (undefined)",
-	"5 (undefined)",
-	"6 (undefined)",
-	"7 (undefined)"
-};
-
-static const char * const colors[] = {
-	"2", "4", "16", "256", "65536", "??", "??", "??"
-};
-
-static void atari_proc_infos(unsigned char *nvram, struct seq_file *seq,
-								void *offset)
-{
-	int checksum = nvram_check_checksum();
-	int i;
-	unsigned vmode;
-
-	seq_printf(seq, "Checksum status  : %svalid\n", checksum ? "" : "not ");
-
-	seq_printf(seq, "Boot preference  : ");
-	for (i = ARRAY_SIZE(boot_prefs) - 1; i >= 0; --i) {
-		if (nvram[1] == boot_prefs[i].val) {
-			seq_printf(seq, "%s\n", boot_prefs[i].name);
-			break;
-		}
-	}
-	if (i < 0)
-		seq_printf(seq, "0x%02x (undefined)\n", nvram[1]);
-
-	seq_printf(seq, "SCSI arbitration : %s\n",
-	    (nvram[16] & 0x80) ? "on" : "off");
-	seq_printf(seq, "SCSI host ID     : ");
-	if (nvram[16] & 0x80)
-		seq_printf(seq, "%d\n", nvram[16] & 7);
-	else
-		seq_printf(seq, "n/a\n");
-
-	/* the following entries are defined only for the Falcon */
-	if ((atari_mch_cookie >> 16) != ATARI_MCH_FALCON)
-		return;
-
-	seq_printf(seq, "OS language      : ");
-	if (nvram[6] < ARRAY_SIZE(languages))
-		seq_printf(seq, "%s\n", languages[nvram[6]]);
-	else
-		seq_printf(seq, "%u (undefined)\n", nvram[6]);
-	seq_printf(seq, "Keyboard language: ");
-	if (nvram[7] < ARRAY_SIZE(languages))
-		seq_printf(seq, "%s\n", languages[nvram[7]]);
-	else
-		seq_printf(seq, "%u (undefined)\n", nvram[7]);
-	seq_printf(seq, "Date format      : ");
-	seq_printf(seq, dateformat[nvram[8] & 7],
-	    nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
-	seq_printf(seq, ", %dh clock\n", nvram[8] & 16 ? 24 : 12);
-	seq_printf(seq, "Boot delay       : ");
-	if (nvram[10] == 0)
-		seq_printf(seq, "default");
-	else
-		seq_printf(seq, "%ds%s\n", nvram[10],
-		    nvram[10] < 8 ? ", no memory test" : "");
-
-	vmode = (nvram[14] << 8) | nvram[15];
-	seq_printf(seq,
-	    "Video mode       : %s colors, %d columns, %s %s monitor\n",
-	    colors[vmode & 7],
-	    vmode & 8 ? 80 : 40,
-	    vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
-	seq_printf(seq, "                   %soverscan, compat. mode %s%s\n",
-	    vmode & 64 ? "" : "no ",
-	    vmode & 128 ? "on" : "off",
-	    vmode & 256 ?
-	    (vmode & 16 ? ", line doubling" : ", half screen") : "");
-
-	return;
-}
-#endif
 
-#endif /* MACH == ATARI */
+#endif /* CONFIG_PROC_FS */
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
-- 
2.19.2

