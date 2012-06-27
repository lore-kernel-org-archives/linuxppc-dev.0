Return-Path: <anton@samba.org>
Date: Thu, 28 Jun 2012 09:13:52 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: check_and_cede_processor never cedes
Message-ID: <20120628091352.48d3859d@kryten>
In-Reply-To: <1340837479.3732.90.camel@pasglop>
References: <20120628084509.4caec81d@kryten> <1340837479.3732.90.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> I'd rather add a helper, something like lazy_irq_pending()
> and hide the actual check for the bits in irq_happened, in
> case we change the scheme again.

Good idea. Look ok?

--

Commit f948501b36c6 ("Make hard_irq_disable() actually hard-disable
interrupts") caused check_and_cede_processor to stop working.
->irq_happened will never be zero right after a hard_irq_disable
so the compiler removes the call to cede_processor completely.

The bug was introduced back in the lazy interrupt handling rework
of 3.4 but was hidden until recently because hard_irq_disable did
nothing.

This issue will eventually appear in 3.4 stable since the
hard_irq_disable fix is marked stable, so mark this one for stable
too.

Signed-off-by: Anton Blanchard <anton@samba.org>  
Cc: stable@vger.kernel.org
---

v2: create a helper, suggested by Ben.

Index: linux-build/arch/powerpc/platforms/pseries/processor_idle.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/processor_idle.c	2012-06-28 08:55:09.422198154 +1000
+++ linux-build/arch/powerpc/platforms/pseries/processor_idle.c	2012-06-28 08:57:36.112591023 +1000
@@ -106,7 +106,7 @@ static void check_and_cede_processor(voi
 	 * we first hard disable then check.
 	 */
 	hard_irq_disable();
-	if (get_paca()->irq_happened == 0)
+	if (!lazy_irq_pending())
 		cede_processor();
 }
 
Index: linux-build/arch/powerpc/include/asm/hw_irq.h
===================================================================
--- linux-build.orig/arch/powerpc/include/asm/hw_irq.h	2012-06-21 09:16:26.265354429 +1000
+++ linux-build/arch/powerpc/include/asm/hw_irq.h	2012-06-28 08:59:22.082320381 +1000
@@ -103,6 +103,11 @@ static inline void hard_irq_disable(void
 /* include/linux/interrupt.h needs hard_irq_disable to be a macro */
 #define hard_irq_disable	hard_irq_disable
 
+static inline bool lazy_irq_pending(void)
+{
+	return !!(get_paca()->irq_happened & ~PACA_IRQ_HARD_DIS);
+}
+
 /*
  * This is called by asynchronous interrupts to conditionally
  * re-enable hard interrupts when soft-disabled after having
