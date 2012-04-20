Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 5D282B7030
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 13:29:39 +1000 (EST)
Message-ID: <1334892574.31646.0.camel@pasglop>
Subject: [PATCH 1/3] powerpc/mpic: Fix confusion between hw_irq and virq
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 20 Apr 2012 13:29:34 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mpic_is_ipi() takes a virq and immediately converts it to a hw_irq.

However, one of the two call sites calls it with a ... hw_irq. The
other call site also happens to have the hw_irq at hand, so let's
change it to just take that as an argument. Also change mpic_is_tm()
for consistency.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/sysdev/mpic.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 9ac71eb..665b0f8 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -604,18 +604,14 @@ static struct mpic *mpic_find(unsigned int irq)
 }
 
 /* Determine if the linux irq is an IPI */
-static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int irq)
+static unsigned int mpic_is_ipi(struct mpic *mpic, unsigned int src)
 {
-	unsigned int src = virq_to_hw(irq);
-
 	return (src >= mpic->ipi_vecs[0] && src <= mpic->ipi_vecs[3]);
 }
 
 /* Determine if the linux irq is a timer */
-static unsigned int mpic_is_tm(struct mpic *mpic, unsigned int irq)
+static unsigned int mpic_is_tm(struct mpic *mpic, unsigned int src)
 {
-	unsigned int src = virq_to_hw(irq);
-
 	return (src >= mpic->timer_vecs[0] && src <= mpic->timer_vecs[7]);
 }
 
@@ -1555,12 +1551,12 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
 		return;
 
 	raw_spin_lock_irqsave(&mpic_lock, flags);
-	if (mpic_is_ipi(mpic, irq)) {
+	if (mpic_is_ipi(mpic, src)) {
 		reg = mpic_ipi_read(src - mpic->ipi_vecs[0]) &
 			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_ipi_write(src - mpic->ipi_vecs[0],
 			       reg | (pri << MPIC_VECPRI_PRIORITY_SHIFT));
-	} else if (mpic_is_tm(mpic, irq)) {
+	} else if (mpic_is_tm(mpic, src)) {
 		reg = mpic_tm_read(src - mpic->timer_vecs[0]) &
 			~MPIC_VECPRI_PRIORITY_MASK;
 		mpic_tm_write(src - mpic->timer_vecs[0],
