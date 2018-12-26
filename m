Return-Path: <SRS0=ZqAX=PD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AC56C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:11:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3B6E2171F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 05:11:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3B6E2171F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Ph0F6chBzDqNZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 26 Dec 2018 16:11:41 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43Pgmy5qmZzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Dec 2018 16:01:54 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 320E129532; Tue, 25 Dec 2018 19:43:57 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Message-Id: <0949c1b7bd8b9d0034e77601a9af73c712d26d4a.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v8 25/25] powerpc: Remove pmac_xpram_{read,write} functions
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

The arch_nvram_ops methods provide a uniform API to replace the
nvram_{read,write}_byte exports and pmac_xpram_{read,write} functions.

The latter API gets removed in this patch. To make that possible, add
a get_partition() method to the nvram_ops struct and call it from
pmac_time_init().

pmac_xpram_read() becomes unused as pmac_time_init() is converted to the
arch_nvram_ops API. pmac_xpram_write() was already unused.

As a bonus, drivers/char/nvram.c benefits from the API conversion by the
removal of an #ifdef.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/powerpc/include/asm/nvram.h        |  4 ----
 arch/powerpc/kernel/nvram_64.c          |  3 +++
 arch/powerpc/kernel/setup_32.c          |  3 +++
 arch/powerpc/platforms/powermac/nvram.c | 28 +++----------------------
 arch/powerpc/platforms/powermac/time.c  | 17 +++++++++++----
 drivers/char/nvram.c                    |  6 ++----
 include/linux/nvram.h                   |  1 +
 7 files changed, 25 insertions(+), 37 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 629a5cdcc865..a7916b1c3f3a 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -74,10 +74,6 @@ extern loff_t nvram_find_partition(const char *name, int sig, int *out_size);
 /* Return partition offset in nvram */
 extern int	pmac_get_partition(int partition);
 
-/* Direct access to XPRAM on PowerMacs */
-extern u8	pmac_xpram_read(int xpaddr);
-extern void	pmac_xpram_write(int xpaddr, u8 data);
-
 /* Initialize NVRAM OS partition */
 extern int __init nvram_init_os_partition(struct nvram_os_partition *part);
 
diff --git a/arch/powerpc/kernel/nvram_64.c b/arch/powerpc/kernel/nvram_64.c
index 6d0461c02e0f..2190ce75467d 100644
--- a/arch/powerpc/kernel/nvram_64.c
+++ b/arch/powerpc/kernel/nvram_64.c
@@ -1093,6 +1093,9 @@ const struct nvram_ops arch_nvram_ops = {
 	.write          = ppc_nvram_write,
 	.get_size       = ppc_nvram_get_size,
 	.sync           = ppc_nvram_sync,
+#ifdef CONFIG_PPC_PMAC
+	.get_partition  = pmac_get_partition,
+#endif
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 96782abb0c41..a76cfb125eb1 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -184,6 +184,9 @@ const struct nvram_ops arch_nvram_ops = {
 	.write_byte     = ppc_nvram_write_byte,
 	.get_size       = ppc_nvram_get_size,
 	.sync           = ppc_nvram_sync,
+#ifdef CONFIG_PPC_PMAC
+	.get_partition  = pmac_get_partition,
+#endif
 };
 EXPORT_SYMBOL(arch_nvram_ops);
 
diff --git a/arch/powerpc/platforms/powermac/nvram.c b/arch/powerpc/platforms/powermac/nvram.c
index 9360cdc408c1..38c5cdd44d7b 100644
--- a/arch/powerpc/platforms/powermac/nvram.c
+++ b/arch/powerpc/platforms/powermac/nvram.c
@@ -629,29 +629,7 @@ int __init pmac_nvram_init(void)
 
 int pmac_get_partition(int partition)
 {
-	return nvram_partitions[partition];
+	if (machine_is(powermac))
+		return nvram_partitions[partition];
+	return -1;
 }
-
-u8 pmac_xpram_read(int xpaddr)
-{
-	int offset = pmac_get_partition(pmac_nvram_XPRAM);
-
-	if (offset < 0 || xpaddr < 0 || xpaddr > 0x100)
-		return 0xff;
-
-	return ppc_md.nvram_read_val(xpaddr + offset);
-}
-
-void pmac_xpram_write(int xpaddr, u8 data)
-{
-	int offset = pmac_get_partition(pmac_nvram_XPRAM);
-
-	if (offset < 0 || xpaddr < 0 || xpaddr > 0x100)
-		return;
-
-	ppc_md.nvram_write_val(xpaddr + offset, data);
-}
-
-EXPORT_SYMBOL(pmac_get_partition);
-EXPORT_SYMBOL(pmac_xpram_read);
-EXPORT_SYMBOL(pmac_xpram_write);
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index b36ddee17c87..7df08c7d348f 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -24,6 +24,7 @@
 #include <linux/interrupt.h>
 #include <linux/hardirq.h>
 #include <linux/rtc.h>
+#include <linux/nvram.h>
 
 #include <asm/sections.h>
 #include <asm/prom.h>
@@ -70,13 +71,21 @@ long __init pmac_time_init(void)
 	s32 delta = 0;
 #if defined(CONFIG_NVRAM) && defined(CONFIG_PPC32)
 	int dst;
+	int offset = arch_nvram_ops.get_partition(pmac_nvram_XPRAM);
 	
-	delta = ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x9)) << 16;
-	delta |= ((s32)pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xa)) << 8;
-	delta |= pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0xb);
+	if (offset < 0)
+		return 0;
+
+	delta = arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 9);
+	delta <<= 8;
+	delta |= arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 10);
+	delta <<= 8;
+	delta |= arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 11);
+
 	if (delta & 0x00800000UL)
 		delta |= 0xFF000000UL;
-	dst = ((pmac_xpram_read(PMAC_XPRAM_MACHINE_LOC + 0x8) & 0x80) != 0);
+	dst = arch_nvram_ops.read_byte(offset + PMAC_XPRAM_MACHINE_LOC + 8);
+	dst &= 0x80;
 	printk("GMT Delta read from XPRAM: %d minutes, DST: %s\n", delta/60,
 		dst ? "on" : "off");
 #endif
diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 8cbfed86ec8d..e19d9be214cf 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -324,8 +324,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 		/* fall through */
 	case IOC_NVRAM_GET_OFFSET:
 		ret = -EINVAL;
-#ifdef CONFIG_PPC_PMAC
-		if (machine_is(powermac)) {
+		if (arch_nvram_ops.get_partition != NULL) {
 			int part, offset;
 
 			if (copy_from_user(&part, (void __user *)arg,
@@ -333,7 +332,7 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 				return -EFAULT;
 			if (part < pmac_nvram_OF || part > pmac_nvram_NR)
 				return -EINVAL;
-			offset = pmac_get_partition(part);
+			offset = arch_nvram_ops.get_partition(part);
 			if (offset < 0)
 				return -EINVAL;
 			if (copy_to_user((void __user *)arg,
@@ -341,7 +340,6 @@ static long nvram_misc_ioctl(struct file *file, unsigned int cmd,
 				return -EFAULT;
 			ret = 0;
 		}
-#endif
 		break;
 	case IOC_NVRAM_SYNC:
 		if (arch_nvram_ops.sync != NULL) {
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index 251472f1b2bd..4ccb491d9871 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -12,6 +12,7 @@ struct nvram_ops {
 	ssize_t         (*get_size)(void);
 #ifdef CONFIG_PPC
 	long            (*sync)(void);
+	int             (*get_partition)(int);
 #else
 	long            (*set_checksum)(void);
 	long            (*initialize)(void);
-- 
2.19.2

