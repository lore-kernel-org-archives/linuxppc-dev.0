Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB19C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:27:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E1C214D8
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E1C214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43PhKz0J4DzDqLv
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:27:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgn05RhjzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:56 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id B457529505; Tue, 25 Dec 2018 19:43:55 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Michael Schmitz <schmitzmic@gmail.com>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
Message-Id: <0e72ee3231529ab642f6aea94cb93644689e79b5.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 03/25] m68k/atari: Replace nvram_{read,write}_byte with
 arch_nvram_ops
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
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

By implementing an arch_nvram_ops struct, any platform can re-use the
drivers/char/nvram.c module without needing any arch-specific code
in that module. Atari does so here.

Atari has one user of nvram_check_checksum() whereas the other "CMOS"
platforms don't use that function at all. Replace this
validate-checksum-and-read-byte sequence with the equivalent
rtc_nvram_ops.read() call and remove the now unused functions.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Christian T. Steigies <cts@debian.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
The advantage of the new ops struct over the old global nvram_* functions
is that the misc device module can be shared by different platforms
without requiring every platform to implement every nvram_* function.
E.g. only RTC "CMOS" NVRAMs have a checksum for the entire NVRAM
and only PowerPC platforms have a "sync" ioctl.
---
 arch/m68k/atari/nvram.c   | 89 ++++++++++++++++++++++++---------------
 drivers/scsi/atari_scsi.c |  8 ++--
 include/linux/nvram.h     |  9 ++++
 3 files changed, 70 insertions(+), 36 deletions(-)

diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 3e620ee955ba..bafc9dc32830 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -39,33 +39,12 @@ unsigned char __nvram_read_byte(int i)
 	return CMOS_READ(NVRAM_FIRST_BYTE + i);
 }
 
-unsigned char nvram_read_byte(int i)
-{
-	unsigned long flags;
-	unsigned char c;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	c = __nvram_read_byte(i);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return c;
-}
-EXPORT_SYMBOL(nvram_read_byte);
-
 /* This races nicely with trying to read with checksum checking */
 void __nvram_write_byte(unsigned char c, int i)
 {
 	CMOS_WRITE(c, NVRAM_FIRST_BYTE + i);
 }
 
-void nvram_write_byte(unsigned char c, int i)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	__nvram_write_byte(c, i);
-	spin_unlock_irqrestore(&rtc_lock, flags);
-}
-
 /* On Ataris, the checksum is over all bytes except the checksum bytes
  * themselves; these are at the very end.
  */
@@ -84,18 +63,6 @@ int __nvram_check_checksum(void)
 	       (__nvram_read_byte(ATARI_CKS_LOC + 1) == (sum & 0xff));
 }
 
-int nvram_check_checksum(void)
-{
-	unsigned long flags;
-	int rv;
-
-	spin_lock_irqsave(&rtc_lock, flags);
-	rv = __nvram_check_checksum();
-	spin_unlock_irqrestore(&rtc_lock, flags);
-	return rv;
-}
-EXPORT_SYMBOL(nvram_check_checksum);
-
 static void __nvram_set_checksum(void)
 {
 	int i;
@@ -107,6 +74,62 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		*p = __nvram_read_byte(i);
+
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		__nvram_write_byte(*p, i);
+
+	__nvram_set_checksum();
+
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t nvram_get_size(void)
+{
+	return NVRAM_BYTES;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read           = nvram_read,
+	.write          = nvram_write,
+	.get_size       = nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
 #ifdef CONFIG_PROC_FS
 static struct {
 	unsigned char val;
diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
index 99e5729d910d..f55d13e400da 100644
--- a/drivers/scsi/atari_scsi.c
+++ b/drivers/scsi/atari_scsi.c
@@ -760,13 +760,15 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
 #ifdef CONFIG_NVRAM
 	else
 		/* Test if a host id is set in the NVRam */
-		if (ATARIHW_PRESENT(TT_CLK) && nvram_check_checksum()) {
-			unsigned char b = nvram_read_byte(16);
+		if (ATARIHW_PRESENT(TT_CLK)) {
+			unsigned char b;
+			loff_t offset = 16;
+			ssize_t count = arch_nvram_ops.read(&b, 1, &offset);
 
 			/* Arbitration enabled? (for TOS)
 			 * If yes, use configured host ID
 			 */
-			if (b & 0x80)
+			if ((count == 1) && (b & 0x80))
 				atari_scsi_template.this_id = b & 7;
 		}
 #endif
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 28bfb9ab94ca..4f78147e74d9 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -11,4 +11,13 @@ extern void __nvram_write_byte(unsigned char c, int i);
 extern void nvram_write_byte(unsigned char c, int i);
 extern int __nvram_check_checksum(void);
 extern int nvram_check_checksum(void);
+
+struct nvram_ops {
+	ssize_t         (*read)(char *, size_t, loff_t *);
+	ssize_t         (*write)(char *, size_t, loff_t *);
+	ssize_t         (*get_size)(void);
+};
+
+extern const struct nvram_ops arch_nvram_ops;
+
 #endif  /* _LINUX_NVRAM_H */
-- 
2.19.2

