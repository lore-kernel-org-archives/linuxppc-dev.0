Return-Path: <anton@samba.org>
Date: Thu, 28 Jun 2012 08:45:09 +1000
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH] powerpc: check_and_cede_processor never cedes
Message-ID: <20120628084509.4caec81d@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


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

Index: linux-build/arch/powerpc/platforms/pseries/processor_idle.c
===================================================================
--- linux-build.orig/arch/powerpc/platforms/pseries/processor_idle.c	2012-06-27 21:20:45.403761715 +1000
+++ linux-build/arch/powerpc/platforms/pseries/processor_idle.c	2012-06-27 21:57:14.796788823 +1000
@@ -106,7 +106,7 @@ static void check_and_cede_processor(voi
 	 * we first hard disable then check.
 	 */
 	hard_irq_disable();
-	if (get_paca()->irq_happened == 0)
+	if (get_paca()->irq_happened == PACA_IRQ_HARD_DIS)
 		cede_processor();
 }
 
