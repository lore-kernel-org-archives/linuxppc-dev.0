Return-Path: <paulus@ozlabs.org>
Date: Thu, 14 Jun 2012 20:31:12 +1000
From: Paul Mackerras <paulus@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: [PATCH] Make hard_irq_disable() actually hard-disable interrupts
Message-ID: <20120614103112.GA15685@bloggs.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

At present, hard_irq_disable() does nothing because of this code in
include/linux/interrupt.h:

#ifndef hard_irq_disable
#define hard_irq_disable()	do { } while(0)
#endif

So we need to make our hard_irq_disable() be a macro.

Signed-off-by: Paul Mackerras <paulus@samba.org>

---
 arch/powerpc/include/asm/hw_irq.h |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c9aac24..d8f873f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -93,12 +93,13 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
-static inline void hard_irq_disable(void)
+static inline void _hard_irq_disable(void)
 {
 	__hard_irq_disable();
 	get_paca()->soft_enabled = 0;
 	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
 }
+#define hard_irq_disable()	_hard_irq_disable()
 
 /*
  * This is called by asynchronous interrupts to conditionally
