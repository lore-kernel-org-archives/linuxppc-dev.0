Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0179.hostedemail.com
 [216.40.44.179])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407p3C6QZQzF1j3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 04:55:19 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 7459180081CE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 17:46:08 +0000 (UTC)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 11/16] nios2: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:53 -0400
Message-Id: <20180324174458.26423-12-shea@shealevy.com>
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
 arch/nios2/Kconfig   | 1 +
 arch/nios2/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
index 3d4ec88f1db1..d3b72d5c8967 100644
--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -19,6 +19,7 @@ config NIOS2
 	select SPARSE_IRQ
 	select USB_ARCH_HAS_HCD if USB_SUPPORT
 	select CPU_NO_EFFICIENT_FFS
+	select INITRAMFS_GENERIC_UNLOAD
 
 config GENERIC_CSUM
 	def_bool y
diff --git a/arch/nios2/mm/init.c b/arch/nios2/mm/init.c
index c92fe4234009..3df75ff8c768 100644
--- a/arch/nios2/mm/init.c
+++ b/arch/nios2/mm/init.c
@@ -82,13 +82,6 @@ void __init mmu_init(void)
 	flush_tlb_all();
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 void __ref free_initmem(void)
 {
 	free_initmem_default(-1);
-- 
2.16.2
