Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF58C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:36:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D91920859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:36:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D91920859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyG72WfMzDqPK
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:36:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyF2lMxzDqWw
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:28 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 2C83329E69; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <c5050570b7659d8094c5fccbb63c153357079062.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 07/22] char/nvram: Adopt arch_nvram_ops
Date: Tue, 15 Jan 2019 15:18:56 +1100
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

NVRAMs on different platforms and architectures have different attributes
and access methods. E.g. some platforms have byte-at-a-time accessor
functions while others have byte-range accessor functions. Some have
checksum functionality while others do not. By calling ops struct methods
via the common wrapper functions, the nvram module and other drivers can
make use of the available NVRAM functionality in a portable way.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
It might be nice if the NVRAM Kconfig symbol depended only on
HAVE_ARCH_NVRAM_OPS and all the x86 code here were moved to arch/x86.
This driver would then be more "generic". However, that x86 code would
have to be built-in when used by thinkpad_acpi or else a new module
would have to be added to arch/x86 too. Better to avoid that bloat
because most x86 platforms won't benefit.

Changed since v8:
 - Added kernel-doc comment describing the nvram_ops methods.
 - Renamed static nvram_* functions to avoid name collisions.
 - Converted arch_nvram_ops method calls to nvram.h wrapper function calls.
---
 drivers/char/nvram.c  | 30 ++++++++++++++++++++++++------
 include/linux/nvram.h | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 6 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index c98775bfd896..2df391f78986 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -52,9 +52,11 @@ static DEFINE_MUTEX(nvram_mutex);
 static DEFINE_SPINLOCK(nvram_state_lock);
 static int nvram_open_cnt;	/* #times opened */
 static int nvram_open_mode;	/* special open modes */
+static ssize_t nvram_size;
 #define NVRAM_WRITE		1 /* opened for writing (exclusive) */
 #define NVRAM_EXCL		2 /* opened with O_EXCL */
 
+#ifdef CONFIG_X86
 /*
  * These functions are provided to be called internally or by other parts of
  * the kernel. It's up to the caller to ensure correct checksum before reading
@@ -145,6 +147,19 @@ void nvram_set_checksum(void)
 }
 #endif  /*  0  */
 
+static ssize_t pc_nvram_get_size(void)
+{
+	return NVRAM_BYTES;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read_byte      = pc_nvram_read_byte,
+	.write_byte     = pc_nvram_write_byte,
+	.get_size       = pc_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+#endif /* CONFIG_X86 */
+
 /*
  * The are the file operation function for user access to /dev/nvram
  */
@@ -152,7 +167,7 @@ void nvram_set_checksum(void)
 static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 {
 	return generic_file_llseek_size(file, offset, origin, MAX_LFS_FILESIZE,
-					NVRAM_BYTES);
+					nvram_size);
 }
 
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
@@ -303,8 +318,7 @@ static int nvram_misc_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 static const char * const floppy_types[] = {
 	"none", "5.25'' 360k", "5.25'' 1.2M", "3.5'' 720k", "3.5'' 1.44M",
 	"3.5'' 2.88M", "3.5'' 2.88M"
@@ -394,7 +408,7 @@ static int nvram_proc_read(struct seq_file *seq, void *offset)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_X86 && CONFIG_PROC_FS */
 
 static const struct file_operations nvram_misc_fops = {
 	.owner		= THIS_MODULE,
@@ -416,13 +430,17 @@ static int __init nvram_module_init(void)
 {
 	int ret;
 
+	nvram_size = nvram_get_size();
+	if (nvram_size < 0)
+		return nvram_size;
+
 	ret = misc_register(&nvram_misc);
 	if (ret) {
 		pr_err("nvram: can't misc_register on minor=%d\n", NVRAM_MINOR);
 		return ret;
 	}
 
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 	if (!proc_create_single("driver/nvram", 0, NULL, nvram_proc_read)) {
 		pr_err("nvram: can't create /proc/driver/nvram\n");
 		misc_deregister(&nvram_misc);
@@ -436,7 +454,7 @@ static int __init nvram_module_init(void)
 
 static void __exit nvram_module_exit(void)
 {
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 	remove_proc_entry("driver/nvram", NULL);
 #endif
 	misc_deregister(&nvram_misc);
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 79431dab87a1..bb4ea8cc6ea6 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -5,8 +5,30 @@
 #include <linux/errno.h>
 #include <uapi/linux/nvram.h>
 
+/**
+ * struct nvram_ops - NVRAM functionality made available to drivers
+ * @read: validate checksum (if any) then load a range of bytes from NVRAM
+ * @write: store a range of bytes to NVRAM then update checksum (if any)
+ * @read_byte: load a single byte from NVRAM
+ * @write_byte: store a single byte to NVRAM
+ * @get_size: return the fixed number of bytes in the NVRAM
+ *
+ * Architectures which provide an nvram ops struct need not implement all
+ * of these methods. If the NVRAM hardware can be accessed only one byte
+ * at a time then it may be sufficient to provide .read_byte and .write_byte.
+ * If the NVRAM has a checksum (and it is to be checked) the .read and
+ * .write methods can be used to implement that efficiently.
+ *
+ * Portable drivers may use the wrapper functions defined here.
+ * The nvram_read() and nvram_write() functions call the .read and .write
+ * methods when available and fall back on the .read_byte and .write_byte
+ * methods otherwise.
+ */
+
 struct nvram_ops {
 	ssize_t         (*get_size)(void);
+	unsigned char   (*read_byte)(int);
+	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
 };
@@ -25,11 +47,21 @@ static inline ssize_t nvram_get_size(void)
 
 static inline unsigned char nvram_read_byte(int addr)
 {
+#ifdef CONFIG_PPC
+#else
+	if (arch_nvram_ops.read_byte)
+		return arch_nvram_ops.read_byte(addr);
+#endif
 	return 0xFF;
 }
 
 static inline void nvram_write_byte(unsigned char val, int addr)
 {
+#ifdef CONFIG_PPC
+#else
+	if (arch_nvram_ops.write_byte)
+		arch_nvram_ops.write_byte(val, addr);
+#endif
 }
 
 static inline ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
-- 
2.19.2

