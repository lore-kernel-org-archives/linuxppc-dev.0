Return-Path: <Laurentiu.Tudor@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0207.outbound.protection.outlook.com [207.46.163.207])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3462C1A0BF9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Aug 2014 21:25:50 +1000 (EST)
Message-ID: <53F33411.2090209@freescale.com>
Date: Tue, 19 Aug 2014 14:25:05 +0300
From: Laurentiu Tudor <b10716@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 3/4] powerpc/fsl_msi: show more meaningful names in
 /proc/interrupts
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Scott Wood <scottwood@freescale.com>,
 Mihai Caraman <mihai.caraman@freescale.com>,
 Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the irq controller associated with a MSI
interrupt to fsl-msi-<V>, where <V> is the virq
of the cascade irq backing up this MSI interrupt.
This way, one can set the affinity of a MSI
through the cascade irq associated with said MSI
interrupt.
Given this example /proc/interrupts snippet:

           CPU0       CPU1       CPU2       CPU3
 16:          0          0          0          0   OpenPIC    16 Edge      mpic-error-int
 17:          0          4          0          0  fsl-msi-224   0 Edge      eth0-rx-0
 18:          0          5          0          0  fsl-msi-225   1 Edge      eth0-tx-0
 19:          0          2          0          0  fsl-msi-226   2 Edge      eth0
 [...]
224:          0         11          0          0   OpenPIC   224 Edge      fsl-msi-cascade
225:          0          0          0          0   OpenPIC   225 Edge      fsl-msi-cascade
226:          0          0          0          0   OpenPIC   226 Edge      fsl-msi-cascade
 [...]

To change the affinity of MSI interrupt 17
(having the irq controller named "fsl-msi-224")
instead of writing /proc/irq/17/smp_affinity, use
the associated MSI cascade irq, in this case,
interrupt 224, e.g.:

   echo 6 > /proc/irq/224/smp_affinity

Note that a MSI cascade irq covers several MSI
interrupts, so changing the affinity on the
cascade will impact all of the associated MSI
interrupts.

Signed-off-by: Laurentiu Tudor <Laurentiu.Tudor@freescale.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Mihai Caraman <mihai.caraman@freescale.com>
---
 arch/powerpc/sysdev/fsl_msi.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 0cfc32a..e2ee226 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 #include <linux/of_platform.h>
 #include <linux/interrupt.h>
+#include <linux/seq_file.h>
 #include <sysdev/fsl_soc.h>
 #include <asm/prom.h>
 #include <asm/hw_irq.h>
@@ -67,11 +68,24 @@ static void fsl_msi_end_irq(struct irq_data *d)
 {
 }
 
+static void fsl_msi_print_chip(struct irq_data *irqd, struct seq_file *p)
+{
+	struct fsl_msi *msi_data = irqd->domain->host_data;
+	irq_hw_number_t hwirq = irqd_to_hwirq(irqd);
+	int cascade_virq, srs;
+
+	srs = (hwirq >> msi_data->srs_shift) & MSI_SRS_MASK;
+	cascade_virq = msi_data->cascade_array[srs]->virq;
+
+	seq_printf(p, " fsl-msi-%d", cascade_virq);
+}
+
+
 static struct irq_chip fsl_msi_chip = {
 	.irq_mask	= mask_msi_irq,
 	.irq_unmask	= unmask_msi_irq,
 	.irq_ack	= fsl_msi_end_irq,
-	.name		= "FSL-MSI",
+	.irq_print_chip = fsl_msi_print_chip,
 };
 
 static int fsl_msi_host_map(struct irq_domain *h, unsigned int virq,
-- 
1.9.2
