Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id E4C22DDE1A
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jun 2008 10:50:18 +1000 (EST)
Date: Mon, 16 Jun 2008 10:50:13 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] powerpc: ppc32 does not need console_drivers exported
Message-Id: <20080616105013.809ebc34.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

There are no in-tree uses of the export any more and in linux-next there
is a change that exports it globally which causes warnings:

WARNING: vmlinux: 'console_drivers' exported twice. Previous export was in vmlinux

and in one case (mpc85xx_defconfig) a build error:

kernel/built-in.o: In function `__crc_console_drivers':
(*ABS*+0x1eb0e6f5): multiple definition of `__crc_console_drivers'

So remove the export now.  Also, there is no longer any need to include
linux/console.h.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/ppc_ksyms.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

Test builds of ppc64_defconfig, allmodconfig, mpc85xx_defconfig for the
current kernel and ppc64_defconfig, mpc85xx_defconfig and
ppc44x_defconfig for linux-next.

Paul, it would be nice if this went into 2.6.26, but early 2.6.27 is OK
(we will just have another bad bisection interval for mpc85xx_defconfig
if the tip-core tree goes in first).

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index cf6b5a7..d3ac631 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -8,7 +8,6 @@
 #include <linux/screen_info.h>
 #include <linux/vt_kern.h>
 #include <linux/nvram.h>
-#include <linux/console.h>
 #include <linux/irq.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
@@ -160,7 +159,6 @@ EXPORT_SYMBOL(screen_info);
 EXPORT_SYMBOL(timer_interrupt);
 EXPORT_SYMBOL(irq_desc);
 EXPORT_SYMBOL(tb_ticks_per_jiffy);
-EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
 #endif
 
-- 
1.5.5.4

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
