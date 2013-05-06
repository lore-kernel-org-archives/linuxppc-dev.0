Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 179B32C00DE
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 May 2013 16:41:45 +1000 (EST)
Message-ID: <1367822494.15842.12.camel@pasglop>
Subject: [PATCH] irqdomain: Allow quiet failure mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 06 May 2013 16:41:34 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Grant Likely <grant.likely@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Some interrupt controllers refuse to map interrupts marked as
"protected" by firwmare. Since we try to map everyting in the
device-tree on some platforms, we end up with a lot of nasty
WARN's in the boot log for what is a normal situation on those
machines.

This defines a specific return code (-EPERM) from the host map()
callback which cause irqdomain to fail silently.

MPIC is updated to return this when hitting a protected source
printing only a single line message for diagnostic purposes.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


Grant, I'm happy to merge that myself provided I have your ack,
it fixes an annoying problem on Cell introduced by previous changes
to irqdomain (not recent but users started to notice).

 arch/powerpc/sysdev/mpic.c |   14 +++++++++++---
 kernel/irq/irqdomain.c     |   20 +++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index d30e6a6..ee21b5e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1001,8 +1001,12 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 
 	if (hw == mpic->spurious_vec)
 		return -EINVAL;
-	if (mpic->protected && test_bit(hw, mpic->protected))
-		return -EINVAL;
+	if (mpic->protected && test_bit(hw, mpic->protected)) {
+		pr_warning("mpic: Mapping of source 0x%x failed, "
+			   "source protected by firmware !\n",\
+			   (unsigned int)hw);
+		return -EPERM;
+	}
 
 #ifdef CONFIG_SMP
 	else if (hw >= mpic->ipi_vecs[0]) {
@@ -1029,8 +1033,12 @@ static int mpic_host_map(struct irq_domain *h, unsigned int virq,
 	if (mpic_map_error_int(mpic, virq, hw))
 		return 0;
 
-	if (hw >= mpic->num_sources)
+	if (hw >= mpic->num_sources) {
+		pr_warning("mpic: Mapping of source 0x%x failed, "
+			   "source out of range !\n",\
+			   (unsigned int)hw);
 		return -EINVAL;
+	}
 
 	mpic_msi_reserve_hwirq(mpic, hw);
 
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 96f3a1d..5a83dde 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -462,9 +462,23 @@ int irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 		if (domain->ops->map) {
 			ret = domain->ops->map(domain, virq, hwirq);
 			if (ret != 0) {
-				pr_err("irq-%i==>hwirq-0x%lx mapping failed: %d\n",
-				       virq, hwirq, ret);
-				WARN_ON(1);
+				/*
+				 * If map() returns -EPERM, this interrupt is protected
+				 * by the firmware or some other service and shall not
+				 * be mapped.
+				 *
+				 * Since on some platforms we blindly try to map everything
+				 * we end up with a log full of backtraces.
+				 *
+				 * So instead, we silently fail on -EPERM, it is the
+				 * responsibility of the PIC driver to display a relevant
+				 * message if needed.
+				 */
+				if (ret != -EPERM) {
+					pr_err("irq-%i==>hwirq-0x%lx mapping failed: %d\n",
+					       virq, hwirq, ret);
+					WARN_ON(1);
+				}
 				irq_data->domain = NULL;
 				irq_data->hwirq = 0;
 				goto err_unmap;
