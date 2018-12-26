Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0677BC43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:07:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8028721720
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 04:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8028721720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PfZf3Nl5zDqJP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 15:07:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43PfDF5BPczDqJg
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 14:51:57 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id CF53A29515; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Message-Id: <66ed571883695314ace53080df8f6dfb132a8b4d.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 05/25] char/nvram: Adopt arch_nvram_ops
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

Different platforms and architectures offer different NVRAM sizes and
access methods. E.g. PPC32 has byte-at-a-time accessor functions whereas
PPC64 has byte-range accessor functions. Adopt the nvram_ops struct so
the nvram module can call such functions as are defined by the various
platforms and architectures.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
The procfs code here could be moved to arch/x86 (like the earlier patch
did for m68k code that was here). The nvram_ops struct could be
implemented and exported by the rtc-cmos driver instead, to eliminate
the remaining #ifdefs.
---
 drivers/char/nvram.c  | 33 +++++++++++++++++++++++++++------
 include/linux/nvram.h |  2 ++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index c660cff9faf4..00897daa0643 100644
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
@@ -162,6 +164,19 @@ void nvram_set_checksum(void)
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
+#endif /* CONFIG_X86 */
+
 /*
  * The are the file operation function for user access to /dev/nvram
  */
@@ -169,7 +184,7 @@ void nvram_set_checksum(void)
 static loff_t nvram_misc_llseek(struct file *file, loff_t offset, int origin)
 {
 	return generic_file_llseek_size(file, offset, origin, MAX_LFS_FILESIZE,
-					NVRAM_BYTES);
+					nvram_size);
 }
 
 static ssize_t nvram_misc_read(struct file *file, char __user *buf,
@@ -320,8 +335,7 @@ static int nvram_misc_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
-#ifdef CONFIG_PROC_FS
-
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 static const char * const floppy_types[] = {
 	"none", "5.25'' 360k", "5.25'' 1.2M", "3.5'' 720k", "3.5'' 1.44M",
 	"3.5'' 2.88M", "3.5'' 2.88M"
@@ -411,7 +425,7 @@ static int nvram_proc_read(struct seq_file *seq, void *offset)
 
 	return 0;
 }
-#endif /* CONFIG_PROC_FS */
+#endif /* CONFIG_X86 && CONFIG_PROC_FS */
 
 static const struct file_operations nvram_misc_fops = {
 	.owner		= THIS_MODULE,
@@ -433,13 +447,20 @@ static int __init nvram_module_init(void)
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
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 	if (!proc_create_single("driver/nvram", 0, NULL, nvram_proc_read)) {
 		pr_err("nvram: can't create /proc/driver/nvram\n");
 		misc_deregister(&nvram_misc);
@@ -453,7 +474,7 @@ static int __init nvram_module_init(void)
 
 static void __exit nvram_module_exit(void)
 {
-#ifdef CONFIG_PROC_FS
+#if defined(CONFIG_X86) && defined(CONFIG_PROC_FS)
 	remove_proc_entry("driver/nvram", NULL);
 #endif
 	misc_deregister(&nvram_misc);
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 4f78147e74d9..d1bdee50d6a8 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -15,6 +15,8 @@ extern int nvram_check_checksum(void);
 struct nvram_ops {
 	ssize_t         (*read)(char *, size_t, loff_t *);
 	ssize_t         (*write)(char *, size_t, loff_t *);
+	unsigned char   (*read_byte)(int);
+	void            (*write_byte)(unsigned char, int);
 	ssize_t         (*get_size)(void);
 };
 
-- 
2.19.2

