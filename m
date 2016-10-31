Return-Path: <Zubair.Kakakhel@imgtec.com>
Received: from mailapp01.imgtec.com (mailapp01.imgtec.com [195.59.15.196])
 by lists.ozlabs.org (Postfix) with ESMTP id 3t6tdl2dKWzDvK0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 23:16:59 +1100 (AEDT)
From: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To: <monstr@monstr.eu>, <tglx@linutronix.de>, <jason@lakedaemon.net>,
 <marc.zyngier@arm.com>
CC: <linux-kernel@vger.kernel.org>, <michal.simek@xilinx.com>,
 <linuxppc-dev@lists.ozlabs.org>, <mpe@ellerman.id.au>,
 <Zubair.Kakakhel@imgtec.com>
Subject: [Patch V6 5/6] irqchip: xilinx: Try to fall back if xlnx,
 kind-of-intr not provided
Date: Mon, 31 Oct 2016 12:16:46 +0000
Message-ID: <1477916207-25157-6-git-send-email-Zubair.Kakakhel@imgtec.com>
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

The powerpc dts file upstream does not have the xlnx,kind-of-intr
property. Instead of erroring out, give a warning instead.
And attempt to continue to probe the interrupt controller while
assuming kind-of-intr is 0x0 as a fall back.

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V5 -> V6
Rebase to v4.9-rc3

V5 new patch
---
 drivers/irqchip/irq-xilinx-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index ea15446..954e9b4 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -200,8 +200,8 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 
 	ret = of_property_read_u32(intc, "xlnx,kind-of-intr", &irqc->intr_mask);
 	if (ret < 0) {
-		pr_err("irq-xilinx: unable to read xlnx,kind-of-intr\n");
-		goto err_alloc;
+		pr_warn("irq-xilinx: unable to read xlnx,kind-of-intr\n");
+		irqc->intr_mask = 0;
 	}
 
 	if (irqc->intr_mask >> nr_irq)
-- 
1.9.1
