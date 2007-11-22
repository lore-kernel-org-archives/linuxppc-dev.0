Return-Path: <jochen@scram.de>
Received: from mail0.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail0.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 03AB8DDECD
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 04:07:22 +1100 (EST)
Message-ID: <4745B422.5080103@scram.de>
Date: Thu, 22 Nov 2007 17:53:54 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH resend 2/4] powerpc: kill non-existent symbols from ksyms
	and commproc.h
Content-Type: text/plain; charset=ISO-8859-15
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Remove exports of __res and cpm_install_handler/cpm_free_handler.  Remove
cpm_install_handler/cpm_free_handler from the commproc.h as well.  Both
were used for ARCH=ppc and aren't defined for ARCH=powerpc.

CC      arch/powerpc/kernel/ppc_ksyms.o
arch/powerpc/kernel/ppc_ksyms.c:180: error: '__res' undeclared here (not in a function)
arch/powerpc/kernel/ppc_ksyms.c:180: warning: type defaults to 'int' in declaration of '__res'
make[1]: *** [arch/powerpc/kernel/ppc_ksyms.o] Error 1
make: *** [arch/powerpc/kernel] Error 2

LD      .tmp_vmlinux1
arch/powerpc/kernel/built-in.o:(__ksymtab+0x198): undefined reference to `cpm_free_handler'
arch/powerpc/kernel/built-in.o:(__ksymtab+0x1a0): undefined reference to `cpm_install_handler'
make: *** [.tmp_vmlinux1] Error 1

Signed-off-by: Jochen Friedrich <jochen@scram.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 arch/powerpc/kernel/ppc_ksyms.c |   12 ------------
 include/asm-powerpc/commproc.h  |    3 ---
 2 files changed, 0 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index c6b1aa3..13ebeb2 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -45,10 +45,6 @@
 #include <asm/signal.h>
 #include <asm/dcr.h>

-#ifdef  CONFIG_8xx
-#include <asm/commproc.h>
-#endif
-
 #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(local_irq_restore);
 #endif
@@ -172,14 +168,6 @@ EXPORT_SYMBOL(console_drivers);
 EXPORT_SYMBOL(cacheable_memcpy);
 #endif

-#ifdef  CONFIG_8xx
-EXPORT_SYMBOL(cpm_install_handler);
-EXPORT_SYMBOL(cpm_free_handler);
-#endif /* CONFIG_8xx */
-#if defined(CONFIG_8xx)
-EXPORT_SYMBOL(__res);
-#endif
-
 #ifdef CONFIG_PPC32
 EXPORT_SYMBOL(next_mmu_context);
 EXPORT_SYMBOL(set_context);
diff --git a/include/asm-powerpc/commproc.h b/include/asm-powerpc/commproc.h
index a2328b8..2ee59d7 100644
--- a/include/asm-powerpc/commproc.h
+++ b/include/asm-powerpc/commproc.h
@@ -698,9 +698,6 @@ typedef struct risc_timer_pram {
 #define CICR_IEN		((uint)0x00000080)	/* Int. enable */
 #define CICR_SPS		((uint)0x00000001)	/* SCC Spread */

-extern void cpm_install_handler(int vec, void (*handler)(void *), void *dev_id);
-extern void cpm_free_handler(int vec);
-
 #define IMAP_ADDR		(get_immrbase())

 #define CPM_PIN_INPUT     0
-- 
1.5.3.4
