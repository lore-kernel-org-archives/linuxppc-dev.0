Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0198.hostedemail.com
 [216.40.44.198])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407p3H6h1ZzF1c1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 04:55:23 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave02.hostedemail.com (Postfix) with ESMTP id A7C4C180244F0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 17:46:01 +0000 (UTC)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 08/16] m32r: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:50 -0400
Message-Id: <20180324174458.26423-9-shea@shealevy.com>
In-Reply-To: <20180324174458.26423-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Shea Levy <shea@shealevy.com>
---
 arch/m32r/Kconfig   |  1 +
 arch/m32r/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index dd84ee194579..010a2b999181 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -21,6 +21,7 @@ config M32R
 	select CPU_NO_EFFICIENT_FFS
 	select DMA_DIRECT_OPS
 	select ARCH_NO_COHERENT_DMA_MMAP if !MMU
+	select INITRAMFS_GENERIC_UNLOAD
 
 config SBUS
 	bool
diff --git a/arch/m32r/mm/init.c b/arch/m32r/mm/init.c
index 93abc8c3a46e..e2b5f09209ee 100644
--- a/arch/m32r/mm/init.c
+++ b/arch/m32r/mm/init.c
@@ -139,14 +139,3 @@ void free_initmem(void)
 {
 	free_initmem_default(-1);
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-/*======================================================================*
- * free_initrd_mem() :
- * orig : arch/sh/mm/init.c
- *======================================================================*/
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
