Return-Path: <shea@shealevy.com>
Received: from smtprelay.hostedemail.com (smtprelay0098.hostedemail.com
 [216.40.44.98])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407p3F6hLLzF1j4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Mar 2018 04:55:21 +1100 (AEDT)
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com
 [10.5.19.251])
 by smtpgrave06.hostedemail.com (Postfix) with ESMTP id 95E848005A60
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 17:45:49 +0000 (UTC)
From: Shea Levy <shea@shealevy.com>
To: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
 uclinux-h8-devel@lists.sourceforge.jp, linux-m68k@lists.linux-m68k.org,
 nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net
Cc: Shea Levy <shea@shealevy.com>
Subject: [PATCH 01/16] initrd: Add generic code path for common initrd
 unloading logic.
Date: Sat, 24 Mar 2018 13:44:43 -0400
Message-Id: <20180324174458.26423-2-shea@shealevy.com>
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
 init/initramfs.c | 7 +++++++
 usr/Kconfig      | 4 ++++
 2 files changed, 11 insertions(+)

diff --git a/init/initramfs.c b/init/initramfs.c
index 7e99a0038942..de5ce873eb5a 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -526,6 +526,13 @@ extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+#ifdef CONFIG_INITRAMFS_GENERIC_UNLOAD
+void free_initrd_mem(unsigned long start, unsigned long end)
+{
+       free_reserved_area((void *)start, (void *)end, -1, "initrd");
+}
+#endif
+
 static void __init free_initrd(void)
 {
 #ifdef CONFIG_KEXEC_CORE
diff --git a/usr/Kconfig b/usr/Kconfig
index 43658b8a975e..fd79d4d6fa26 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -233,3 +233,7 @@ config INITRAMFS_COMPRESSION
 	default ".lzma" if RD_LZMA
 	default ".bz2"  if RD_BZIP2
 	default ""
+
+# Arches can select this for a generic initrd unloading codepath
+config INITRAMFS_GENERIC_UNLOAD
+	bool
-- 
2.16.2
