Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe001.messaging.microsoft.com [216.32.180.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5C9102C032C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 19:11:40 +1100 (EST)
Received: from mail23-co1 (localhost [127.0.0.1])	by mail23-co1-R.bigfish.com
 (Postfix) with ESMTP id 97E755C016E	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Mar 2013 08:11:37 +0000 (UTC)
Received: from CO1EHSMHS014.bigfish.com (unknown [10.243.78.233])	by
 mail23-co1.bigfish.com (Postfix) with ESMTP id 6CEC47C00BB	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Mar 2013 08:11:36 +0000 (UTC)
From: Wang Dongsheng <dongsheng.wang@freescale.com>
To: <scottwood@freescale.com>, <kumar.gala@freescale.com>
Subject: [PATCH 1/3] powerpc/mpic: add irq_set_wake support
Date: Fri, 8 Mar 2013 15:38:45 +0800
Message-ID: <1362728327-21013-1-git-send-email-dongsheng.wang@freescale.com>
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
 arch/powerpc/sysdev/mpic.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 3b2efd4..10e474e 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -920,6 +920,18 @@ int mpic_set_irq_type(struct irq_data *d, unsigned int flow_type)
 	return IRQ_SET_MASK_OK_NOCOPY;
 }
 
+static int mpic_irq_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct irq_desc *desc = container_of(d, struct irq_desc, irq_data);
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
@@ -957,6 +969,7 @@ static struct irq_chip mpic_irq_chip = {
 	.irq_unmask	= mpic_unmask_irq,
 	.irq_eoi	= mpic_end_irq,
 	.irq_set_type	= mpic_set_irq_type,
+	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_SMP
@@ -971,6 +984,7 @@ static struct irq_chip mpic_tm_chip = {
 	.irq_mask	= mpic_mask_tm,
 	.irq_unmask	= mpic_unmask_tm,
 	.irq_eoi	= mpic_end_irq,
+	.irq_set_wake	= mpic_irq_set_wake,
 };
 
 #ifdef CONFIG_MPIC_U3_HT_IRQS
@@ -981,6 +995,7 @@ static struct irq_chip mpic_irq_ht_chip = {
 	.irq_unmask	= mpic_unmask_ht_irq,
 	.irq_eoi	= mpic_end_ht_irq,
 	.irq_set_type	= mpic_set_irq_type,
+	.irq_set_wake	= mpic_irq_set_wake,
 };
 #endif /* CONFIG_MPIC_U3_HT_IRQS */
 
-- 
1.7.5.1
