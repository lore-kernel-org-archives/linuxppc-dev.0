Return-Path: <emmedve1@emmedve1-12.am.freescale.net>
From: Emil Medve <Emilian.Medve@Freescale.com>
To: paulus@samba.org, kumar.gala@Freescale.com, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org, bzolnier@gmail.com, linux-ide@vger.kernel.org
Subject: [PATCH v3] [POWERPC] Fix build errors when BLOCK=n
Date: Wed, 19 Sep 2007 21:25:17 -0500
Message-Id: <1190255117-25999-1-git-send-email-Emilian.Medve@Freescale.com>
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

Moved the EXPORT_SYMBOL(ppc_ide_md) from ppc_ksysms.c next to its declaration
in setup_32.c which made <linux/ide.h> not needed. With <linux/ide.h> gone from
ppc_ksyms.c, <asm/cacheflush.h> is needed to address the following warnings and
errors:

  CC      arch/powerpc/kernel/ppc_ksyms.o
arch/powerpc/kernel/ppc_ksyms.c:122: error: '__flush_icache_range' undeclared here (not in a function)
arch/powerpc/kernel/ppc_ksyms.c:122: warning: type defaults to 'int' in declaration of '__flush_icache_range'
arch/powerpc/kernel/ppc_ksyms.c:123: error: 'flush_dcache_range' undeclared here (not in a function)
arch/powerpc/kernel/ppc_ksyms.c:123: warning: type defaults to 'int' in declaration of 'flush_dcache_range'

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---

I tested that the code builds with this patch in various combinations of
configuration options: all the combinations involving BLOCK, IDE and BLK_DEV_IDE

A patch for the warnings above has been already commited here: http://git.kernel.org/?p=linux/kernel/git/jejb/scsi-misc-2.6.git;a=commitdiff;h=49892223f7d3a2333ef9e6cbdd526676e1fc517a

This patch is against Paul's tree (75cdff9242c4e048cb830d359920719d29b9ee7c)

powerpc> scripts/checkpatch.pl 0001-POWERPC-Fix-build-errors-when-BLOCK-n.patch
Your patch has no obvious style problems and is ready for submission.

 arch/powerpc/kernel/ppc_ksyms.c |    6 +-----
 arch/powerpc/kernel/setup_32.c  |    5 +++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 430c502..c6b1aa3 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -12,12 +12,12 @@
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
-#include <linux/ide.h>
 #include <linux/bitops.h>
 
 #include <asm/page.h>
 #include <asm/semaphore.h>
 #include <asm/processor.h>
+#include <asm/cacheflush.h>
 #include <asm/uaccess.h>
 #include <asm/io.h>
 #include <asm/atomic.h>
@@ -95,10 +95,6 @@ EXPORT_SYMBOL(__strnlen_user);
 EXPORT_SYMBOL(copy_4K_page);
 #endif
 
-#if defined(CONFIG_PPC32) && (defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE))
-EXPORT_SYMBOL(ppc_ide_md);
-#endif
-
 #if defined(CONFIG_PCI) && defined(CONFIG_PPC32)
 EXPORT_SYMBOL(isa_io_base);
 EXPORT_SYMBOL(isa_mem_base);
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index a288a5f..7474502 100644
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
@@ -49,7 +51,10 @@
 
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
+#if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
 struct ide_machdep_calls ppc_ide_md;
+EXPORT_SYMBOL(ppc_ide_md);
+#endif
 
 int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
-- 
1.5.3.GIT
