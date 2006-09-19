Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 0471F67B61
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 16:57:45 +1000 (EST)
Date: Tue, 19 Sep 2006 16:57:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] remove unused asm routines
Message-Id: <20060919165734.5a242017.sfr@canb.auug.org.au>
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

_insw, _outsw, _insl amd _outsl are all unused, so remove them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/misc.S      |   52 ------------------------
 arch/powerpc/kernel/ppc_ksyms.c |    4 --
 arch/ppc/kernel/misc.S          |   84 ---------------------------------------
 arch/ppc/kernel/ppc_ksyms.c     |    4 --
 include/asm-powerpc/io.h        |    4 --
 include/asm-ppc/io.h            |    4 --
 6 files changed, 0 insertions(+), 152 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/kernel/misc.S b/arch/powerpc/kernel/misc.S
index f770805..dd5f8e4 100644
--- a/arch/powerpc/kernel/misc.S
+++ b/arch/powerpc/kernel/misc.S
@@ -86,58 +86,6 @@ _GLOBAL(_outsb)
 	sync
 	blr
 
-_GLOBAL(_insw)
-	sync
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhbrx	r5,0,r3
-	eieio
-	sthu	r5,2(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-	sync
-00:	lhzu	r5,2(r4)
-	sthbrx	r5,0,r3
-	bdnz	00b
-	sync
-	blr
-
-_GLOBAL(_insl)
-	sync
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwbrx	r5,0,r3
-	eieio
-	stwu	r5,4(r4)
-	bdnz	00b
-	twi	0,r5,0
-	isync
-	blr
-
-_GLOBAL(_outsl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-	sync
-00:	lwzu	r5,4(r4)
-	stwbrx	r5,0,r3
-	bdnz	00b
-	sync
-	blr
-
 #ifdef CONFIG_PPC32
 _GLOBAL(__ide_mm_insw)
 #endif
diff --git a/arch/powerpc/kernel/ppc_ksyms.c b/arch/powerpc/kernel/ppc_ksyms.c
index b2edac8..314d611 100644
--- a/arch/powerpc/kernel/ppc_ksyms.c
+++ b/arch/powerpc/kernel/ppc_ksyms.c
@@ -104,10 +104,6 @@ #endif
 
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
-EXPORT_SYMBOL(_insw);
-EXPORT_SYMBOL(_outsw);
-EXPORT_SYMBOL(_insl);
-EXPORT_SYMBOL(_outsl);
 EXPORT_SYMBOL(_insw_ns);
 EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
diff --git a/arch/ppc/kernel/misc.S b/arch/ppc/kernel/misc.S
index 2fa0075..44700bb 100644
--- a/arch/ppc/kernel/misc.S
+++ b/arch/ppc/kernel/misc.S
@@ -768,90 +768,6 @@ _GLOBAL(_outsb)
 	bdnz	00b
 	blr
 
-_GLOBAL(_insw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhbrx	r5,0,r3
-01:	eieio
-02:	sthu	r5,2(r4)
-	ISYNC_8xx
-	.section .fixup,"ax"
-03:	blr
-	.text
-	.section __ex_table, "a"
-		.align 2
-		.long 00b, 03b
-		.long 01b, 03b
-		.long 02b, 03b
-	.text
-	bdnz	00b
-	blr
-
-_GLOBAL(_outsw)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,2
-	blelr-
-00:	lhzu	r5,2(r4)
-01:	eieio
-02:	sthbrx	r5,0,r3
-	ISYNC_8xx
-	.section .fixup,"ax"
-03:	blr
-	.text
-	.section __ex_table, "a"
-		.align 2
-		.long 00b, 03b
-		.long 01b, 03b
-		.long 02b, 03b
-	.text
-	bdnz	00b
-	blr
-
-_GLOBAL(_insl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwbrx	r5,0,r3
-01:	eieio
-02:	stwu	r5,4(r4)
-	ISYNC_8xx
-	.section .fixup,"ax"
-03:	blr
-	.text
-	.section __ex_table, "a"
-		.align 2
-		.long 00b, 03b
-		.long 01b, 03b
-		.long 02b, 03b
-	.text
-	bdnz	00b
-	blr
-
-_GLOBAL(_outsl)
-	cmpwi	0,r5,0
-	mtctr	r5
-	subi	r4,r4,4
-	blelr-
-00:	lwzu	r5,4(r4)
-01:	stwbrx	r5,0,r3
-02:	eieio
-	ISYNC_8xx
-	.section .fixup,"ax"
-03:	blr
-	.text
-	.section __ex_table, "a"
-		.align 2
-		.long 00b, 03b
-		.long 01b, 03b
-		.long 02b, 03b
-	.text
-	bdnz	00b
-	blr
-
 _GLOBAL(__ide_mm_insw)
 _GLOBAL(_insw_ns)
 	cmpwi	0,r5,0
diff --git a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
index d173540..2bd1f73 100644
--- a/arch/ppc/kernel/ppc_ksyms.c
+++ b/arch/ppc/kernel/ppc_ksyms.c
@@ -122,10 +122,6 @@ EXPORT_SYMBOL(__ide_mm_outsl);
 
 EXPORT_SYMBOL(_insb);
 EXPORT_SYMBOL(_outsb);
-EXPORT_SYMBOL(_insw);
-EXPORT_SYMBOL(_outsw);
-EXPORT_SYMBOL(_insl);
-EXPORT_SYMBOL(_outsl);
 EXPORT_SYMBOL(_insw_ns);
 EXPORT_SYMBOL(_outsw_ns);
 EXPORT_SYMBOL(_insl_ns);
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 9aaced5..0ee4843 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -151,10 +151,6 @@ #define readq_relaxed(addr) readq(addr)
 
 extern void _insb(volatile u8 __iomem *port, void *buf, int ns);
 extern void _outsb(volatile u8 __iomem *port, const void *buf, int ns);
-extern void _insw(volatile u16 __iomem *port, void *buf, int ns);
-extern void _outsw(volatile u16 __iomem *port, const void *buf, int ns);
-extern void _insl(volatile u32 __iomem *port, void *buf, int nl);
-extern void _outsl(volatile u32 __iomem *port, const void *buf, int nl);
 extern void _insw_ns(volatile u16 __iomem *port, void *buf, int ns);
 extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns);
 extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index fb0a8fc..9fac420 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -329,10 +329,6 @@ #define outl_p(val, port)	outl((val), (p
 
 extern void _insb(volatile u8 __iomem *port, void *buf, int ns);
 extern void _outsb(volatile u8 __iomem *port, const void *buf, int ns);
-extern void _insw(volatile u16 __iomem *port, void *buf, int ns);
-extern void _outsw(volatile u16 __iomem *port, const void *buf, int ns);
-extern void _insl(volatile u32 __iomem *port, void *buf, int nl);
-extern void _outsl(volatile u32 __iomem *port, const void *buf, int nl);
 extern void _insw_ns(volatile u16 __iomem *port, void *buf, int ns);
 extern void _outsw_ns(volatile u16 __iomem *port, const void *buf, int ns);
 extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
-- 
1.4.2.1
