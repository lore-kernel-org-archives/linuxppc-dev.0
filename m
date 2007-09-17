Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 800B0DDE06
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Sep 2007 08:02:51 +1000 (EST)
From: Emil Medve <Emilian.Medve@Freescale.com>
To: paulus@samba.org, kumar.gala@Freescale.com, linuxppc-dev@ozlabs.org,
	bzolnier@gmail.com, linux-ide@vger.kernel.org
Subject: [PATCH] [POWERPC] Fix build errors when BLOCK=n
Date: Mon, 17 Sep 2007 16:58:33 -0500
Message-Id: <11900663131073-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are the symptom error messages:

  CC      arch/powerpc/kernel/setup_32.o
In file included from include/linux/blkdev.h:17,
                 from include/linux/ide.h:13,
                 from arch/powerpc/kernel/setup_32.c:13:
include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
In file included from arch/powerpc/kernel/setup_32.c:13:
include/linux/ide.h:857: error: field 'wrq' has incomplete type

  CC      arch/powerpc/kernel/ppc_ksyms.o
In file included from include/linux/blkdev.h:17,
                 from include/linux/ide.h:13,
                 from arch/powerpc/kernel/ppc_ksyms.c:15:
include/linux/bsg.h:67: warning: 'struct request_queue' declared inside parameter list
include/linux/bsg.h:67: warning: its scope is only this definition or declaration, which is probably not what you want
include/linux/bsg.h:71: warning: 'struct request_queue' declared inside parameter list
In file included from arch/powerpc/kernel/ppc_ksyms.c:15:
include/linux/ide.h:857: error: field 'wrq' has incomplete type

The fix tries to use the smallest scope CONFIG_* symbols that will fix the build
problem. In this case <linux/ide.h> needs to be included only if IDE=y or
IDE=m were selected. Also, ppc_ide_md is needed only if BLK_DEV_IDE=y or
BLK_DEV_IDE=m

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

I tested that the code builds with this patch in various combinations of
configuration options: all the combinations involving BLOCK, IDE and BLK_DEV_IDE

A patch for the warnings above has been already commited here: http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commitdiff;h=49892223f7d3a2333ef9e6cbdd526676e1fc517a

This a patch against Paul's tree (01f1c735f57548e6b862e815cc845e452405643d)

powerpc> scripts/checkpatch.pl 0001-POWERPC-Fix-build-errors-when-BLOCK-n.patch 
Your patch has no obvious style problems and is ready for submission.

 arch/powerpc/kernel/ppc_ksyms.c |    5 ++++-
 arch/powerpc/kernel/setup_32.c  |    4 ++++
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 430c502..ba3a928 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -12,12 +12,15 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
 #include <linux/ide.h>
+#endif
 #include <linux/bitops.h>
 
 #include <asm/page.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
+#include <asm/cacheflush.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
@@ -95,7 +98,7 @@ EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(copy_4K_page);
 #endif
 
-#if defined(CONFIG_PPC32) && (defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE))
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 EXPORT_SYMBOL(ppc_ide_md);
 #endif
 
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a288a5f..3d46a30 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -10,7 +10,9 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/initrd.h>
+#if defined(CONFIG_IDE) || defined(CONFIG_IDE_MODULE)
 #include <linux/ide.h>
+#endif
 #include <linux/tty.h>
 #include <linux/bootmem.h>
 #include <linux/seq_file.h>
@@ -49,7 +51,9 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 struct ide_machdep_calls ppc_ide_md;
+#endif
 
 int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
-- 
1.5.3.GIT
