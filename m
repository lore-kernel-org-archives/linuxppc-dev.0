Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id BEC951A0CB2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:02 +1000 (AEST)
Message-Id: <20150531010133.039488166@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:35 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 03/24] m68k/atari: Move Atari-specific code out of
 drivers/char/nvram.c
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the m68k-specific code elsewhere to make the driver generic.

Change the vmode calculation from logical OR to bitwise OR, since it is
obviously wrong.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

BTW, I didn't change the SCSI ID location in NVRAM. This code says 16
whereas atari_scsi says 14. Which one is correct?

---
 arch/m68k/atari/Makefile |    2 
 arch/m68k/atari/nvram.c  |  255 ++++++++++++++++++++++++++++++++++++++++++
 drivers/char/nvram.c     |  280 +++++------------------------------------------
 3 files changed, 292 insertions(+), 245 deletions(-)

Index: linux/arch/m68k/atari/nvram.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux/arch/m68k/atari/nvram.c	2015-05-31 11:01:01.000000000 +1000
@@ -0,0 +1,255 @@
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
+	char *name;
+} boot_prefs[] = {
+	{ 0x80, "TOS" },
+	{ 0x40, "ASV" },
+	{ 0x20, "NetBSD (?)" },
+	{ 0x10, "Linux" },
+	{ 0x00, "unspecified" },
+};
+
+static char *languages[] = {
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
+static char *dateformat[] = {
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
+static char *colors[] = {
+	"2", "4", "16", "256", "65536", "??", "??", "??"
+};
+
+static void atari_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
+                                  void *offset)
+{
+	int checksum;
+	int i;
+	unsigned vmode;
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
+	           (nvram[16] & 0x80) ? "on" : "off");
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
+	           nvram[9] ? nvram[9] : '/', nvram[9] ? nvram[9] : '/');
+	seq_printf(seq, ", %dh clock\n", nvram[8] & 16 ? 24 : 12);
+	seq_puts(seq, "Boot delay       : ");
+	if (nvram[10] == 0)
+		seq_puts(seq, "default");
+	else
+		seq_printf(seq, "%ds%s\n", nvram[10],
+		           nvram[10] < 8 ? ", no memory test" : "");
+
+	vmode = (nvram[14] << 8) | nvram[15];
+	seq_printf(seq,
+	           "Video mode       : %s colors, %d columns, %s %s monitor\n",
+	           colors[vmode & 7], vmode & 8 ? 80 : 40,
+	           vmode & 16 ? "VGA" : "TV", vmode & 32 ? "PAL" : "NTSC");
+	seq_printf(seq,
+	           "                   %soverscan, compat. mode %s%s\n",
+	           vmode & 64 ? "" : "no ", vmode & 128 ? "on" : "off",
+	           vmode & 256 ?
+	           (vmode & 16 ? ", line doubling" : ", half screen") : "");
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
+static int nvram_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, nvram_proc_read, NULL);
+}
+
+static const struct file_operations nvram_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nvram_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
+static int __init atari_nvram_init(void)
+{
+	if (!(MACH_IS_ATARI && ATARIHW_PRESENT(TT_CLK)))
+		return -ENODEV;
+
+	if (!proc_create("driver/nvram", 0, NULL, &nvram_proc_fops)) {
+		pr_err("nvram: can't create /proc/driver/nvram\n");
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+device_initcall(atari_nvram_init);
+#endif /* CONFIG_PROC_FS */
Index: linux/arch/m68k/atari/Makefile
===================================================================
--- linux.orig/arch/m68k/atari/Makefile	2015-05-31 11:00:59.000000000 +1000
+++ linux/arch/m68k/atari/Makefile	2015-05-31 11:01:01.000000000 +1000
@@ -6,3 +6,5 @@ obj-y		:= config.o time.o debug.o ataint
 			atasound.o stram.o
 
 obj-$(CONFIG_ATARI_KBD_CORE)	+= atakeyb.o
+
+obj-$(CONFIG_NVRAM:m=y)		+= nvram.o
Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:00:59.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:01.000000000 +1000
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
@@ -119,12 +54,9 @@ static int nvram_open_mode;	/* special o
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
-static int mach_check_checksum(void);
-static void mach_set_checksum(void);
-
 #ifdef CONFIG_PROC_FS
-static void mach_proc_infos(unsigned char *contents, struct seq_file *seq,
-								void *offset);
+static void pc_nvram_proc_read(unsigned char *contents, struct seq_file *seq,
+                               void *offset);
 #endif
 
 /*
@@ -138,6 +70,14 @@ static void mach_proc_infos(unsigned cha
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
@@ -173,9 +113,22 @@ void nvram_write_byte(unsigned char c, i
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
 
@@ -193,7 +146,13 @@ EXPORT_SYMBOL(nvram_check_checksum);
 
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
@@ -396,7 +355,7 @@ static int nvram_proc_read(struct seq_fi
 		contents[i] = __nvram_read_byte(i);
 	spin_unlock_irq(&rtc_lock);
 
-	mach_proc_infos(contents, seq, offset);
+	pc_nvram_proc_read(contents, seq, offset);
 
 	return 0;
 }
@@ -443,10 +402,6 @@ static int __init nvram_init(void)
 {
 	int ret;
 
-	/* First test whether the driver should init at all */
-	if (!CHECK_DRIVER_INIT())
-		return -ENODEV;
-
 	ret = misc_register(&nvram_dev);
 	if (ret) {
 		printk(KERN_ERR "nvram: can't misc_register on minor=%d\n",
@@ -476,36 +431,6 @@ static void __exit nvram_cleanup_module(
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
 
 static char *floppy_types[] = {
@@ -520,8 +445,8 @@ static char *gfx_types[] = {
 	"monochrome",
 };
 
-static void pc_proc_infos(unsigned char *nvram, struct seq_file *seq,
-								void *offset)
+static void pc_nvram_proc_read(unsigned char *nvram, struct seq_file *seq,
+                               void *offset)
 {
 	int checksum;
 	int type;
@@ -582,143 +507,8 @@ static void pc_proc_infos(unsigned char
 
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
-	char *name;
-} boot_prefs[] = {
-	{ 0x80, "TOS" },
-	{ 0x40, "ASV" },
-	{ 0x20, "NetBSD (?)" },
-	{ 0x10, "Linux" },
-	{ 0x00, "unspecified" }
-};
-
-static char *languages[] = {
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
-static char *dateformat[] = {
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
-static char *colors[] = {
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
-	vmode = (nvram[14] << 8) || nvram[15];
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
-
-#endif /* MACH == ATARI */
+#endif /* CONFIG_PROC_FS */
 
 MODULE_LICENSE("GPL");
 MODULE_ALIAS_MISCDEV(NVRAM_MINOR);
