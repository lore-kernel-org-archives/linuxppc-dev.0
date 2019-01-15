Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A77C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8C620859
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 04:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D8C620859
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43dyDD3Kl0zDqJB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 15:34:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=telegraphics.com.au
 (client-ip=98.124.60.144; helo=kvm5.telegraphics.com.au;
 envelope-from=fthain@telegraphics.com.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=telegraphics.com.au
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 43dxyD63HrzDqWv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 15:22:28 +1100 (AEDT)
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 1CDF629E68; Mon, 14 Jan 2019 23:22:24 -0500 (EST)
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Message-Id: <0792e10d71abdf3152b74bddbb9da68c1f17e48c.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v9 06/22] powerpc: Replace nvram_* extern declarations with
 standard header
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
Cc: dri-devel@lists.freedesktop.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove the nvram_read_byte() and nvram_write_byte() declarations in
powerpc/include/asm/nvram.h and use the cross-platform static functions
in linux/nvram.h instead.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Added nvram_read_byte() and nvram_write_byte() functions to avoid a
potential build failure during 'git bisect'.
 - Brought forward some powerpc cleanup to avoid naming collisions with
nvram.h functions.
 - Replaced the ppc_md.nvram_* method wrappers with the ones in nvram.h.
---
 arch/powerpc/include/asm/nvram.h           |  6 ------
 arch/powerpc/kernel/setup_32.c             | 25 +---------------------
 drivers/char/generic_nvram.c               |  1 +
 drivers/video/fbdev/matrox/matroxfb_base.c |  2 +-
 include/linux/nvram.h                      |  3 +++
 5 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 09a518bb7c03..56a388da9c4f 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -98,10 +98,4 @@ extern int nvram_write_os_partition(struct nvram_os_partition *part,
 				    unsigned int err_type,
 				    unsigned int error_log_cnt);
 
-/* Determine NVRAM size */
-extern ssize_t nvram_get_size(void);
-
-/* Normal access to NVRAM */
-extern unsigned char nvram_read_byte(int i);
-extern void nvram_write_byte(unsigned char c, int i);
 #endif /* _ASM_POWERPC_NVRAM_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..f5107796e2d7 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/nvram.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -149,30 +150,6 @@ __setup("l3cr=", ppc_setup_l3cr);
 
 #ifdef CONFIG_GENERIC_NVRAM
 
-/* Generic nvram hooks used by drivers/char/gen_nvram.c */
-unsigned char nvram_read_byte(int addr)
-{
-	if (ppc_md.nvram_read_val)
-		return ppc_md.nvram_read_val(addr);
-	return 0xff;
-}
-EXPORT_SYMBOL(nvram_read_byte);
-
-void nvram_write_byte(unsigned char val, int addr)
-{
-	if (ppc_md.nvram_write_val)
-		ppc_md.nvram_write_val(addr, val);
-}
-EXPORT_SYMBOL(nvram_write_byte);
-
-ssize_t nvram_get_size(void)
-{
-	if (ppc_md.nvram_size)
-		return ppc_md.nvram_size();
-	return -1;
-}
-EXPORT_SYMBOL(nvram_get_size);
-
 void nvram_sync(void)
 {
 	if (ppc_md.nvram_sync)
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index ff5394f47587..0c22b9503e84 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -20,6 +20,7 @@
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/nvram.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
 #include <asm/nvram.h>
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 838869c6490c..0a4e5bad33f4 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -111,12 +111,12 @@
 #include "matroxfb_g450.h"
 #include <linux/matroxfb.h>
 #include <linux/interrupt.h>
+#include <linux/nvram.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
-unsigned char nvram_read_byte(int);
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 #endif
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index a1e01dc89759..79431dab87a1 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -15,8 +15,11 @@ extern const struct nvram_ops arch_nvram_ops;
 
 static inline ssize_t nvram_get_size(void)
 {
+#ifdef CONFIG_PPC
+#else
 	if (arch_nvram_ops.get_size)
 		return arch_nvram_ops.get_size();
+#endif
 	return -ENODEV;
 }
 
-- 
2.19.2

