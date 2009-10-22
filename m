Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: benh@kernel.crashing.org
MIME-Version: 1.0
Subject: [PATCH] powerpc: Fix potential compile error irqs_disabled_flags
Date: Thu, 22 Oct 2009 16:58:35 +1100
Message-ID: <6797.1256191115@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kumar.gala@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irqs_disabled_flags is #defined in linux/irqflags.h when
CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled.

This fixes the case when someone needs to include both linux/irqflags.h
and asm/hw_irq.h.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
I'm not sure if this is the right fix.  We could just remove
irqs_disabled_flags but I think that has the possibility of breaking
32bit.

 arch/powerpc/include/asm/hw_irq.h |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/hw_irq.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
@@ -64,10 +64,12 @@ extern void iseries_handle_interrupts(vo
 		get_paca()->hard_enabled = 0;	\
 	} while(0)
 
+#ifndef CONFIG_TRACE_IRQFLAGS_SUPPORT
 static inline int irqs_disabled_flags(unsigned long flags)
 {
 	return flags == 0;
 }
+#endif
 
 #else
 
