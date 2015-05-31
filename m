Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 894121A0CA2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 May 2015 11:17:01 +1000 (AEST)
Message-Id: <20150531010133.879182445@telegraphics.com.au>
Date: Sun, 31 May 2015 11:01:38 +1000
From: Finn Thain <fthain@telegraphics.com.au>
To: <linux-kernel@vger.kernel.org>, <linux-m68k@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [RFC 06/24] char/nvram: Adopt arch_nvram_ops
References: <20150531010132.289674310@telegraphics.com.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Different platforms and architectures offer different NVRAM sizes and
access methods. E.g. PPC32 has byte-at-a-time read/write functions whereas
PPC64 has byte-range read/write functions. Adopt the nvram_ops struct so
the nvram module can call such functions as are defined by the various 
platforms and architectures.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

---

The #ifdefs here restrict the procfs and checksumming code to those
architectures with PC-style RTC NVRAM. There may be a better place for
that code but it's an open question. See https://lkml.org/lkml/2015/2/3/22

The procfs code here, if irrelevant to ARM platforms, could be moved to
arch/x86 (like the earlier patch does for m68k code) and the nvram ops
could implemented and exported by the rtc-cmos driver instead. This
would eliminate these #ifdefs.

---
 drivers/char/nvram.c  |   30 +++++++++++++++++++++++++++---
 include/linux/nvram.h |    2 ++
 2 files changed, 29 insertions(+), 3 deletions(-)

Index: linux/drivers/char/nvram.c
===================================================================
--- linux.orig/drivers/char/nvram.c	2015-05-31 11:01:05.000000000 +1000
+++ linux/drivers/char/nvram.c	2015-05-31 11:01:06.000000000 +1000
@@ -51,9 +51,12 @@ static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
+static ssize_t nvram_size;
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
+#if defined(CONFIG_X86) || defined(CONFIG_ARM)
+
 /*
  * These functions are provided to be called internally or by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -161,6 +164,20 @@ void nvram_set_checksum(void)
 }
 #endif  /*  0  */
 
+static ssize_t nvram_get_size(void)
+{
+	return NVRAM_BYTES;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read_byte      = nvram_read_byte,
+	.write_byte     = nvram_write_byte,
+	.get_size       = nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
+#endif /* CONFIG_X86 || CONFIG_ARM */
+
 /*
  * The are the file operation function for user access to /dev/nvram
  */
@@ -332,7 +349,7 @@ static int nvram_misc_release(struct ino
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) && (defined(CONFIG_X86) || defined(CONFIG_ARM))
 
 static char *floppy_types[] = {
 	"none", "5.25'' 360k", "5.25'' 1.2M", "3.5'' 720k", "3.5'' 1.44M",
@@ -459,13 +476,20 @@ static int __init nvram_module_init(void
 {
 	int ret;
 
+	if (arch_nvram_ops.get_size == NULL)
+		return -ENODEV;
+
+	nvram_size = arch_nvram_ops.get_size();
+	if (nvram_size < 0)
+		return nvram_size;
+
 	ret = misc_register(&nvram_misc);
 	if (ret) {
 		pr_err("nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
 		return ret;
 	}
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) && (defined(CONFIG_X86) || defined(CONFIG_ARM))
 	if (!proc_create("driver/nvram", 0, NULL, &nvram_proc_fops)) {
 		pr_err("nvram: can't create /proc/driver/nvram\n");
 		misc_deregister(&nvram_misc);
@@ -479,7 +503,7 @@ static int __init nvram_module_init(void
 
 static void __exit nvram_module_exit(void)
 {
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_PROC_FS) && (defined(CONFIG_X86) || defined(CONFIG_ARM))
 	remove_proc_entry("driver/nvram", NULL);
 #endif
 	misc_deregister(&nvram_misc);
Index: linux/include/linux/nvram.h
===================================================================
--- linux.orig/include/linux/nvram.h	2015-05-31 11:01:03.000000000 +1000
+++ linux/include/linux/nvram.h	2015-05-31 11:01:06.000000000 +1000
@@ -14,6 +14,8 @@ extern int nvram_check_checksum(void);
 struct nvram_ops {
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
+	unsigned char   (*read_byte)(int);
+	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
 };
 
