Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id F407967B8F
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Aug 2006 17:11:45 +1000 (EST)
Date: Wed, 30 Aug 2006 17:11:34 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [POWERPC] iseries: define some more i/o accessor functions
Message-Id: <20060830171134.2fbc2383.sfr@canb.auug.org.au>
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

These are merely build fixes that enable (for example) libata and the
ide code to actually build on iSeries.  The associated hardware will
never be supported on legacy iSeries, so the code paths don't actually
need to work, but it is useful (especially for a combined kernel) if
the code can build.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 include/asm-powerpc/io.h |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

Paul, please consider this for 2.6.18 as it does fix the build if you
happen to enable IDE or SATA on iSeries, currently.
-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/include/asm-powerpc/io.h b/include/asm-powerpc/io.h
index a9496f3..36c4c34 100644
--- a/include/asm-powerpc/io.h
+++ b/include/asm-powerpc/io.h
@@ -72,6 +72,9 @@ #define outl(data,addr)		writel(data,((v
  * Neither do the standard versions now, these are just here
  * for older code.
  */
+#define insb(port, buf, ns)	_insb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define insw(port, buf, ns)	_insw_ns((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
+#define insl(port, buf, nl)	_insl_ns((u8 __iomem *)((port)+pci_io_base), (buf), (nl))
 #define insw_ns(port, buf, ns)	_insw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define insl_ns(port, buf, nl)	_insl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 #else
@@ -137,12 +140,12 @@ #define insl(port, buf, nl)	eeh_insl_ns(
 #define insw_ns(port, buf, ns)	eeh_insw_ns((port), (buf), (ns))
 #define insl_ns(port, buf, nl)	eeh_insl_ns((port), (buf), (nl))
 
+#endif
+
 #define outsb(port, buf, ns)  _outsb((u8 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsw(port, buf, ns)  _outsw_ns((u16 __iomem *)((port)+pci_io_base), (buf), (ns))
 #define outsl(port, buf, nl)  _outsl_ns((u32 __iomem *)((port)+pci_io_base), (buf), (nl))
 
-#endif
-
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
-- 
1.4.1.1
