Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 6144FDDE20
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 13:22:44 +1100 (EST)
Date: Sun, 4 Nov 2007 13:22:46 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: [PATCH] [POWERPC] iSeries_init_IRQ non-PCI tidy
Message-Id: <20071104132246.c748dcea.sfr@canb.auug.org.au>
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

ppc_md.init_IRQ is not called if it is NULL, so we don't need an empty
routine in the non PCI case.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/iseries/irq.h   |    4 ++++
 arch/powerpc/platforms/iseries/setup.c |    4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/iseries/irq.h b/arch/powerpc/platforms/iseries/irq.h
index 69f1b43..a1c2360 100644
--- a/arch/powerpc/platforms/iseries/irq.h
+++ b/arch/powerpc/platforms/iseries/irq.h
@@ -1,9 +1,13 @@
 #ifndef	_ISERIES_IRQ_H
 #define	_ISERIES_IRQ_H
 
+#ifdef CONFIG_PCI
 extern void iSeries_init_IRQ(void);
 extern int  iSeries_allocate_IRQ(HvBusNumber, HvSubBusNumber, u32);
 extern void iSeries_activate_IRQs(void);
+#else
+#define iSeries_init_IRQ	NULL
+#endif
 extern unsigned int iSeries_get_irq(void);
 
 #endif /* _ISERIES_IRQ_H */
diff --git a/arch/powerpc/platforms/iseries/setup.c b/arch/powerpc/platforms/iseries/setup.c
index 37ae07e..0877a88 100644
--- a/arch/powerpc/platforms/iseries/setup.c
+++ b/arch/powerpc/platforms/iseries/setup.c
@@ -617,10 +617,6 @@ static void iseries_dedicated_idle(void)
 	}
 }
 
-#ifndef CONFIG_PCI
-void __init iSeries_init_IRQ(void) { }
-#endif
-
 static void __iomem *iseries_ioremap(phys_addr_t address, unsigned long size,
 				     unsigned long flags)
 {
-- 
1.5.3.5
