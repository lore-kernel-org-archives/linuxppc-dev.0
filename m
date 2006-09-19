Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6EC4767BFB
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Sep 2006 14:56:55 +1000 (EST)
Date: Tue, 19 Sep 2006 14:56:16 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] remove unused io accessors
Message-Id: <20060919145616.b8cfd1f0.sfr@canb.auug.org.au>
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

The io accessors insw_ns, outsw_ns, insl_ns and outsl_ns are unused
(except for one unnecessary use in drivers/net/3c509.c that is addressed
in a previous patch) and are only defined in powerpc/ppc, so remove them.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/ppc/syslib/m8260_pci_erratum9.c |   16 ----------------
 include/asm-powerpc/io.h             |   13 +------------
 include/asm-ppc/io.h                 |   10 ----------
 include/asm-ppc/mpc8260_pci9.h       |    4 ----
 4 files changed, 1 insertions(+), 42 deletions(-)

The 3c509 driver will not build after this patch without the patch I have
posted previously to netdev.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/ppc/syslib/m8260_pci_erratum9.c b/arch/ppc/syslib/m8260_pci_erratum9.c
index 974581e..5475709 100644
--- a/arch/ppc/syslib/m8260_pci_erratum9.c
+++ b/arch/ppc/syslib/m8260_pci_erratum9.c
@@ -339,20 +339,6 @@ void insl(unsigned port, void *buf, int 
 	idma_pci9_read((u8 *)buf, (u8 *)addr, nl*sizeof(u32), sizeof(u32), 0);
 }
 
-void insw_ns(unsigned port, void *buf, int ns)
-{
-	u8 *addr = (u8 *)(port + _IO_BASE);
-
-	idma_pci9_read((u8 *)buf, (u8 *)addr, ns*sizeof(u16), sizeof(u16), 0);
-}
-
-void insl_ns(unsigned port, void *buf, int nl)
-{
-	u8 *addr = (u8 *)(port + _IO_BASE);
-
-	idma_pci9_read((u8 *)buf, (u8 *)addr, nl*sizeof(u32), sizeof(u32), 0);
-}
-
 void *memcpy_fromio(void *dest, unsigned long src, size_t count)
 {
 	unsigned long pa = iopa((unsigned long) src);
@@ -373,8 +359,6 @@ EXPORT_SYMBOL(inl);
 EXPORT_SYMBOL(insb);
 EXPORT_SYMBOL(insw);
 EXPORT_SYMBOL(insl);
-EXPORT_SYMBOL(insw_ns);
-EXPORT_SYMBOL(insl_ns);
 EXPORT_SYMBOL(memcpy_fromio);
 
 #endif	/* ifdef CONFIG_8260_PCI9 */
diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index 212428d..9aaced5 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -76,8 +76,7 @@ #define outl(data,addr)		writel(data,((v
 #define insb(port, buf, ns)	_insb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define insw(port, buf, ns)	_insw_ns((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define insl(port, buf, nl)	_insl_ns((u8 __iomem *)((port)+pci_io_base), (buf), (nl))
-#define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
+
 #else
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
@@ -138,8 +137,6 @@ #define outl(val, port)		eeh_outl(val, (
 #define insb(port, buf, ns)	eeh_insb((port), (buf), (ns))
 #define insw(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
-#define insw_ns(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
-#define insl_ns(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
 
 #endif
 
@@ -180,14 +177,6 @@ #define outw_p(val, port)       (udelay(
 #define inl_p(port)             inl(port)
 #define outl_p(val, port)       (udelay(1), outl((val), (port)))
 
-/*
- * The *_ns versions below don't do byte-swapping.
- * Neither do the standard versions now, these are just here
- * for older code.
- */
-#define outsw_ns(port, buf, ns)	_outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
-#define outsl_ns(port, buf, nl)	_outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
-
 
 #define IO_SPACE_LIMIT ~(0UL)
 
diff --git a/include/asm-ppc/io.h b/include/asm-ppc/io.h
index 680555b..fb0a8fc 100644
--- a/include/asm-ppc/io.h
+++ b/include/asm-ppc/io.h
@@ -338,16 +338,6 @@ extern void _outsw_ns(volatile u16 __iom
 extern void _insl_ns(volatile u32 __iomem *port, void *buf, int nl);
 extern void _outsl_ns(volatile u32 __iomem *port, const void *buf, int nl);
 
-/*
- * The *_ns versions below don't do byte-swapping.
- * Neither do the standard versions now, these are just here
- * for older code.
- */
-#define insw_ns(port, buf, ns)	_insw_ns((port)+___IO_BASE, (buf), (ns))
-#define outsw_ns(port, buf, ns)	_outsw_ns((port)+___IO_BASE, (buf), (ns))
-#define insl_ns(port, buf, nl)	_insl_ns((port)+___IO_BASE, (buf), (nl))
-#define outsl_ns(port, buf, nl)	_outsl_ns((port)+___IO_BASE, (buf), (nl))
-
 
 #define IO_SPACE_LIMIT ~0
 
diff --git a/include/asm-ppc/mpc8260_pci9.h b/include/asm-ppc/mpc8260_pci9.h
index 26b3f6e..9f71768 100644
--- a/include/asm-ppc/mpc8260_pci9.h
+++ b/include/asm-ppc/mpc8260_pci9.h
@@ -30,8 +30,6 @@ #undef insl
 #undef inb
 #undef inw
 #undef inl
-#undef insw_ns
-#undef insl_ns
 #undef memcpy_fromio
 
 extern int readb(volatile unsigned char *addr);
@@ -43,8 +41,6 @@ extern void insl(unsigned port, void *bu
 extern int inb(unsigned port);
 extern int inw(unsigned port);
 extern unsigned inl(unsigned port);
-extern void insw_ns(unsigned port, void *buf, int ns);
-extern void insl_ns(unsigned port, void *buf, int nl);
 extern void *memcpy_fromio(void *dest, unsigned long src, size_t count);
 
 #endif /* !__CONFIG_8260_PCI9_DEFS */
-- 
1.4.2.1
