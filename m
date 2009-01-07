Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.175])
	by ozlabs.org (Postfix) with ESMTP id 4D67CDE571
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 06:25:12 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so9217264wfg.15
	for <linuxppc-dev@ozlabs.org>; Wed, 07 Jan 2009 11:25:10 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/mpc52xx: Properly update irq_desc when set_type() is
	called.
To: linuxppc-dev@ozlabs.org
Date: Wed, 07 Jan 2009 12:25:06 -0700
Message-ID: <20090107192505.26320.23112.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The MPC5200 PIC driver doesn't correctly update the .status field of
the irq_desc structure when the set_type hook is called.  This patch
adds the required code.

Also cleans up the external IRQ typename field to be something easier
to read (very minor).

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)


diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 72865e8..0a093f0 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -196,6 +196,7 @@ static void mpc52xx_extirq_ack(unsigned int virq)
 
 static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 {
+	struct irq_desc *desc = get_irq_desc(virq);
 	u32 ctrl_reg, type;
 	int irq;
 	int l2irq;
@@ -222,6 +223,11 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 		type = 0;
 	}
 
+	desc->status &= ~(IRQ_TYPE_SENSE_MASK | IRQ_LEVEL);
+	desc->status |= flow_type & IRQ_TYPE_SENSE_MASK;
+	if (flow_type & (IRQ_TYPE_LEVEL_HIGH | IRQ_TYPE_LEVEL_LOW))
+		desc->status |= IRQ_LEVEL;
+
 	ctrl_reg = in_be32(&intr->ctrl);
 	ctrl_reg &= ~(0x3 << (22 - (l2irq * 2)));
 	ctrl_reg |= (type << (22 - (l2irq * 2)));
@@ -231,7 +237,7 @@ static int mpc52xx_extirq_set_type(unsigned int virq, unsigned int flow_type)
 }
 
 static struct irq_chip mpc52xx_extirq_irqchip = {
-	.typename = " MPC52xx IRQ[0-3] ",
+	.typename = "MPC52xx External",
 	.mask = mpc52xx_extirq_mask,
 	.unmask = mpc52xx_extirq_unmask,
 	.ack = mpc52xx_extirq_ack,
