Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F1EC43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:39:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A79D20859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:39:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A79D20859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyKY0vJGzDqYJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:39:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyF2rgGzDqX3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:28 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 552DE29E67; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <833b60b5efaac347849e2bd438f383f921f7469a.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 10/22] m68k/atari: Implement arch_nvram_ops methods and
 enable CONFIG_HAVE_ARCH_NVRAM_OPS
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

Atari RTC NVRAM uses a checksum so implement the remaining arch_nvram_ops
methods for the set_checksum and initialize ioctls. Enable
CONFIG_HAVE_ARCH_NVRAM_OPS.

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Moved the HAVE_ARCH_NVRAM_OPS symbol to common code as suggested by
Christoph Hellwig.
 - Renamed functions to avoid name collisions with nvram.h.

Changed since v7:
 - Changed the default for CONFIG_NVRAM, because "select NVRAM" was
removed from ATARI_SCSI in patch 1.
---
 arch/Kconfig              |  3 +++
 arch/m68k/Kconfig.machine |  1 +
 arch/m68k/atari/nvram.c   | 24 ++++++++++++++++++++++++
 drivers/char/Kconfig      |  3 ++-
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 4cfb6de48f79..87393fb8141c 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -701,6 +701,9 @@ config HAVE_ARCH_HASH
 	  file which provides platform-specific implementations of some
 	  functions in <linux/hash.h> or fs/namei.c.
 
+config HAVE_ARCH_NVRAM_OPS
+	bool
+
 config ISA_BUS_API
 	def_bool ISA
 
diff --git a/arch/m68k/Kconfig.machine b/arch/m68k/Kconfig.machine
index 328ba83d735b..ad584e3eb8f7 100644
--- a/arch/m68k/Kconfig.machine
+++ b/arch/m68k/Kconfig.machine
@@ -16,6 +16,7 @@ config ATARI
 	bool "Atari support"
 	depends on MMU
 	select MMU_MOTOROLA if MMU
+	select HAVE_ARCH_NVRAM_OPS
 	help
 	  This option enables support for the 68000-based Atari series of
 	  computers (including the TT, Falcon and Medusa). If you plan to use
diff --git a/arch/m68k/atari/nvram.c b/arch/m68k/atari/nvram.c
index e75adebe6e7d..c347fd206ddf 100644
--- a/arch/m68k/atari/nvram.c
+++ b/arch/m68k/atari/nvram.c
@@ -74,6 +74,26 @@ static void __nvram_set_checksum(void)
 	__nvram_write_byte(sum, ATARI_CKS_LOC + 1);
 }
 
+static long atari_nvram_set_checksum(void)
+{
+	spin_lock_irq(&rtc_lock);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
+static long atari_nvram_initialize(void)
+{
+	loff_t i;
+
+	spin_lock_irq(&rtc_lock);
+	for (i = 0; i < NVRAM_BYTES; ++i)
+		__nvram_write_byte(0, i);
+	__nvram_set_checksum();
+	spin_unlock_irq(&rtc_lock);
+	return 0;
+}
+
 static ssize_t atari_nvram_read(char *buf, size_t count, loff_t *ppos)
 {
 	char *p = buf;
@@ -113,6 +133,8 @@ static ssize_t atari_nvram_write(char *buf, size_t count, loff_t *ppos)
 
 static ssize_t atari_nvram_get_size(void)
 {
+	if (!MACH_IS_ATARI)
+		return -ENODEV;
 	return NVRAM_BYTES;
 }
 
@@ -120,6 +142,8 @@ const struct nvram_ops arch_nvram_ops = {
 	.read           = atari_nvram_read,
 	.write          = atari_nvram_write,
 	.get_size       = atari_nvram_get_size,
+	.set_checksum   = atari_nvram_set_checksum,
+	.initialize     = atari_nvram_initialize,
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
index a8cac68de177..ce9979529cf3 100644
--- a/drivers/char/Kconfig
+++ b/drivers/char/Kconfig
@@ -244,7 +244,8 @@ source "drivers/char/hw_random/Kconfig"
 
 config NVRAM
 	tristate "/dev/nvram support"
-	depends on X86 || GENERIC_NVRAM
+	depends on X86 || GENERIC_NVRAM || HAVE_ARCH_NVRAM_OPS
+	default M68K
 	---help---
 	  If you say Y here and create a character special file /dev/nvram
 	  with major number 10 and minor number 144 using mknod ("man mknod"),
-- 
2.19.2

