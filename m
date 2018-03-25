Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0215.hostedemail.com
 [216.40.44.215])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 408WsR0nC2zF1sZ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 09:19:23 +1100 (AEDT)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH v2 06/16] frv: Use INITRAMFS_GENERIC_UNLOAD
Date: Sun, 25 Mar 2018 18:18:43 -0400
Message-Id: <20180325221853.10839-7-shea@shealevy.com>
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
 arch/frv/Kconfig   |  1 +
 arch/frv/mm/init.c | 11 -----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/frv/Kconfig b/arch/frv/Kconfig
index af369b05fed5..5c104b800cb1 100644
--- a/arch/frv/Kconfig
+++ b/arch/frv/Kconfig
@@ -17,6 +17,7 @@ config FRV
 	select OLD_SIGACTION
 	select HAVE_DEBUG_STACKOVERFLOW
 	select ARCH_NO_COHERENT_DMA_MMAP
+	select INITRAMFS_GENERIC_UNLOAD
 
 config CPU_BIG_ENDIAN
 	def_bool y
diff --git a/arch/frv/mm/init.c b/arch/frv/mm/init.c
index cf464100e838..345edc4dc462 100644
--- a/arch/frv/mm/init.c
+++ b/arch/frv/mm/init.c
@@ -131,14 +131,3 @@ void free_initmem(void)
 	free_initmem_default(-1);
 #endif
 } /* end free_initmem() */
-
-/*****************************************************************************/
-/*
- * free the initial ramdisk memory
- */
-#ifdef CONFIG_BLK_DEV_INITRD
-void __init free_initrd_mem(unsigned long start, unsigned long end)
-{
-	free_reserved_area((void *)start, (void *)end, -1, "initrd");
-} /* end free_initrd_mem() */
-#endif
-- 
2.16.2
