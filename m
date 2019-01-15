Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C442C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:32:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D52BF20859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:32:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D52BF20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyBH6tgkzDqTn
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:32:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyD5mVJzDqWs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:28 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 08A7129E65; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <c458ac4d4300dcbb8956bd13c7e034911603479e.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 05/22] m68k/atari: Implement arch_nvram_ops struct
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

By implementing an arch_nvram_ops struct, a platform can re-use the
drivers/char/nvram.c module without needing any arch-specific code
in that module. Atari does so here.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Added static inline wrapper functions to nvram.h.
 - Removed excess whitespace.
 - Renamed functions to avoid collisions with nvram.h wrapper functions.
 - Moved nvram_check_checksum() changes to the preceding patch.
---
 arch/m68k/atari/nvram.c | 49 +++++++++++++++++++++++++++++++++++++++++
 include/linux/nvram.h   | 14 ++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index 1d767847ffa6..e75adebe6e7d 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,6 +74,55 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		*p = __nvram_read_byte(i);
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
+{
+	char *p = buf;
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	if (!__nvram_check_checksum()) {
+		spin_unlock_irq(&rtc_lock);
+		return -EIO;
+	}
+	for (i = *ppos; count > 0 && i < NVRAM_BYTES; --count, ++i, ++p)
+		__nvram_write_byte(*p, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+
+	*ppos = i;
+	return p - buf;
+}
+
+static ssize_t atari_nvram_get_size(void)
+{
+	return NVRAM_BYTES;
+}
+
+const struct nvram_ops arch_nvram_ops = {
+	.read           = atari_nvram_read,
+	.write          = atari_nvram_write,
+	.get_size       = atari_nvram_get_size,
+};
+EXPORT_SYMBOL(arch_nvram_ops);
+
 #ifdef CONFIG_PROC_FS
 static struct {
 	unsigned char val;
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index eb5b52a9a747..a1e01dc89759 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -5,8 +5,18 @@
 #include <linux/errno.h>
 #include <uapi/linux/nvram.h>
 
+struct nvram_ops {
+	ssize_t         (*get_size)(void);
+	ssize_t         (*read)(char *, size_t, loff_t *);
+	ssize_t         (*write)(char *, size_t, loff_t *);
+};
+
+extern const struct nvram_ops arch_nvram_ops;
+
 static inline ssize_t nvram_get_size(void)
 {
+	if (arch_nvram_ops.get_size)
+		return arch_nvram_ops.get_size();
 	return -ENODEV;
 }
 
@@ -21,11 +31,15 @@ static inline void nvram_write_byte(unsigned char val, int addr)
 
 static inline ssize_t nvram_read(char *buf, size_t count, loff_t *ppos)
 {
+	if (arch_nvram_ops.read)
+		return arch_nvram_ops.read(buf, count, ppos);
 	return -ENODEV;
 }
 
 static inline ssize_t nvram_write(char *buf, size_t count, loff_t *ppos)
 {
+	if (arch_nvram_ops.write)
+		return arch_nvram_ops.write(buf, count, ppos);
 	return -ENODEV;
 }
 
-- 
2.19.2

