Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408Wsv0rJYzF1y6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 09:19:46 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 16/16] um: Use INITRAMFS_GENERIC_UNLOAD
Date: Sun, 25 Mar 2018 18:18:53 -0400
Message-Id: <20180325221853.10839-17-shea@shealevy.com>
In-Reply-To: <20180325221853.10839-1-shea@shealevy.com>
References: <20180324174458.26423-1-shea@shealevy.com>
 <20180325221853.10839-1-shea@shealevy.com>
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
 arch/um/Kconfig.common | 1 +
 arch/um/kernel/mem.c   | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index c68add8df3ae..1cb8a023938b 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -13,6 +13,7 @@ config UML
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
+	select INITRAMFS_GENERIC_UNLOAD
 
 config MMU
 	bool
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 3c0e470ea646..2d26eec92126 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -170,13 +170,6 @@ void free_initmem(void)
 {
 }
 
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-
 /* Allocate and free page tables. */
 
 pgd_t *pgd_alloc(struct mm_struct *mm)
-- 
2.16.2
