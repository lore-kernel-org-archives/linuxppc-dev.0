Return-Path: <sudeep.holla@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id BA62A1A0048
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Sep 2015 01:48:12 +1000 (AEST)
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <scottwood@freescale.com>,
 Hongtao Jia <hongtao.jia@freescale.com>,
 Marc Zyngier <marc.zyngier@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 04/17] powerpc: mpic: use IRQCHIP_SKIP_SET_WAKE instead of
 redundant mpic_irq_set_wake
Date: Mon, 21 Sep 2015 16:47:00 +0100
Message-Id: <1442850433-5903-5-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
References: <1442850433-5903-1-git-send-email-sudeep.holla@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_irq_set_wake return -ENXIO for non FSL MPIC and sets IRQF_NO_SUSPEND
flag for FSL ones. enable_irq_wake already returns -ENXIO if irq_set_wak
is not implemented. Also there's no need to set the IRQF_NO_SUSPEND flag
as it doesn't guarantee wakeup for that interrupt.

This patch removes the redundant mpic_irq_set_wake and sets the
IRQCHIP_SKIP_SET_WAKE for only FSL MPIC.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Hongtao Jia <hongtao.jia@freescale.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/powerpc/sysdev/mpic.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 537e5db85a06..123e43612f0a 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -924,22 +924,6 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
-static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
-	struct mpic *mpic = mpic_from_irq_data(d);
-
-	if (!(mpic->flags & MPIC_FSL))
-		return -ENXIO;
-
-	if (on)
-		desc->action->flags |= IRQF_NO_SUSPEND;
-	else
-		desc->action->flags &= ~IRQF_NO_SUSPEND;
-
-	return 0;
-}
-
 void mpic_set_vector(unsigned int virq, unsigned int vector)
 {
 	struct mpic *mpic = mpic_from_irq(virq);
@@ -977,7 +961,6 @@ static struct irq_chip mpic_irq_chip = {
 	.irq_unmask	= mpic_unmask_irq,
 	.irq_eoi	= mpic_end_irq,
 	.irq_set_type	= mpic_set_irq_type,
-	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_SMP
@@ -992,7 +975,6 @@ static struct irq_chip mpic_tm_chip = {
 	.irq_mask	= mpic_mask_tm,
 	.irq_unmask	= mpic_unmask_tm,
 	.irq_eoi	= mpic_end_irq,
-	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
@@ -1283,8 +1265,11 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 		flags |= MPIC_NO_RESET;
 	if (of_get_property(node, "single-cpu-affinity", NULL))
 		flags |= MPIC_SINGLE_DEST_CPU;
-	if (of_device_is_compatible(node, "fsl,mpic"))
+	if (of_device_is_compatible(node, "fsl,mpic")) {
 		flags |= MPIC_FSL | MPIC_LARGE_VECTORS;
+		mpic_irq_chip.flags |= IRQCHIP_SKIP_SET_WAKE;
+		mpic_tm_chip.flags |= IRQCHIP_SKIP_SET_WAKE;
+	}
 
 	mpic = kzalloc(sizeof(struct mpic), GFP_KERNEL);
 	if (mpic == NULL)
-- 
1.9.1
