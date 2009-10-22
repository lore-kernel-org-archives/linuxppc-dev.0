Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Kumar Gala <kumar.gala@freescale.com>, benh@kernel.crashing.org
Subject: [PATCH] powerpc: Fix potential compile error irqs_disabled_flags 
In-reply-to: <58391C58-B57E-47A8-ACE3-0272C3CF223F@freescale.com> 
References: <6797.1256191115@neuling.org>
	<58391C58-B57E-47A8-ACE3-0272C3CF223F@freescale.com>
Date: Thu, 22 Oct 2009 17:15:43 +1100
Message-ID: <8702.1256192143@neuling.org>
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

irqs_disabled_flags is #defined in linux/irqflags.h when
CONFIG_TRACE_IRQFLAGS_SUPPORT is enabled.  64 and 32 bit always have
CONFIG_TRACE_IRQFLAGS_SUPPORT enabled so just remove
irqs_disabled_flags. 

This fixes the case when someone needs to include both linux/irqflags.h
and asm/hw_irq.h.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
> I think you can just remove irqs_disabled_flags as we always have  
> CONFIG_TRACE_IRQFLAGS_SUPPORT (for both 32 and 64).

Ok, thanks kumar.

 arch/powerpc/include/asm/hw_irq.h |    5 -----
 1 file changed, 5 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/include/asm/hw_irq.h
+++ linux-2.6-ozlabs/arch/powerpc/include/asm/hw_irq.h
@@ -64,11 +64,6 @@ extern void iseries_handle_interrupts(vo
 		get_paca()->hard_enabled = 0;	\
 	} while(0)
 
-static inline int irqs_disabled_flags(unsigned long flags)
-{
-	return flags == 0;
-}
-
 #else
 
 #if defined(CONFIG_BOOKE)
