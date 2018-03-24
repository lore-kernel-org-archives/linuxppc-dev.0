Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0176.hostedemail.com
 [216.40.44.176])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407p2n1NHxzF1c1
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 04:54:57 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave08.hostedemail.com (Postfix) with ESMTP id 1D6C31800CA76
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 17:46:04 +0000 (UTC)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 09/16] m68k: Use INITRAMFS_GENERIC_UNLOAD
Date: Sat, 24 Mar 2018 13:44:51 -0400
Message-Id: <20180324174458.26423-10-shea@shealevy.com>
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
 arch/m68k/Kconfig   | 1 +
 arch/m68k/mm/init.c | 7 -------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 785612b576f7..47913a68529e 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -24,6 +24,7 @@ config M68K
 	select MODULES_USE_ELF_RELA
 	select OLD_SIGSUSPEND3
 	select OLD_SIGACTION
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index e85acd131fa8..e20bef09258c 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -172,10 +172,3 @@ void __init mem_init(void)
 	mem_init_print_info(NULL);
 	print_memmap();
 }
-
-#ifdef CONFIG_BLK_DEV_INITRD
-void free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-}
-#endif
-- 
2.16.2
