Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t6tdk6t0kzDvJb
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 23:16:58 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <Zubair.Kakakhel@imgtec.com>
Subject: [Patch V6 4/6] irqchip: xilinx: Add support for parent intc
Date: Mon, 31 Oct 2016 12:16:45 +0000
Message-ID: <1477916207-25157-5-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1477916207-25157-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1477916207-25157-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The MIPS based xilfpga platform has the following IRQ structure

Peripherals --> xilinx_intcontroller -> mips_cpu_int controller

Add support for the driver to chain the irq handler

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V5 -> V6
Use chained_irq_enter and chained_irq_exit
Add error check for irq_of_parse_and_map
Rebase to v4.9-rc3

V4 -> V5
Rebased to v4.9-rc1
Missing curly braces

V3 -> V4
Clean up if/else when a parent is found
Pass irqchip structure to handler as data

V2 -> V3
Reused existing parent node instead of finding again.
Cleanup up handler based on review

V1 -> V2

No change
---
 drivers/irqchip/irq-xilinx-intc.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 1f37089..ea15446 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -12,9 +12,11 @@
 #include <linux/irqdomain.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/io.h>
 #include <linux/bug.h>
+#include <linux/of_irq.h>
 
 /* No one else should require these constants, so define them locally here. */
 #define ISR 0x00			/* Interrupt Status Register */
@@ -154,11 +156,26 @@ static int xintc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
 	.map = xintc_map,
 };
 
+static void xil_intc_irq_handler(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 pending;
+
+	chained_irq_enter(chip, desc);
+	do {
+		pending = xintc_get_irq();
+		if (pending == -1U)
+			break;
+		generic_handle_irq(pending);
+	} while (true);
+	chained_irq_exit(chip, desc);
+}
+
 static int __init xilinx_intc_of_init(struct device_node *intc,
 					     struct device_node *parent)
 {
 	u32 nr_irq;
-	int ret;
+	int ret, irq;
 	struct xintc_irq_chip *irqc;
 
 	if (xintc_irqc) {
@@ -220,7 +237,22 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		goto err_alloc;
 	}
 
-	irq_set_default_host(root_domain);
+	if (parent) {
+		irq = irq_of_parse_and_map(intc, 0);
+		if (irq) {
+			irq_set_chained_handler_and_data(irq,
+							 xil_intc_irq_handler,
+							 irqc);
+		} else {
+			pr_err("irq-xilinx: interrupts property not in DT\n");
+			ret = -EINVAL;
+			goto err_alloc;
+		}
+
+
+	} else {
+		irq_set_default_host(root_domain);
+	}
 
 	return 0;
 
-- 
1.9.1
