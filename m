Return-Path: <B40534@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0188.outbound.messaging.microsoft.com [213.199.154.188])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1BD52C0193
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 18:18:21 +1100 (EST)
Received: from mail180-db8 (localhost [127.0.0.1])	by
 mail180-db8-R.bigfish.com (Postfix) with ESMTP id 277D744014A	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 07:18:16 +0000 (UTC)
Received: from DB8EHSMHS007.bigfish.com (unknown [10.174.8.238])	by
 mail180-db8.bigfish.com (Postfix) with ESMTP id 3D068A8004B	for
 <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Apr 2013 07:18:14 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>
Subject: [PATCH v2 1/4] powerpc/mpic: add irq_set_wake support
Date: Tue, 2 Apr 2013 14:40:37 +0800
Message-ID: <1364884840-28635-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add irq_set_wake support. Just add IRQF_NO_SUSPEND to desc->action->flag.
So the wake up interrupt will not be disable in suspend_device_irqs.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
v2:
* Add: Check freescale chip in mpic_irq_set_wake().
* Remove: Support mpic_irq_set_wake() in ht_chip.

 arch/powerpc/sysdev/mpic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3b2efd4..50d1ee1 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -920,6 +920,22 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
+static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
+	struct mpic *mpic = mpic_from_irq_data(d);
+
+	if (!(mpic->flags & MPIC_FSL))
+		return -EINVAL;
+
+	if (on)
+		desc->action->flags |= IRQF_NO_SUSPEND;
+	else
+		desc->action->flags &= ~IRQF_NO_SUSPEND;
+
+	return 0;
+}
+
 void mpic_set_vector(unsigned int virq, unsigned int vector)
 {
 	struct mpic *mpic = mpic_from_irq(virq);
@@ -957,6 +973,7 @@ static struct irq_chip mpic_irq_chip = {
 	.irq_unmask	= mpic_unmask_irq,
 	.irq_eoi	= mpic_end_irq,
 	.irq_set_type	= mpic_set_irq_type,
+	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_SMP
@@ -971,6 +988,7 @@ static struct irq_chip mpic_tm_chip = {
 	.irq_mask	= mpic_mask_tm,
 	.irq_unmask	= mpic_unmask_tm,
 	.irq_eoi	= mpic_end_irq,
+	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
-- 
1.8.0
