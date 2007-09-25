Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 068F2DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Sep 2007 00:32:39 +1000 (EST)
Received: from localhost (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP id 8738A8810
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 19:32:38 +0500 (SAMST)
Date: Tue, 25 Sep 2007 18:34:29 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 2/7] [POWERPC] Fix QEIC->MPIC cascading
Message-ID: <20070925143429.GB5323@localhost.localdomain>
References: <20070925143126.GA30013@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20070925143126.GA30013@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

set_irq_chained_handler overwrites MPIC's handle_irq function
(handle_fasteoi_irq) thus MPIC never gets eoi event from the
cascaded IRQ. This situation hangs MPIC on MPC8568E.

Patch adds flow level "end" handler to the MPIC, and QEIC calls
it when QEIC's interrupt processing finished.

Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
---
 arch/powerpc/sysdev/mpic.c         |    3 +++
 arch/powerpc/sysdev/qe_lib/qe_ic.c |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 8de29f2..bee2d5b 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -846,6 +846,7 @@ static struct irq_chip mpic_irq_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_irq,
 	.eoi		= mpic_end_irq,
+	.end		= mpic_end_irq,
 	.set_type	= mpic_set_irq_type,
 };
 
@@ -854,6 +855,7 @@ static struct irq_chip mpic_ipi_chip = {
 	.mask		= mpic_mask_ipi,
 	.unmask		= mpic_unmask_ipi,
 	.eoi		= mpic_end_ipi,
+	.end		= mpic_end_ipi,
 };
 #endif /* CONFIG_SMP */
 
@@ -864,6 +866,7 @@ static struct irq_chip mpic_irq_ht_chip = {
 	.mask		= mpic_mask_irq,
 	.unmask		= mpic_unmask_ht_irq,
 	.eoi		= mpic_end_ht_irq,
+	.end		= mpic_end_ht_irq,
 	.set_type	= mpic_set_irq_type,
 };
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/arch/powerpc/sysdev/qe_lib/qe_ic.c
index 55e6f39..8e743e0 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_ic.c
@@ -328,6 +328,9 @@ void qe_ic_cascade_low(unsigned int irq, struct irq_desc *desc)
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
+
+	if (desc->chip->end)
+		desc->chip->end(irq);
 }
 
 void qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
@@ -337,6 +340,9 @@ void qe_ic_cascade_high(unsigned int irq, struct irq_desc *desc)
 
 	if (cascade_irq != NO_IRQ)
 		generic_handle_irq(cascade_irq);
+
+	if (desc->chip->end)
+		desc->chip->end(irq);
 }
 
 void __init qe_ic_init(struct device_node *node, unsigned int flags)
-- 
1.5.0.6
