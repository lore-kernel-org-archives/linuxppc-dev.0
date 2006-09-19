Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 1283367B6A
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 17:31:55 +1000 (EST)
Date: Tue, 19 Sep 2006 17:31:44 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] clean up ide io accessors
Message-Id: <20060919173144.2f254f7e.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/misc.S      |   12 ------------
 arch/powerpc/kernel/ppc_ksyms.c |    7 -------
 arch/ppc/kernel/misc.S          |    4 ----
 arch/ppc/kernel/ppc_ksyms.c     |    5 -----
 include/asm-powerpc/ide.h       |   12 ++++++------
 include/asm-powerpc/io.h        |    6 ------
 6 files changed, 6 insertions(+), 40 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index dd5f8e4..6feb391 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -86,9 +86,6 @@ _GLOBAL(_outsb)
 	sync
 	blr
 
-#ifdef CONFIG_PPC32
-_GLOBAL(__ide_mm_insw)
-#endif
 _GLOBAL(_insw_ns)
 	sync
 	cmpwi	0,r5,0
@@ -103,9 +100,6 @@ _GLOBAL(_insw_ns)
 	isync
 	blr
 
-#ifdef CONFIG_PPC32
-_GLOBAL(__ide_mm_outsw)
-#endif
 _GLOBAL(_outsw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -118,9 +112,6 @@ _GLOBAL(_outsw_ns)
 	sync
 	blr
 
-#ifdef CONFIG_PPC32
-_GLOBAL(__ide_mm_insl)
-#endif
 _GLOBAL(_insl_ns)
 	sync
 	cmpwi	0,r5,0
@@ -135,9 +126,6 @@ _GLOBAL(_insl_ns)
 	isync
 	blr
 
-#ifdef CONFIG_PPC32
-_GLOBAL(__ide_mm_outsl)
-#endif
 _GLOBAL(_outsl_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index 314d611..75429e5 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -95,13 +95,6 @@ #ifdef CONFIG_PPC64
 EXPORT_SYMBOL(copy_4K_page);
 #endif
 
-#ifndef  __powerpc64__
-EXPORT_SYMBOL(__ide_mm_insl);
-EXPORT_SYMBOL(__ide_mm_outsw);
-EXPORT_SYMBOL(__ide_mm_insw);
-EXPORT_SYMBOL(__ide_mm_outsl);
-#endif
-
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
 EXPORT_SYMBOL(_insw_ns);
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 44700bb..50b4bbd 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -768,7 +768,6 @@ _GLOBAL(_outsb)
 	bdnz	00b
 	blr
 
-_GLOBAL(__ide_mm_insw)
 _GLOBAL(_insw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -790,7 +789,6 @@ _GLOBAL(_insw_ns)
 	bdnz	00b
 	blr
 
-_GLOBAL(__ide_mm_outsw)
 _GLOBAL(_outsw_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -812,7 +810,6 @@ _GLOBAL(_outsw_ns)
 	bdnz	00b
 	blr
 
-_GLOBAL(__ide_mm_insl)
 _GLOBAL(_insl_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
@@ -834,7 +831,6 @@ _GLOBAL(_insl_ns)
 	bdnz	00b
 	blr
 
-_GLOBAL(__ide_mm_outsl)
 _GLOBAL(_outsl_ns)
 	cmpwi	0,r5,0
 	mtctr	r5
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index 2bd1f73..c8b65ca 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -115,11 +115,6 @@ EXPORT_SYMBOL(outw);
 EXPORT_SYMBOL(outl);
 EXPORT_SYMBOL(outsl);*/
 
-EXPORT_SYMBOL(__ide_mm_insl);
-EXPORT_SYMBOL(__ide_mm_outsw);
-EXPORT_SYMBOL(__ide_mm_insw);
-EXPORT_SYMBOL(__ide_mm_outsl);
-
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
 EXPORT_SYMBOL(_insw_ns);
diff --git a/include/asm-powerpc/ide.h b/include/asm-powerpc/ide.h
index b09b42a..c8390f9 100644
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -12,6 +12,7 @@ #ifndef __powerpc64__
 #include <linux/sched.h>
 #include <asm/mpc8xx.h>
 #endif
+#include <asm/io.h>
 
 #ifndef MAX_HWIFS
 #ifdef __powerpc64__
@@ -21,15 +22,14 @@ #define MAX_HWIFS	8
 #endif
 #endif
 
+#define __ide_mm_insw(p, a, c)	_insw_ns((volatile u16 __iomem *)(p), (a), (c))
+#define __ide_mm_insl(p, a, c)	_insl_ns((volatile u32 __iomem *)(p), (a), (c))
+#define __ide_mm_outsw(p, a, c)	_outsw_ns((volatile u16 __iomem *)(p), (a), (c))
+#define __ide_mm_outsl(p, a, c)	_outsl_ns((volatile u32 __iomem *)(p), (a), (c))
+
 #ifndef  __powerpc64__
 #include <linux/hdreg.h>
 #include <linux/ioport.h>
-#include <asm/io.h>
-
-extern void __ide_mm_insw(void __iomem *port, void *addr, u32 count);
-extern void __ide_mm_outsw(void __iomem *port, void *addr, u32 count);
-extern void __ide_mm_insl(void __iomem *port, void *addr, u32 count);
-extern void __ide_mm_outsl(void __iomem *port, void *addr, u32 count);
 
 struct ide_machdep_calls {
         int         (*default_irq)(unsigned long base);
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 0ee4843..51a5987 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -28,12 +28,6 @@ #include <asm/delay.h>
 
 #include <asm-generic/iomap.h>
 
-#define __ide_mm_insw(p, a, c) _insw_ns((volatile u16 __iomem *)(p), (a), (c))
-#define __ide_mm_insl(p, a, c) _insl_ns((volatile u32 __iomem *)(p), (a), (c))
-#define __ide_mm_outsw(p, a, c) _outsw_ns((volatile u16 __iomem *)(p), (a), (c))
-#define __ide_mm_outsl(p, a, c) _outsl_ns((volatile u32 __iomem *)(p), (a), (c))
-
-
 #define SIO_CONFIG_RA	0x398
 #define SIO_CONFIG_RD	0x399
 
-- 
1.4.2.1
