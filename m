Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp02.imgtec.com [217.156.133.132])
 by lists.ozlabs.org (Postfix) with ESMTP id 3syPmR5LP6zDvJY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 04:08:23 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
 <jason@lakedaemon.net>, <marc.zyngier@arm.com>, <alistair@popple.id.au>,
 <mporter@kernel.crashing.org>
CC: <soren.brinkmann@xilinx.com>, <linux-kernel@vger.kernel.org>,
 <linux-mips@linux-mips.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>, <paulus@samba.org>,
 <benh@kernel.crashing.org>
Subject: [Patch v5 03/12] irqchip: xilinx: Rename get_irq to xintc_get_irq
Date: Mon, 17 Oct 2016 17:52:47 +0100
Message-ID: <1476723176-39891-4-git-send-email-Zubair.Kakakhel@imgtec.com>
In-Reply-To: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1476723176-39891-1-git-send-email-Zubair.Kakakhel@imgtec.com>
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

Now that the driver is generic and used by multiple archs,
get_irq is too generic.

Rename get_irq to xintc_get_irq to avoid any conflicts

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V4 -> V5
Rebased to v4.9-rc1
Use __func__ in pr_err

V3 -> V4
New patch.
---
 arch/microblaze/include/asm/irq.h | 2 +-
 arch/microblaze/kernel/irq.c      | 4 ++--
 drivers/irqchip/irq-xilinx-intc.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/microblaze/include/asm/irq.h b/arch/microblaze/include/asm/irq.h
index bab3b13..d785def 100644
--- a/arch/microblaze/include/asm/irq.h
+++ b/arch/microblaze/include/asm/irq.h
@@ -16,6 +16,6 @@
 extern void do_IRQ(struct pt_regs *regs);
 
 /* should be defined in each interrupt controller driver */
-extern unsigned int get_irq(void);
+extern unsigned int xintc_get_irq(void);
 
 #endif /* _ASM_MICROBLAZE_IRQ_H */
diff --git a/arch/microblaze/kernel/irq.c b/arch/microblaze/kernel/irq.c
index 11e24de..903dad8 100644
--- a/arch/microblaze/kernel/irq.c
+++ b/arch/microblaze/kernel/irq.c
@@ -29,12 +29,12 @@ void __irq_entry do_IRQ(struct pt_regs *regs)
 	trace_hardirqs_off();
 
 	irq_enter();
-	irq = get_irq();
+	irq = xintc_get_irq();
 next_irq:
 	BUG_ON(!irq);
 	generic_handle_irq(irq);
 
-	irq = get_irq();
+	irq = xintc_get_irq();
 	if (irq != -1U) {
 		pr_debug("next irq: %d\n", irq);
 		++concurrent_irq;
diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index fe533e1..45e5154 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -119,7 +119,7 @@ static void intc_mask_ack(struct irq_data *d)
 
 static struct irq_domain *root_domain;
 
-unsigned int get_irq(void)
+unsigned int xintc_get_irq(void)
 {
 	unsigned int hwirq, irq = -1;
 
@@ -127,7 +127,7 @@ unsigned int get_irq(void)
 	if (hwirq != -1U)
 		irq = irq_find_mapping(root_domain, hwirq);
 
-	pr_debug("get_irq: hwirq=%d, irq=%d\n", hwirq, irq);
+	pr_debug("%s: hwirq=%d, irq=%d\n", __func__, hwirq, irq);
 
 	return irq;
 }
-- 
1.9.1
