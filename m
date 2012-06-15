Return-Path: <paulus@ozlabs.org>
Date: Fri, 15 Jun 2012 14:51:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH v2] Make hard_irq_disable() actually hard-disable interrupts
Message-ID: <20120615045139.GA11041@pale.ozlabs.ibm.com>
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

At present, hard_irq_disable() does nothing on powerpc because of
this code in include/linux/interrupt.h:

#ifndef hard_irq_disable
#define hard_irq_disable()      do { } while(0)
#endif

So we need to make our hard_irq_disable be a macro.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>
--
 arch/powerpc/include/asm/hw_irq.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index c9aac24..32b394f 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -100,6 +100,9 @@ static inline void hard_irq_disable(void)
 	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
 }
 
+/* include/linux/interrupt.h needs hard_irq_disable to be a macro */
+#define hard_irq_disable	hard_irq_disable
+
 /*
  * This is called by asynchronous interrupts to conditionally
  * re-enable hard interrupts when soft-disabled after having
